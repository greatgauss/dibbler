/*
 * Dibbler - a portable DHCPv6
 *
 * authors: Tomasz Mrugalski <thomson@klub.com.pl>
 *          Marek Senderski <msend@o2.pl>
 *
 * released under GNU GPL v2 or later licence
 */

#ifndef CLNTOPTELAPSED_H
#define CLNTOPTELAPSED_H

#include "OptInteger.h"

class TClntOptElapsed : public TOptInteger
{
  public:
    TClntOptElapsed(TMsg* parent);
    TClntOptElapsed( char * buf,  int n, TMsg* parent);
    bool doDuties();
};
#endif
