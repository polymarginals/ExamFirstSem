var t1,t2:text;
var A:array[1..10,1..20] of char;
i,j,sred,sred2,k:integer;
sim:char;
begin

 assign(t1,'C:\Users\Богдан\Desktop\ВУЗ\Программы\input1.txt'); reset(t1);
 assign(t2,'C:\Users\Богдан\Desktop\ВУЗ\Программы\output.txt'); rewrite(t2);
 
 for i:=1 to 10 do begin
  j:=1;
  while not EOLN(t1) do begin
  read(t1,A[i,j]);
  j:=j+1;
  end;
  readln(t1);
 end;
 
 for k:=1 to 10 do begin
  for i:=1 to 9 do begin
   sred:=ord(A[i,17])+ord(A[i,18])+ord(A[i,19])+ord(A[i,20]);
   sred2:=ord(A[i+1,17])+ord(A[i+1,18])+ord(A[i+1,19])+ord(A[i+1,20]);
   if sred2>sred then 
   for j:=1 to 20 do begin
    sim:=A[i,j];
    A[i,j]:=A[i+1,j];
    A[i+1,j]:=sim;
   end;
  end;
  end;
  
   for i:=1 to 10 do begin
    if ord(A[i,15])=1084{мужчины} then begin
     for j:=1 to 20 do
      write(t2,A[i,j]);
      writeln(t2);
     end;
    end;
   
  writeln(t2);
  
  for i:=1 to 10 do begin
    if ord(A[i,15])<>1084{мужчины} then begin
     for j:=1 to 20 do
      write(t2,A[i,j]);
      writeln(t2);
     end;
    end;
 
 close(t1);
 close(t2);
 
 END.