//���������� ���������
{1.��������������� ��� ��������������� ����� ������� , ������ �����
��� �������� �������� �� ����������������� �����. ��� ���� � ��������
������ ��� � ����� ��� ����� ������� ���������� � ������� ������� �����-
������ �� ������ �����.
2.������������ ��� ������� �������� �� ����������������� �����
������� � ����������� � ����������� ����� ��� ��������������� �����
�������.}


var A:array [1..10] of integer;
i,max,j,c,buf:integer;
begin
 for i:=1 to 10 do
  A[i]:=random(100);
  
 for i:=1 to 10 do
  write(A[i],'  ');
  
   for i := 2 to 10 do
  begin
    buf := A[i];
    j := i - 1;
    while (j >= 1) and (A[j] > buf) do
    begin
      A[j + 1] := A[j];
      j := j - 1;
    end;
    A[j + 1] := buf;
  end;
  
 writeln();
 for i:=1 to 10 do
  write(A[i],'  ');
end.