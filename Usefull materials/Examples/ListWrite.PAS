type
  ptr=^list;
  list=record
    inf:  integer;
    next: ptr;
  end;

procedure WriteInvList(head: ptr; var output: text); 
begin
  if head^.next <> nil then
    WriteInvList(head^.next, output);
  Writeln(output, head^.inf);
end;

procedure CreateList(var head: ptr; var input: text);
var
  tmp: ptr;
begin
  new(head);
  read(input, head^.inf);
  tmp:=head;
  while not eof(input) do
    begin
      new(tmp^.next);
      read(input, tmp^.next^.inf);
      tmp:=tmp^.next;
    end;
  tmp^.next:=nil;
end;

procedure WriteList(head: ptr; var output: text);
begin
  while head <> nil do begin
    writeln(output, head^.inf);
    head:=head^.next;
  end;
  writeln(output);
end;

Var
  input, output: text;
  head: ptr;
  
Begin
  assign(input,'input.txt');
  reset(input);
  CreateList(head, input);
  close(input);
  assign(output,'output.txt');
  rewrite(output);
  WriteList(head, output);
  WriteInvList(head, output);
  close(output);
End.