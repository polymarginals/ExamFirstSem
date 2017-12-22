{
в readData использовал стандартные функции работы со строками:

Pos(subS, s) -возвращает индекс первого вхождения подстроки(subS) в строку(s).
возвращает индекс вхождения, или -1, если нет вхождений.

Copy(s, start, len) - возвращает подстроку длиной len, идущюю с позиции strat в строке s

Length(s) - длина строки
}


uses
Crt;

type

elPtr = ^element_t; {тип указателя на элемент списка}

{элемент двусвяхного списка}
element_t = record
  number : integer; {номер книги}
  autor : string; {автор}
  name : string; {название книги}
  
  next, prev : elPtr;
end;


var

{нехочу переназначать input/output, чтобы иметь возможность вывода на экран}
op : text; {для вывода в текстовый файл}
inp : text; {для ввода из текстового файла}

pHead : elPtr; {указатель на головной элемент списка}
{список имеет 2 незначащих элемента: в начале и вконце}


{вставка элемента в список по номеру}
procedure insertElement(head : elPtr; number : integer; name, autor : string);
var
  newEl : elPtr; {создаваемый элемент}
begin
{проход по списку, поиск места вставки}
  while head^.next^.next <> nil do
  begin
  {если нашли место вставки - прервать цикл (head указывает на нужное место)}
    if head^.next^.number > number then break;
    
    head := head^.next;
  end;
      
  {после выполнения предыдущих действий head указывает на место вставки}
  new(newEl); {создать элемент}
  
  newEl^.next := head^.next; {связхь с следующим элементом}
  head^.next^.prev := newEl;
  
  newEl^.prev := head; {и с текущим}
  head^.next := newEl;
  
  newEl^.number := number; {заполнение полей (капитан очевидность!)}
  newEl^.name := name;
  newEl^.autor := autor;
end;


{P1}
{чтение данных из файла, составление списка с сортировкой}
procedure readData(head : elPtr);
var
  num : integer;
  str : string;
  chr : char;
  name, autor : string;
  commaIndex : integer; {индекс запятой в строке str}
begin

  while not eof(inp) do
  begin
    readLn(inp, num, chr, chr, str); {прочитать строку и счисло}
    {в середине 2 лишних сммвола -это пробел и запятая}
    {т.е. в num - номер, а в str - строка с названием и автором (разделенными одной запятой)}
    
    commaIndex := Pos(',' , str); {получить индекс запятой между именем и названием}
    
    autor := Copy(str, 1, commaIndex - 1); {извлеч подстроку с автором}
    name := Copy(str, commaIndex + 1, Length(str) - commaIndex); {извлеч подстроку с именем книги}

    insertElement(head, num, name, autor); {вставить элемент в список}
  end;
end;


{P2}
{читает введённую с клавы записть для списка}
procedure readRecord(head : elPtr);
var
  num : integer;
  str : string;
  chr : char;
  name, autor : string;
  commaIndex : integer; {индекс запятой в строке str}
begin
  readLn(num, chr, chr, str); {прочитать записть с клавиатуры}
  
  {анализ данных:}
  commaIndex := Pos(',' , str); {получить индекс запятой между именем и названием}
    
  autor := Copy(str, 1, commaIndex - 1); {извлеч подстроку с автором}
  name := Copy(str, commaIndex + 1, Length(str) - commaIndex); {извлеч подстроку с именем книги}

  insertElement(head, num, name, autor); {вставить элемент в список}
end;


{P3}
{вывод списка в текстовый файл}
procedure list_print(head : elPtr; direction : boolean); {direction - задает направление}
begin
  head := head^.next;
  
  {если требуют проход с конца - прейти в конец}
  if not (direction) then
    while head^.next^.next <> nil do
      head := head^.next;
  
  while true do
  begin
  {проверка условия выхода из цикла в зависимости от направления прохода}
    if direction and (head^.next = nil) then break;
    if not (direction) and (head^.prev = nil) then break;
  
    writeLn(op, head^.number, ' ,', head^.autor, ' ,', head^.name);
    
    {выбор направления прохода}
    if direction then
    begin
      head := head^.next;
    end
    else begin 
      head := head^.prev;
    end;
  end;
  
  writeLn(op);
end;


{P4}
{вывод всех книг заданного автора}
procedure list_printAutor(head : elPtr; autor : string);
begin
  head := head^.next;
  
  while(head^.next <> nil) do
  begin
  {если у очередной книги автор совпал с требуемым - вывести}
    if head^.autor = autor then
      writeLn(op, head^.number, ' ,', head^.autor, ' ,' , head^.name);
  
    head := head^.next;
  end;
end;



begin
  ClrScr; {очистить экран вывода (это из Crt)}

  assign(inp, 'dan1.inp');
  assign(op, 'res1.out');
  
  reset(inp);
  rewrite(op);
  
  {создать головной и хвостовой элементы (не созеержат значения. список между ними)}
  new(pHead);
  new(pHead^.next);
  pHead^.prev := nil;
  pHead^.next^.next := nil;
  pHead^.next^.prev := pHead;
  
  
  readData(pHead); {прочитать данный список книг из файла}
  
  readRecord(pHead); {ввод с клавиатуры записи}
  
  list_print(pHead, true); {вывести список прямым порядком}
  list_print(pHead, false); {и обратным}
  
  list_printAutor(pHead, ' aaaa '); {вывести книги автора aaaa (збс имя =)}
  
  close(inp);
  close(op);

end.