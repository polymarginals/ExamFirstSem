program selectionSort;

const N = 3;

type mass = array[1..N] of integer;

procedure selectSort(var a : mass; length : integer);
var i, j, tmp, min : integer;
begin
  for i := 1 to length - 1 do begin
    min := i;
    for j := i + 1 to length do
      if a[min] > a[j] then
        min := j;
    if min<>i then begin
      tmp := a[i];
      a[i] := a[min];
      a[min] := tmp;
    end;
  end;
end;

procedure printArray(a : mass; length : integer);
var i : integer;
begin
  for i:=1 to length do begin
    write(a[i]);
  end;
  writeln;
end;

var numbers : mass;

begin
  numbers[1] := 2;
  numbers[2] := 1;
  numbers[3] := 3;
  printArray(numbers, N);
  selectSort(numbers, N);
  printArray(numbers, N);
  writeln('------------');
end.