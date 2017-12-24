program p12;
type
 next=^uk;
 uk=record
 nom:integer;
 avt:string;
 im:string;
 god:integer;
 cen:integer;
 sled,pred:next;
 end;

 var uksp:next;

procedure p1(var uksp:next);
var ukzv,p:next;
    ch:char;
    strA , strI:string;
    i,j:integer;
begin
 new(ukzv);
 uksp:=ukzv;
 ukzv^.sled:=nil;
 ukzv^.pred:=nil;
 p:=ukzv;
  while not eof do
  begin
   i:=1;
   j:=1;

   new(ukzv^.sled);
   ukzv:=ukzv^.sled;
   read(ukzv^.nom, ch, ch, ch);
   while ch<>',' do
    begin
    read(ch);
    if (ch<>',')and(ch<>' ') then
       begin
       strA[i]:=ch;
       inc(i);
       end;
    end;
    ukzv^.avt:=copy(strA, 1, i-1);
   read(ch);
   while ch<>',' do
    begin
    read(ch);
    if (ch<>',')and(ch<>' ') then
       begin
       strI[j]:=ch;
       inc(j);
       end;
    end;
    ukzv^.Im:=copy(strI,1,j-1);
    read(ch, ukzv^.god, ch, ch, ch, ukzv^.cen);
    readln;
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
 writeln(ukzv^.nom,', ',ukzv^.avt,', ',ukzv^.im,', ',ukzv^.god,', ',ukzv^.cen);
 ukzv:=ukzv^.sled;
 end;
 writeln;
 ukzv:=ukzv^.pred;
 while ukzv^.pred<>nil do
 begin
 writeln(ukzv^.nom,', ',ukzv^.avt,', ',ukzv^.im,', ',ukzv^.god,', ',ukzv^.cen);
 ukzv:=ukzv^.pred;
 end;
 writeln;
end;

procedure p3(var uksp:next);
var ukzv,ukzv2,p:next; c:uk;
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
        c.nom:=ukzv^.nom;
        c.avt:=ukzv^.avt;
        c.im:=ukzv^.im;
        c.god:=ukzv^.god;
        c.cen:=ukzv^.cen;

        ukzv^.nom:=ukzv2^.nom;
        ukzv^.avt:=ukzv2^.avt;
        ukzv^.im:=ukzv2^.im;
        ukzv^.god:=ukzv2^.god;
        ukzv^.cen:=ukzv2^.cen;

        ukzv2^.nom:=c.nom;
        ukzv2^.avt:=c.avt;
        ukzv2^.im:=c.im;
        ukzv2^.god:=c.god;
        ukzv2^.cen:=c.cen;

        ukzv:=ukzv2;
        ukzv2:=ukzv2^.pred;
   end
   else
       ukzv2:=ukzv2^.pred;
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
p2(uksp);
p3(uksp);
p2(uksp);
close(input);
close(output);
end.