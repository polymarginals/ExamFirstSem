program p10;
type
 next=^uk;
 uk=record
 fam:string;
 sled,pred:next;
 end;

var ukpl,uksp:next; f,f1:text;

procedure p1(var uksp:next; var H:text;var ukpl:next);
var ukzv,p:next;
begin
 new(ukzv);
 uksp:=ukzv;
 ukzv^.sled:=nil;
 ukzv^.pred:=nil;
 p:=ukzv;
  while not eof(H) do
  begin
   new(ukzv^.sled);
   ukzv:=ukzv^.sled;
   readln(H,ukzv^.fam);
   ukzv^.pred:=p;
   ukzv^.sled:=nil;
   p:=ukzv;
  end;
  new(ukzv^.sled);
  ukzv:=ukzv^.sled;
  ukzv^.sled:=nil;
  ukzv^.pred:=p;
  ukpl:=ukzv;
end;

procedure p2(var uksp:next; var G:text);
var ukzv:next;
begin
 ukzv:=uksp^.sled;
 while ukzv^.sled<>nil do
 begin
  writeln(G,ukzv^.fam);
  ukzv:=ukzv^.sled;
 end;
end;
procedure p3(var uksp:next;var uklp:next);
var ukzv,ukzv1:next; i:integer;
begin
 ukzv:=uksp;
 while ukzv<>ukpl do
 begin
 if ukzv^.sled^.sled=nil then break;
 ukzv^.sled:=ukzv^.sled^.sled;
 ukzv:=ukzv^.sled;
 end
end;


begin
assign(f,'ex10.inp');
reset(f);
assign(f1,'ex10.out');
rewrite(f1);
p1(uksp,f,ukpl);
p3(uksp,ukpl);
p2(uksp,f1);
close(f);
close(f1);
end.