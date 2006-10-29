/*
 * Dibbler - a portable DHCPv6
 *
 * authors: Tomasz Mrugalski <thomson@klub.com.pl>
 *          Marek Senderski <msend@o2.pl>
 *
 * released under GNU GPL v2 or later licence
 *
 * $Id: SrvOptElapsed.h,v 1.4 2006-10-29 13:11:47 thomson Exp $
 *
 */

#ifndef SRVOPTELAPSED_H
#define SRVOPTELAPSED_H

#include "OptInteger.h"

class TSrvOptElapsed : public TOptInteger
{
 public:
    TSrvOptElapsed(TMsg* parent);
    TSrvOptElapsed( char * buf,  int n, TMsg* parent);
    bool doDuties();
};

#endif /* SRVOPTELAPSED_H */
