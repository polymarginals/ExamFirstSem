{1) procedure AddElem(var spis1:List;znach1:TInf);
2) procedure Print(spis1:List);
3) Procedure FreeStek(spis1:List);
4) Function SearchElemZnach(spis1:List;znach1:TInf):List;
5) Procedure DelElem(var spis1:List;tmp:List);
6) procedure DelElemZnach(var Spis1:List;znach1:TInf);
7) Procedure DelElemPos(var spis1:List;posi:integer);
8) procedure SortBublInf(nach:list);
9) procedure SortBublLink(nach:List);
10) Procedure Swap(var nach,ends:List;a,b,c:integer); - ЅерЄт часть списка и вставл€ет в нужную позиицию
11) procedure AddElemVst(var nach,ends:List;znach1:TInf); - ѕроцедура добавлени€ нового элемента в двунаправленный список методом "вставок"
}
Program Spisok_dn;
uses
  crt; {ƒл€ использовани€ readkey и clrscr}
type
  Tinf=integer; {тип данных, который будет хранитьс€ в элементе списка}
  List=^TList;  {”казатель на элемент типа TList}
  TList=record {ј это наименование нашего типа "запись" обычно динамические структуры описываютс€ через запись}
    data:TInf;  {данные, хранимые в элементе}
    next,    {указатель на следующий элемент списка}
    prev:List;   {указатель на предыдущий элемент списка}
  end;
 
{ѕроцедура добавлени€ нового элемента в двунаправленный список}
procedure AddElem(var nach,ends:List;znach1:TInf);
begin
  if nach=nil then {не пуст ли список, если пуст, то}
  begin
    Getmem(nach,SizeOf(TList)); {создаЄм элемент, указатель nach уже будет иметь адрес}
    nach^.next:=nil; {никогда не забываем "занул€ть" указатели}
    nach^.prev:=nil; {аналогично}
    ends:=nach; {измен€ем указатель конца списка}
  end
  else {если список не пуст}
  begin
    GetMem(ends^.next,SizeOf(Tlist)); {создаЄм новый элемент}
    ends^.next^.prev:=ends; {св€зь нового элемента с последним элементом списка}
    ends:=ends^.next;{конец списка изменилс€ и мы указатель "переставл€ем"}
    ends^.next:=nil; {не забываем "занул€ть" указатели}
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
    Getmem(nach,SizeOf(TList)); {создаЄм элемент, указатель nach уже будет иметь адрес}
    nach^.next:=nil; {никогда не забываем "занул€ть" указатели}
    nach^.prev:=nil; {аналогично}
    ends:=nach; {измен€ем указатель конца списка}
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
 
{‘ункци€ поиска в списке
 полностью расписана при работе со стеком}
Function SearchElemZnach(spis1:List;znach1:TInf):List;
begin
  if spis1<>nil then
    while (Spis1<>nil) and (znach1<>spis1^.data) do
      spis1:=spis1^.next;
  SearchElemZnach:=spis1;
end;
 
{процедура удалени€ элемента в двунаправленном списке}
Procedure DelElem(var spis1,spis2:List;tmp:List);
var
  tmpi:List;
begin
  if (spis1=nil) or (tmp=nil) then
    exit;
  if tmp=spis1 then {если удал€емый элемент первый в списке, то}
  begin
    spis1:=tmp^.next; {указатель на первый элемент переставл€ем на следующий элемент списка}
    if spis1<>nil then {если список оказалс€ не из одного элемента, то}
      spis1^.prev:=nil {"занул€ем" указатель}
    else {в случае, если элемент был один, то}
      spis2:=nil; {"занул€ем" указатель конца списка, а указатель начала уже "занулЄн"}
    FreeMem(tmp,SizeOf(TList));
  end
  else
    if tmp=spis2 then {если удал€емый элемент оказалс€ последним элементом списка}
    begin
      spis2:=spis2^.prev; {указатель конца списка переставл€ем на предыдущий элемент}
      if spis2<>nil then {если предыдущий элемент существует,то}
        spis2^.next:=nil {"занул€ем" указатель}
      else {в случае, если элемент был один в списке, то}
        spis1:=nil; {"занул€ем" указатель на начало списка}
      FreeMem(tmp,SizeOf(TList));
    end
    else {если же удал€етс€ список не из начали и не из конца, то}
    begin
      tmpi:=spis1;
      while tmpi^.next<>tmp do {ставим указатель tmpi на элемент перед удал€емым}
        tmpi:=tmpi^.next;
      tmpi^.next:=tmp^.next; {мен€ем св€зи}
      if tmp^.next<>nil then
        tmp^.next^.prev:=tmpi; {у элемента до удал€емого и после него}
      FreeMem(tmp,sizeof(TList));
    end;
end;
 
{процедура удалени€ элемента по значению
 полностью расписана при работе со стеком}
procedure DelElemZnach(var Spis1,spis2:List;znach1:TInf);
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
  DelElem(spis1,spis2,tmp);
  Writeln('ЭЂ•ђ•*в г§*Ђс*.');
end;
 
{процедура удалени€ элемента по позиции
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
    writeln('В бѓ®б™• Ґб•£Ѓ ' ,i-1, ' нЂ•ђ•*вЃҐ.');
    exit
  end;
  DelElem(spis1,spis2,tmp);
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
 
{ѕроцедура сортировки "пузырьком" с изменением только адресов}
{„тобы разобратьс€ как она работает ¬ам точно понадобитс€ листок
 с рисунком списка и св€з€ми между элементами. ¬нимательно следите
 за тем, что происходит в процедуре, описывать всЄ € не вижу смысла}
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
 
{процедура берЄт часть списка и вставл€ет в нужную позицию списка}
Procedure Swap(var nach,ends:List;a,b,c:integer); {а-начало части, b-конец части, с-позици€}
var
  i:integer;
  yk,yk1,yk2,rab:List;
begin
  rab:=nach;
  i:=0;
  while rab<>nil do {цикл определ€ет количество элементов}
  begin
    inc(i);
    rab:=rab^.next
  end;
 {проверка на "нормальность" введЄнных данных}
  if (i+1<a) or (i+1<b) or (i+1<c) or ((c>=a) and (c<=b)) then
    exit;
  if a>b then {если "ошибочно" спутаны начало и конец части, то}
  begin
    a:=a xor b; {произведЄм замену переменных, т.е.}
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
  if yk=nach then {провер€ем следует ли нам изменить начало списка}
  begin
   nach:=yk1^.next; {измен€ем начало}
   nach^.prev:=nil; {"занул€ем" указатель}
  end
  else {далее € советую смотреть по листочку}
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
  SpisEnd,   {указатель на конец списка. Ёти два указател€ }
  tmpl:List; {неотъемлима€ часть в двунаправленном списке}
  znach,a,b:integer;
  ch:char;
begin
  SpisNach:=nil;
  SpisEnd:=nil;
  repeat
    clrscr;
    Write('ПаЃ£а*ђђ* §Ђп а*°Ѓвл б ');
    TextColor(4);
    Writeln('§Ґг**ѓа*ҐЂ•**лђ бѓ®б™Ѓђ.');
    TextColor(7);
    Writeln('Вл°•а®в• ¶•Ђ*•ђЃ• §•©бвҐ®•:');
    Writeln('1) ДЃ°*Ґ®вм нЂ•ђ•*в.');
    Writeln('2) ВлҐЃ§ бѓ®б™*.');
    Writeln('3) У§*Ђ•*®• нЂ•ђ•*в* ѓЃ І**з•*®о.');
    Writeln('4) У§*Ђ•*®• нЂ•ђ•*в* ѓЃ ѓЃап§™ЃҐЃђг *Ѓђ•аг.');
    Writeln('5) ПЃ®б™ нЂ•ђ•*в* ѓЃ І**з•*®о.');
    Writeln('6) СЃав®аЃҐ™* бѓ®б™* ђ•вЃ§Ѓђ "ПгІлам™*", ђ•*пп вЃЂм™Ѓ §***л•.');
    Writeln('7) СЃав®аЃҐ™* бѓ®б™* б ®Іђ•*•*®•ђ *§а•бЃҐ.');
    Writeln('8) Swap бѓ®бЃ™.');
    Writeln('9) ВлеЃ§.');
    writeln;
    ch:=readkey;
    case ch of
      '1':begin
            write('ВҐ•§®в• І**з•*®• §Ѓ°*ҐЂп•ђЃ£Ѓ нЂ•ђ•*в* ');
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
            Write('ВҐ•§®в• І**з•*®• г§*Ђп•ђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            DelElemZnach(SpisNach,SpisEnd,znach);
            readkey;
          end;
      '4':begin
            Write('ВҐ•§®в• ѓЃап§™ЃҐл© *Ѓђ•а г§*Ђп•ђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            DelElemPos(SpisNach,SpisEnd,znach);
            readkey;
          end;
      '5':begin
            write('ВҐ•§®в• І**з•*®• ®б™ЃђЃ£Ѓ нЂ•ђ•*в* ');
            readln(znach);
            tmpl:=SearchElemZnach(SpisNach,znach);
            if tmpl=nil then
              write('?б™Ѓђл© нЂ•ђ•*в ЃвбгвбвҐг•в Ґ бѓ®б™•')
            else
            begin
              write('ЭЂ•ђ•*в ');
              TextColor(4);
              Write(tmpl^.data);
              TextColor(7);
              Write(' **©§•*');
            end;
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
      '7':begin
            if SpisNach=nil then
            begin
              Write('Сѓ®бЃ™ ѓгбв.');
              readkey
            end
            else
            begin
              SortBublLink(SpisNach,SpisEnd);
              Write('Сѓ®бЃ™ ЃвбЃав®аЃҐ**.');
              readkey;
            end
          end;
      '8':begin
            Writeln('Сѓ®бЃ™ §Ѓ ®Іђ•*•*®©:');
            print(SpisNach);
            writeln;
            write('ВҐ•§®в• **з*Ђм*го ѓЃІ®ж®о ');
            readln(a);
            Write('ВҐ•§®в• ™Ѓ*•з*го ѓЃІ®ж®о ');
            readln(b);
            write('ВҐ•§®в• ђ•бвЃ ™г§* Ґбв*ҐЂпвм ');
            readln(znach);
            Writeln;
            swap(SpisNach,SpisEnd,a,b,znach);
            writeln;
            Writeln('Сѓ®бЃ™ ѓЃбЂ• ®Іђ•*•*®©:');
            print(SpisNach);
            readkey;
          end;
    end;
  until ch='9';
  FreeStek(SpisNach);
end.