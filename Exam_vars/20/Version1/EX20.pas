program p20;
type
 next=^uk;
 uk=record
 im:string[5];
 data:integer;
 cen:integer;
 kol:integer;
 sled:next;
 end;

var uksp:next; f,t:text;

procedure p1(var uksp:next;var f:text);
var ukzv:next;
begin
 new(ukzv);
 uksp:=ukzv;
 ukzv^.sled:=nil;
  while not eof(f) do
  begin
   new(ukzv^.sled);
   ukzv:=ukzv^.sled;
   readln(f,ukzv^.im,ukzv^.data,ukzv^.cen,ukzv^.kol);
   ukzv^.sled:=nil;
  end;
 new(ukzv^.sled);
 ukzv:=ukzv^.sled;
 ukzv^.sled:=nil;
end;

procedure p2(var uksp:next; var f:text);
var ukzv,ukzv1,m:next; i:string[5]; d:integer; c,k:integer;
begin
 ukzv:=uksp^.sled;
 m:=uksp;
 readln(i,d,c,k);
 while ukzv^.sled<>nil do
 begin
  if ukzv^.im=i then
                begin
                ukzv^.kol:=ukzv^.kol+1;
                break;
                end;
  if ukzv^.im<i then begin
                     m:=ukzv;
                     ukzv:=ukzv^.sled;
                     end

                     else
                     begin
                     new(ukzv1);
                     ukzv1^.sled:=nil;
                     ukzv1^.im:=i;
                     ukzv1^.data:=d;
                     ukzv1^.cen:=c;
                     ukzv1^.kol:=k;
                     m^.sled:=ukzv1;
                     ukzv1^.sled:=ukzv;
                     break;
                     end;
 end;
end;

{[procedure p3(var uksp:next);
var ukzv,ukzv2,m,n,t,min,s:next;

 begin
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
       if min^.data>ukzv2^.data then
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
   {     ukzv:=min^.sled;
        m:=t^.sled^.sled;
        n:=t^.sled^.sled;
        t:=t^.sled;
        end
        end

        else
        begin
        ukzv:=ukzv^.sled;
        n:=t^.sled^.sled;
        m:=m^.sled;
        t:=t^.sled;
      end;
       end;
        end;


  }

        {
procedure p3(var uksp:next);
var ukzv,m,n,t,s,min,ukzv2:next;
begin
 ukzv:=uksp^.sled;
 t:=uksp;
 n:=ukzv;
 m:=ukzv;
 while ukzv^.sled^.sled<>nil do
 begin
  min:=ukzv;
  ukzv2:=ukzv^.sled;
  while ukzv2^.sled<>nil do
   begin
   if ukzv2^.data<min^.data then begin
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
    ukzv:=min^.sled;
    t:=t^.sled;
    end
                    else
    begin
    s:=ukzv^.sled;
    t^.sled:=min;
    m^.sled:=ukzv;
    ukzv^.sled:=min^.sled;
    min^.sled:=s;
    ukzv:=min^.sled;
    m:=min;
    n:=min;
    t:=t^.sled;
    end;
    end
               else
               begin
               ukzv:=ukzv^.sled;
               m:=t^.sled^.sled;
               n:=t^.sled^.sled;
               t:=t^.sled;
               end;
    end;
   end;}

   procedure p3(var uksp:next);
   var m,ukzv,ukzv2,ukpos:next;
   begin
   ukzv:=uksp^.sled;
   while ukzv^.sled<>nil do
   ukzv:=ukzv^.sled;
   ukpos:=ukzv;

   ukzv:=uksp;
   while uksp^.sled^.sled<>ukpos do
   begin
    ukzv:=uksp;
    while ukpos<>ukzv^.sled^.sled do
    begin
     m:=ukzv;
     ukzv:=ukzv^.sled;
     ukzv2:=ukzv^.sled;
     if ukzv^.data>ukzv2^.data then
      begin
      m^.sled:=ukzv2;
      ukzv^.sled:=ukzv2^.sled;
      ukzv2^.sled:=ukzv;
      ukzv:=ukzv2;
      end;
     end;
      ukpos:=ukzv^.sled;
   end;
   end;       {

   procedure p3(var uksp:next);
 var ukzv,ukpos,ukzv2,m:next;
 begin
 ukzv:=uksp^.sled;
 while ukzv^.sled<>nil do
 ukzv:=ukzv^.sled;
 ukpos:=ukzv;

 ukzv:=uksp;
 while uksp^.sled^.sled<>ukpos do
      begin
      ukzv:=uksp;
       while ukpos<>ukzv^.sled^.sled do
        begin
        m:=ukzv;
        ukzv:=ukzv^.sled;
        ukzv2:=ukzv^.sled;
        if ukzv^.data>ukzv2^.data then
         begin
         m^.sled:=ukzv2;
         ukzv^.sled:=ukzv2^.sled;
         ukzv2^.sled:=ukzv;
         ukzv:=ukzv2;
         end;
         end;
         ukpos:=ukzv^.sled;
         end;
         end;     }
procedure p4(var uksp:next; var t:text);
var ukzv:next;
begin
 ukzv:=uksp^.sled;
 while ukzv^.sled<>nil do
 begin
 writeln(t,ukzv^.im,' ',ukzv^.data,' ',ukzv^.cen,' ',ukzv^.kol);
 ukzv:=ukzv^.sled;
 end;
end;

begin
assign(f,'dan20.inp');
reset(f);
assign(t,'res20.out');
rewrite(t);

p1(uksp,f); {
p4(uksp,t);
p2(uksp,f);}
writeln(t);
p3(uksp);
p4(uksp,t);
close(f);
close(t);

sr:=llist;
fr:=sr^.next;
while fr^.next^.date<>0 do begin
pr:=sr; min:=fr;
prev:=fr; lrun:=prev^.next;
while lrun^.date<>0 do begin
if lrun^.date<min^.date then begin
min:=lrun;
pr:=prev;
end;
prev:=lrun;
lrun:=lrun^.next;
end;
if (sr<>pr) and (fr<>min) then begin
pr^.next:=min^.next;
sr^.next:=min;
min^.next:=fr;
end;
sr:=sr^.next;
fr:=sr^.next;
end;
end.