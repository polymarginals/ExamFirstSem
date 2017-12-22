{1) procedure AddElem(var stek1:List;znach1:TInf) - процедура добавление элемента в стек.
2) procedure Print(stek1:List) - вывод стека.
3) Procedure FreeStek(stek1:List) - освобождение пам€ти использованного под стек.
4) Function SearchElemZnach(stek1:List;znach1:TInf):List - поиск в стеке по значению, функци€ возвращает адрес найденного элемента.
5) Procedure DelElem(var stek1:List;tmp:List) - процедура удалени€ из стека элемента с адресом tmp.
6) procedure DelElemZnach(var Stek1:List;znach1:TInf) - удаление из стека элемента со значением znach1.
7) Procedure DelElemPos(var stek1:List;posi:integer) - удаление из стека элемента с пор€дковым номером posi.
8) procedure SortBublInf(nach:list) - сортировка стека "пузырьком" (самый простой вариант), с обменом данными между элементами.
}
Program Spisok_kolco;
uses
  crt; {ƒл€ использовани€ readkey и clrscr}
type
  Tinf=integer; {тип данных, который будет хранитьс€ в элементе списка}
  List=^TList;  {”казатель на элемент типа TList}
  TList=record  {ј это наименование нашего типа "запись" обычно динамические структуры описываютс€ через запись}
    data:TInf;  {данные, хранимые в элементе}
    next:List;  {указатель на следующий элемент списка}
  end;
 
{ѕроцедура добавлени€ нового элемента в двунаправленный список}
procedure AddElem(var nach:List;znach1:TInf);
var
  tmp,tmp1:List;
begin
  if nach=nil then {не пуст ли список, если пуст, то}
  begin
    Getmem(nach,SizeOf(TList)); {создаЄм элемент, указатель nach уже будет иметь адрес}
    nach^.next:=nach; {никогда не забываем "занул€ть" указатели}
    tmp:=nach;
  end
  else {если список не пуст}
  begin
    tmp:=nach;
    while tmp^.next<>nach do
      tmp:=tmp^.next;
    GetMem(tmp1,SizeOf(Tlist));
    tmp1^.next:=nach;
    tmp^.next:=tmp1;
    tmp:=tmp1;
  end;
  tmp^.data:=znach1; {заносим данные}
end;
 
{процедура печати списка
полностью расписана при работе со стеком}
procedure Print(spis1:List);
var
  nach:List;
begin
  if spis1=nil then
  begin
    writeln('Сѓ®бЃ™ ѓгбв.');
    exit;
  end;
  nach:=spis1;
  Write(spis1^.data, ' ');
  spis1:=spis1^.next;
  while spis1<>nach do
  begin
    Write(spis1^.data, ' ');
    spis1:=spis1^.next;
  end;
end;
 
{процедура удалени€ списка
 полностью расписана при работе со стеком}
Procedure FreeStek(spis1:List);
var
  tmp,nach:List;
begin
  if spis1=nil then
    exit;
  nach:=spis1;
  tmp:=spis1;
  spis1:=spis1^.next;
  dispose(tmp);
  while spis1<>nach do
  begin
    tmp:=spis1;
    spis1:=spis1^.next;
    FreeMem(tmp,SizeOf(Tlist));
  end;
end;
 
{‘ункци€ поиска в списке
 полностью расписана при работе со стеком}
Function SearchElemZnach(spis1:List;znach1:TInf):List;
var
  tmp:List;
begin
  tmp:=spis1;
  if spis1<>nil then
    if spis1^.data=znach1 then
      SearchElemZnach:=spis1
    else
    begin
      spis1:=spis1^.next;
      while (Spis1<>tmp) and (znach1<>spis1^.data) do
        spis1:=spis1^.next;
      if spis1=tmp then
        spis1:=nil;
    end;
  SearchElemZnach:=spis1;
end;
 
{процедура удалени€ элемента в двунаправленном списке}
Procedure DelElem(var spis1:List;tmp:List);
var
  tmpi:List;
begin
  if tmp=spis1 then
  begin
    tmpi:=tmp;
    while tmpi^.next<>spis1 do
      tmpi:=tmpi^.next;
    if tmpi=spis1 then
    begin
      spis1^.next:=nil;
      dispose(spis1);
      spis1:=nil
    end
    else
    begin
      tmpi^.next:=tmp^.next;
      spis1:=spis1^.next;
      dispose(tmp)
    end;
  end
  else
  begin
    tmpi:=spis1;
    while tmpi^.next<>tmp do
      tmpi:=tmpi^.next;
    tmpi^.next:=tmp^.next;
    dispose(tmp);
  end;
end;
 
{процедура удалени€ элемента по значению
 полностью расписана при работе со стеком}
procedure DelElemZnach(var Spis1:List;znach1:TInf);
var
  tmp:List;
begin
  tmp:=spis1;
  if znach1=tmp^.data then
  begin
    DelElem(spis1,tmp);
    exit;
  end;
  tmp:=tmp^.next;
  while tmp<>Spis1 do
  begin
    if tmp^.data=znach1 then
    begin
      DelElem(spis1,tmp);
      exit
    end;
    tmp:=tmp^.next;
  end;
end;
 
{процедура удалени€ элемента по позиции
 полностью расписана при работе со стеком}
Procedure DelElemPos(var spis1:List;posi:integer);
var
  i:integer;
  tmp:List;
begin
  if spis1=nil then
  begin
    writeln('Spisok /7ycT');
    readkey;
    exit
  end;
  tmp:=spis1^.next;
  i:=1;
  while tmp<>spis1 do
  begin
    tmp:=tmp^.next;
    inc(i)
  end;
  if (posi<1) or (posi>i) then
  begin
    writeln('В бѓ®б™• ',i, ' нЂ•ђ•*в*(ЃҐ).');
    writeln('ЭЂ•ђ•*в ',posi,' ЃвбгвбвҐг•в Ґ бѓ®б™•.');
    readkey;
    exit
  end
  else
  begin
    i:=1;
    tmp:=spis1;
    while i<posi do
    begin
      tmp:=tmp^.next;
      inc(i)
    end;
    DelElem(spis1,tmp);
  end;
end;
 
{ѕроцедура сортировки "пузырьком" с изменением только данных
 полностью расписана при работе со стеком}
procedure SortBublInf(nach:list);
var
  tmp,rab:List;
  tmps:Tinf;
begin
  GetMem(tmp,SizeOf(Tlist));
  rab:=nach;
  while rab^.next<>nach do
  begin
    tmp:=rab^.next;
    while tmp<>nach do
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
 
 
{procedure SortBublLink(var nach:List);
var
  tmp,pocle1,rab:List;
begin
  if nach=nil then
    exit;
  rab:=nach;
  while rab^.next<>nach do
  begin
    tmp:=rab^.next;
    while tmp<>nach do
    begin
      if tmp^.data<rab^.data then
      begin
 
      end;
      tmp:=tmp^.next;
    end;
    rab:=rab^.next;
  end;
end;}
 
 
 
var
  SpisNach, {указатель на начало списка и}
  tmpl:List; {неотъемлима€ часть в двунаправленном списке}
  znach,a,b:integer;
  ch:char;
begin
  SpisNach:=nil;
  repeat
    clrscr;
    Write('ПаЃ£а*ђђ* §Ђп а*°Ѓвл б ');
    TextColor(4);
    Writeln('™ЃЂмж•Ґлђ бѓ®б™Ѓђ.');
    TextColor(7);
    Writeln('Вл°•а®в• ¶•Ђ*•ђЃ• §•©бвҐ®•:');
    Writeln('1) ДЃ°*Ґ®вм нЂ•ђ•*в.');
    Writeln('2) ВлҐЃ§ бѓ®б™*.');
    Writeln('3) У§*Ђ•*®• нЂ•ђ•*в* ѓЃ І**з•*®о.');
    Writeln('4) У§*Ђ•*®• нЂ•ђ•*в* ѓЃ ѓЃап§™ЃҐЃђг *Ѓђ•аг.');
    Writeln('5) ПЃ®б™ нЂ•ђ•*в* ѓЃ І**з•*®о.');
    Writeln('6) СЃав®аЃҐ™* бѓ®б™* ђ•вЃ§Ѓђ "ПгІлам™*", ђ•*пп вЃЂм™Ѓ §***л•.');
    Writeln('7) ВлеЃ§.');
    writeln;
    ch:=readkey;
    case ch of
      '1':begin
            write('ВҐ•§®в• І**з•*®• §Ѓ°*ҐЂп•ђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            AddElem(SpisNach,znach);
          end;
      '2':begin
            clrscr;
            Print(SpisNach);
            readkey;
          end;
      '3':begin
            Write('ВҐ•§®в• І**з•*®• г§*Ђп•ђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            DelElemZnach(SpisNach,znach);
          end;
      '4':begin
            Write('ВҐ•§®в• ѓЃап§™ЃҐл© *Ѓђ•а г§*Ђп•ђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            DelElemPos(SpisNach,znach);
            readkey;
          end;
      '5':begin
            write('ВҐ•§®в• І**з•*®• ®б™ЃђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            tmpl:=SearchElemZnach(SpisNach,znach);
            if tmpl=nil then
              write('?б™Ѓђл© нЂ•ђ•*в ЃвбгвбвҐг•в Ґ бѓ®б™•')
            else
              write('ЭЂ•ђ•*в ',tmpl^.data,' **©§•*');
            readkey;
          end;
      '6':begin
            if SpisNach=nil then
            begin
              Write('Сѓ®бЃ™ ѓгбв.');
              readkey
            end
            else
            begin
              SortBublInf(SpisNach);
              Write('Сѓ®бЃ™ ЃвбЃав®аЃҐ**.');
              readkey;
            end
          end;
    end;
  until ch='7';
  FreeStek(SpisNach);
end.