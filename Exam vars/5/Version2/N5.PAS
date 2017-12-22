
type

elPtr = ^element_t; {тип указателя на элемент списка}

{элемент двусвяхного списка}
element_t = record
  number : integer; {номер}
  name : string; {имя}
  
  next, prev : elPtr;
end;


var

pHead : elPtr; {указатель на головной элемент списка}

pNumList, pNameList : elPtr; {указатель на односвязные списки}



{P1}
{чтение данных из файла, составление списка}
{список имеет 1 пустой элемент в начале. в конце дополнительных элементов нет}
procedure createList(var head : elPtr);
var
  curr : elPtr;
begin
  new(head);head^.prev := nil;
  curr := head;
  
  while not eof do
  begin
    new (curr^.next);
    curr^.next^.prev := curr;
    curr := curr^.next;

    readLn(curr^.number, curr^.name);
  end;

  curr^.next := nil;
end;


{P2}
{выводит список в заданный текстовый файл}
{clearFile определяет - перезаписывать файл, или дописывать в конец}
procedure printList(head : elPtr; direction, clearFile : boolean; fileName : string);
var
  OpenFile : text;
begin
  assign(openFile, fileName);
  
  {выбор - дописать файл, или перезаписать его}
  if clearFile then
  begin
    rewrite(openFile);
  end
  else begin
    append(openFile);
  end;

  head := head^.next;

  {если требуют проход с конца - прейти в конец}
  if not (direction) then
    while head^.next <> nil do
      head := head^.next;

  while true do
  begin
  {проверка условия выхода из цикла в зависимости от направления прохода}
    if direction and (head = nil) then break;
    if not (direction) and (head^.prev = nil) then break;

    if length(head^.name) > 0 then {если есть имя (через эту процедуру выводится и список номеров)}
    begin
      writeLn(openFile, head^.number, ' ', head^.name);
    end
    else begin {если нет имяни - вывести только номер}
      writeLn(openFile, head^.number);
    end;

    {выбор направления прохода}
    if direction then
    begin
      head := head^.next;
    end
    else begin
      head := head^.prev;
    end;
  end;

  writeLn(openFile);
  close(openFile);
end;



{P3}
{формирует два односвязных списка. один сортирован по алфвиту, другой по номерам}
{элменты обоих список - element_t, просто указател prev = nil}
procedure createSubLists(head : elPtr; var numList : elPtr; var nameList : elPtr);
var
  curr : elPtr; {используется для прохода по создаваемым спискам}
  currL : elPtr; {используется для прохода по основному списку (доступ к элементам)}
  newEl : elPtr; {для создания элементов}
begin
  new(numList);
  numList^.prev := nil;
  numList^.next := nil;
  
  new(nameList);
  nameList^.next := nil;
  nameList^.prev := nil;
  
  currL := head^.next; {первый значащий элемент}
  
  {проход по основному списку, разбор на список номеров}
  while currL <> nil do
  begin
    curr := numList; {поиск места вставки каждый раз идёт с нуля}
    
    {поиск места вставки в списке номеров}
    while curr <> nil do {можно было while tru}
    begin
      if (curr^.next^.number > currL^.number) or {если нашли место вставки}
          (curr^.next = nil) then {или дошли до конца писка}
      begin
      {создать элемент}
        new(newEl);
        newEl^.next := curr^.next; {установить связи}
        newEl^.prev := nil;
        
        curr^.next := newEl;
        
        newEl^.number := currL^.number;
        break; {перейти к след. элеемнту из списка head}
      end;
      
      curr := curr^.next;
    end;
    
    currL := currL^.next;
  end;
  
  currL := head^.next; {начать проход сначала (создается второй список)}
  
  while currL <> nil do
  begin
    curr := nameList; {поиск места вставки каждый раз идёт с нуля}
    
    {поиск места вставки в списке номеров}
    while curr <> nil do {можно было while tru}
    begin
      if (curr^.next^.name > currL^.name) or {если нашли место вставки}
          (curr^.next = nil) then {или дошли до конца писка}
      begin
      {создать элемент}
        new(newEl);
        newEl^.next := curr^.next; {установить связи}
        newEl^.prev := nil;
        
        curr^.next := newEl;
        
        newEl^.name := currL^.name;
        break; {перейти к след. элеемнту из списка head}
      end;
      
      curr := curr^.next;
    end;
    
    currL := currL^.next;
  end;
  
end;



begin
  assign(input, 'dan1.inp');
  
  reset(input);
  
  createList(pHead); {создать список из файла}
  
  printList(pHead, true, true, 'res1.out'); {вывести в прямом направлении}
  printList(pHead, false, false, 'res1.out'); {вывести в обратном}
  
  createSubLists(pHead, pNumList, pNameList); {создать односвязные pNumList и pNameList}
  
  printList(pNumList, true, false, 'res1.out'); {вывести номера}
  printList(pNameList, true, false, 'res1.out'); {вывести имена}
  
  close(input);

end.