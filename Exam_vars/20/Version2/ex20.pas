program ex20;
uses crt;

type
    a =^dan;
    dan = record
      name: string;
      day: integer;
      month: integer;
      year: integer;
      price: integer;
      num: integer;
      sled: a;
    end;

var
ukstr: a;
f1: text;

procedure making(var head: a);
var
str: string;
i: integer;
ukzv: a;
f: text;
begin
assign(f,'vhod.inp');
reset(f);                         {Первый пустой}
new(ukzv);
head:=ukzv;
while not eof(f) do begin
readln(f,str);
new(ukzv^.sled);
ukzv:=ukzv^.sled;
i:=1;
while str[i]<>' ' do                {Гнилое заполнение полей из строки}
i:=i+1;
ukzv^.name:=copy(str,1,i-1);
i:=i+1;
ukzv^.day:=0;
while str[i]<>'.' do begin
ukzv^.day:=ukzv^.day*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
ukzv^.month:=0;
while str[i]<>'.' do begin
ukzv^.month:=ukzv^.month*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
ukzv^.year:=0;
while str[i]<>' ' do begin
ukzv^.year:=ukzv^.year*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
ukzv^.price:=0;
while str[i]<>' ' do begin
ukzv^.price:=ukzv^.price*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
ukzv^.num:=0;
while i<=length(str) do begin
ukzv^.num:=ukzv^.num*10+ord(str[i])-48;
i:=i+1;
end;
end;
new(ukzv^.sled);                     {Последний пустой}
ukzv^.sled^.sled:=nil;
close(f);
end;

procedure adding(var head: a);
var
ukzv: a;
buf,tm: a;
str: string;
i: integer;
begin
new(buf);                 {Создали новую ячейки}
writeln('Введите новую запись по формату "Наим ДД.ММ.ГГГГ Цена Кол-во" :');
read(str);
i:=1;
while str[i]<>' ' do            
i:=i+1;
buf^.name:=copy(str,1,i-1);
i:=i+1;
buf^.day:=0;
while str[i]<>'.' do begin
buf^.day:=buf^.day*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
buf^.month:=0;
while str[i]<>'.' do begin
buf^.month:=buf^.month*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
buf^.year:=0;
while str[i]<>' ' do begin
buf^.year:=buf^.year*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
buf^.price:=0;
while str[i]<>' ' do begin
buf^.price:=buf^.price*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
buf^.num:=0;
while i<=length(str) do begin
buf^.num:=buf^.num*10+ord(str[i])-48;
i:=i+1;
end;

ukzv:=head;  {Поставили на голову, ищем место для новой записи}
while (ukzv^.sled^.name < buf^.name) and (ukzv^.sled^.sled<>nil) do
ukzv:=ukzv^.sled;
tm:=ukzv^.sled;
if (tm^.name=buf^.name) and (tm^.day=buf^.day) and (tm^.month=buf^.month)
and (tm^.year=buf^.year) and (tm^.price=buf^.price) then begin
tm^.num:=tm^.num+buf^.num;    {Если она уже была, то делаем как надо}
dispose(buf);                 {И стираем лишнюю ячейку из памяти}
end
else begin
buf^.sled:=ukzv^.sled;     {Либо вставяем новую запись указателями}
ukzv^.sled:=buf;
end;
end;

procedure sort(var head: a);
var
uksp: a;
pered,work,mu,posle,before: a;   {Указатели для сортировки}
beg: a;
begin
uksp:=head;
while uksp^.sled<>nil do begin   {Описание к сортировке см. в билете 18}
      pered:=uksp;
      uksp:=uksp^.sled;
      work:=uksp;
      mu:=uksp;
      beg:=uksp;
      while beg^.sled<>nil do begin
      if (beg^.year>mu^.year) or
      ((beg^.year=mu^.year) and (beg^.month>mu^.month)) or
      ((beg^.year=mu^.year) and (beg^.month=mu^.month) and (beg^.day>mu^.day))
      then
      mu:=beg;                {Условие выбора}
      beg:=beg^.sled;
      end;
      if mu<>work then begin
      posle:=mu^.sled;
      before:=head;
      while before^.sled<>mu do
      before:=before^.sled;
      pered^.sled:=before^.sled;  {Переставляем 3 указателя}
      mu^.sled:=work;
      before^.sled:=posle;
      end;
pered:=pered^.sled;       {Переход далее}
uksp:=pered;
end;
end;

procedure vivod(var head: a);
var
uksp: a;
f: text;
begin
assign(f,'rez.out');
append(f);                       {Простой вывод}
uksp:=head^.sled;
while uksp^.sled<>nil do begin
write(f,uksp^.name,' ',uksp^.day,'.',uksp^.month);
writeln(f,'.',uksp^.year,' ',uksp^.price,' ',uksp^.num);
uksp:=uksp^.sled;
end;
writeln(f);
close(f);
end;

begin
assign(f1,'rez.out');
rewrite(f1);
writeln(f1,'  Исходные данные__:');
close(f1);
clrscr;
making(ukstr);          {Оформление}
vivod(ukstr);
append(f1);
writeln(f1,'  Новые данные по датам__:');
close(f1);
write('Список готов.');
adding(ukstr);
sort(ukstr);
vivod(ukstr);
writeln('Done');
readkey;
end.