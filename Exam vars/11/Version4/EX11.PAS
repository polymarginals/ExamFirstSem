program ex11;
uses crt;

type
    a = ^dan;
    dan = record
     age: integer;
     num: integer;
     lt,rt:a;
     check:boolean;
     end;

procedure create(var head: a; var co: integer); {Создание}
label 1;
var
f: text;
str: string;
i,vozr: integer;
uksp: a;
buf: a;
begin
assign(f,'vhod.inp');
reset(f);
readln(f,str);
i:=1;
while str[i]<>' ' do      {Прочитали строку}
i:=i+1;
vozr:=0;                  {Идем до цифр}
i:=i+1;
while i<=length(str) do begin
vozr:=vozr*10+ord(str[i])-48;   {Считаем возраст}
i:=i+1;
end;
new(uksp);              {Создаем голову}
uksp^.age:=vozr;        {В нее возраст и число 1(сотрудник один)}
uksp^.num:=1;
uksp^.rt:=nil; uksp^.lt:=nil;
head:=uksp;             {Запоминаем голову}
co:=1;                  {Это счетчик элементов в дереве}

while not eof(f) do begin
readln(f,str);
i:=1;                   {Чтение возраста для каждого нового элемента}
while str[i]<>' ' do
i:=i+1;
vozr:=0;
i:=i+1;
while i<=length(str) do begin
vozr:=vozr*10+ord(str[i])-48;
i:=i+1;
end;
uksp:=head;           {Поиск места идет с головы}

1: if uksp^.age = vozr then begin   {Если в узле уже есть возраст}
   inc(uksp^.num); continue;        {то увеличить счет сотрудников}
   end;
   if vozr < uksp^.age then begin   {Если новый возраст меньше узлового}
      if uksp^.lt = nil then begin  {Если записи еще нет, то создаем}
         new(uksp^.lt);
         uksp:=uksp^.lt;
         uksp^.age:=vozr; uksp^.num:=1; {С новым возрастом и числом 1}
         uksp^.lt:=nil; uksp^.rt:=nil;
         inc(co);                   {Увелич. число элементов дерева}
      end
      else begin               {Если есть левый потомок, то идем на него}
           uksp:=uksp^.lt;     {и по метке снова сравниваем}
           goto 1;
      end;
   end
   else begin
      if uksp^.rt = nil then begin    {Аналогично для случая, если новый}
         new(uksp^.rt);               {возраст больше узла}
         uksp:=uksp^.rt;
         uksp^.age:=vozr; uksp^.num:=1;
         uksp^.lt:=nil; uksp^.rt:=nil;
         inc(co);
      end
      else begin
           uksp:=uksp^.rt;
           goto 1;
      end;
   end;
end;
close(f);
end;

procedure gettree(var head: a);   {Рекурсивная процедура снятия поля check}
begin                             {после обхода итерацией}
if head^.lt<>nil then
gettree(head^.lt);
head^.check:=false;
if head^.rt<>nil then
gettree(head^.rt);
end;

procedure obhod(head: a; co: integer);  {Итеративный обход}
label 2;
var
uksp: a;                      {uksp - бегущий, high - верхний к нему}
high: a;
i: integer;
f: text;
begin
i:=0;
assign(f,'rez.out');
rewrite(f);
gettree(head);
while i<co do begin        {Цикл, пока счетчик не равен числу элементов}
      uksp:=head;
      high:=head;
2:    while (uksp^.lt<>nil) do   {Бежим по левой стороне}
      if (uksp^.lt^.check <> true) then begin {Если след. левый еще не}
            high:=uksp;                                 {вывели}
            uksp:=uksp^.lt;
      end else break;          {Если след. вывели, то конец пробега}
      if uksp^.check<>true then begin    {Если запись еще не выводилась}
      writeln(f,'Возраст: ',uksp^.age,' Число: ',uksp^.num);
      uksp^.check:=true;              {то вывести и поставить чек + счетчик}
      i:=i+1;
      end;
      if (uksp^.rt<>nil) then begin  {Если у узла есть правый потомок, то}
         high:=uksp;
         uksp:=uksp^.rt;             {перейти к нему и потом по метке снова}
         goto 2;
         end;
end;        {После всех выводов снять чеки}
close(f);
end;

procedure count(var head: a; var co,b1: integer);  {Подсчет сотрудников}
begin
if head^.lt<> nil then
count(head^.lt,co,b1);
if head^.age < b1 then
co:=co+head^.num;
if head^.rt<> nil then
count(head^.rt,co,b1);
end;


var
uktree: a;
count1: integer;
c,b: integer;
f1: text;

begin
clrscr;
create(uktree,count1);
writeln('Элементов: ',count1);
obhod(uktree,count1);
write('Введите возраст: ');
readln(b);
c:=0;
count(uktree,c,b);
assign(f1,'ex11.out');
append(f1);
writeln(f1);
writeln(f1,'Сотрудников младше введеного возраста: ',c);
close(f1);
writeln('Выполнено успешно');
readkey;
end.
