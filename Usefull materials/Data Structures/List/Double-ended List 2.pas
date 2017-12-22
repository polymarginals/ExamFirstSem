Program Spisok_dn;
uses
  crt; {Для использования readkey и clrscr}
type
  Tinf=integer; {тип данных, который будет храниться в элементе списка}
  List=^TList;  {Указатель на элемент типа TList}
  TList=record {А это наименование нашего типа "запись" обычно динамические структуры описываются через запись}
    data:TInf;  {данные, хранимые в элементе}
    next,    {указатель на следующий элемент списка}
    prev:List;   {указатель на предыдущий элемент списка}
  end;
 
{Процедура добавления нового элемента в двунаправленный список}
procedure AddElem(var nach,ends:List;znach1:TInf);
begin
  if nach=nil then {не пуст ли список, если пуст, то}
  begin
    Getmem(nach,SizeOf(TList)); {создаём элемент, указатель nach уже будет иметь адрес}
    nach^.next:=nil; {никогда не забываем "занулять" указатели}
    nach^.prev:=nil; {аналогично}
    ends:=nach; {изменяем указатель конца списка}
  end
  else {если список не пуст}
  begin
    GetMem(ends^.next,SizeOf(Tlist)); {создаём новый элемент}
    ends^.next^.prev:=ends; {связь нового элемента с последним элементом списка}
    ends:=ends^.next;{конец списка изменился и мы указатель "переставляем"}
    ends^.next:=nil; {не забываем "занулять" указатели}
  end;
  ends^.data:=znach1; {заносим данные}
end;
 
procedure AddElemVst(var nach:List; var ends:List;znach1:TInf);
var
  tmp,tmpL:List;
  flag:boolean;
begin
  if nach=nil then {не пуст ли список, если пуст, то}
  begin
    Getmem(nach,SizeOf(TList)); {создаём элемент, указатель nach уже будет иметь адрес}
    nach^.next:=nil; {никогда не забываем "занулять" указатели}
    nach^.prev:=nil; {аналогично}
    ends:=nach; {изменяем указатель конца списка}
    tmp:=nach;
  end
  else {если список не пуст}
  begin
    tmpl:=nach;
    flag:=true;
    while tmpl^.data<znach1 do
    begin
      tmpl:=tmpl^.next;
      if tmpl=nil then
        break;
    end;
    if tmpl<>nil then
    begin
      tmpl:=tmpl^.prev;
      if tmpl=nach then
        flag:=false;
      if tmpl=nil then
        tmpl:=nach;
    end
    else
    begin
      tmpl:=ends;
      flag:=false
    end;
    GetMem(tmp,SizeOf(TList));
    if ends=nach then
      if ends^.data<znach1 then
      begin
        ends^.next:=tmp;
        tmp^.prev:=ends;
        tmp^.next:=nil;
        ends:=tmp;
      end
      else
      begin
        nach^.prev:=tmp;
        tmp^.prev:=nil;
        tmp^.next:=nach;
        nach:=tmp;
      end
    else
    if (tmpl=nach) and (flag) then
    begin
      nach^.prev:=tmp;
      tmp^.prev:=nil;
      tmp^.next:=nach;
      nach:=tmp;
    end
    else
      if (tmpl=nach) and not(flag) then
      begin
        tmp^.next:=nach^.next;
        nach^.next^.prev:=tmp;
        tmp^.prev:=nach;
        nach^.next:=tmp;
      end
      else
      if (tmpL=ends) and not (flag) then
      begin
        ends^.next:=tmp;
        tmp^.prev:=ends;
        tmp^.next:=nil;
        ends:=tmp;
      end
      else
      begin
        tmp^.next:=tmpl^.next;
        tmpl^.next^.prev:=tmp;
        tmp^.prev:=tmpl;
        tmpl^.next:=tmp;
      end;
  end;
  tmp^.data:=znach1; {заносим данные}
end;
 
{процедура печати списка
полностью расписана при работе со стеком}
procedure Print(spis1:List);
begin
  if spis1=nil then
  begin
    writeln('Список пуст.');
    exit;
  end;
  while spis1<>nil do
  begin
    Write(spis1^.data, ' ');
    spis1:=spis1^.next
  end;
end;
 
{процедура удаления списка
 полностью расписана при работе со стеком}
Procedure FreeStek(spis1:List);
var
  tmp:List;
begin
  while spis1<>nil do
  begin
    tmp:=spis1;
    spis1:=spis1^.next;
    FreeMem(tmp,SizeOf(Tlist));
  end;
end;
 
{Функция поиска в списке
 полностью расписана при работе со стеком}
Function SearchElemZnach(spis1:List;znach1:TInf):List;
begin
  if spis1<>nil then
    while (Spis1<>nil) and (znach1<>spis1^.data) do
      spis1:=spis1^.next;
  SearchElemZnach:=spis1;
end;
 
{процедура удаления элемента в двунаправленном списке}
Procedure DelElem(var spis1,spis2:List;tmp:List);
var
  tmpi:List;
begin
  if (spis1=nil) or (tmp=nil) then
    exit;
  if tmp=spis1 then {если удаляемый элемент первый в списке, то}
  begin
    spis1:=tmp^.next; {указатель на первый элемент переставляем на следующий элемент списка}
    if spis1<>nil then {если список оказался не из одного элемента, то}
      spis1^.prev:=nil {"зануляем" указатель}
    else {в случае, если элемент был один, то}
      spis2:=nil; {"зануляем" указатель конца списка, а указатель начала уже "занулён"}
    FreeMem(tmp,SizeOf(TList));
  end
  else
    if tmp=spis2 then {если удаляемый элемент оказался последним элементом списка}
    begin
      spis2:=spis2^.prev; {указатель конца списка переставляем на предыдущий элемент}
      if spis2<>nil then {если предыдущий элемент существует,то}
        spis2^.next:=nil {"зануляем" указатель}
      else {в случае, если элемент был один в списке, то}
        spis1:=nil; {"зануляем" указатель на начало списка}
      FreeMem(tmp,SizeOf(TList));
    end
    else {если же удаляется список не из начали и не из конца, то}
    begin
      tmpi:=spis1;
      while tmpi^.next<>tmp do {ставим указатель tmpi на элемент перед удаляемым}
        tmpi:=tmpi^.next;
      tmpi^.next:=tmp^.next; {меняем связи}
      if tmp^.next<>nil then
        tmp^.next^.prev:=tmpi; {у элемента до удаляемого и после него}
      FreeMem(tmp,sizeof(TList));
    end;
end;
 
{процедура удаления элемента по значению
 полностью расписана при работе со стеком}
procedure DelElemZnach(var Spis1,spis2:List;znach1:TInf);
var
  tmp:List;
begin
  if Spis1=nil then
  begin
    Writeln('Список пуст');
    exit;
  end;
  tmp:=SearchElemZnach(spis1,znach1);
  if tmp=nil then
  begin
    writeln('Элемент с искомым значением ' ,znach1, ' отсутствует в списке.');
    exit;
  end;
  DelElem(spis1,spis2,tmp);
  Writeln('Элемент удалён.');
end;
 
{процедура удаления элемента по позиции
 полностью расписана при работе со стеком}
Procedure DelElemPos(var spis1,spis2:List;posi:integer);
var
  i:integer;
  tmp:List;
begin
  if posi<1 then
    exit;
  if spis1=nil then
  begin
    Write('Список пуст');
    exit
  end;
  i:=1;
  tmp:=spis1;
  while (tmp<>nil) and (i<>posi) do
  begin
    tmp:=tmp^.next;
    inc(i)
  end;
  if tmp=nil then
  begin
    Writeln('Элемента с порядковым номером ' ,posi, ' нет в списке.');
    writeln('В списке всего ' ,i-1, ' элементов.');
    exit
  end;
  DelElem(spis1,spis2,tmp);
  Writeln('Элемент удалён.');
end;
 
{Процедура сортировки "пузырьком" с изменением только данных
 полностью расписана при работе со стеком}
procedure SortBublInf(nach:list);
var
  tmp,rab:List;
  tmps:Tinf;
begin
  GetMem(tmp,SizeOf(Tlist));
  rab:=nach;
  while rab<>nil do
  begin
    tmp:=rab^.next;
    while tmp<>nil do
    begin
      if tmp^.data<rab^.data then
      begin
        tmps:=tmp^.data;
        tmp^.data:=rab^.data;
        rab^.data:=tmps
      end;
      tmp:=tmp^.next
    end;
    rab:=rab^.next
  end
end;
 
{Процедура сортировки "пузырьком" с изменением только адресов}
{Чтобы разобраться как она работает Вам точно понадобится листок
 с рисунком списка и связями между элементами. Внимательно следите
 за тем, что происходит в процедуре, описывать всё я не вижу смысла}
procedure SortBublLink(var nach,ends:List);
var
  tmp,pocle1,rab:List;
begin
  rab:=nach;
  while rab<>nil do
  begin
    tmp:=rab^.next;
    while tmp<>nil do
    begin
      if tmp^.data<rab^.data then
      begin
        pocle1:=tmp^.next;
        if rab^.next=tmp then
        begin
          if tmp^.next<>nil then
            tmp^.next^.prev:=rab;
          tmp^.next:=rab;
          tmp^.prev:=rab^.prev;
          if tmp^.prev<>nil then
            tmp^.prev^.next:=tmp;
          rab^.prev:=tmp;
          rab^.next:=pocle1;
        end
        else
        begin
          if rab^.prev<>nil then
            rab^.prev^.next:=tmp;
          tmp^.prev^.next:=rab;
          if tmp^.next<>nil then
            tmp^.next^.prev:=rab;
          rab^.next^.prev:=tmp;
          tmp^.next:=rab^.next;
          rab^.next:=pocle1;
          pocle1:=rab^.prev;
          rab^.prev:=tmp^.prev;
          tmp^.prev:=pocle1;
        end;
        if rab=nach then
        begin
          nach:=tmp;
          nach^.prev:=nil;
        end;
        if tmp=ends then
        begin
          ends:=rab;
          ends^.next:=nil
        end;
        pocle1:=rab;
        rab:=tmp;
        tmp:=pocle1;
      end;
      tmp:=tmp^.next;
    end;
    rab:=rab^.next;
  end;
end;
 
{процедура берёт часть списка и вставляет в нужную позицию списка}
Procedure Swap(var nach,ends:List;a,b,c:integer); {а-начало части, b-конец части, с-позиция}
var
  i:integer;
  yk,yk1,yk2,rab:List;
begin
  rab:=nach;
  i:=0;
  while rab<>nil do {цикл определяет количество элементов}
  begin
    inc(i);
    rab:=rab^.next
  end;
 {проверка на "нормальность" введённых данных}
  if (i+1<a) or (i+1<b) or (i+1<c) or ((c>=a) and (c<=b)) then
    exit;
  if a>b then {если "ошибочно" спутаны начало и конец части, то}
  begin
    a:=a xor b; {произведём замену переменных, т.е.}
    b:=b xor a; {значение из a поместим в b}
    a:=b xor a; {из b поместим в a}
  end;
  yk:=nach;
  for i:=1 to a-1 do
    yk:=yk^.next; {ставим указатель на нужный нам элемент}
  yk1:=nach;
  for i:=1 to b-1 do
    yk1:=yk1^.next;{ставим указатель на нужный нам элемент}
  yk2:=nach;
  for i:=1 to c-1 do
    yk2:=yk2^.next;{ставим указатель на нужный нам элемент}
  if yk=nach then {проверяем следует ли нам изменить начало списка}
  begin
   nach:=yk1^.next; {изменяем начало}
   nach^.prev:=nil; {"зануляем" указатель}
  end
  else {далее я советую смотреть по листочку}
  begin
    if yk1^.next<>nil then
      yk1^.next^.prev:=yk^.prev
    else
    begin
      ends:=yk^.prev;
      yk^.prev^.next:=nil;
    end;
    yk^.prev^.next:=yk1^.next;
  end;
  if yk2^.next=nil then
  begin
    yk1^.next:=nil;
    ends:=yk1;
  end
  else
  begin
    yk2^.next^.prev:=yk1;
    yk1^.next:=yk2^.next;;
  end;
  yk2^.next:=yk;
  yk^.prev:=yk2;
end;
 
var
  SpisNach, {указатель на начало списка и}
  SpisEnd,   {указатель на конец списка. Эти два указателя }
  tmpl:List; {неотъемлимая часть в двунаправленном списке}
  znach,a,b:integer;
  ch:char;
begin
  SpisNach:=nil;
  SpisEnd:=nil;
  repeat
    clrscr;
    Write('Программа для работы с ');
    TextColor(4);
    Writeln('двунаправленным списком.');
    TextColor(7);
    Writeln('Выберите желаемое действие:');
    Writeln('1) Добавить элемент.');
    Writeln('2) Вывод списка.');
    Writeln('3) Удаление элементов по значению.');
    Writeln('4) Удаление элементов по порядковому номеру.');
    Writeln('5) Поиск элементов по значению.');
    Writeln('6) Сортировка списка методом "Пузырька", меняя только данные.');
    Writeln('7) Сортировка списка с изменением адресов.');
    Writeln('8) Swap список.');
    Writeln('9) Выход.');
    writeln;
    ch:=readkey;
    case ch of
      '1':begin
            write('Введите значение добавляемого элемента: ');
            readln(znach);
            AddElemVst(SpisNach,SpisEnd,znach);
            {AddElem(SpisNach,SpisEnd,znach);}
          end;
      '2':begin
            clrscr;
            Print(SpisNach);
            readkey;
          end;
      '3':begin
            Write('Введите значение удаляемого элемента: ');
            readln(znach);
            DelElemZnach(SpisNach,SpisEnd,znach);
            readkey;
          end;
      '4':begin
            Write('Введите порядковый номер удаляемого элемента: ');
            readln(znach);
            DelElemPos(SpisNach,SpisEnd,znach);
            readkey;
          end;
      '5':begin
            write('Введите значение искомого элемента: ');
            readln(znach);
            tmpl:=SearchElemZnach(SpisNach,znach);
            if tmpl=nil then
              write('Искомый элемент отсутствует в списке.')
            else
            begin
              write('Элемент ');
              TextColor(4);
              Write(tmpl^.data);
              TextColor(7);
              Write(' найден');
            end;
            readkey;
          end;
      '6':begin
            if SpisNach=nil then
            begin
              Write('Список пуст.');
              readkey
            end
            else
            begin
              SortBublInf(SpisNach);
              Write('Список отсортирован.');
              readkey;
            end
          end;
      '7':begin
            if SpisNach=nil then
            begin
              Write('Список пуст.');
              readkey
            end
            else
            begin
              SortBublLink(SpisNach,SpisEnd);
              Write('Список отсортирован.');
              readkey;
            end
          end;
      '8':begin
            Writeln('Список до изменений:');
            print(SpisNach);
            writeln;
            write('Введите начальную позицию: ');
            readln(a);
            Write('Введите конечную позицию: ');
            readln(b);
            write('Введите место куда вставлять: ');
            readln(znach);
            Writeln;
            swap(SpisNach,SpisEnd,a,b,znach);
            writeln;
            Writeln('Список после изменений:');
            print(SpisNach);
            readkey;
          end;
    end;
  until ch='9';
  FreeStek(SpisNach);
end.