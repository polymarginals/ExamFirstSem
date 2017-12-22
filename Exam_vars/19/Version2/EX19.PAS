program ex19;
uses crt;

type
    a = ^dan;
      dan = record
      num: integer;
      author: string;
      name: string;
      year: string;
      cost: string;
      sled: a;
      pred: a;
      end;

procedure form(var head,ass: a);
var
ukzv,this: a;
f: text;
before: a;
i,j: integer;
str: string;
begin
assign(f,'vhod.inp');
reset(f);
{Создаем первый и последний элементы пустыми}
new(ukzv);
ukzv^.pred:=nil;
head:=ukzv;
before:=ukzv;
new(ukzv^.sled);
ukzv:=ukzv^.sled;
ukzv^.sled:=nil;
{Начинаем читать данные из списка}
while not eof(f) do begin
readln(f,str); {Читаем одну запись как строку}
new(this);
i:=1;
this^.num:=0;
while str[i] <> ' ' do begin {Здесь идет перевод в число из строки}
this^.num:=this^.num*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1; {Переходим к автору}
j:=i;
while str[j]<>' ' do {Находим место, где автор кончается}
j:=j+1;
this^.author:=copy(str,i,j-i); {Копируем диапазон символов в поле списка}
i:=j+1; {Переходим к названию и повторяем вышеуказанное, как с автором}
j:=i;
while str[j]<>' ' do
j:=j+1;
this^.name:=copy(str,i,j-i); {Тут тоже копирование}
i:=j+1; {Переход на чтение года}
j:=i;
while str[j]<>' ' do
j:=j+1;
this^.year:=copy(str,i,j-i); {Тоже копирование}
i:=j+1;
this^.cost:=copy(str,i,length(str)-i+1); {Копируем оставшиеся символы в поле цены}

{Ищем место для вставки новой записи. Поиск идет до последнего непустого
элемента, и если нашли такой элемент, что следующий за ним по номеру
больше нового, то останавливаемся.}
ukzv:=head;
while (ukzv^.sled^.sled<>nil) and (ukzv^.sled^.num < this^.num) do
ukzv:=ukzv^.sled;
{Просто переносим два указателя. Текущий указывает теперь следом на новый,
а новый следом указывает на остаток списка}
this^.sled:=ukzv^.sled;
ukzv^.sled:=this;
end;

{Проставим указатели на обратный порядок и запомним последний пустой}
ukzv:=head^.sled;
before:=head;
while ukzv<>nil do begin
ukzv^.pred:=before;
before:=ukzv;
ukzv:=ukzv^.sled;
end;
ass:=before;
close(f);
end;

{Процедура вставки новой записи. Имеет тот же алгоритм, что и при
формировании списка, когда вставляли по поиску места новый элемент}
procedure newelem(var head:a);
var
mem,ukzv: a;
i,j: integer;
str: string;
begin
writeln('Введите новые данные: (Пробелы в названии разделяйте знаком _ )');
readln(str);
{Создаем ячейку в памяти компа и читаем аналогично чтению выше}
new(mem);
i:=1;
mem^.num:=0;
while str[i] <> ' ' do begin
mem^.num:=mem^.num*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
j:=i;
while str[j]<>' ' do
j:=j+1;
mem^.author:=copy(str,i,j-i);
i:=j+1;
j:=i;
while str[j]<>' ' do
j:=j+1;
mem^.name:=copy(str,i,j-i);
i:=j+1;
j:=i;
while str[j]<>' ' do
j:=j+1;
mem^.year:=copy(str,i,j-i);
i:=j+1;
mem^.cost:=copy(str,i,length(str)-i+1);

{Проводим поиск места для вставки нового элемента, прям как в процедуре выше}
ukzv:=head;
while (ukzv^.sled^.sled<>nil) and (ukzv^.sled^.num < mem^.num) do
ukzv:=ukzv^.sled;
{Меняем так же местами, но добавляя переназначение указателей на предыдущ.}
mem^.sled:=ukzv^.sled;
mem^.pred:=ukzv;
ukzv^.sled:=mem;
ukzv:=mem^.sled;
ukzv^.pred:=mem;
end;

procedure poisk(head,ass: a);
var
ukzv:a;
i: integer;
avtor,nazv: string;
f: text;
begin
assign(f,'out.out');
append(f);
writeln('Поиск начинается...');
write('Введите название книги: ');
readln(nazv);
write('Введите автора книги: ');
readln(avtor);
i:=1;
{Если Первая буква Автора от А до К, то поиск идет слева}
if avtor[1] <= 'K' then begin
ukzv:=head^.sled;
while ukzv^.sled <> nil do begin
{Если нашли - нижу действия. Выписываем в файл данные}
if (ukzv^.author = avtor) and (ukzv^.name = nazv) then begin
writeln('Ваша книга найдена. Она ',i,' слева в списке');
writeln(f,'Вы искали и нашли книгу - ',ukzv^.name);
write(f,'Цена - ',ukzv^.cost,'rub');
writeln(f,'Год издания - ',ukzv^.year);
i:=0;
break; end; {И кончаем цикл поиска}
i:=i+1;
ukzv:=ukzv^.sled;
end;
{Если не нашли, то выведем сообщение}
if i<>0 then writeln(f,'Такой книги нет');
end;
{Если автор с L-Z, то поиск справа аналогично}
if avtor[1] > 'K' then begin
ukzv:=ass^.pred;
while ukzv^.pred <> nil do begin
if (ukzv^.author = avtor) and (ukzv^.name = nazv) then begin
writeln('Ваша книга найдена. Она ',i,' справа в списке');
writeln(f,'Вы искали и нашли книгу - ',ukzv^.name);
write(f,'Цена - ',ukzv^.cost,'rub ');
writeln(f,'Год издания - ',ukzv^.year);
i:=0;
break; end;
i:=i+1;
ukzv:=ukzv^.pred;
end;
if i<>0 then writeln(f,'Такой книги нет');
end;
writeln('Done');
writeln(f,' ');
close(f);
end;

procedure vivod(head,ass: a);
label 1;
var
ukzv: a;
co: string;
f: text;
begin
assign(f,'out.out');
append(f);
writeln(f,'Data:');
1: writeln('Куда выводим? right or left?');
readln(co);
if (co <> 'right') and (co <> 'left') then begin
writeln('Ошибка');
goto 1;
end;
{Вывод вправо. Идем с головы}
if co = 'right' then begin
ukzv:=head^.sled;
while ukzv^.sled <> nil do begin
write(f,ukzv^.num,' ');
write(f,ukzv^.author,' ',ukzv^.name,' ');
writeln(f,ukzv^.year,' ',ukzv^.cost);
ukzv:=ukzv^.sled;
end;
writeln('Done');
end;
{Вывод влево - идем с конца}
if co = 'left' then begin
ukzv:=ass^.pred;
while ukzv^.pred <> nil do begin
write(f,ukzv^.num,' ');
write(f,ukzv^.author,' ',ukzv^.name,' ');
writeln(f,ukzv^.year,' ',ukzv^.cost);
ukzv:=ukzv^.pred;
end;
writeln('Done');
end;
writeln(f);
close(f);
end;

var
ukstr,last: a;
uksp: a;
i: integer;
f1: text;

begin
clrscr;
assign(f1,'out.out');
rewrite(f1);
close(f1);
form(ukstr,last);
writeln('Список книг создан');
vivod(ukstr,last);
newelem(ukstr);
vivod(ukstr,last);
poisk(ukstr,last);
vivod(ukstr,last);
readkey;
end.