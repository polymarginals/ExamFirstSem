{1) procedure AddElem(var stek1:List;znach1:TInf) - процедура добавление элемента в стек.
2) procedure Print(stek1:List) - вывод стека.
3) Procedure FreeStek(stek1:List) - освобождение памяти использованного под стек.
4) Function SearchElemZnach(stek1:List;znach1:TInf):List - поиск в стеке по значению, функция возвращает адрес найденного элемента.
5) Procedure DelElem(var stek1:List;tmp:List) - процедура удаления из стека элемента с адресом tmp.
6) procedure DelElemZnach(var Stek1:List;znach1:TInf) - удаление из стека элемента со значением znach1.
7) Procedure DelElemPos(var stek1:List;posi:integer) - удаление из стека элемента с порядковым номером posi.
8) procedure SortBublInf(nach:list) - сортировка стека "пузырьком" (самый простой вариант), с обменом данными между элементами.
9) procedure SortBublLink(nach:List)- сортировка стека "пузырьком" (самый простой вариант), с изменением лишь указателей на элементы.
}
Program Stek;
uses
  crt; {Для использования readkey и clrscr}
type
  Tinf=integer; {тип данных, который будет храниться в элементе стека}
  List=^TList;  {Указатель на элемент типа TList}
  TList=record {А это наименование нашего типа "запись" обычно динамические структуры описываются через запись}
    data:TInf;  {данные, хранимые в элементе}
    next:List;   {указатель на следующий элемент}
  end;
 
{Процедура добавляющая элемент в стек}
procedure AddElem(var stek1:List;znach1:TInf);
var
  tmp:List;
begin
  GetMem(tmp,sizeof(TList)); {выделяем в памяти место для нового элемента}
  tmp^.next:=stek1;  {указатель на следующий элемент "направляем" на вершину стека}
  tmp^.data:=znach1; {добавляем к элементу данные}
  stek1:=tmp; {вершина стека изменилась, надо перенести и указатели на неё}
end;
 
{Процедура вывода стека}
procedure Print(stek1:List);
begin
  if stek1=nil then {проверка на пустоту стека}
  begin
    writeln('‘вҐЄ Їгбв.');
    exit;
  end;
  while stek1<>nil do {пока указатель stek1 не станет указывать в пустоту}
  begin   {а это произойдёт как только он перейдёт по ссылке последнего элемента}
    Write(stek1^.data, ' '); {выводить данне}
    stek1:=stek1^.next  {и переносить указатель вглубь по стеку}
  end;
end;
 
{Процедура освобождения памяти занятой стеком}
Procedure FreeStek(stek1:List);
var
  tmp:List;
begin
  while stek1<>nil do {пока stek1 не станет указывать в "пустоту" делать}
  begin
    tmp:=stek1; {указатель tmp направим на вершину стека}
    stek1:=stek1^.next; {вершину стека перенесём на следующий за данной вершиной элемент}
    FreeMem(tmp,SizeOf(Tlist)); {освободим память занятую под старую вершину}
  end;
end;
 
{Поиск элемента в стеке по значению}
Function SearchElemZnach(stek1:List;znach1:TInf):List;
begin
  if stek1<>nil then {если стек не пуст, то}
    while (Stek1<>nil) and (znach1<>stek1^.data) do {пока stek1 не укажет в "пустоту" или пока мы не нашли нужный нам элемент}
      stek1:=stek1^.next; {переносить указатель}
  SearchElemZnach:=stek1;{функция возвращает указатель на найденный элемент}
end;         {в случае если элемент не найден, она вернёт nil}
 
{Процедура удаления элемента по указателю}
Procedure DelElem(var stek1:List;tmp:List);
var
  tmpi:List;
begin
  if (stek1=nil) or (tmp=nil) then {если стек пуст или указатель никуда не указывает, то выходим}
    exit;
  if tmp=stek1 then {если мы удаляем элемент который является вершиной стека, то}
  begin
    stek1:=tmp^.next;{следует перенести вершину и}
    FreeMem(tmp,SizeOf(TList)); {высвободить память из под элемента}
  end
  else {в случае, если удаляемый элемент не вершина стека, то}
  begin
    tmpi:=stek1; {ставим указатель на вершину стека}
    while tmpi^.next<>tmp do {доходим до элемента стоящего "перед" тем, который нам следует удалить}
      tmpi:=tmpi^.next;
    tmpi^.next:=tmp^.next; {указатель элемента переносим на следующий элемент за удаляемым}
    FreeMem(tmp,sizeof(TList)); {удаляем элемент}
  end;
end;
 
{Процедура удаления элемента по значению}
procedure DelElemZnach(var Stek1:List;znach1:TInf);
var
  tmp:List;
begin
  if Stek1=nil then {Если стек пуст, то выводим сообщение и выходим}
  begin
    Writeln('‘вҐЄ Їгбв');
    exit;
  end;
  tmp:=SearchElemZnach(stek1,znach1); {tmp указывает на удаляемый элемент}
  if tmp=nil then {если элемент не был найден, то выводим сообщение и выходим}
  begin
    writeln('ќ«Ґ¬Ґ*в б ЁбЄ®¬л¬ §**зҐ*ЁҐ¬ ' ,znach1, ' ®вбгвбвўгҐв ў бвҐЄҐ.');
    exit;
  end;
  DelElem(stek1,tmp); {удаляем элемент из стека }
  Writeln('ќ«Ґ¬Ґ*в г¤*«с*.'); {сообщаем о выполнении действия}
end;
 
{Удаление элемента по порядковому номеру (вершина имеет номер 1)}
Procedure DelElemPos(var stek1:List;posi:integer);
var
  i:integer;
  tmp:List;
begin
  if posi<1 then {проверка на ввод информации}
    exit;
  if stek1=nil then {если стек пуст}
  begin
    Write('‘вҐЄ Їгбв');
    exit
  end;
  i:=1; {будет считать позиции}
  tmp:=stek1;
  while (tmp<>nil) and (i<>posi) do {пока tmp не укажет в "пустоту" или мы не найдём искомый элемент}
  begin
    tmp:=tmp^.next; {переходим на следующий элемент}
    inc(i)   {увеличиваем значение счётчика}
  end;
  if tmp=nil then {если элемента нет выводим соответствующие сообщения и выходим}
  begin
    Writeln('ќ«Ґ¬Ґ*в* б Ї®ап¤Є®ўл¬ *®¬Ґа®¬ ' ,posi, ' *Ґв ў бвҐЄҐ.');
    writeln('‚ бвҐЄҐ ' ,i-1, ' н«Ґ¬Ґ*в*(®ў).');
    exit
  end;
  DelElem(stek1,tmp); {если мы не вышли, то элемент есть и его следует удалить}
  Writeln('ќ«Ґ¬Ґ*в г¤*«с*.'); {сообщаем о выполнении действия}
end;
 
{Процедура сортировки "пузырьком" с изменением только данных}
procedure SortBublInf(nach:list);
var
  tmp,rab:List;
  tmps:Tinf;
begin
  GetMem(tmp,SizeOf(Tlist)); {выделяем память для рабочего "буфера" обмена}
  rab:=nach; {рабочая ссылка, становимся на вершину стека}
  while rab<>nil do {пока мы не дойдём до конца стека делать}
  begin
    tmp:=rab^.next; {перейдём на следующий элемент}
    while tmp<>nil do {пока не конец стека делать}
    begin
      if tmp^.data<rab^.data then {проверяем следует ли менять элементы}
      begin
        tmps:=tmp^.data; {стандартная замена в 3 операции}
        tmp^.data:=rab^.data;
        rab^.data:=tmps
      end;
      tmp:=tmp^.next {переход к следующему элементу}
    end;
    rab:=rab^.next {переход к следующему элементу}
  end
end;
 
{Процедура сортировки "пузырьком" с изменением только адресов}
procedure SortBublLink(nach:List);
var
  tmp,pered,pered1,pocle,rab:List; {все рабочие ссылки}
begin
  rab:=nach; {становимся на вершину стека}
  while rab<>nil do{пока не конец стека делать}
  begin
    tmp:=rab^.next; {переходим к следующему за сортируемым элементу}
    while tmp<>nil do {пока не конец стека делать}
    begin
      if tmp^.data<rab^.data then {если следует произвести замену, то}
      begin
        pered:=nach; {становимся в вершину стека}
        pered1:=nach; {становимся в вершину стека}
        if rab<>nach then {если мы не стоим на изменяемом элементе, то}
          while pered^.next<>rab do pered:=pered^.next; {станем на элементе перед изменяемым}
        while pered1^.next<>tmp do pered1:=pered1^.next; {станем на элементе перед изменяемым, который находится за
        первым изменяемым}
        pocle:=tmp^.next; {запоминаем адрес элемента после второго изменяемого}
        if rab^.next=tmp then {если элементы "соседи", то}
        begin
          tmp^.next:=rab; {меняем ссылки, тут если не понятно рисуйте на листочке}
          rab^.next:=pocle
        end
        else {в случае если элементы не соседи, то}
        begin
          tmp^.next:=rab^.next;{меняем ссылки, тут если не понятно рисуйте на листочке}
          rab^.next:=pocle;
        end;
        if pered1<>rab then{советую просмотреть на листочке}
          pered1^.next:=rab;
        if rab<>nach then{советую просмотреть на листочке}
          pered^.next:=tmp
        else{всё советую просмотреть на листочке}
          nach:=tmp;
        pered1:=tmp;{советую просмотреть на листочке}
        tmp:=rab;{советую просмотреть на листочке}
        rab:=pered1;{советую просмотреть на листочке}
      end;
      tmp:=tmp^.next; {переходим на следующий элемент}
    end;
    rab:=rab^.next;{переходим на следующий элемент}
  end;
end;
 
var
  Stk, {переменная, которая всегда будет указывать на "вершину" стека}
  tmpl:List; {рабочая переменная}
  znach:Tinf; {данные вводимые пользователем}
  ch:char; {для работы менюшки}
begin
  Stk:=nil;
  repeat {цикл для нашего меню}
    clrscr; {очистка экрана, далее идёт вывод самого меню}
    Write('Џа®Ја*¬¬* ¤«п а*Ў®вл б® ');
    Textcolor(4);
    Writeln('бвҐЄ®¬.');
    Textcolor(7);
    Writeln('‚лЎҐаЁвҐ ¦Ґ«*Ґ¬®Ґ ¤Ґ©бвўЁҐ:');
    Writeln('1) „®Ў*ўЁвм н«Ґ¬Ґ*в.');
    Writeln('2) ‚лў®¤ бвҐЄ*.');
    Writeln('3) “¤*«Ґ*ЁҐ н«Ґ¬Ґ*в* Ї® §**зҐ*Ёо.');
    Writeln('4) “¤*«Ґ*ЁҐ н«Ґ¬Ґ*в* Ї® Ї®ап¤Є®ў®¬г *®¬Ґаг.');
    Writeln('5) Џ®ЁбЄ н«Ґ¬Ґ*в* Ї® §**зҐ*Ёо');
    Writeln('6) ‘®авЁа®ўЄ* бвҐЄ* ¬Ґв®¤®¬ "Џг§ламЄ*", ¬Ґ*пп в®«мЄ® ¤***лҐ.');
    Writeln('7) ‘®авЁа®ўЄ* бвҐЄ* б Ё§¬Ґ*Ґ*ЁҐ¬ *¤аҐб®ў.');
    Writeln('8) ‚ле®¤.');
    writeln;
    ch:=readkey; {ожидаем нажатия клавиши}
    case ch of {выбираем клавишу}
      '1':begin
            write('‚ўҐ¤ЁвҐ §**зҐ*ЁҐ ¤®Ў*ў«пҐ¬®Ј® н«Ґ¬Ґ*в* ');
            readln(znach); {считываем значение добавляемого нового элемент}
            AddElem(Stk,znach);
          end;
      '2':begin
            clrscr; {очистка экрана}
            Print(Stk); {вызов процедуры вывода}
            readkey; {ожидаем нажатия клавиши}
          end;
      '3':begin
            Write('‚ўҐ¤ЁвҐ §**зҐ*ЁҐ г¤*«пҐ¬®Ј® н«Ґ¬Ґ*в* ');
            readln(znach); {ввод значения удаляемого элемента}
            DelElemZnach(Stk,znach); {вызов процедуры удаления элемента по значению}
            readkey;{ожидаем нажатия клавиши}
          end;
      '4':begin
            Write('‚ўҐ¤ЁвҐ Ї®ап¤Є®ўл© *®¬Ґа г¤*«пҐ¬®Ј® н«Ґ¬Ґ*в* ');
            readln(znach); {ввод позиции удаляемого файла}
            DelElemPos(Stk,znach);{вызов процедуры удаления элемента по значению}
            readkey;{ожидаем нажатия клавиши}
          end;
      '5':begin
            write('‚ўҐ¤ЁвҐ §**зҐ*ЁҐ ЁбЄ®¬®Ј® н«Ґ¬Ґ*в* ');
            readln(znach); {ввод искомого значения}
            tmpl:=SearchElemZnach(Stk,znach); {вызываем процедуру поиска элемента по значению}
            if tmpl=nil then {проверяем найден ли элемент и выводим соответствующие сообщения}
              write('?бЄ®¬л© н«Ґ¬Ґ*в ®вбгвбвўгҐв ў бвҐЄҐ')
            else
              write('ќ«Ґ¬Ґ*в ',tmpl^.data,' **©¤Ґ*');
            readkey;{ожидаем нажатия клавиши}
          end;
      '6':begin
            if Stk=nil then {проверяем не пустой ли стек}
            begin
              Write('‘вҐЄ Їгбв.');
              readkey{ожидаем нажатия клавиши}
            end
            else
            begin
              SortBublInf(Stk);{вызов процедуры сортировки стека с изменением данных}
              Write('‘вҐЄ ®вб®авЁа®ў**.');
              readkey;{ожидаем нажатия клавиши}
            end
          end;
      '7':begin
            if Stk=nil then{проверяем не пустой ли стек}
            begin
              Write('‘вҐЄ Їгбв.');
              readkey{ожидаем нажатия клавиши}
            end
            else
            begin
              SortBublLink(Stk);{вызов процедуры сортировки стека с изменением адресов}
              Write('‘вҐЄ ®вб®авЁа®ў**.');
              readkey;{ожидаем нажатия клавиши}
            end
          end;
    end;
  until ch='8';
  FreeStek(Stk); {освобождаем память занятую стеком}
end.