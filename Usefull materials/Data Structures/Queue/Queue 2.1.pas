program new1;

uses
  crt;

type
  next = ^node;
  node = record
    Num: Integer;
    pointer: next;
  end;

procedure p1(var lbeg: next; var n: integer);{ввод списка}
var
  p1: next;
  f1: text;

begin
  assign(f1, 'input.txt');
  reset(f1);
  n := 0;
  if not (eof(f1))
    then
  begin
    new(lbeg);
    readln(f1, lbeg^.Num);
    lbeg^.pointer := nil;
    p1 := lbeg;
    n := 1;
    while not (eof(f1)) do
    begin
      new(p1^.pointer);
      p1 := p1^.pointer;
      readln(f1, p1^.num);
      p1^.pointer := nil;
      Inc(n);
      {writeln(p1^.num); }
    end;
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
  
  WriteLn( 'Начало списка');
  p1 := lbeg;
  while p1 <> nil do
  begin
    writeLn( p1^.Num);
    p1 := p1^.pointer;
  end;
  WriteLn('Конец списка');
  close(f2);
end;

procedure p22(var lbeg: next);{поиск}
var
  p1: next;
  fla: boolean;
begin
  fla := false;
  
  
  p1 := lbeg;
  while p1 <> nil do
  begin
    if (p1^.Num mod 2) = 1
      then
    begin
      writeLn( p1^.Num);
      fla := true;
    end;
    p1 := p1^.pointer;
  end;
  if fla = false then
    writeLn('элементы не найдены');
end;

procedure p3(var lbeg: next);{удаление списка}
var
  p1: next;
begin
  p1 := lbeg;
  while lbeg <> nil do
  begin
    lbeg := lbeg^.pointer;
    dispose(p1);
    p1 := lbeg;
    
  end;
end;

procedure delelem(var lbeg : next; n : integer);   // удаление элемента
  var
    p1, p2 : next;
    flag : boolean;

begin
   new(p1);
   p1^.pointer := lbeg;
   
   lbeg := p1;

   while p1^.pointer <> nil do
     begin
       flag := false;
       if p1^.pointer^.Num = n then
         begin
           p2 := p1^.pointer;
           p1^.pointer := p1^.pointer^.pointer;
           dispose(p2);
           flag := true;
         end;
       if flag = false
         then
           p1 := p1^.pointer;
     end;
   p2 := lbeg;
   lbeg := lbeg^.pointer;
   dispose(p2);

end;


procedure p41(lbeg: next; n: integer);{сортировка}
var
  p1: next;
  tmp,
  i,
  j: integer;
begin
  for i := 1 to n - 1 do
  begin
    p1 := lbeg;
    for j := 1  to n - i do
    begin
      if p1^.Num > p1^.pointer^.Num
          then
      begin
        tmp := p1^.Num;
        p1^.Num := p1^.pointer^.Num;
        p1^.pointer^.Num := tmp;
      end;
      
      
      p1 := p1^.pointer;
    end;
  end;
end;

var
  lbeg: next;
  n: integer;

begin
  clrscr;
  p1(lbeg, n);
  p2(lbeg);
  p22(lbeg);
  //p41(lbeg, n);

  delelem(lbeg,12);

  p2(lbeg);
end.