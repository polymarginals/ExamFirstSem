program p11;
type
 ptree=^uk;
 uk=record
 fam:string[10];
 voz:integer;
 kol:integer;
 lf,rt:ptree
 end;
var uksp:ptree;f,t:text;

procedure p1(var uksp:ptree;var f:text);
label 1;
var ukzv,ukzv2:ptree;c:string[10]; a:integer;
begin
 uksp:=nil;
 while not eof(f) do
 begin
  if uksp=nil then
  begin
   new(ukzv);
   uksp:=ukzv;
   readln(f,ukzv^.fam,ukzv^.voz);
   ukzv^.kol:=1;
   ukzv^.lf:=nil;
   ukzv^.rt:=nil;
  end
  else
  begin
    readln(f,c,a);
    ukzv:=uksp;
    while ukzv<>nil do
    begin
    ukzv2:=ukzv;
    if ukzv^.voz<>a then
    begin

    if ukzv^.voz>a then ukzv:=ukzv^.lf
                    else ukzv:=ukzv^.rt;
    end
    else begin
         ukzv^.kol:=ukzv^.kol+1;
         goto  1
         end;
         end;
     new(ukzv);
     ukzv^.fam:=c;
     ukzv^.voz:=a;
     ukzv^.kol:=1;
     ukzv^.rt:=nil;
     ukzv^.lf:=nil;
     if ukzv2^.voz>a then ukzv2^.lf:=ukzv
                     else ukzv2^.rt:=ukzv;
    1: end;
     end;

     end;




procedure p2(var uksp:ptree;var t:text);
begin
 if uksp^.lf<>nil then p2(uksp^.lf,t);
 if uksp<>nil then writeln(t,uksp^.fam,uksp^.voz,' ',uksp^.kol);
 if uksp^.rt<>nil then p2(uksp^.rt,t);
end;

procedure p3(var uksp:ptree;var f:text; var t:text);
type
 next=^uk;
 uk=record
 fam:string[10];
 voz:integer;
 kol:integer;
 sled:next;
 end;
 var uksp1,ukzv:next; c,m:integer;
procedure p31(var uksp:ptree;var ukzv:next);
begin
if uksp^.lf<>nil then p31(uksp^.lf,ukzv);
 if uksp<>nil then begin
                   new(ukzv^.sled);
                   ukzv:=ukzv^.sled;
                   ukzv^.fam:=uksp^.fam;
                   ukzv^.voz:=uksp^.voz;
                   ukzv^.kol:=uksp^.kol;
                   end;
 if uksp^.rt<>nil then p31(uksp^.rt,ukzv);
end;
  begin

  new(ukzv);
  uksp1:=ukzv;
  ukzv^.sled:=nil;
  p31(uksp,ukzv);
  new(ukzv^.sled);
  ukzv:=ukzv^.sled;
  ukzv^.sled:=nil;

  readln(c);
  ukzv:=uksp1^.sled;
  m:=0;
  while ukzv^.sled<>nil do
  begin
  if ukzv^.voz=c then begin
                      m:=m+ukzv^.kol;
                      ukzv:=ukzv^.sled;
                      end
                 else ukzv:=ukzv^.sled;
  end;
  writeln(t,m);
  end;


begin
assign(f,'dan11.inp');
reset(f);
assign(t,'res11.out');
rewrite(t);

p1(uksp,f);
p2(uksp,t);
p3(uksp,f,t);
close(f);
close(t);
end.