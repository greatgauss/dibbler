/*                                                                           *
 * Dibbler - a portable DHCPv6                                               *
 *                                                                           *
 * authors: Tomasz Mrugalski <thomson@klub.com.pl>                           *
 *          Marek Senderski <msend@o2.pl>                                    *
 *                                                                           *
 * released under GNU GPL v2 or later licence                                */

#include <iostream>
#include <stdlib.h>
#include "SmartPtr.h"
#include "DHCPClient.h"
#include "ClntTransMgr.h"
#include "IfaceMgr.h"
#include "ClntIfaceMgr.h"
#include "Logger.h"
#include "Portable.h"

volatile int serviceShutdown;

TDHCPClient::TDHCPClient(string config)
{
    string oldconf = config+"-old";

    serviceShutdown = 0;
    srand(now());
    this->IsDone = false;

    IfaceMgr = new TClntIfaceMgr();
    if ( IfaceMgr->isDone() ) {
	std::clog << logger::logCrit << "Fatal error during IfaceMgr. Aborting." << logger::endl;
	this->IsDone = true;
    }

    TransMgr = new TClntTransMgr(IfaceMgr, config);
    TransMgr->setThat(TransMgr);
}

void TDHCPClient::stop() {
    serviceShutdown = 1;

#ifdef WIN32
    // just to break select() in WIN32 systems
    //std::clog << logger::logInfo << "Service shutdown." << logger::endl;
    //int fd=sock_add("",1,"::1",DHCPCLIENT_PORT,true);
    //char buf = 0;
    //sock_send(fd,"::1",buf,1,DHCPCLIENT_PORT,1);
    //sock_del(fd);
#endif
}


void TDHCPClient::run()
//## 1. W zależności czy:  
//## a. wystąpił timeoutu - wywołanie doDuties
//## b. przyszla wiadomość - wywołanie relayMessage
//## 
//## powtarzanie: (do nadrobienia czasu)
//## 2. wywolanie getTimeout
//## 3. wywolanie doDuties 
//## 
//## 4. Zaśnięcie w oczekiwaniu na przyjście wiadomości lub upłynięcie
//## tiemoutu tj. wywołanie SELECT

{
    long theBeginning = now();
    SmartPtr<TMsg> msg;
    while ( (!TransMgr->isDone()) && (!this->isDone()) )
    {
	if (serviceShutdown)
	    TransMgr->shutdown();

        TransMgr->doDuties();

        unsigned int timeout = TransMgr->getTimeout();
	// FIXME: everything should be unsigned
	if (timeout == DHCPV6_INFINITY)
	    timeout = DHCPV6_INFINITY/2;
	if (timeout == 0)
	    timeout = 1;

	
        std::clog << logger::logNotice << "Sleeping for " 
		  << timeout << " seconds." << logger::endl;
        SmartPtr<TMsg> msg=IfaceMgr->select(timeout);
	
        if (msg) {
            std::clog << logger::logNotice << "Received msg(" << msg->getType() 
		      << hex << ") transID=" << msg->getTransID() << dec
		      << ", " << msg->countOption() << " opts:";
            SmartPtr<TOpt> ptrOpt;
            msg->firstOption();
            while (ptrOpt = msg->getOption() )
                std::clog << " " << ptrOpt->getOptType() << "(" << ptrOpt->getSize() << ")";
            std::clog << logger::endl;
	    
            TransMgr->relayMsg(msg);
        }
    }
}

bool TDHCPClient::isDone() {
    return IsDone;
}

bool TDHCPClient::checkPrivileges() {
    // FIXME: check privileges
    return true;
}

TDHCPClient::~TDHCPClient()
{
}
