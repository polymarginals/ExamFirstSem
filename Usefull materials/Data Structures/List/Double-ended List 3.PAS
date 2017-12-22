program ex;

type
  ukspisok = ^spisok;
  spisok = record   
    stroka: string;
    next, prev: ukspisok;
  end;

var
  x: ukspisok;
  first, current, last: ukspisok;
  inpu: text;

procedure p1(var first, last: ukspisok);
var
  str: string;
  current: ukspisok;
  future: ukspisok;


begin
  assign(inpu, 'input.txt');
  reset(inpu);
  first := nil;
  readln(inpu, str);
  new(first);
  first^.stroka := str;
  current := first;
  first^.prev := nil;
  new(future);
  first^.next := future;
  while not eof(inpu) do
  begin
    readln(inpu, str);
    future^.stroka := str;
    future^.prev := current;
    current := future;
    new(future);
    future^.next := future;
  end;
end;

procedure p2(var first: ukspisok);
var
  str: string;
begin
  assign(outpu, 'output.txt');
  rewrite(outpu);
  current := first;
  current^.stroka := str;
  writeln(outpu, str);
  writeln(str);
  close(outpu);
end;

begin
  p1(first, last);
  p2(first);
end.