{1) procedure AddElem(var stek1:List;znach1:TInf) - процедура добавление элемента в стек.
2) procedure Print(stek1:List) - вывод стека.
3) Procedure FreeStek(stek1:List) - освобождение пам€ти использованного под стек.
4) Function SearchElemZnach(stek1:List;znach1:TInf):List - поиск в стеке по значению, функци€ возвращает адрес найденного элемента.
5) Procedure DelElem(var stek1:List;tmp:List) - процедура удалени€ из стека элемента с адресом tmp.
6) procedure DelElemZnach(var Stek1:List;znach1:TInf) - удаление из стека элемента со значением znach1.
7) Procedure DelElemPos(var stek1:List;posi:integer) - удаление из стека элемента с пор€дковым номером posi.
8) procedure SortBublInf(nach:list) - сортировка стека "пузырьком" (самый простой вариант), с обменом данными между элементами.
9) procedure SortBublLink(nach:List)- сортировка стека "пузырьком" (самый простой вариант), с изменением лишь указателей на элементы.
}
Program Spisok;
uses
  crt; {ƒл€ использовани€ readkey и clrscr}
type
  Tinf=integer; {тип данных, который будет хранитьс€ в элементе списка}
  List=^TList;  {”казатель на элемент типа TList}
  TList=record {ј это наименование нашего типа "запись" обычно динамические структуры описываютс€ через запись}
    data:TInf;  {данные, хранимые в элементе}
    next:List;   {указатель на следующий элемент списка}
  end;
 
{ѕроцедура добавлени€ нового элемента в односв€зный список}
procedure AddElem(var spis1:List;znach1:TInf);
var
  tmp:List;
begin
  if spis1=nil then {ѕровер€ем не пуст ли список, если пуст, то }
  begin
    GetMem(spis1,sizeof(TList));  {создаЄм его первый элемент}
    tmp:=spis1;
  end
  else {в случае если список не пуст}
  begin
    tmp:=spis1;
    while tmp^.next<>nil do
      tmp:=tmp^.next; {ставим tmp на последний элемент списка}
    GetMem(tmp^.next,sizeof(TList)); {создаЄм следующий элемент}
    tmp:=tmp^.next;   {переносим tmp на новый элемент}
  end;
  tmp^.next:=nil; {занул€ем указатель}
  tmp^.data:=znach1; {заносим значение}
end;
 
{процедура печати списка
полностью расписана при работе со стеком}
procedure Print(spis1:List);
begin
  if spis1=nil then
  begin
    writeln('Сѓ®бЃ™ ѓгбв.');
    exit;
  end;
  while spis1<>nil do
  begin
    Write(spis1^.data, ' ');
    spis1:=spis1^.next
  end;
end;
 
{процедура удалени€ списка
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
 
{процедура поиска в списке
 полностью расписана при работе со стеком}
Function SearchElemZnach(spis1:List;znach1:TInf):List;
begin
  if spis1<>nil then
    while (Spis1<>nil) and (znach1<>spis1^.data) do
      spis1:=spis1^.next;
  SearchElemZnach:=spis1;
end;
 
{процедура удалени€ элемента
 полностью расписана при работе со стеком}
Procedure DelElem(var spis1:List;tmp:List);
var
  tmpi:List;
begin
  if (spis1=nil) or (tmp=nil) then
    exit;
  if tmp=spis1 then
  begin
    spis1:=tmp^.next;
    FreeMem(tmp,SizeOf(TList));
  end
  else
  begin
    tmpi:=spis1;
    while tmpi^.next<>tmp do
      tmpi:=tmpi^.next;
    tmpi^.next:=tmp^.next;
    FreeMem(tmp,sizeof(TList));
  end;
end;
 
{процедура удалени€ элемента по значению
 полностью расписана при работе со стеком}
procedure DelElemZnach(var Spis1:List;znach1:TInf);
var
  tmp:List;
begin
  if Spis1=nil then
  begin
    Writeln('Сѓ®бЃ™ ѓгбв');
    exit;
  end;
  tmp:=SearchElemZnach(spis1,znach1);
  if tmp=nil then
  begin
    writeln('ЭЂ•ђ•*в б ®б™Ѓђлђ І**з•*®•ђ ' ,znach1, ' ЃвбгвбвҐг•в Ґ бѓ®б™•.');
    exit;
  end;
  DelElem(spis1,tmp);
  Writeln('ЭЂ•ђ•*в г§*Ђс*.');
end;
 
{процедура удалени€ элемента по позиции
 полностью расписана при работе со стеком}
Procedure DelElemPos(var spis1:List;posi:integer);
var
  i:integer;
  tmp:List;
begin
  if posi<1 then
    exit;
  if spis1=nil then
  begin
    Write('Сѓ®бЃ™ ѓгбв');
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
    Writeln('ЭЂ•ђ•*в* б ѓЃап§™ЃҐлђ *Ѓђ•аЃђ ' ,posi, ' *•в Ґ бѓ®б™•.');
    writeln('В бѓ®б™• Ґб•£Ѓ ' ,i-1, ' нЂ•ђ•*в*(ЃҐ).');
    exit
  end;
  DelElem(spis1,tmp);
  Writeln('ЭЂ•ђ•*в г§*Ђс*.');
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
 
{ѕроцедура сортировки "пузырьком" с изменением только адресов
 полностью расписана при работе со стеком}
procedure SortBublLink(nach:List);
var
  tmp,pered,pered1,pocle,rab:List;
begin
  rab:=nach;
  while rab<>nil do
  begin
    tmp:=rab^.next;
    while tmp<>nil do
    begin
      if tmp^.data<rab^.data then
      begin
        pered:=nach;
        pered1:=nach;
        if rab<>nach then
          while pered^.next<>rab do pered:=pered^.next;
        while pered1^.next<>tmp do pered1:=pered1^.next;
        pocle:=tmp^.next;
        if rab^.next=tmp then
        begin
          tmp^.next:=rab;
          rab^.next:=pocle
        end
        else
        begin
          tmp^.next:=rab^.next;
          rab^.next:=pocle;
        end;
        if pered1<>rab then
          pered1^.next:=rab;
        if rab<>nach then
          pered^.next:=tmp
        else
          nach:=tmp;
        pered1:=tmp;
        tmp:=rab;
        rab:=pered1;
      end;
      tmp:=tmp^.next;
    end;
    rab:=rab^.next;
  end;
end;
 
var
  Spis,tmpl:List;
  znach:integer;
  ch:char;
begin
  Spis:=nil;
  repeat
    clrscr;
    Write('ПаЃ£а*ђђ* §Ђп а*°Ѓвл бЃ ');
    TextColor(4);
    Writeln('бѓ®б™Ѓђ.');
    TextColor(7);
    Writeln('Вл°•а®в• ¶•Ђ*•ђЃ• §•©бвҐ®•:');
    Writeln('1) ДЃ°*Ґ®вм нЂ•ђ•*в.');
    Writeln('2) ВлҐЃ§ бѓ®б™*.');
    Writeln('3) У§*Ђ•*®• нЂ•ђ•*в* ѓЃ І**з•*®о.');
    Writeln('4) У§*Ђ•*®• нЂ•ђ•*в* ѓЃ ѓЃап§™ЃҐЃђг *Ѓђ•аг.');
    Writeln('5) ПЃ®б™ нЂ•ђ•*в* ѓЃ І**з•*®о.');
    Writeln('6) СЃав®аЃҐ™* бѓ®б™* ђ•вЃ§Ѓђ "ПгІлам™*", ђ•*пп вЃЂм™Ѓ §***л•.');
    Writeln('7) СЃав®аЃҐ™* бѓ®б™* б ®Іђ•*•*®•ђ *§а•бЃҐ.');
    Writeln('8) ВлеЃ§.');
    writeln;
    ch:=readkey;
    case ch of
      '1':begin
            write('ВҐ•§®в• І**з•*®• §Ѓ°*ҐЂп•ђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            AddElem(Spis,znach);
          end;
      '2':begin
            clrscr;
            Print(Spis);
            readkey;
          end;
      '3':begin
            Write('ВҐ•§®в• І**з•*®• г§*Ђп•ђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            DelElemZnach(Spis,znach);
            readkey;
          end;
      '4':begin
            Write('ВҐ•§®в• ѓЃап§™ЃҐл© *Ѓђ•а г§*Ђп•ђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            DelElemPos(Spis,znach);
            readkey;
          end;
      '5':begin
            write('ВҐ•§®в• І**з•*®• ®б™ЃђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            tmpl:=SearchElemZnach(Spis,znach);
            if tmpl=nil then
              write('?б™Ѓђл© нЂ•ђ•*в ЃвбгвбвҐг•в Ґ бѓ®б™•')
            else
              write('ЭЂ•ђ•*в ',tmpl^.data,' **©§•*');
            readkey;
          end;
      '6':begin
            if Spis=nil then
            begin
              Write('Сѓ®бЃ™ ѓгбв.');
              readkey
            end
            else
            begin
              SortBublInf(Spis);
              Write('Сѓ®бЃ™ ЃвбЃав®аЃҐ**.');
              readkey;
            end
          end;
      '7':begin
            if Spis=nil then
            begin
              Write('Сѓ®бЃ™ ѓгбв.');
              readkey
            end
            else
            begin
              SortBublLink(Spis);
              Write('Сѓ®бЃ™ ЃвбЃав®аЃҐ**.');
              readkey;
            end
          end;
    end;
  until ch='8';
  FreeStek(Spis);
end.