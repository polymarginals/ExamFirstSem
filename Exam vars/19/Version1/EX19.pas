program p19;
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
 e=set of char;
var uksp:next;t,f:text;

procedure p1(var uksp:next; var f:text);
var ukzv,ukzv1,p,t,m:next;n,g,c:integer;a,i:string[5];
begin
 new(ukzv);
 uksp:=ukzv;
 ukzv^.sled:=nil;
 ukzv^.pred:=nil;
 p:=ukzv;
 new(ukzv^.sled);
 ukzv:=ukzv^.sled;
 readln(f,ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,ukzv^.cen);
 ukzv^.pred:=p;
 p:=ukzv;
 ukzv^.sled:=nil;
  while not eof(f) do
  begin
   ukzv:=uksp^.sled;
   t:=uksp;
   readln(f,n,a,i,g,c);
   while ukzv<>nil do
   begin
   m:=ukzv;
   if ukzv^.nom<n then
                  begin
                  if ukzv^.sled=nil then
                  begin
                  new(ukzv^.sled);
                  ukzv:=ukzv^.sled;
                  ukzv^.nom:=n;
                  ukzv^.avt:=a;
                  ukzv^.im:=i;
                  ukzv^.god:=g;
                  ukzv^.cen:=c;
                  ukzv^.pred:=m;
                  ukzv^.sled:=nil;
                  break
                  end;
                  t:=ukzv;
                  ukzv:=ukzv^.sled;
                  end
                  else
                  begin
                  new(ukzv1);
                  ukzv1^.nom:=n;
                  ukzv1^.avt:=a;
                  ukzv1^.im:=i;
                  ukzv1^.god:=g;
                  ukzv1^.cen:=c;
                  ukzv1^.pred:=t;
                  ukzv1^.sled:=ukzv;
                  t^.sled:=ukzv1;
                  ukzv^.pred:=ukzv1;
                  break
                  end;
               end;
             end;
             ukzv:=uksp;
             while ukzv^.sled<>nil do
             begin
             ukzv:=ukzv^.sled;
             t:=ukzv;
             end;
             new(ukzv^.sled);
             ukzv:=ukzv^.sled;
             ukzv^.sled:=nil;
             ukzv^.pred:=t;
             end;

procedure p2(var uksp:next; var l:text);
var ukzv,t,m,ukzv1,z:next;n,g,c:integer;a,i:string[5];
begin
 ukzv:=uksp^.sled;
 while ukzv^.sled<>nil do
 begin
 ukzv:=ukzv^.sled;
 z:=ukzv;
 end;
 ukzv:=uksp^.sled;
   t:=uksp;
   readln(n,a,i,g,c);

   while ukzv<>nil do
   begin
   m:=ukzv;
   if ukzv^.nom<n then
                  begin
                  if ukzv^.sled^.sled=nil then
                  begin
                  new(ukzv^.sled);
                  ukzv:=ukzv^.sled;
                  ukzv^.nom:=n;
                  ukzv^.avt:=a;
                  ukzv^.im:=i;
                  ukzv^.god:=g;
                  ukzv^.cen:=c;
                  ukzv^.pred:=m;
                  ukzv^.sled:=z;
                  z^.pred:=ukzv;
                  break
                  end;
                  t:=ukzv;
                  ukzv:=ukzv^.sled;
                  end
                  else
                  begin
                  new(ukzv1);
                  ukzv1^.nom:=n;
                  ukzv1^.avt:=a;
                  ukzv1^.im:=i;
                  ukzv1^.god:=g;
                  ukzv1^.cen:=c;
                  ukzv1^.pred:=t;
                  ukzv1^.sled:=ukzv;
                  t^.sled:=ukzv1;
                  ukzv^.pred:=ukzv1;
                  break
                  end;
               end;
             end;

procedure p3(var uksp:next; var f:text);
var ukzv:next;k,l:e;i:string[5];
begin
 k:=['a'..'k'];
 l:=['l'..'z'];
 readln(i);
 if i[2] in k then
 begin
 ukzv:=uksp^.sled;
 while ukzv^.sled<>nil do
  begin
  if ukzv^.im=i then
                begin
                writeln(t,ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,ukzv^.cen);
                ukzv:=ukzv^.sled;
                end
                else ukzv:=ukzv^.sled;
  end;
  end
              else
  begin
  while ukzv^.sled<>nil do
  ukzv:=ukzv^.sled;
  ukzv:=uksp^.pred;
  while ukzv^.pred<>nil do
  begin
  if ukzv^.im=i then
                begin
                writeln(t,ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,ukzv^.cen);
                ukzv:=ukzv^.pred;
                end
                else ukzv:=ukzv^.pred;
  end;
  end;
end;
procedure p4(var uksp:next; var t:text);
var ukzv:next;
begin
ukzv:=uksp^.sled;
while ukzv^.sled<>nil do
     begin
     writeln(t,ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,ukzv^.cen);
     ukzv:=ukzv^.sled;
     end;
writeln(t);
ukzv:=ukzv^.pred;
while ukzv^.pred<>nil do
     begin
     writeln(t,ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,ukzv^.cen);
     ukzv:=ukzv^.pred;
     end;
end;

begin
assign(f,'dan191.inp');
reset(f);
assign(t,'res19.out');
rewrite(t);
p1(uksp,f);
p4(uksp,t);
writeln(t);
p2(uksp,f);
p4(uksp,t);
writeln(t);
p3(uksp,t);
close(f);
close(t);

end.