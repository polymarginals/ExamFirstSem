program new1;

type
  next = ^node;
  node = record
    Num: Integer;
    pointer: next;
  end;

procedure p1(var lbeg: next);{ввод списка}
var
  p1: next;
  f1: text;
begin
  assign(f1, 'input.txt');
  reset(f1);
  
  {new(lbeg);
  lbeg^.num := 5;
  lbeg^.pointer := nil;
  p1 := lbeg;
  }
  new(lbeg);
  readln(f1, lbeg^.Num);
  lbeg^.pointer := nil;
  p1 := lbeg;
  
  while not (eof(f1)) do
  begin
    new(p1^.pointer);
    p1 := p1^.pointer;
    readln(f1, p1^.num);
    p1^.pointer := nil;
    {writeln(p1^.num); }
  end;
  close(f1);
end;

procedure p2(var lbeg: next);{вывод списка}
var
  p1: next;
  f2: text;
begin
  assign(f2, 'output.txt');
  rewrite(f2);
  
  WriteLn(f2, 'Начало списка');
  p1 := lbeg;
  while p1 <> nil do
  begin
    writeLn(f2, p1^.Num);
    p1 := p1^.pointer;
  end;
  WriteLn(f2, 'Конец списка');
  close(f2);
end;

procedure p3(var lbeg: next);{удаление списка}
var
  p1: next;
begin
  while lbeg <> nil do
  begin
    //lbeg := p1;
    p1 := lbeg;
    p1 := p1^.pointer;
    dispose(p1^.pointer);
    //dispose(lbeg);
  end;
end;


var
  lbeg: next;

begin
  p1(lbeg);
  p2(lbeg);
  p3(lbeg);
end.