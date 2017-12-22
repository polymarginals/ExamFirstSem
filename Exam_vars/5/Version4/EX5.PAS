program ex5;

uses crt;

type

t=^el;
el = record
fam:string[10];
num:integer;
sl,pr:t;
end;

sp=^lst;
lst = record
fam:string[10];
num:integer;
sl:sp;
end;

procedure getsp(var uksp,ukkn:t; var f:text);
var
ukzv,p:t;
begin
new(ukzv);
uksp:=ukzv;
uksp^.pr:=nil;
uksp^.sl:=nil;
readln(f,uksp^.fam,uksp^.num);
p:=uksp;
while not EOF(f) do begin
new(ukzv^.sl);
ukzv:=ukzv^.sl;
ukzv^.pr:=p;
p:=ukzv;
readln(f,ukzv^.fam,ukzv^.num);
end;
ukkn:=p;
ukkn^.sl:=nil;
end;

procedure putsp(var uksp,ukkn:t; var g:text; var b:boolean);
var ukzv:t;
begin
if b=true then begin
ukzv:=uksp;
while ukzv<>nil do begin
writeln(g,ukzv^.fam,ukzv^.num);
ukzv:=ukzv^.sl;
end;
end
else
ukzv:=ukkn;
while ukzv<>nil do begin
writeln(g,ukzv^.fam,ukzv^.num);
ukzv:=ukzv^.pr;
end;
end;

procedure convertout(var uksp:t; var g:text);
var
ukzv:t;
h1,h2,beg1,beg2,tmp,p,p1,f:sp;
begin
ukzv:=uksp;
new(beg1);
new(beg2);
h1:=beg1;
h2:=beg2;
while ukzv <> nil do begin
new(beg1^.sl);
beg1:=beg1^.sl;
beg1^.sl:=nil;
beg1^.num:=ukzv^.num;
beg1^.fam:=ukzv^.fam;
new(beg2^.sl);
beg2:=beg2^.sl;
beg2^.sl:=nil;
beg2^.num:=ukzv^.num;
beg2^.fam:=ukzv^.fam;
ukzv:=ukzv^.sl;
end;

beg1:=h1^.sl;
while beg1<>nil do begin
 tmp:=beg1^.sl;
 while tmp<>nil do begin
  if tmp^.num < beg1^.num then begin
   p:=h1; p1:=h1;
   if beg1<>h1 then
    while p^.sl<>beg1 do p:=p^.sl;
    while p1^.sl<>tmp do p1:=p1^.sl;
    f:=tmp^.sl;
    if beg1^.sl=tmp then begin
     tmp^.sl:=beg1;
     beg1^.sl:=f;
    end
    else begin
     tmp^.sl:=beg1^.sl;
     beg1^.sl:=f;
    end;
    if p1<>beg1 then
     p1^.sl:=beg1;
    if beg1<>h1 then
     p^.sl:=tmp
    else
      h1:=tmp;
    p1:=tmp;
    tmp:=beg1;
    beg1:=p1;
   end;
   tmp:=tmp^.sl;
  end;
  beg1:=beg1^.sl;
 end;
writeln(g);
beg1:=h1^.sl;
while beg1<>nil do begin
writeln(g,beg1^.num,' ',beg1^.fam);
beg1:=beg1^.sl;
end;

beg2:=h2^.sl;
while beg2<>nil do begin
 tmp:=beg2^.sl;
 while tmp<>nil do begin
  if tmp^.fam < beg2^.fam then begin
   p:=h2; p1:=h2;
   if beg2<>h2 then
    while p^.sl<>beg2 do p:=p^.sl;
    while p1^.sl<>tmp do p1:=p1^.sl;
    f:=tmp^.sl;
    if beg2^.sl=tmp then begin
     tmp^.sl:=beg2;
     beg2^.sl:=f;
    end
    else begin
     tmp^.sl:=beg2^.sl;
     beg2^.sl:=f;
    end;
    if p1<>beg2 then
     p1^.sl:=beg2;
    if beg1<>h2 then
     p^.sl:=tmp
    else
      h2:=tmp;
    p1:=tmp;
    tmp:=beg2;
    beg2:=p1;
   end;
   tmp:=tmp^.sl;
  end;
  beg2:=beg2^.sl;
 end;
writeln(g);
beg2:=h2^.sl;
while beg2<>nil do begin
writeln(g,beg2^.fam,' ',beg2^.num);
beg2:=beg2^.sl;
end;

end;

var
uksp,ukkn:t;
f,g:text;
b:boolean;
c:char;

begin
assign(f,'ex5.inp');
assign(g,'ex5.out');
reset(f);
rewrite(g);
getsp(uksp,ukkn,f);
close(f);
clrscr;
writeln('Insert the direction: "S" for straight and "R" fo reverse:');
readln(c);
if c='S' then b:=true;
if c='R' then b:=false;
putsp(uksp,ukkn,g,b);
convertout(uksp,g);
close(g);
end.
