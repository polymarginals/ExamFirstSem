program p8;
type
 next=^uk;
 uk=record
 fam:string;
 sled:next;
 end;

var uksp,t:next; f,m,k:text;

procedure p1(var uksp:next; var H:text; var t:next);
var ukzv:next;
begin
 uksp:=nil;
 new(ukzv);
 ukzv^.sled:=uksp;
 uksp:=ukzv;
 t:=ukzv;
  while not eof(H) do
  begin
   new(ukzv);
   ukzv^.sled:=uksp;
   readln(H,ukzv^.fam);
   uksp:=ukzv;
  end;
   new(ukzv);
   ukzv^.sled:=uksp;
   uksp:=ukzv;
end;

procedure p2(var uksp:next; var G:text; var t:next);
var ukzv:next;
begin
 ukzv:=uksp;
 while uksp^.sled<>t do
 begin
  while ukzv^.sled<>t do
  begin
   ukzv:=ukzv^.sled;
  end;

  writeln(G,ukzv^.fam);
  t:=ukzv;
  ukzv:=uksp;
 end;
end;

procedure p3(var uksp:next; var t:text; var a:next);
var ukzv,ukzv1,m:next; c:string;
begin
 while not eof(t) do
 begin
  ukzv:=uksp^.sled;
  m:=uksp;
  readln(t,c);
  while ukzv^.sle d<>nil do
  begin

   if ukzv^.fam>c then
                 begin
                 m:=ukzv;
                 ukzv:=ukzv^.sled;
                 end
                 else
                 begin
                 new(ukzv1);
                                  ukzv1^.fam:=c;
                 ukzv1^.sled:=nil;

                 m^.sled:=ukzv1;
                 ukzv1^.sled:=ukzv;
                 break;
                 end;
   end;
   end;
   ukzv:=uksp;
   while ukzv^.sled<>nil do
   begin
   ukzv:=ukzv^.sled;
   end;
   a:=ukzv;
   end;
begin
assign(f,'dan8.inp');
reset(f);
assign(m,'res8.out');
rewrite(m);
assign(k,'dan81.inp');
reset(k);

p1(uksp,f,t);
p2(uksp,m,t);
writeln(m);
p3(uksp,k,t);

p2(uksp,m,t);

close(f);
close(m);
close(k);
end.
