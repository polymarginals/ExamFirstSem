Type 
   Tree=^s; 
   S=record 
   Inf: integer;//<тип хранимой информации>; 
    
      Left , right : tree ; 
End ;
//poisk
function find(root:tree; key:integer; var p, parent:tree):Boolean; 
begin 
   p:=root; 
   while p<>nil do begin 
      if key=p^.inf then begin{ узел с таким ключом есть } 
         find:=true; 
         exit; 
      end; 
      parent:=p; {запомнить указатель на предка} 
      if key<p^.inf then
         p := p ^. left {спуститьс€ влево} 
      else p := p ^. right ; {спуститьс€ вправо} 
   end; 
find:=false; 
end;
//obxod
Procedure obhod(p:tree); 
Begin 
   if p<>nil then 
   begin 
      obhod(p^.left); 
      writeln(p^.inf); 
      obhod(p^.right); 
   end; 
end;
//udalenie
procedure del ( var root : tree ; key : integer ); 
var 
   p : tree ; {удал€емый узел} 
   parent : tree ; {предок удал€емого узла} 
   y : tree ; {узел, замен€ющий удал€емый} 
function spusk(p:tree):tree; 
var 
   y : tree ; {узел, замен€ющий удал€емый} 
   pred:tree; { предок узла УyФ} 
begin 
   y:=p^.right; 
   if y^.left=nil then y^.left:=p^.left {1} 
   else {2} 
   begin 
      repeat 
         pred:=y; y:=y^.left; 
      until y^.left=nil; 
      y^.left:=p^.left; {3} 
      pred^.left:=y^.right; {4} 
      y^.right:=p^.right; {5} 
   end; 
   spusk:=y; 
end;
procedure TreeLoad(var aPNode : TPNode; const aFileName : String); //чтение из файла
var
  F : TextFile;
begin
  TreeFree(aPNode);
  AssignFile(F, aFileName);
  Reset(F);
  try
    NodeLoad(aPNode, F);
  finally
    CloseFile(F);
  end;
end;
Procedure Create_Cicl( var head? PList; n? byte ); var p? PList; i? byte; begin new( head ); head^.link?=head;	{ head Ц указатель на голову списка } { n Ц количество узлов в списке }     { создание элементарного кольца }
for i?=1 to n do begin	{ cоздание циклического списка из n узлов }
new( p );	{ создание узла списка }
readln(p^.info);	{ заполнение информационного пол€ узла }
p^.link?=head^.link;	{ установка св€зи между вставленным узлом и cписком}
head^.link?=p;	{ обновление пол€ св€зи головного узла }
end; end;
begin 
   if not find(root, key, p, parent) then {6} 
   begin writeln('такого элемента нет'); exit; end; 
   if p^.left=nil then y:=p^.right {7} 
   else 
      if p^.right=nil then y:=p^.left {8} 
      else y:=spusk(p); {9} 
   if p=root then root:=y {10} 
   else {11} 
      if key<parent^.inf then 
         parent^.left:=y 
      else parent^.right:=y; 
   dispose(p); {12} 
end;
