const
  MAX = 10;
{.........................................................}
type
  {.........................................................}
  U = ^Prog;
  {.........................................................}
  Prog = record
    INF: integer;
    Spis1: U;
    Spis2: U;
  end;
{.........................................................}
var
  Head, run, x, nextu, beforei, beforej: U;
  i, k, j: integer;
{.........................................................}
{Создание первого пустого элемента}
procedure First(var Run, Head: U);
begin
  new(run);
  Head := run;
  run^.INF := 0;
  run^.Spis1 := nil;
  run^.Spis2 := nil;
end;
{.........................................................}
{Создание последнего пустого элемента}
procedure Last(var Run: U);
begin
  new(run^.Spis1);
  Run^.Spis2 := run^.Spis1;
  Run := run^.Spis1;
  Run^.INF := 0;
  Run^.Spis1 := nil;
  Run^.Spis2 := nil;
end;
{.........................................................}
{Создание середины}
procedure Middle(var Run: U);
begin
  new(run^.Spis1);
  Run^.Spis2 := run^.Spis1;
  Run := run^.Spis1;
  Run^.INF := random(100);
  Run^.Spis1 := nil;
  Run^.Spis2 := nil;
end;
{.........................................................}
{Процедура создания}
procedure Create(MAX: Integer; var Run, Head: U);
var
  i: integer;
begin
  for i := 1 to MAX+2 do
    if i = 1 then First(Run, Head)
    else if i = MAX then Last(Run)
    else Middle(Run);
end;
{.........................................................}
{Вывод списков на печать}
procedure Print(Head: U; Select: boolean);
var
  Run: U;
begin
  if Select = true then Run := Head^.Spis2
  else Run := Head^.Spis1;
  while Run^.Spis2 <> nil do 
  begin
    write(Run^.inf, ' ');
    if Select = true then 
      run := run^.Spis2 else
      run := run^.Spis1
  end;
end;
{.........................................................}
{Перестановка указателей для продолжения сортировки}
procedure Return(var Run, Nextu: U);
var
  x: U;
begin
  x := Run;
  Run := Nextu;
  Nextu := x;
end;
{.........................................................}
{Если рокеруемые элементы рядом}
procedure Near(i: integer; Head: U; var Nextu, Run: U);
var
  k: integer;
  Beforei: U;
begin
  Beforei := head;
  if i = 1 then beforei := Head else 
    for k := 1 to i - 1 do Beforei := Beforei^.Spis2;
  Run^.Spis2 := Nextu^.Spis2;
  Nextu^.Spis2 := Run;
  Beforei^.Spis2 := Nextu;
end;
{.........................................................}
{Если рокеруемые элементы не рядом}
procedure Far(i, j: integer; Head: U; var Nextu, Run: U);
var
  k: integer;
  Beforei, Beforej, x: U;
begin
  Beforei := Head; Beforej := Head;
  for k := 1 to i - 1 do Beforei := Beforei^.Spis2;
  for k := 1 to j - 1 do Beforej := Beforej^.Spis2;
  Beforei^.Spis2 := nextu;
  Beforej^.Spis2 := run;
  x := nextu^.Spis2;
  Nextu^.Spis2 := Run^.Spis2;
  Run^.Spis2 := x;
end;
{.........................................................}
{Сортировка списка}
procedure Sort(Head: U; var Run, Nextu: U);
var
  Beforei, beforej: U;
  i, j: integer;
begin
  i := 0; Run := Head^.Spis2;
  while Run^.Spis2^.Spis2 <> nil do 
  begin
    i := i + 1; j := i; Nextu := run^.Spis2;
    while Nextu^.spis2 <> nil do 
    begin
      j := j + 1;
      if nextu^.inf < run^.INF then begin
        if Run^.Spis2 = Nextu then Near(i, Head, Nextu, Run)
        else Far(i, j, Head, Nextu, Run);
        Return(Run, Nextu);
      end;
      nextu := nextu^.Spis2;
    end;
    Run := Run^.Spis2;
  end;
end;
{.........................................................}
begin
  Create(MAX, Run, Head);
  Sort(Head, Run, Nextu);
  Print(Head, false);
  Writeln();
  Print(Head, true);
end.