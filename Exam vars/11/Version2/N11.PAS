
type

nodePtr = ^node_t;
elPtr = ^element_t;

{узел/лист дерева}
node_t = record
  age : integer; {возраст}
  count : integer; {кол-во сотрудников данного возраста}
  pLeft, pRight : nodePtr;
end;

{элемент обходного списка}
element_t = record
  pNode : nodePtr; {указатель на узел, которому принадлежит}
  depth : integer; {глубина этого узла в дереве}
  pPrev, pNext : elPtr; {список двусвязный}
end;


{добавление элемента в дерево}
procedure addElement(root : nodePtr; age : integer);
begin
{проход по дереву, поиск места вставки}
  while true do
  begin
  
  {если > текущего - переход в правое поддерево}
    if age > root^.age then
    begin
    
      if root^.pRight <> nil then {если есть, уда переходить}
      begin
        root := root^.pRight;
      end
      else begin {иначе - создать лист}
        new(root^.pRight);
        root := root^.pRight;
        
        root^.pLeft := nil;
        root^.pRight := nil;
        root^.age := age;
        root^.count := 1;
        
        break; {выход из цикла}
      end;
      
    end
    else if age < root^.age then {если < текущего - переход в левое поддерево}
    begin
    
      if root^.pLeft <> nil then {если есть, уда переходить}
      begin
        root := root^.pLeft;
      end
      else begin {иначе - создать лист}
        new(root^.pLeft);
        root := root^.pLeft;
        
        root^.pLeft := nil;
        root^.pRight := nil;
        root^.age := age;
        root^.count := 1;
        
        break; {выход из цикла}
      end;
    
    end
    else begin {если = текущему - увеличить счетчик}
      root^.count := root^.count + 1;
      break; {выход из цикла}
    end;
    
  end;
end;


{P1}
{итеративное создание дерева}
procedure createTree(var root : nodePtr);
var
  cPos : byte; {позиция запятой в строке}
  age, err : integer; {значение возраста, код ошибки для парсера}
  str : string;
begin
  new(root);
  root^.pLeft := nil;
  root^.pRight := nil;
{читаем первый элемент}

  readLn(str); {исходная строка}
  cPos := Pos(',', str); {позиция запятой, отделяющий имя от возвраста}
  str := copy(str, cPos + 1, Length(str) - cPos); {взять подстроку, содержащую только цифру возраста}

  Val(str , root^.age, err); {строка в число}
  
  root^.count := 1;

{читаем остальные}
  while not eof do
  begin

    readLn(str); {исходная строка}
    cPos := Pos(',', str); {позиция запятой, отделяющий имя от возвраста}
    str := copy(str, cPos + 1, Length(str) - cPos); {взять подстроку, содержащую только цифру возраста}
    
    Val(str , age, err); {перевести в число}
    
    if err = 0 then {если прочитали число без ошибок}
    begin
      addElement(root, age); {вставка в дерево}
    end
    else begin
      writeLn('readErr: ' , err, '; str:', str) {если запарсили с ошибкой - вывести}
    end;

  end;
end;


procedure passList_print(head :elPtr);
begin
  head := head^.pNext; {пропустить головной (не значащий)}
  
  while head^.pNext<> nil do
  begin
    writeLn('age: ' , head^.pNode^.age, ' count: ', head^.pNode^.count);
    head := head^.pNext;
  end;
  
  writeLn;
end;


{создает головной и замыкающий элементы обходного списка (не значащие)}
procedure passList_create(var head : elPtr);
begin
  new(head);
  head^.pNode := nil;
  head^.pPrev := nil;
  
  new(head^.pNext);
  head^.pNext^.pNode := nil;
  head^.pNext^.pPrev := head;
  head^.pNext^.pNext := nil;
end;


{вставка в обходной список элемента (слева или справа от текущего)}
procedure passList_insert(curr : elPtr; node : nodePtr; depth : integer; pos : boolean);
var
  el : elPtr;
begin
  if pos then {вставка справа от текущего}
  begin
    new(el);
    el^.pNode := node;
    el^.depth := depth;
    
    el^.pNext := curr^.pNext;
    curr^.pNext^.pPrev := el;
    
    el^.pPrev := curr;
    curr^.pNext := el;
  end
  else begin {слева от текущего}
    new(el);
  
    el^.pNode := node;
    el^.depth := depth;
    
    el^.pPrev := curr^.pPrev;
    curr^.pPrev^.pNext := el;
    
    el^.pNext := curr;
    curr^.pPrev := el;
  end;
end;


{обход дерева интерациями. соствление обходного списка}
function getPassList(root : nodePtr) : elPtr;
var
  desCount : integer; {число потомков на след. уровне (если = 0, цикл прекращается)}
  passList : elPtr; {головной элемент (незначащий) списка обхода}
  curr_list : elPtr; {для обхода списка}
  curr_tree : nodePtr; {для обхода дерева}
  currDepth : integer; {текущая глубина. используется дли идентификации элементов,
  которые будут рассматириватьсяна текущей итерации}
begin
  desCount := 2; {у корня 2 потомка (может быть и меньше, но сейчас это не важно)}
  currDepth := -1;
  
  passList_create(passList); {создать служебные элементы списка обхода}
  
  passList_insert(passList, root, 0, true); {вставить головной элемент в список}
  
  {обход дерева в ширину}
  while desCount <> 0 do
  begin
    desCount := 0;
    currDepth := currDepth + 1; {переходим на новый уровень в дереве}
    
    curr_list := passList^.pNext; {каждй раз проходим весть список с головы}
    
    {проход по списку, обработка элементов, стоящих на текущем уровне}
    while curr_list^.pNext <> nil do
    begin
      
      if curr_list^.depth = currDepth then {если элемент стоит на текущем уровне - анализ}
      begin
        curr_tree := curr_list^.pNode;
        
        {занести в список всех его потомков}
        if curr_tree^.pLeft <> nil then
        begin
          passList_insert(curr_list, curr_tree^.pLeft, currDepth + 1, false); {вставить слева}
          desCount := desCount + 1; {есть 1 потомок на уровне}
        end;
        if curr_tree^.pRight <> nil then
        begin
          passList_insert(curr_list, curr_tree^.pRight, currDepth + 1, true); {вставить справа}
          desCount := desCount + 1; {есть 1 потомок на уровне}
        end;
        
      end;
      
      curr_list := curr_list^.pNext;
    end;
  end;
  
  {в passList элеемнты занесены в порядке вывода (левое-коренть-правое)}
  
  getPassList := passList;
end;


{p2}
{вывод дерева. итерациями}
procedure printTree(root : nodePtr);
begin
  passList_print(getPassList(root));
end;


{p3}
{определение общего числа сотрудников, возраст которых < указанного}
function getLess(root : nodePtr; age : integer) : integer;
var
  el : elPtr;
  count : integer;
begin
  el := getPassList(root);
  
  el := el^.pNext;
  
  count := 0;
  
  while el^.pNext <> nil do
  begin
    if el^.pNode^.age < age then {если сотрудники в этом узле моложе - подсчитать их}
      count := count + el^.pNode^.count;
      
    el := el^.pNext;
  end;
  
  getLess := count;
end;


var
  pRoot : nodePtr; {указатель на корень дерева}


begin
  assign(input, 'dan1.inp');
  assign(output, 'res1.out');
  
  reset(input);
  rewrite(output);
  
  createTree(pRoot); {создать дерево}
  
  printTree(pRoot); {вывести элементы по возрастанию}
  
  writeLn('less 20: ', getLess(pRoot, 20)); {вывести число людей, моложе 20}
  
  close(input);
  close(output);
end.