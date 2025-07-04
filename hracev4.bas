1 rem horserace v4 - by eyvind ebsen 2025
2 poke53280,11:poke53281,0:forx=.to20:d$=d$+"{down}":next
3 mt=20:h=9:dimh$(mt),hs(mt),h(h),sh(h)::gosub540:rem gosub550
5 de=300:tr=0:rem settings init;de=keydelay, tr=total races(for stats)
7 rem print"{clear}"
9 gosub900:print"{down*2}{white} welcome to the horse race stadium!"
10 cn=1:pl=h:ra=1:l=1
15 forx=1toh:pm(x)=100:pp(x)=0:pn$(x)="":next:bp=33:rem set ply money and betprize
21 print"{light green} type name of human player"
22 print" or press enter for ai player{light gray}"
23 forx=1topl:print:print"name of player"x:inputpn$(x):ifpn$(1)="-1"thengosub940:goto9
24 iflen(pn$(x))>7thenpn$(x)=left$(pn$(x),7)
25 ifleft$(pn$(x),2)=""thenpn$(x)="cpu"+str$(cn):printpn$(x)+" entered the game":cn=cn+1
26 next
27 gosub520:forx=1topl:ifpp(x)<1thenprint"player "pn$(x)" pick a horse (1-9)";
28 ifleft$(pn$(x),2)="cp"thenifpp(x)<1theng=1+int(rnd(.)*9):printg:goto30
29 ifpp(x)<1 then g=0:inputg:ifg<1 or g>h then 29
30 pg(x)=g:next
35 ?:print"{yellow}lets get ready for the race!":
37 gosub500
45 m=rnd(-ti):print"{light gray}{clear}{down*2} ";
46 forx=1toh:tl=2:fory=1toh:poke646,x:rem prevent line overflow
47 ifpp(y)<1thenifpg(y)=xtheniftl+len(pn$(y))<38thenprintpn$(y)", ";:tl=tl+2+len(pn$(y))
48 next:?:?:?" ";
49 next:?"{light gray}{left}{up}";:forx=.to36:print"{sh asterisk}";
51 next:x$=str$(ra):gosub570:print"{light blue}"x$:gosub800:rem race off
55 ?"{home}";:forx=1toh:poke646,x:?:?"{left}"x:next
60 print"{home}";
70 forx=1toh:poke646,x
75 printtab(1+h(x))"{down}{reverse on}  {pi}":next
80 m=1+int(h*rnd(1)):h(m)=h(m)+1:ifh(m)>33then92
90 goto60
92 poke646,m:print"{home}"left$(d$,20);:sh(m)=sh(m)+1:rem print"horse"m"wins"
93 forx=.to99:poke2023-x,32:poke1824+x,32:next:rem clear score field
94 print"{home}"left$(d$,20)"{light gray}top 3:":h(m)=-1:t(0)=m
96 fort=1to2:hh=0:hn=1
97 forx=1toh:ifh(x)>hhthenhh=h(x):bn=x
98 next:h(bn)=-1:t(t)=bn:next
100 forx=.to2:poke646,t(x):print" #"x+1"{left}. horse";t(x):next
103 gosub500:?
105 ?:print"{light gray}winning players:"
110 ap=0:forx=1toh:ifpp(x)=1then150
115 ifpg(x)=t(0)thengosub200:goto150
120 ifpg(x)=t(1)thengosub202:goto150
130 ifpg(x)=t(2)thengosub204
150 next:print"{light gray}";:rem change color back
155 if ap=0thenprint"no player won!":?
160 gosub500
165 ?:?"{white}players left":print"player     coins"
170 forx=1toh:ifpp(x)=1then175
172 ifleft$(pn$(x),2)="cp"thenpoke646,15:goto174
173 poke646,10
174 printpn$(x),pm(x)
175 next
178 bp=bp+10:?:print"{light gray}bet price goes up to"bp"coins":?
180 gosub500
185 pf=0:forx=1toh:h(x)=0:ifpp(x)<1andpm(x)>=bpthenpm(x)=pm(x)-bp:pf=pf+1:goto188
186 rem ifpp(x)<1thengoto188
187 ifpm(x)<bpandpp(x)<1thengosub530
188 next:rem reset horses, and costs
190 if pf<1then?:print"{yellow}we have a winner!":goto600:rem game ends
192 print:print"{white}"pf"player";:ifpf>1thenprint"s";
193 print" left in the game!{light gray}"
194 gosub500
195 ra=ra+1:tr=tr+1:goto27:rem more races
199 rem fix some long lines with some gosubs
200 print"{yellow}player "pn$(x)" wins x3.5 ("int(bp*3.5)")":pm(x)=pm(x)+int(bp*3.5):ap=1:return
202 print"{gray}player "pn$(x)" wins x2.5 ("int(bp*2.5)")":pm(x)=pm(x)+int(bp*2.5):ap=1:return
204 print"{orange}player "pn$(x)" wins x1.5 ("int(bp*1.5)")":pm(x)=pm(x)+int(bp*1.5):ap=1:return
498 end
499 rem wait key
500 geta$:ifa$<>""then500:rem empty keyboard buffer
501 w=0:poke 2021,11:poke2022,5:poke2023,25:c=0
502 poke 56293,c:c=c+1:poke56294,c:c=c+1:poke56295,c
504 if c>250thenc=0:rem no color overflow
505 if de=0then507:rem no delay, force key press
506 w=w+1:ifw>de then508:rem autoplay/skip wait
507 geta$:ifa$=""then502
508 poke 2021,32:poke2022,32:poke2023,32
510 return
519 rem raceinfo
520 print"{light green}{down*2}welcome to the horserace of today"
522 print"this is the #"ra"race of the day."
523 print"bet price is"bp:?"{light gray}"
524 return
529 rem kick a player
530 printpn$(x)" cant afford to play, bye!":pp(x)=1:pm(x)=pm(x)+(1000*ra)
535 return
539 rem init hiscore
540 forx=1tomt:h$(x)=".......":hs(x)=9999-x*300:next
542 h$(1)="eyvind.":h$(2)="was....":h$(3)="here...":h$(4)="2025..."
544 return
549 rem show hiscore
550 print:printspc(15)"{white}hi-score":print
551 printspc(8)"{white}place   player   score"
552 printspc(5);:forx=.to27:print"{sh asterisk}";:next:print
554 forx=1tomt:gosub590:x$=str$(x)
556 gosub570;rem strip spaces
558 iflen(x$)<2thenx$=" "+x$
560 printspc(9)x$"."spc(4)h$(x)" "hs(x):next
562 gosub500:return
569 rem strip spaces in front and back
570 if left$(x$,1)=" "thenx$=right$(x$,len(x$)-1):goto570
572 if right$(x$,1)=" "thenx$=left$(x$,len(x$)-1):goto572
574 return
579 rem first game tips
580 print:print"{white} tip: type -1 as the first player"
582 print" for options and statistics.":gosub500
588 return
589 rem determine color for scores
590 ifxand1thenpoke646,14:goto592
591 poke646,6
592 if x=1thenpoke646,7
593 if x=2thenpoke646,12
594 if x=3thenpoke646,8
595 return
599 rem game ended
600 forx=1toh:ifpp(x)<1thenpm(x)=pm(x)+(1000*(ra+1)):print"{yellow}player "pn$(x)" wins!"
602 next:rem now sort by pm()
604 q=0:forx=1to9
606 ifpm(x)>=pm(x+1)then608
607 q$=pn$(x):q=pm(x):pn$(x)=pn$(x+1):pm(x)=pm(x+1):pn$(x+1)=q$:pm(x+1)=q
608 next:ifq<>0thengoto604:rem more to sort
610 print"{white}place     player     score"
611 forx=.to27:print"{sh asterisk}";:next:print
612 forx=1toh:gosub590
618 print" "x"{left}.",pn$(x),pm(x):next
619 rem print"{yellow}player "pn$(ls(l))" wins!"
620 print:print"{white}made"ra"races"
630 gosub500
640 rem determine which players made hiscore
650 j=0:forx=1toh:k=0
660 fory=mtto1step-1
670 if pm(x)>hs(y)thenk=y
680 next y
685 if k=0then720
690 print"player "pn$(x)" made"k"place!":j=1
700 forz=mttok+1step-1:h$(z)=h$(z-1):hs(z)=hs(z-1):nextz
705 iflen(pn$(x))<7thenpn$(x)=pn$(x)+".":goto705:rem fill name with dots
710 h$(k)=pn$(x):hs(k)=pm(x)
720 next x
725 if j=0thenprint"no player made the hiscore"
730 gosub500
740 gosub550:iffg=0thenfg=1:gosub580:rem first game
760 goto9:rem new game
799 rem race on logo
800 ?"  {light green}{cm +}{cm +}{cm +}   {cm +}   {cm +}{cm +} {cm +}{cm +}{cm +}   {cm +} {cm +}{cm +}{cm +}    {cm +}  {cm +}  {cm +}"
802 ?"  {cm +}  {cm +} {cm +} {cm +} {cm +}   {cm +}     {cm +} {cm +}     {cm +} {cm +} {cm +}{cm +} {cm +}"
804 ?"  {cm +}{cm +}{cm +}  {cm +}{cm +}{cm +} {cm +}   {cm +}{cm +}    {cm +} {cm +}{cm +}{cm +}   {cm +} {cm +} {cm +} {cm +}{cm +}"
806 ?"  {cm +}  {cm +} {cm +} {cm +} {cm +}   {cm +}     {cm +}   {cm +}   {cm +} {cm +} {cm +}  {cm +}"
808 ?"  {cm +}  {cm +} {cm +} {cm +}  {cm +}{cm +} {cm +}{cm +}{cm +}   {cm +} {cm +}{cm +}{cm +}    {cm +}  {cm +}  {cm +}";
810 return
899 rem game logo
900 ?
901 ?"  {cyan}{reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}PP{reverse off}  {reverse on}PP{reverse off}  {reverse on}PPP{reverse off} {reverse on}PPP{reverse off}   {reverse on}PP{reverse off}   {reverse on}P{reverse off}   {reverse on}PP{reverse off} {reverse on}PPP"
902 ?"  {light green}{reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off}   {reverse on}P{reverse off}     {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off}   {reverse on}P"
904 ?"  {yellow}{reverse on}PPP{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}PP{reverse off}  {reverse on}PPP{reverse off} {reverse on}PP{reverse off}    {reverse on}PP{reverse off}  {reverse on}PPP{reverse off} {reverse on}P{reverse off}   {reverse on}PP"
906 ?"  {light green}{reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off}   {reverse on}P{reverse off} {reverse on}P{reverse off}     {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off}   {reverse on}P"
908 ?"  {cyan}{reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}PPP{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}PPP{reverse off} {reverse on}PPP{reverse off}   {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off} {reverse on}P{reverse off}  {reverse on}PP{reverse off} {reverse on}PPP"
912 ?spc(12)"{dark gray}a game by eyvind ebsen 2025":?
914 ?"{white} game rules:":?
916 ?"{light gray}  there are 9 horses in the game."
918 ?"  pick a horse you think will win."
920 ?"  if your horse makes the top 3,"
922 ?"  you are awarded coins. coins are "
924 ?"  needed to pay for further races."
926 ?"  win as many races that you can"
927 ?"  to enter the legendary {yellow}top 20."
930 return
939 rem game settings
940 m$="":print:print"{white} game settings:":?
944 print:print"1. key wait (set:"de")"
948 rem print:print"2. end-game settings"
952 print:print"2. show hi-score (top: '"h$(1)"')"
956 print:print"3. statistics (stats for"tr"races)"
960 print:print"0. end menu"
964 input"(0-3)";m$:ifm$<"0"orm$>"3"then940
972 ifm$="0"then return
976 ifm$="1"thengosub1000:goto940
978 rem ifm$="2"thengosub1040:goto940
980 ifm$="2"thengosub550:goto940
982 ifm$="3"thengosub1100:goto940
990 goto940
999 rem settings: set time delay
1000 print:print"set keypress timeout"
1008 print"0= force wait keypress"
1010 print">0 timeout value"
1012 print:print"current delay is set to: "de
1016 print:input"enter delay:";de
1020 ifde<0 then 1000
1030 return
1039 rem settings: set end game
1040 print:print"set end game"
1042 rem print:print"1. end game if only cpus left"
1044 print:print"this feature is not working yet"
1050 return
1099 rem statistics
1100 print:print"statistics:":print
1105 if tr=0 then print"statisctics not available yet!":return
1110 forx=1toh
1120 print"horse"x"has won"sh(x)"of"tr+1"races"int(sh(x)/tr*100)"%"
1130 next:print:print"statistics for"tr+1"total races."
1140 inputm$:rem force wait
1150 return