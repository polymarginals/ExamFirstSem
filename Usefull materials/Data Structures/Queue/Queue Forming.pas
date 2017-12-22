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
   Tail:=head;
   Head^.inf:=i;
   Head^.next:=nil;
  end else begin
   new(M);
   Tail^.Next:=M;
   Tail:=M;
   Tail^.inf:=i;
   Tail^.Next:=nil;
  end;
 end;
 
 M:=head;
 While M<>nil do begin
  Write(M^.inf,' ');
  M:=M^.Next;
 end;
end.