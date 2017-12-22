var t1,t2:text;
var A: Array [1..5,1..10] of integer;
var i,j,elem,k,c:integer;
begin
 assign(t1,'C:\Users\Богдан\Desktop\ВУЗ\Программы\input.txt');
 assign(t2,'C:\Users\Богдан\Desktop\ВУЗ\Программы\output.txt');
 reset(t1);
 rewrite(t2);
 
 for i:=1 to 5 do begin
  j:=1;
  While not EOLN(t1)do begin
   read (t1,elem);
   A[i,j]:=elem;
   j:=j+1;
  end;
  readln(t1);
 end;
 
 for i:=1 to 5 do 
  for j:=1 to 9 do
   for k:=j+1 to 10 do
   if A[i,k]>A[i,j] then begin
    c:=A[i,j];
    A[i,j]:=A[i,k];
    A[i,k]:=c;
   end;
 
 for i:=1 to 5 do begin
  for j:=1 to 10 do begin
  if A[i,j]<>0 then write(t2,A[i,j],' ')
  end;
 writeln(t2);
 end;

 close(t1);
 close(t2);
end.