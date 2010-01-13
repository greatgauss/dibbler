/*
 * Dibbler - a portable DHCPv6
 *
 * authors: Tomasz Mrugalski <thomson@klub.com.pl>
 *          Marek Senderski <msend@o2.pl>
 *
 * released under GNU GPL v2 only licence
 *
 * $Id: SrvOptIA_NA.h,v 1.11 2008-08-29 00:07:36 thomson Exp $
 *
 * $Log: not supported by cvs2svn $
 * Revision 1.10  2008-03-02 19:20:30  thomson
 * RemoteID, EchoRequest options implemneted.
 *
 * Revision 1.9  2007-05-04 17:47:25  thomson
 * *** empty log message ***
 *
 * Revision 1.8  2006-03-05 21:32:28  thomson
 * Temp. addresses support merged into main branch.
 *
 * Revision 1.7.2.1  2006/02/05 23:38:08  thomson
 * Devel branch with Temporary addresses support added.
 *
 * Revision 1.7  2004/07/05 00:12:30  thomson
 * Lots of minor changes.
 *
 * Revision 1.6  2004/06/20 21:00:45  thomson
 * Various fixes.
 *
 * Revision 1.5  2004/06/20 19:29:23  thomson
 * New address assignment finally works.
 *
 * Revision 1.2  2004/06/20 17:51:48  thomson
 * getName() method implemented, comment cleanup
 *
 *
 */

class TSrvOptIA_NA;
#ifndef SRVOPTIA_NA_H
#define SRVOPTIA_NA_H

#include "OptIA_NA.h"
#include "SrvOptIAAddress.h"
#include "SmartPtr.h"
#include "DUID.h"
#include "SrvCfgMgr.h"
#include "SrvAddrMgr.h"
#include "Container.h"
#include "IPv6Addr.h"

class TSrvOptIA_NA : public TOptIA_NA
{
  public:
    
    TSrvOptIA_NA(SPtr<TSrvCfgMgr> cfgMgr,
		 SPtr<TSrvAddrMgr> addrMgr,
		 SPtr<TSrvOptIA_NA> queryOpt,
		 SPtr<TIPv6Addr> clntAddr, SPtr<TDUID> duid,
		 int iface, unsigned long &addrCount, int msgType , TMsg* parent);

    TSrvOptIA_NA(char * buf, int bufsize, TMsg* parent);    
    TSrvOptIA_NA(long IAID, long T1, long T2, TMsg* parent);    
    TSrvOptIA_NA(long IAID, long T1, long T2, int Code, string Msg, TMsg* parent);

/* Constructor used in answers to:
 * - SOLICIT 
 * - SOLICIT (with RAPID_COMMIT)
 * - REQUEST */
    TSrvOptIA_NA(SPtr<TSrvAddrMgr> addrMgr,  SPtr<TSrvCfgMgr> cfgMgr,
		 SPtr<TSrvOptIA_NA> queryOpt,
		 SPtr<TDUID> clntDuid, SPtr<TIPv6Addr> clntAddr, 
		 int iface, int msgType, TMsg* parent);
    
    void releaseAllAddrs(bool quiet);

    void solicit(SPtr<TSrvOptIA_NA> queryOpt, unsigned long &addrCount);
    void request(SPtr<TSrvOptIA_NA> queryOpt, unsigned long &addrCount);
    bool renew(SPtr<TSrvOptIA_NA> queryOpt, bool complainIfMissing);
    void rebind(SPtr<TSrvOptIA_NA> queryOpt,  unsigned long &addrCount);
    void release(SPtr<TSrvOptIA_NA> queryOpt, unsigned long &addrCount);
    void confirm(SPtr<TSrvOptIA_NA> queryOpt, unsigned long &addrCount);
    void decline(SPtr<TSrvOptIA_NA> queryOpt, unsigned long &addrCount);
    bool doDuties();
 private:
    SPtr<TSrvAddrMgr> AddrMgr;
    SPtr<TSrvCfgMgr>  CfgMgr;
    SPtr<TIPv6Addr>   ClntAddr;
    SPtr<TDUID>       ClntDuid;
    int                   Iface;
    
    SPtr<TSrvOptIAAddress> assignAddr(SPtr<TIPv6Addr> hint, unsigned long pref,
					  unsigned long valid, bool quiet);
    SPtr<TIPv6Addr> getFreeAddr(SPtr<TIPv6Addr> hint);
    SPtr<TIPv6Addr> getExceptionAddr();
};

#endif
