/*
 * Dibbler - a portable DHCPv6
 *
 * authors: Tomasz Mrugalski <thomson@klub.com.pl>
 *          Marek Senderski <msend@o2.pl>
 *
 * released under GNU GPL v2 or later licence
 *
 * $Id: RelParsIfaceOpt.h,v 1.1 2005-01-11 22:53:35 thomson Exp $
 *
 * $Log: not supported by cvs2svn $
 */

#ifndef RELPARSIFACEOPT_H_
#define RELPARSIFACEOPT_H_

#include "SmartPtr.h"
#include "IPv6Addr.h"

class TRelParsIfaceOpt
{
public:
    TRelParsIfaceOpt(void);
    ~TRelParsIfaceOpt(void);

    void setClientUnicast(SmartPtr<TIPv6Addr> addr);
    void setServerUnicast(SmartPtr<TIPv6Addr> addr);
    void setClientMulticast(bool unicast);
    void setServerMulticast(bool unicast);

    SmartPtr<TIPv6Addr> getServerUnicast();
    SmartPtr<TIPv6Addr> getClientUnicast();
    bool getServerMulticast();
    bool getClientMulticast();

    void setInterfaceID(int id);
    int getInterfaceID();

private:
    SmartPtr<TIPv6Addr> ClientUnicast;
    SmartPtr<TIPv6Addr> ServerUnicast;
    bool ClientMulticast;
    bool ServerMulticast;

    int InterfaceID;
};

#endif