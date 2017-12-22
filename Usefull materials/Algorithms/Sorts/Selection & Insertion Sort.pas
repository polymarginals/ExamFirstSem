Sort Vyborom
const n = 10;
 
var
    arr: array[1..n] of byte;
    max, id_max, i, j: byte;
 
begin
    randomize;
    for i := 1 to n do begin
        arr[i] := random(256);
        write(arr[i]:4)
    end;
    writeln;
 
    j := n;
 
    while j > 1 do begin
        max := arr[1];
        id_max := 1;
        for i := 2 to j do
            if arr[i] > max then begin
                max := arr[i];
                id_max := i
            end;
        arr[id_max] := arr[j];
        arr[j] := max;
        j := j - 1
    end;
 
    for i := 1 to n do
        write(arr[i]:4);
 
readln
end.





{сортировка выбором, пример 1}
                          procedure Selekt(var item: DataArray; count:integer);
                          var
                          i, j, k: integer;
                          x: DataItem;
                          begin
                          for i := i to count-1 do
                          begin
                          k := i;
                          x := item[i];
                          for j := i+1 to count do { найти элемент с наименьшим значением }
                          if item[j]<x then
                          begin
                          k := j;
                          x := item[j];
                          end;
                          item[k] := item[i]; { обмен }
                          item[i] := x;
                          end;
                          end;
                          
  vstavki
   for  i:= 2  to  N  do
      if  a[i-1]>a[i]  then
      begin      
         x:= a[i];     
         j:= i-1;  
         while  (j>0) and (a[j]>x)  do
         begin 
            a[j+1]:= a[j];      
            j:= j-1;
         end; 
       a[j+1]:= x;
     end;
     
     program main;
const a: array[1..8] of Integer = (153, 967, 8, 0, 9, 22, 35, 1);
type List=^node;
     node=record
        data: Integer;
        next: list
        end;
var lst: List;

procedure InputSeq(var head: List);
var p,q: List;
begin
    while not EoLn do begin
        new(p);
        read(p^.data);
        if head=nil then
            head:=p
        else q^.next:=p;
        q:=p;
    end;
    p^.next:=nil;
end;

procedure CreateBinFile();
var f:file of Integer;
    i: Integer;
begin
    assign (f,'sequence.dat');
    rewrite (f);
    i:=1;
    while i<=8 do begin
        write (f,a[i]);
        i:=i+1;
    end;
    close (f);
end;

procedure OutputSeq(head: List);
var p: List;
begin
    p:=head;
    while p<>nil do begin
        write(p^.data, ' ');
        p:=p^.next;
    end;
end;

function FirstDigit(n: Integer): Integer;
var first: Integer;
begin
    while n<>0 do begin
        first:=n mod 10;
        n:=n div 10;
    end;
    FirstDigit:=first;
end;

procedure swap(p, q: List);
var temp: List;
begin
    temp:=p;
    p:=q;
    p^.next:=q^.next;
    q:=temp;
    q^.next:=p;
end;

procedure InsertDownSort(head: List);
var p, q, key: List;
begin
    p:=head^.next;
    while p <> nil do begin
        key:=p;
        while (p <> nil) and (p^.data > key^.data) do
            p^.next:=p;
        p^.next:=key;
    end;
end;

procedure BubbleDownSort(var head: List);
var p, q, key: List; 
    temp: Integer;
begin
    p:=head;
    while p<>nil do begin
        q:=p;
        key:=q;
        while q<>nil do begin
            if FirstDigit(key^.data) <= FirstDigit(q^.data) then 
                key:=q;
            q:=q^.next
        end;
        temp:=p^.data; 
        p^.data:=key^.data; 
        key^.data:=temp;
        p:=p^.next
    end
end;

begin
    if not (FileExists('sequence.dat')) then
        CreateBinFile();
    InputSeq(lst);
    InsertDownSort(lst);
    OutputSeq(lst);
end.

const  N=255;
  type array_type=array [1..N] of integer; 
 
  procedure InsertSort(var x:array_type);
     var i, j, buf:integer;
     begin
         for i:=2 to N do
         begin
           buf:=x[i];
           j:=i-1;
           while (j>=1) and (x[j]>buf) do
             begin
               x[j+1]:=x[j];
               j:=j-1;
             end;
           x[j+1]:=buf;
         end;
     end;
     
     
     procedure insert(item:array of char; n:integer);
var
a,b:integer; t:char;
begin
for a:=1 to n-1 do
begin
t:=item[a];
b:=a-1;
while (b>=0) and (t<item[b]) do
begin
item[b+1]:=item[b];
b:=b-1
end;
item[b+1]:=t
end
end;

procedure select(item:array of char; n:integer);
var
a,b,c,ssign:integer;
t:char;
begin
for a:=0 to n-2 do
begin
ssign:=0;
c:=a;
t:=item[a];
for b:=a+1 to n do
if item[b]<t then
begin
c:=b;
t:=item[b];
ssign:=1
end;
if ssign<>0 then
begin
item[c]:=item[a];
item[a]:=t
end
end
end;
