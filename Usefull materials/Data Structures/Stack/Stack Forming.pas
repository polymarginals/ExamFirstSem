Type Stek=^Mas;

MAS=record
inf:integer;
Next:Stek;
end;

Var
i,j:integer;
M,head,tail:Stek;

begin

 For i:=1 to 10 do begin
  if i=1 then begin
   new(Head);
   Head^.inf:=i;
   Head^.next:=nil;
  end else begin
   new(M);
   M^.Next:=Head;
   M^.inf:=i;
   Head:=M;
  end;
 end;
 
 M:=head;
 While M<>nil do begin
  Write(M^.inf,' ');
  M:=M^.Next;
 end;
end.