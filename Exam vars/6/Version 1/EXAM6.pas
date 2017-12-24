program p6;
type
 next=^uk;
 uk=record
 fam:string[10];
 kol:integer;
 sled:next;
 end;

 zap=record
 fam:string[10];
 kol:integer;
 end;

var uksp1,uksp:next; f,t,m:text;

procedure p1(var uksp:next; var f:text);
var ukzv:next; zap1:zap;
begin
 new(ukzv);
 uksp:=ukzv;
 ukzv^.sled:=nil;
 while not eof(f) do
 begin
  new(ukzv^.sled);
  ukzv:=ukzv^.sled;
  readln(f,zap1.fam,zap1.kol);
  ukzv^.fam:=zap1.fam;
  ukzv^.kol:=zap1.kol;
  ukzv^.sled:=nil;
 end;
 new(ukzv^.sled);
 ukzv:=ukzv^.sled;
 ukzv^.sled:=nil;
end;

procedure p2(var uksp:next; var t:text);
var ukzv:next;
begin
 ukzv:=uksp^.sled;
 while ukzv^.sled<>nil do
 begin
  writeln(t,ukzv^.fam,ukzv^.kol);
  ukzv:=ukzv^.sled;
 end;
end;

procedure p3(var uksp:next; var uksp1:next);
var ukzv,ukzv1,p:next;
begin
 ukzv:=uksp^.sled;
 while ukzv^.sled<>nil do
 begin
  ukzv1:=uksp1^.sled;
  while ukzv1^.sled<>nil do
  begin
   if ukzv^.fam=ukzv1^.fam then
                           begin
                           if ukzv^.kol>ukzv1^.kol then
                            begin
                            ukzv^.kol:=ukzv^.kol-ukzv1^.kol;
                            ukzv1^.kol:=0;
                            end
                            else
                            begin
                            ukzv1^.kol:=ukzv1^.kol-ukzv^.kol;
                            ukzv^.kol:=0;
                            end;
                           end;
                           ukzv1:=ukzv1^.sled;
                           end;
                           ukzv:=ukzv^.sled;
                           end;

   ukzv1:=uksp1^.sled;
   p:=uksp1;
   while ukzv1^.sled<>nil do
   begin
   if ukzv1^.kol=0 then
                   begin
                   p^.sled:=ukzv1^.sled;
                   ukzv1:=p^.sled;
                   end
                   else
                   begin
                   p:=ukzv1;
                   ukzv1:=ukzv1^.sled;
                   end;
     end;
     end;

begin
assign(f,'dan6.inp');
reset(f);
assign(t,'res6.out');
rewrite(t);
assign(m,'dan61.inp');
reset(m);
p1(uksp,f);
p2(uksp,t);
p1(uksp1,m);
writeln(t);
p2(uksp1,t);
writeln(t);
p3(uksp,uksp1);
p2(uksp,t);
writeln(t);
p2(uksp1,t);
close(f);
close(t);
end.