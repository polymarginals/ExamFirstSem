program ex6;

type

t=^el;
el = record
name:string[10];
kol:integer;
sl:t;
end;

procedure putsp(var uksp_s,uksp_z:t;var f,h:text); {создаем 2 списка. Один для склада, другой для заявок}
var
ukzv:t;
begin
new(ukzv);           {формируем склад}
uksp_s:=ukzv;
uksp_s^.sl:=nil;
while not EOF(f) do begin
new(ukzv^.sl);
ukzv:=ukzv^.sl;
readln(f,ukzv^.name,ukzv^.kol);
ukzv^.sl:=nil;
end;
new(ukzv);        {формируем заявки}
uksp_z:=ukzv;
uksp_z^.sl:=nil;
while not EOF(h) do begin
new(ukzv^.sl);
ukzv:=ukzv^.sl;
readln(h,ukzv^.name,ukzv^.kol);
ukzv^.sl:=nil;
end;
end;

procedure getsp(var uksp_s,uksp_z:t; var g:text); {просто процедура вывода двух списков один под другим}
var
ukzv:t;
begin
writeln(g,'Na sklade:');
ukzv:=uksp_s^.sl;
while ukzv<>nil do begin
writeln(g,ukzv^.name,ukzv^.kol);
ukzv:=ukzv^.sl;
end;
writeln(g);
writeln(g,'Spisok zayavok:');
ukzv:=uksp_z^.sl;
while ukzv<>nil do begin
writeln(g,ukzv^.name,ukzv^.kol);
ukzv:=ukzv^.sl;
end;
end;

procedure correction(var uksp_s,uksp_z:t);  {процедура корректировки значений}
var
ukzv,temp,p,f:t;  {temp - бегущий указатель для заявок, ukzv - для склада}
begin
temp:=uksp_z^.sl;
p:=uksp_z;  {предыдущий элемент, нужен для dispose заявок, которые удовлетворены}
while temp<>nil do begin  {пробегаем по всем заявкам и ищем им соответствие на складе}
 f:=temp^.sl; {след. элемент, тоже нужен для dispose ниже}
 ukzv:=uksp_s^.sl;
 while ukzv<>nil do begin
  if temp^.name = ukzv^.name then begin {если имена там и там равны, то анализируем количество и делаем необходимые операции}
   if temp^.kol <= ukzv^.kol then begin
    ukzv^.kol:= ukzv^.kol - temp^.kol;
    dispose(temp);    {тот самый диспоуз - удаление удовлетворенных заявок}
    p^.sl:=f;
   end;
   if temp^.kol > ukzv^.kol then begin
    temp^.kol:= temp^.kol - ukzv^.kol;
    ukzv^.kol:=0;
    end;
  end;       {конец обработки}
  ukzv:=ukzv^.sl;
  end;
  p:=temp; {запись предыдущего элемента для диспоуза}
  temp:=temp^.sl;
end;
end;

var
f,h,g:text;
uksp_s,uksp_z:t;

begin             {головная, ну тут все понятно}
assign(f,'ex6-1.inp');
assign(g,'ex6.out');
assign(h,'ex6-2.inp');
reset(f);
reset(h);
rewrite(g);
putsp(uksp_s,uksp_z,f,h);
close(f);
close(h);
writeln(g,'Do obrabotki:');
getsp(uksp_s,uksp_z,g);
correction(uksp_s,uksp_z);
writeln(g);
writeln(g,'Posle obrabotki:');
getsp(uksp_s,uksp_z,g);
close(g);
end.