/* <Linux> */
%option noyywrap
%option yylineno
/* </Linux> */

%{
#include "SrvParser.h"
#include "Portable.h"
#define YYABORT yyterminate();
%}

%x COMMENT
%x ADDR

hexdigit [0-9A-Fa-f]
hexnumber {hexdigit}+h
letter [a-zA-Z]
cipher [0-9]
integer {cipher}+
curly_op [{]
curly_cl [}]
hex1to4  {hexdigit}{1,4}

%{
  unsigned ComBeg; //line, in which comment begins
  unsigned LftCnt; //how many signs : on the left side of 
                                    //'::' sign was interpreted
  unsigned RgtCnt; //the same as above, but on the right side of '::'
  char Address[16]; //address, which is analizing right now
  char AddrPart[16];
  unsigned intpos,pos;
  unsigned analyzeBigPart(char* bigPart, unsigned length, char *dst);
  int decodeSmallPart(char *src, char* dst,int length);
  bool decodeIntPart(char *src, char *dst);
  void resetAddress(char *tab);
  yy_SrvParser_stype yylval;
%}

%%


%{//KEYWORDS
%}

[Ii][fF][aA][cC][Ee] {return SrvParser::IFACE_;}  //defines which iface is gonna be to config.
[Nn][Oo]-[Cc][Oo][Nn][Ff][Ii][Gg] {return SrvParser::NO_CONFIG_;} //not configure this iface
[Cc][Ll][Aa][Ss][Ss] {return SrvParser::CLASS_;}

[Ll][Oo][Gg]-[Nn][aA][Mm][Ee] {return SrvParser::LOGNAME_;}
[Ll][Oo][Gg]-[Ll][Ee][Vv][Ee][Ll] {return SrvParser::LOGLEVEL_;}
[Ww][Oo][Rr][Kk]-[Dd][Ii][Rr] {return SrvParser::WORKDIR_;}

[Dd][Nn][Ss]-[Ss][Ee][Rr][Vv][Ee][Rr] {return SrvParser::DNS_SERVER_;}
[Dd][Oo][Mm][Aa][Ii][Nn] {return SrvParser::DOMAIN_;}

[Nn][Tt][Pp]-[Ss][Ee][Rr][Vv][Ee][Rr] {return SrvParser::NTP_SERVER_;}
[Tt][Ii][Mm][Ee]-[Zz][Oo][Nn][Ee] {return SrvParser::TIME_ZONE_;}

%{ //[Nn][Ii][Ss]-[Ss][Ee][Rr][Vv][Ee][Rr] {return SrvParser::NIS_SERVER_;}
%}
[Aa][Cc][Ee][Pp][Tt]-[Oo][Nn][Ll][Yy] {return SrvParser::ACCEPT_ONLY_;}
[Rr][Ee][Jj][Ee][Cc][Tt]-[Cc][Ll][Ii][eE][nN][tT][sS] {return SrvParser::REJECT_CLIENTS_;}

[Tt][1] {return SrvParser::T1_;}
[Tt][2] {return SrvParser::T2_;}

[Pp][Rr][Ee][Ff][Ee][Rr][Ee][Dd]-[Ll][iI][Ff][Ee][Tt][Ii][Mm][Ee] {return SrvParser::PREF_TIME_;}
[Vv][Aa][Ll][Ii][Dd]-[Ll][iI][Ff][Ee][Tt][Ii][Mm][Ee]  {return SrvParser::VALID_TIME_;}

[Uu][Nn][Ii][Cc][Aa][Ss][Tt] {return SrvParser::UNICAST_;}
[Pp][Rr][Ee][Ff][Ee][Rr][Ee][Nn][Cc][Ee] {return SrvParser::PREFERENCE_;}
[Pp][Oo][Oo][Ll] {return SrvParser::POOL_;}
[Rr][Aa][Pp][Ii][Dd][Cc][Oo][Mm][Mm][Ii][Tt] {return SrvParser::RAPID_COMMIT_;}
[Mm][Aa][Xx]-[Ll][Ee][Aa][Ss][Ee] {return SrvParser::MAX_LEASE_;}
[Cc][Ll][iI][Ee][Nn][Tt]-[Mm][Aa][Xx]-[Ll][Ee][Aa][Ss][Ee] {return SrvParser::CLNT_MAX_LEASE_;}

[Yy][Ee][Ss] {yylval.ival=1; return SrvParser::INTNUMBER_;}
[Nn][Oo]         {yylval.ival=0; return SrvParser::INTNUMBER_;}
[Tt][Rr][Uu][Ee]    {yylval.ival=1; return SrvParser::INTNUMBER_;}
[Ff][Aa][Ll][Ss][Ee] {yylval.ival=0; return SrvParser::INTNUMBER_;}

%{ //COMMENTS
%}
#.* ;

"//"(.*) ;

"/*" {
  BEGIN(COMMENT);
  ComBeg=yylineno; 
}


<COMMENT>"*/" BEGIN(INITIAL);
<COMMENT>.|"\n" ;
<COMMENT><<EOF>> {
//  printf ("Niezamkni�ty komentarz /* w linii:%d\n",ComBeg); 
  { YYABORT; }
}

%{ //IPv6 address - various forms
%}
({hex1to4}:){7}{hexdigit} {
  if(!inet_pton6(yytext,yylval.addrval))
      { YYABORT; }
    else
    /*analyzeBigPart(yytext,strlen(yytext)-2,Address);
    memcpy(yylval.addrval,Address,16);*/
        return SrvParser::IPV6ADDR_;
}

(({hex1to4}:){1,6})?{hex1to4}"::"(({hex1to4}:){1,6})?{hex1to4} {
  if(!inet_pton6(yytext,yylval.addrval))
      { YYABORT; }
    else  
  /*pos=0;
  while ((yytext[pos]!=':')||(yytext[pos+1]!=':')) pos++;
  LftCnt=analyzeBigPart(yytext,pos,AddrPart);
  resetAddress(Address);
  memcpy(Address, AddrPart,16);
  pos+=2;
    RgtCnt=analyzeBigPart(yytext+pos,strlen(yytext+pos),AddrPart);
    if ((LftCnt+RgtCnt)>8)
      { YYABORT; } //to many address parts - raise exception
    memcpy( Address+16-(RgtCnt<<1), AddrPart,RgtCnt<<1);
    memcpy(yylval.addrval,Address,16);*/
    return SrvParser::IPV6ADDR_;
}

"::"(({hex1to4}:){1,7})?{hex1to4} { 
  if(!inet_pton6(yytext,yylval.addrval))
      { YYABORT; }
    else  
  /*resetAddress(Address);
  RgtCnt=analyzeBigPart(yytext+2,strlen(yytext)-2,AddrPart);
    memcpy(Address+16-(RgtCnt<<1), AddrPart, RgtCnt<<1);
    memcpy(yylval.addrval,Address,16);*/
        return SrvParser::IPV6ADDR_;
}

(({hex1to4}:){0,7})?{hex1to4}:: {
  if(!inet_pton6(yytext,yylval.addrval))
      { YYABORT; }
    else  
    /*analyzeBigPart(yytext,strlen(yytext)-2,Address);
    memcpy(yylval.addrval,Address,16);*/
        return SrvParser::IPV6ADDR_;
}

"::" {
    /*resetAddress(Address);
    memcpy(yylval.addrval,Address,16);*/
  if(!inet_pton6(yytext,yylval.addrval))
      { YYABORT; }
    else  
        return SrvParser::IPV6ADDR_;
}

(({hex1to4}:){1,5})?{hex1to4}"::"(({hex1to4}:){1,6})?{integer}"."{integer}"."{integer}"."{integer} {
  if(!inet_pton6(yytext,yylval.addrval))
      { YYABORT; }
    else
  /*pos=0;
  while ((yytext[pos]!=':')||(yytext[pos+1]!=':')) pos++;
  LftCnt=analyzeBigPart(yytext,pos,AddrPart);
  resetAddress(Address);
  memcpy(Address, AddrPart,16);
  intpos=(pos+=2);
    while (yytext[intpos]!='.') intpos++;
    while (yytext[intpos]!=':') intpos--;
    if(intpos>pos)
    {
      RgtCnt=analyzeBigPart(yytext+pos,intpos-pos,AddrPart);
      if ((RgtCnt+LftCnt)>6) { YYABORT; }
      memcpy(Address+12-(RgtCnt<<1), AddrPart, RgtCnt<<1);  
    }
    decodeIntPart(yytext+intpos+1, Address+12);
    memcpy(yylval.addrval,Address,16);*/
      return SrvParser::IPV6ADDR_;
}

"::"(({hex1to4}":"){1,6})?{integer}"."{integer}"."{integer}"."{integer} {

  if(!inet_pton6(yytext,yylval.addrval))
      { YYABORT; }
    else  
    /*resetAddress(Address);
  intpos=0;
    while (yytext[intpos]!='.') intpos++;
    while (yytext[intpos]!=':') intpos--;
    if (intpos>1)
    {
    RgtCnt=analyzeBigPart(yytext+2,intpos-2,AddrPart);
      memcpy(Address+12-(RgtCnt<<1), AddrPart, RgtCnt<<1);
    };
    decodeIntPart(yytext+intpos+1, Address+12);
    memcpy(yylval.addrval,Address,16);*/
      return SrvParser::IPV6ADDR_;
}

%{ //STRING (interface identifier,dns server etc.)
%}

'([^']|(''))*' {
    yylval.strval=new char[strlen(yytext)-1];
    strncpy(yylval.strval, yytext+1, strlen(yytext)-2);
    yylval.strval[strlen(yytext)-2]=0;
    return SrvParser::STRING_;
}

%{ //DUID
%}
\"{hexdigit}+\" {
    //every hex digit corresponds to half of byte, even at the begining
    //of string
    if (strlen(yytext)%2) 
        yytext[0]='0'; //if odd than no-meaning zero at the beginning
    else
        yytext++;
    //and now there is an even number of hex digits
    yylval.duidval.length=(strlen(yytext)-1)>>1;
    yylval.duidval.duid=new char[yylval.duidval.length];
    for (int i=0;i<(yylval.duidval.length<<1);i+=1)
    {
        yylval.duidval.duid[i>>1]<<=4;
        if (!isxdigit(yytext[i])) 
            { YYABORT; } //or raise exeception
        else
        if (isalpha(yytext[i]))
            yylval.duidval.duid[i>>1]|=toupper(yytext[i])-'A'+10;
        else
            yylval.duidval.duid[i>>1]|=yytext[i]-'0';
   }
   return SrvParser::DUID_;
}

%{ //HEXADECIMAL NUMBER (interface id, option's values etc.)
%}
{hexnumber} {
    yytext[strlen(yytext)-1]='\n';
    if(!sscanf(yytext,"%x",&(yylval.ival)))
      { YYABORT; }
    return SrvParser::HEXNUMBER_;
}

%{ //DECIMAL NUMBER (as for HEXNUMBER)
%}
{integer} { 
    //FIXME:Check if number appropriate
    if(!sscanf(yytext,"%u",&(yylval.ival)))
      { YYABORT; }
    return SrvParser::INTNUMBER_;
}

%{ //WHITE CHARS should be omitted
%}
[ \n\t] ; 

%{ //OTHER CHARS are direclty passed to parser
%}
.  {return yytext[0];}


%%

/////////////////////////////////////////////////////////////////////////////
// programs section

 void resetAddress(char *tab)
 {
  int i;
  for (i=0;i<16;i++) tab[i]=0;
 }

 bool decodeIntPart(char *src, char *dst)
 {
  
  int i,obyte;
  int ipos=0;
    for (i=0;i<4;i++)
    {
      obyte=src[ipos]-'0';
      while((src[++ipos]!='.')&&(ipos<strlen(src)))
      {
        obyte=obyte*10+src[ipos]-'0';
        if (obyte>255) { YYABORT; }
      }
      Address[12+i]=obyte;
      ipos++;
    }
 }

 int decodeSmallPart(char *src, char* dst,int length)
 {
  int int16=0;
  int i;
  if (length>4)
    { YYABORT; }//there is too many digits abort and raise exception
  for (i=0; i<length; i++) 
  {
    if (!isxdigit(src[i])) 
      return 0; //or raise exeception
    else
      if (isalpha(src[i]))
        int16=(int16<<4)+toupper(src[i])-55;
      else

        int16=(int16<<4)+src[i]-48;
  }
  dst[1]=*((char*)(&int16));
  dst[0]=*(((char*)(&int16))+1);
  return 1;
 }

 unsigned analyzeBigPart(char* bigPart, unsigned length, char *dst)
 {
  unsigned srcStart,dstStart,pos;
  srcStart=pos=0;
  dstStart=0;
  resetAddress(dst);
  do
  {
    //extracting part of string to next ':' sign or its end
    while((pos<length)&&(bigPart[pos]!=':')) pos++;
    //decode this part to binary form
    decodeSmallPart(bigPart+srcStart,dst+dstStart,pos-srcStart);
    //bigPart[pos]!=':'?(pos-srcStart-1):
    //next two bytes found
    dstStart+=2;
    //omission of : sign    
    srcStart=++pos;
  }while(pos<=length);
  return (dstStart)>>1;
 }