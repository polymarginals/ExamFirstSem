program ex17;
uses crt;

type
    a = ^elem;
    dan = record       
        num: integer;
        name: string;   
    end;
    elem = record
      tp: dan;
      sled: a;
    end;
    t = file of dan;

var
ukstr1,ukstr2,golova: a;
f0: text;
f: t;

procedure P1(var f1: t; var ff: text); {Чтение в типизированный}
var
buf: dan;
begin
while not eof(ff) do begin;
read(ff,buf.num); readln(ff,buf.name);   {Читаем по полям}
write(f1,buf);                           {Запись целиком}
end;
end;

procedure P2(var f1: t;var head: a);
var
buf: dan;
uksp: a;          {Создание одного списка}
temp: a;
begin
new(uksp);                {Делаем первый пустой и последний пустой}
head:=uksp;
new(uksp^.sled);
uksp^.sled^.sled:=nil;
while not eof(f) do begin
uksp:=head;
new(temp);        {Создаем новый элемент и читаем в него инфу}
read(f1,buf);     {Записывать можно прям запись целиком}
temp^.tp:=buf;
while (uksp^.sled^.tp.name < temp^.tp.name) and (uksp^.sled^.sled<> nil) do
 uksp:=uksp^.sled;                  {Ведем поиск места для нового элемента}
 temp^.sled:=uksp^.sled;   {Как нашли - вставляем его указателями}
 uksp^.sled:=temp;
end;
end;

procedure P4(var head1,head2,sim: a);  {Слияние в общий список}
var                          {sim - голова на общий список}
uksp1,uksp2: a;
ukzv: a;
begin
new(ukzv);      {Создаем в общем первый пустой}
sim:=ukzv;
uksp1:=head1^.sled;   {Ставим в списках на первые}
uksp2:=head2^.sled;
while (uksp1^.sled<>nil) or (uksp2^.sled<>nil) do begin   {Пока оба списка }
      new(ukzv^.sled);                                  {не кончатся}
      ukzv:=ukzv^.sled;
      if (uksp1^.sled=nil) or (uksp2^.sled=nil) then begin
         if uksp1^.sled = nil then begin    {Если один кончился, то }
            ukzv^.tp:=uksp2^.tp;
            uksp2:=uksp2^.sled; end         {Запись идет только из другого}
         else begin
            ukzv^.tp:=uksp1^.tp;
            uksp1:=uksp1^.sled; end;
      end
      else begin                  {Если оба еще не кончились, то}
           if uksp1^.tp.name < uksp2^.tp.name then begin
              ukzv^.tp:=uksp1^.tp;
              uksp1:=uksp1^.sled; end       {Сравниваем элементы и выбираем}
           else begin
                ukzv^.tp:=uksp2^.tp;
                uksp2:=uksp2^.sled; end;
      end;
end;
new(ukzv^.sled);             {Последний создадим пустым}
ukzv^.sled^.sled:=nil;
end;

procedure P5(var head: a;var ff: text);
var
uksp: a;                            {Вывод списка в файл}
begin
uksp:=head^.sled;
while uksp^.sled<>nil do begin
writeln(ff,uksp^.tp.num,uksp^.tp.name);
uksp:=uksp^.sled;
end;
end;


begin
assign(f0,'rez.out');
rewrite(f0);
close(f0);
clrscr;
{---}
assign(f0,'v1.inp');
reset(f0);
assign(f,'o1.tip');
rewrite(f);
P1(f,f0);
close(f0);
close(f);
{---}
assign(f0,'v2.inp');
reset(f0);
assign(f,'o2.tip');
rewrite(f);
P1(f,f0);
close(f0);
close(f);
{---}
assign(f,'o1.tip');
reset(f);
P2(f,ukstr1);
close(f);
{---}
assign(f,'o2.tip');
reset(f);
P2(f,ukstr2);
close(f);
{---}
assign(f0,'rez.out');
append(f0);
writeln(f0,'  Первый список:');
P5(ukstr1,f0);
writeln(f0);
close(f0);
{---}
assign(f0,'rez.out');
append(f0);
writeln(f0,'  Второй список:');
P5(ukstr2,f0);
writeln(f0);
close(f0);
{---}
P4(ukstr1,ukstr2,golova);
{---}
assign(f0,'rez.out');
append(f0);
writeln(f0,'  Общий список:');
P5(golova,f0);
writeln(f0);
close(f0);
{---}
writeln('Done');
readkey;
end.