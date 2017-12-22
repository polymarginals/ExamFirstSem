program selectionSort;

const N = 3;

type mass = array[1..N] of integer;

procedure insertSort(var a : mass; length : integer);
var i, j, tmp : integer;
begin
  for i := 2 to length do begin
    tmp := a[i];
    j := i - 1;
    while (j >= 1) and (a[j] > tmp) do begin
      a[j+1] := a[j];
      j := j - 1;
    end;
    a[j+1] := tmp;
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
  insertSort(numbers, N);
  printArray(numbers, N);
  writeln('------------');
end.