Type
  sf=^fl;
  fl=record
  fam: string[15];
  next: sf;
end;

var
  head: sf;
  input, output: text;

procedure P1(var input: text; var head: sf);
  var
    uk: sf;

begin
  head:= nil;

  new(uk);

  readln(input, uk^.fam);
  head:=uk;
  uk^.next:=nil;

  while not eof(input) do begin

    new(uk^.next);
    uk:=uk^.next;
    readln(input, uk^.fam);
  end;
  uk^.next:=nil;
end;

procedure P2(var head: sf);
  var
    spf: string;
    uk1,uk2,su: sf;

begin
  uk1:=head;

  while uk1^.next<>nil do
    begin
      uk2:=uk1^.next;
      su:=uk1;
      while uk2<>nil do
        begin

          if (su^.fam > uk2^.fam) then
            su:=uk2;

          uk2:=uk2^.next;
        end;
      spf:=su^.fam;
      su^.fam:=uk1^.fam;
      uk1^.fam:=spf;
      uk1:=uk1^.next;
    end;
end;

procedure P3(var output: text; var head: sf);
  var
    uk: sf;
begin
  uk:=head;
  while uk <> nil do begin
    writeln(output, uk^.fam);
    uk:=uk^.next;
  end;
  writeln(output);
end;

procedure P4(head: sf);
begin
  if head^.next<>nil then
    P4(head^.next);
  dispose(head);
end;

Begin
  assign(input,'F1.txt');
  reset(input);
  P1(input, head);
  close(input);
  assign(output,'G.txt');
  rewrite(output);
  P3(output, head);
  P2(head);
  P3(output, head);
  P4(head);
  close(output);
End.