program p12;
type
 next=^uk;
 uk=record
 nom:integer;
 avt:string[5];
 im:string[5];
 god:integer;
 cen:integer;
 sled,pred:next;
 end;

 var uksp:next;

procedure p1(var uksp:next);
var ukzv,p:next;
begin
 new(ukzv);
 uksp:=ukzv;
 ukzv^.sled:=nil;
 ukzv^.pred:=nil;
 p:=ukzv;
  while not eof do
  begin
   new(ukzv^.sled);
   ukzv:=ukzv^.sled;
   readln(ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,ukzv^.god);
   ukzv^.pred:=p;
   ukzv^.sled:=nil;
   p:=ukzv;
  end;
 new(ukzv^.sled);
 ukzv:=ukzv^.sled;
 ukzv^.pred:=p;
 ukzv^.sled:=nil;
end;

procedure p2(var uksp:next);
var ukzv:next;
begin
 ukzv:=uksp^.sled;
 while ukzv^.sled<>nil do
 begin
 writeln(ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,ukzv^.god);
 ukzv:=ukzv^.sled;
 end;
 writeln;
 ukzv:=ukzv^.pred;
 while ukzv^.pred<>nil do
 begin
 writeln(ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,ukzv^.god);
 ukzv:=ukzv^.pred;
 end;
end;

procedure p3(var uksp:next);
var ukzv,ukzv2,p:next; c:string[5];
begin
 ukzv:=uksp^.sled^.sled;
 while ukzv^.sled<>nil do
  begin
  p:=ukzv;
  ukzv2:=ukzv^.pred;
  while ukzv2<>uksp do
  begin
   if ukzv2^.avt>ukzv^.avt then
                           begin
                           c:=ukzv^.avt;
                           ukzv^.avt:=ukzv2^.avt;
                           ukzv2^.avt:=c;
                           ukzv:=ukzv2;
                           ukzv2:=ukzv2^.pred;
                           end
                           else ukzv2:=ukzv2^.pred;
  end;
  ukzv:=p^.sled;
  end;

  end;


begin
assign(input,'dan12.inp');
reset(input);
assign(output,'res12.out');
rewrite(output);
p1(uksp);
p3(uksp);
p2(uksp);
close(input);
close(output);
end.