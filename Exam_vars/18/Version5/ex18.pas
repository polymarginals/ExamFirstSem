program bilet18;
uses crt;

type
    a =^dan;
    dan=record
      num: integer;
      data: string;
      next: a;
      sort: a;
    end;

var
ukstr: a;
c1: integer;

procedure making(var head: a);
var
ukzv: a;
f: text;
work,pered,mu,posle,before: a;   {указатели для сортировки}
beg: a;                          {work - рабочий, mu - минимальный}
begin                            {before - перед mu, posle - за mu}
assign(f,'vhod.inp');            {pered - перед work, beg - бегущий}
reset(f);
new(ukzv);
head:=ukzv;
while not eof(f) do begin
new(ukzv^.next);
ukzv^.sort:=ukzv^.next;       {Просто создание списка с первым и посл. пустым}
ukzv:=ukzv^.next;             {указатели sort ставим пока по порядку}
read(f,ukzv^.num);
readln(f,ukzv^.data);
end;
new(ukzv^.next);
ukzv^.sort:=ukzv^.next;
ukzv^.next^.next:=nil;
ukzv^.sort^.sort:=nil;

ukzv:=head;
while ukzv^.sort<>nil do begin   {Начинаем сортировку}
      pered:=ukzv;
      ukzv:=ukzv^.sort;          {Расставляем указатели для начала пробега}
      work:=ukzv;
      mu:=ukzv;
      beg:=ukzv;
      while beg^.sort<>nil do begin
      if beg^.data < mu^.data then    {Бежим до конца и ищем минимальный}
      mu:=beg;
      beg:=beg^.sort;
      end;
      if mu<>work then begin      {Если нашли, то делаем смену}
      posle:=mu^.sort;            {Ставим posle}
      before:=head;
      while before^.sort<>mu do   {Ищем before}
      before:=before^.sort;
      pered^.sort:=before^.sort;  {Переставляем 3 указателя!!}
      mu^.sort:=work;
      before^.sort:=posle;
      end;
pered:=pered^.sort;    {Переходим на поставленный минимальный}
ukzv:=pered;           {и так до конца сортированного списка sort}
end;
end;

procedure adding(var head: a);
var
ukzv: a;
buf: a;
begin
new(buf);
writeln('Добавьте запись. Вместо пробелов в названии должно быть _ :');
read(buf^.num);     {читаем новую запись в новый элемент}
read(buf^.data);
ukzv:=head^.next;
while ukzv^.next^.next<>nil do
ukzv:=ukzv^.next;          {Ставим его в конец обычного списка }
buf^.next:=ukzv^.next;
ukzv^.next:=buf;

ukzv:=head;
while (ukzv^.sort^.data < buf^.data) and (ukzv^.sort^.sort<>nil) do
ukzv:=ukzv^.sort;           {Ищем ему место в сортированном виде}
buf^.sort:=ukzv^.sort;
ukzv^.sort:=buf;
end;

procedure vivod(var head: a; c: integer);
var
uksp: a;
f: text;
begin
assign(f,'rez.out');               {Просто вывод по порядку, а потом сорт.}
if c=0 then begin
rewrite(f);
writeln(f,'Исходные данные__:');
end
else begin
append(f);
writeln(f,'Новые данные__:');
end;
writeln(f,'  По порядку:');
uksp:=head^.next;
while uksp^.next<>nil do begin
write(f,uksp^.num:3);
writeln(f,uksp^.data);
uksp:=uksp^.next;
end;
writeln(f);
writeln(f,'  По алфавиту:');
uksp:=head^.sort;
while uksp^.sort<>nil do begin
write(f,uksp^.num:3);
writeln(f,uksp^.data);
uksp:=uksp^.sort;
end;
writeln(f);
close(f);
end;

begin
clrscr;
making(ukstr);
c1:=0;
writeln('Список сделан');
vivod(ukstr,c1);
writeln('Список выведен в файл');
c1:=1;
adding(ukstr);
vivod(ukstr,c1);
writeln('Новые файлы выведены');
readkey;
end.
