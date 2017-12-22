Program belkaexamen;

type

ptwin=^twin;
pone=^one;
twin= record
      K:integer;
      fam:string[15];
      n,p:ptwin;
      end;
one= record
     K:integer;
     fam:string[15];
     n:pone;
     end;

function minstring(s1,s2:string):boolean;
var i,k:integer;
begin
if s1[0]<s2[0] then k:=ord(s1[0])
else k:=ord(s2[0]);
for i:=1 to 15 do
  begin
  if s1[i]<>s2[i] then
    begin
    if ord(s1[i])<ord(s2[i]) then begin minstring:=TRUE;break;end;
    if ord(s1[i])>ord(s2[i]) then begin minstring:=FALSE;break;end;
    end;
  end;
end;





procedure P1(var S:ptwin;H:string);
var
vvod:text;
pc,pt:ptwin;
ch:char;
begin
assign(vvod,H);
reset(vvod);
while not(eof(vvod)) do
  begin
  new(pt);
  readln(vvod,pt^.K,ch,pt^.fam);
  pt^.n:=nil;
  pt^.p:=nil;
  if S=nil then
    begin
    S:=pt;
    pc:=s;
    end
  else
      begin
      pt^.p:=pc;
      pc^.n:=pt;
      pc:=pt;
      end;
  end;
close(vvod);
end;







var
D:ptwin;
S1,S2:pone;

Begin
P1(D,'in.xxx');
end.