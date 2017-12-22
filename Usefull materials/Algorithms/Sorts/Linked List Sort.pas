Type U=^Mas;
Mas=record
 Num:integer;
 Next:U;
end;
var x,V,head,y:U;
i:integer;

begin

new(x);
x^.Num:=Random(100);
x^.Next:=nil;
Head := x;
for i:=1 to 10 do begin
 new(x^.Next);
 x:=x^.Next;
 x^.Num:=Random(100);
 x^.Next:=nil;
end;

V:=Head;
While V<>nil do begin
 Write(V^.num);
 writeln();
 V := V^.Next;
end;

{x:=head;
y:=Head^.Next;
i:=x^.Num;
x^.Num:=y^.Num;
y^.Num:=i;}

//Сортировка линейного списка
x:=head;
while x<>nil do begin
y:=x^.Next; 
 while y<>nil do begin 
  if y^.Num>x^.Num then begin
   i:=x^.Num;
   x^.Num:=y^.Num;
   y^.Num:=i;
   end;
 y:=y^.Next;
 end;
 x:=x^.Next;
end;
 

writeln();

V:=Head;
While V<>nil do begin
 Write(V^.num);
 writeln();
 V := V^.Next;
end;

end.