Type
  ptr=^sp3 ;
  sp3=record
  x, y, f: integer;
  next: ptr;
end;

Procedure P1(var head: ptr; var input: text);
var
  tmp, search: ptr;
begin
  new(head);
  readln(input, head^.x, head^.y, head^.f);
  head^.next:=nil;
  while not eof(input) do begin

    new(tmp);
    tmp^.next:=nil;
    readln(input, tmp^.x, tmp^.y, tmp^.f);
    search:=head;
    while search <> nil do
      begin
        if (search = head) and ((tmp^.x < search^.x) or ((tmp^.x = search^.x) and (tmp^.y < search^.y))) then
          begin
            tmp^.next:=search;
            head:=tmp;
            break;
          end
        else begin
          if (tmp^.x < search^.next^.x) or ((tmp^.x = search^.next^.x) and (tmp^.y < search^.next^.y)) then
            begin
              tmp^.next:=search^.next;
              search^.next:=tmp;
              break;
            end;
        end;
        if (search^.next = nil) and (search^.x < tmp^.x) then
          search^.next:=tmp;
        search:=search^.next;
      end;
  end;
  tmp^.next:=nil;
end;

Procedure P2(var head: ptr);
var
  tmp1 {Текущий элемент} ,tmp2 {Предшествующий элемент}: ptr;
begin
  tmp1:=head;
  while tmp1^.f = 0 do
    begin
      tmp2:=tmp1^.next;
      dispose(tmp1);
      tmp1:=tmp2;
    end;
  head:= tmp1;
  tmp2:=head;
  tmp1:=head^.next;

  while tmp1 <> nil do
    begin
      if tmp1^.f = 0 then
        begin
          tmp2^.next:=tmp2^.next^.next;
          dispose(tmp1);
          tmp1:=tmp2^.next;
        end
      else
        begin
          tmp1:=tmp1^.next;
          tmp2:=tmp2^.next;
        end;
    end;
end;

procedure P3(head: ptr; x:integer; var output: text);
begin
  while head <> nil do
    begin
      if head^.f > x then
        writeln(output, head^.x, ' ', head^.y,' ', head^.f);
      head:=head^.next;
    end;
    Writeln(output);
end;

procedure P4(head: ptr; var output: text);
begin
  while head <> nil do begin
    writeln(output, head^.x, ' ', head^.y,' ', head^.f);
    head:=head^.next;
  end;
  writeln(output);
end;



var
  head: ptr;
  input, output: text;
  x: integer;
Begin
  assign(input,'input.txt');
  reset(input);
  P1(head, input);
  close(input);
  assign(output,'output.txt');
  rewrite(output);
  P4(head, output);
  P2(head);
  P4(head, output);
  Writeln('Write number');
  Readln(x);
  P3(head, x, output);
  P4(head, output);
  close(output);
End.