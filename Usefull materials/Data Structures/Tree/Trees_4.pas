Структура для создания корня и узлов дерева имеет вид:
type
	T = Integer;	{ скрываем зависимость от конкретного типа данных }

	TTree = ^TNode;
	TNode = record
		value: T;
		Left, Right: TTree;
	end;
Здесь поля Left и Right - это указатели на потомков данного узла, а поле value предназначено для хранения информации. 

При создании дерева вызывается рекурсивная процедура следующего вида:
procedure Insert(var Root: TTree; X: T);

	{ Дополнительная процедура, создающая и инициализирующая новый узел }
	procedure CreateNode(var p: TTree; n: T);
	begin
		New(p);
		p^.value := n;
		p^.Left := nil;
		p^.Right := nil
	end;
	
begin
	if Root = nil Then CreateNode(Root, X) { создаем новый узел дерева }
	else 
		with Root^ do begin
			if value < X then Insert(Right, X)
			else
				if value > X Then Insert(Left, X)
				else 
				{ Действия, производимые в случае повторного
				внесения элементов в дерево}
		end;
end;
Эта процедура добавляет элемент X к дереву, учитывая величину X. При этом создается новый узел дерева.

Получить значение текущего элемента можно так:
function GetNode(Root: TTree): T;
begin
	if Root = nil then WriteLn('Дерево - пусто!')
	else
		GetNode:=Root^.value
end;
Поиск заданного элемента (функция возвращает адрес узла с найденным элементом; если элемент в дереве не найден, возвращается nil):
function Find(Root: TTree; X: T): TTree;
begin
	if Root = nil then Find := nil
	else
		if X = Root^.value then Find := Root
		else
			if X < Root^.value then Find := Find(Root^.Left, X)
			else Find := Find(Root^.Right, X);
end;
Удаление узла бинарного дерева.

Это немного более сложная операция, чем поиск заданного элемента. Сначала необходимо найти элемент, подлежащий удалению. Если этот элемент - лист, он может быть просто удален. Если же он является внутренним узлом (имеет потомков), то просто так удалить его не получится - будут разрушены внутренние связи в дереве.

Поступаем так:
если удаляемый узел имеет только одного "сына", то его значение можно заменить значением этого "сына"
если у удаляемого элемента 2 "сына", заменяем его элементом с наименьшим значением среди потомков правого "сына" (или элементом с наибольшим значением среди потомков левого "сына")


Для реализации процедуры Remove желательно иметь функцию DeleteMin, которая будет удалять наименьший элемент непустого дерева Root, и возвращать значение удаленного элемента:
function DeleteMin(var Root: TTree): T;
var WasRoot: TTree;
begin

	if Root^.Left = nil then begin
		DeleteMin := Root^.value;	{ Результат функции }
		WasRoot := Root;		{ Запоминаем узел для последующего удаления }
		Root := Root^.Right;		{ продвигаемся дальше }
		Dispose(WasRoot);		{ удаляем бывший корень }
	end
	else { узел Root имеет левого "сына" }
		DeleteMin := DeleteMin(Root^.Left);
	
end;
Теперь процедура Remove может быть реализована так:
procedure Remove(var Root: TTree; X: T);
var WasNext: TTree;
begin
	if Root <> nil then
		if X < Root^.value then Remove(Root^.Left, X)
		else 
			if X > Root^.value then Remove(Root^.Right, X)
			else 
				if (Root^.Left = nil) and (Root^.Right = nil) then begin
					{ Нет "сыновей", удаляем узел, на который указывает Root }
					Dispose(Root); 
					Root := nil
				end
				else 
					if Root^.Left = nil then begin
						WasNext := Root^.Right;
						Dispose(Root);
						Root := WasNext;
					end
					else
						if Root^.Right = nil then begin
							WasNext := Root^.Left;
							Dispose(Root);
							Root := WasNext;
						end
						else { у удаляемого элемента есть оба "сына" }
							Root^.value := DeleteMin(Root^.Right);
end;
Уничтожение бинарного дерева.
Procedure Delete(T: TTree);
Begin
  If T = nil Then Exit;

  Delete(T^.Right);
  Delete(T^.Left);
  Dispose(T)
End;