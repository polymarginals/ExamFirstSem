program ex18;
type
next=^uk;
uk=record
nom:integer;
avt:string[10];
im:string[10];
god:integer;
cen:integer;
sled,sort:next;
end;

var ukzv,uksp,uksp1:next; f,t:text;

procedure p1(var uksp:next;var f:text);
var ukzv,min,p,man,ukzv2,m,n,t,s:next;
begin
 new(ukzv);
 uksp:=ukzv;
 ukzv^.sled:=nil;
 ukzv^.sort:=nil;
  while not eof(f) do
  begin
   new(ukzv^.sled);
   ukzv:=ukzv^.sled;
   readln(f,ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,ukzv^.cen);
   ukzv^.sled:=nil;
  end;
  new(ukzv^.sled);
  ukzv:=ukzv^.sled;
  ukzv^.sled:=nil;

  ukzv:=uksp;
  while ukzv<>nil do
  begin
   ukzv^.sort:=ukzv^.sled;
   ukzv:=ukzv^.sled;
  end;

  ukzv:=uksp^.sled;
  m:=uksp^.sled;
  n:=uksp^.sled;
  t:=uksp;

  while ukzv^.sled^.sled<>nil do
  begin
       ukzv2:=ukzv^.sled;
       min:=ukzv;
       while ukzv2^.sled<>nil do
       begin
       if min^.avt>ukzv2^.avt then
        begin
         m:=n;
         min:=ukzv2;
        end;
        n:=ukzv2;
        ukzv2:=ukzv2^.sled;
       end;

       if ukzv<>min then
       begin
       if ukzv^.sled=min then
        begin
        t^.sled:=min;
        ukzv^.sled:=min^.sled;
        min^.sled:=ukzv;

        m:=ukzv;
        n:=ukzv;
        t:=t^.sled;
        end
                        else
        begin
        s:=ukzv^.sled;
        t^.sled:=min;
        m^.sled:=ukzv;
        ukzv^.sled:=min^.sled;
        min^.sled:=s;
        {min^.sled:=ukzv^.sled;
        ukzv^.sled:=m^.sled^.sled;}
        ukzv:=min^.sled;
        m:=t^.sled;
        n:=t^.sled;
        t:=t^.sled;
        end
        end

        else
        begin
        ukzv:=ukzv^.sled;
        n:=t^.sled;
        m:=m^.sled;
        t:=t^.sled;
      end;
       end;
        end;

procedure p2(var uksp:next; var f:text);
var ukzv,ukzv1,ukzv2,q,m,n:next;
begin
 new(ukzv1);
 readln(ukzv1^.nom,ukzv1^.avt,ukzv1^.im,ukzv1^.god,ukzv1^.cen);
 ukzv1^.sort:=nil;

 ukzv:=uksp^.sort;
 while ukzv^.sort^.sort<>nil do
 begin
 ukzv:=ukzv^.sort;
 end;
 q:=ukzv;
 ukzv:=uksp^.sort;
 while ukzv^.sort<>nil do
 begin
 ukzv:=ukzv^.sort;
 end;
 q^.sort:=ukzv1;
 ukzv1^.sort:=ukzv;
 ukzv2:=ukzv1;

 ukzv:=uksp^.sled;
 m:=uksp;
 while ukzv^.sled<>nil do
 begin
  if ukzv^.avt<ukzv1^.avt then
                          begin
                          m:=ukzv;
                          ukzv:=ukzv^.sled;
                          n:=ukzv;
                          if ukzv^.sled=nil then
                          begin
                          m^.sled:=ukzv1;
                          ukzv1^.sled:=ukzv;
                          break
                          end;
                          end
                          else
                          begin
                          m^.sled:=ukzv1;
                          ukzv1^.sled:=ukzv;
                          break
                          end;

 end;
 end;

begin
assign(f,'ex18.inp');
reset(f);
assign(t,'rex18.out');
rewrite(t);
p1(uksp,f);
p2(uksp,f);
ukzv:=uksp^.sort;
while ukzv^.sort<>nil do
begin
 writeln(t,ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,' ',ukzv^.cen);
 ukzv:=ukzv^.sort;
end;

writeln(t);
ukzv:=uksp^.sled;
while ukzv^.sled<>nil do
begin
 writeln(t,ukzv^.nom,ukzv^.avt,ukzv^.im,ukzv^.god,' ',ukzv^.cen);
 ukzv:=ukzv^.sled;
end;


close(f);
close(t);
end.