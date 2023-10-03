    1 cl$=chr$(27)+"q"
    2 ff=0:gosub 1200
   10 rem *** screen capture ***
   20 rem 1. press 'space' key on top-left point
   30 rem 2. then use cursor keys to move to bottom-right point & press 'space'
   40 rem 3. provide a filename to save to
   50 x=0:y=0:s=0:sv=0
   51 if peek($5fffe)<>71 or peek($5ffff)<>73 then wpoke $5fffe,$4947:poke $40000,0:rem check for magic marker at end of bank 5, if not there, initialise b4 mem
   55  cursor 0,24:gosub 1100:print cl$;"block count=";peek($40000);", next-free=$";hex$(z);
   60 if s=0 then t1=peek($800+x+y*80):c1=peek($1f800+x+y*80):x0=x:y0=y
   65 if s=1 then t2=peek($800+x+y*80):c2=peek($1f800+x+y*80):x1=x:y1=y
   70 poke $800+x+y*80,43:poke $1f800+x+y*80,1
   80 getkey a$
   85 if a$<>" " then gosub 1000
   90 if a$="{left}" and x>0 then x=x-1
  100 if a$="{rght}" and x<79 then x=x+1
  101 if a$=";" and sv>0 then sv=sv-1:gosub 1300
  102 if a$=":" and sv<8 then sv=sv+1:gosub 1300
  103 if a$="]" and sg>0 then sg=sg-1:gosub 1400
  104 if a$="[" and sg<8 then sg=sg+1:gosub 1400
  110 if a$="{up}" and y>0 then y=y-1
  120 if a$="{down}" and y<24 then y=y+1
  121 if a$="c" then print "{clr}";:b=0:gosub 620
  122 if a$="-" and ff>0 then ff=ff-1:b=ff:gosub 620
  124 if a$="=" and ff<peek($40000) then ff=ff+1:b=ff:gosub 620
  130 if a$=" " then s=s+1:gosub 1000:if s=2 then goto 150
  132 if a$="l" then gosub 600:rem load block
  133 if a$="x" then cursor 0,0:end
  135 gosub 1050
  140 goto 60
  150 rem *** restore original chars and save block to memory ***
  160 rem - save x,y,w,h,data
  170 poke $800+x0+y0*80,t1:poke $1f800+x0+y0*80,c1
  180 poke $800+x+y*80,t2:poke $1f800+x+y*80,c2
  190 i=peek($40000):rem block count
  200 gosub 1100:rem locate next free byte
  220 z=$40000+l
  230 poke z,x0:z=z+1
  240 poke z,y0:z=z+1
  250 poke z,x-x0+1:z=z+1
  260 poke z,y-y0+1:z=z+1
  270 for yy=y0 to y
  280   for xx=x0 to x
  290     poke z,peek($800+xx+yy*80):z=z+1
  310   next xx
  320 next yy
  321 for yy=y0 to y
  322   for xx=x0 to x
  323     poke z,peek($1f800+xx+yy*80):z=z+1
  324   next xx
  325 next yy
  330 poke $40000,i+1
  350 cursor 0,24:print cl$;"block count=";peek($40000);", next-free=$";hex$(z);
  360 cursor 0,0:end
  600 rem *** load block ***
  610 print "{home}";cl$;:input "block#";b
  620 mx=peek($40000):z=$40001:i=0
  630 if i>=mx then cursor 0,0:print cl$;"invalid block#!";:return
  640 rem traverse to find block
  650 if i=b then goto 720:rem found
  660 z=z+2:rem skip x,y
  670 w=peek(z):z=z+1
  680 h=peek(z):z=z+1
  690 z=z+w*h*2
  700 i=i+1
  710 goto 630
  720 rem found, now load it
  730 x=peek(z):z=z+1
  740 y=peek(z):z=z+1
  750 w=peek(z):z=z+1:x1=x+w-1
  760 h=peek(z):z=z+1:y1=y+h-1
  765 print "{home}";cl$;"x=";x;", y=";y;", w=";w;", h=";h;", z=$";hex$(z);"{down}";chr$(27);"j";cl$;"frame=";ff;", nxt=$";hex$(z+w*h*2);
  767 zz=z+w*h:p=$800+x+y*80:pp=$1f800+x+y*80
  770 for yy=y to y1
  780 edma 0, w, z, p
  790 edma 0, w, zz, pp
  800 z=z+w:zz=zz+w:p=p+80:pp=pp+80
  820 next yy
  830 return
  999 cursor 0,0:end
 1000 rem *** if movement, restore original char ***
 1010 if a$<>" " then begin
 1020   if s=0 then poke $800+x+y*80,t1:poke $1f800+x+y*80,c1
 1030   if s=1 then poke $800+x+y*80,t2:poke $1f800+x+y*80,c2
 1040 bend
 1045 return
 1049 rem *** show coords ***
 1050 cursor 0,24:print "                            ";:cursor 0,24
 1055 if s=0 then print chr$(27)+"qx=";x;", y=";y;
 1060 if s=1 then print chr$(27)+"qx=";x0;", y=";y0;", w=";x-x0+1;", h=";y-y0+1;
 1070 print "     ";
 1080 return
 1100 rem *** locate next free byte ***
 1110 z=$40001:mx=peek($40000):i=0
 1120 if i=mx then l=z-$40000:return
 1130 z=z+2
 1140 w=peek(z):z=z+1
 1150 h=peek(z):z=z+1
 1160 z=z+w*h*2
 1170 i=i+1:goto 1120
 1200 rem *** store 1st 32 default colours ***
 1210 dim dr(32),dg(32),db(32)
 1220 for k=0 to 31
 1230 dr(k)=peek($d100+k):dg(k)=peek($d200+k):db(k)=peek($d300+k)
 1240 next k
 1250 return
 1300 rem *** fade all colours by value sv (0-8) ***
 1305 sz = (8-sv)/8
 1310 for k=0 to 31
 1320 poke $d100+k, dr(k)*sz
 1330 poke $d200+k, dg(k)*sz
 1340 poke $d300+k, db(k)*sz
 1350 next k
 1360 return
 1400 rem *** fade all colours to greyscale sgclose(0-8) ***
 1410 sz = (8-sg)/8
 1420 for k=0 to 31
 1430 gr=(dr(k)+dg(k)+db(k))/3
 1440 poke $d100+k, int(gr+(dr(k)-gr)*sz)
 1450 poke $d200+k, int(gr+(dg(k)-gr)*sz)
 1460 poke $d300+k, int(gr+(db(k)-gr)*sz)
 1470 next k
 1480 return
