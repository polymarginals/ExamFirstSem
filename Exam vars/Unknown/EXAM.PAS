program exem;

type
mas=array[1..3]of integer;
st=^el;
el=record
         nam:string;
         dat:mas;
         cen:longint;
         kol:integer;
         nex:st end;

var
s:st; t:text;

procedure p1(var c:st; f:string);
var t:text; n:st; q:char;
begin
  assign(t,f);
  reset(t);
  new(c);
  n:=c;
  while not eof(t) do
  begin
    new(n^.nex);
    n:=n^.nex;
    readln(t,n^.dat[3],n^.dat[2],n^.dat[1],n^.cen,n^.kol,q,n^.nam);
  end;
  new(n^.nex);
  n^.nex^.nex:=nil;
  close(t)
end;

procedure p2(var c:st);
var n,v:st; i:byte;
begin
  i:=0;
  n:=c;
  new(v);
  writeln('Vvedite novuu zapis');
  write('naimenovanie tovara s BOLSHOY bukvi- ');
  readln(v^.nam);
  write('day - ');
  readln(v^.dat[3]);
  write('month - ');
  readln(v^.dat[2]);
  write('year - ');
  readln(v^.dat[1]);
  write('cena tovara - ');
  readln(v^.cen);
  write('kolichestvo - ');
  readln(v^.kol);
  while n^.nex^.nex<>nil do
  begin
    n:=n^.nex;
    if i=0 then
       if (n^.nam=v^.nam)and(n^.dat[1]=v^.dat[1])and(n^.dat[2]=v^.dat[2])and
       (n^.dat[3]=v^.dat[3])and(n^.cen=v^.cen) then begin i:=i+1; n^.kol:=n^.kol+v^.kol end
  end;
  if i=0 then
  begin
    v^.nex:=n^.nex; {v konec predposlednim}
    n^.nex:=v;
  end
end;

procedure p3(var c:st);
var n,n1:st; i:integer; x1,x2:longint;
begin
  i:=1;
  while i<>0 do
  begin
    n:=c;
    i:=0;  {kol-vo perestanovok}
    while n^.nex^.nex^.nex<>nil do
    begin
      x1:=(n^.nex^.dat[1]*373)+(n^.nex^.dat[2]*31)+n^.nex^.dat[3];
      x2:=(n^.nex^.nex^.dat[1]*373)+(n^.nex^.nex^.dat[2]*31)+n^.nex^.nex^.dat[3];
      if x1<x2 then
      begin
          i:=i+1;
          n1:=n^.nex;
          n^.nex:=n^.nex^.nex;
          n1^.nex:=n^.nex^.nex;
          n^.nex^.nex:=n1
      end;
      n:=n^.nex
    end;
   end
end;

procedure p4(c:st);
var n:st; h:char;
begin
  h:=':';
  n:=c;
  writeln(t,'****************************');
  while n^.nex^.nex<>nil do
  begin
    n:=n^.nex;
    writeln(t,n^.dat[3],h,n^.dat[2],h,n^.dat[1],'god ',n^.cen,'p. ',n^.kol,'sht. ',n^.nam)
  end
end;

begin
  assign(t,'otsortirovanniy.pas');
  rewrite(t);
  p1(s,'spisok.pas');
  p4(s);
  p2(s);
  p3(s);
  p4(s);
  close(t);
end.