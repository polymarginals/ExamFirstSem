program trees;
type treePtr = ^treeRecord;
     treeRecord = record
                  data : string;
                  left, right : treePtr;
                  end;
procedure itAddtoTree(var tree : treePtr; s : string);
var tmp : treePtr;
begin
  tmp := tree;
  while(tree <> nil) do
    if s < tree^.data then tree := tree^.left
    else if s >= tree^.data then tree := tree^.right;
  new(tree);
  tree^.data := s;
  tree^.left := nil;
  tree^.right := nil;
end;

procedure AddToTree(var tree : treePtr; s : string);
begin
if tree = nil then begin
new(tree);
tree^.data := s;
tree^.left := nil;
tree^.right := nil;
exit;
end;
if s < tree^.data then AddtoTree(tree^.left, s)
else if s > tree^.data then AddToTree(tree^.right, s);
end;
function search(tree : treePtr; s : string) : treePtr;
var tmp : treePtr;
begin
  if tree = nil then
  begin
    search := nil;
    exit;
  end;
  if s = tree^.data then tmp := tree
  else if s < tree^.data then tmp := search(tree^.left, s)
       else if s > tree^.data then tmp := search(tree^.right, s);
  search := tmp;
end;
procedure deleteTree(var tree : treePtr);
begin
  if Tree <> nil then begin
  deleteTree(tree^.left);
  deleteTree(tree^.right);
  dispose(tree);
  end;
end;
procedure traversal(tree : treePtr);
begin
  if tree = nil then exit;
   writeln(tree^.data);
  traversal(tree^.left);
  traversal(tree^.right);
end;
var treen : treePtr; s : string;
begin
  s := 'blablabla';
  treen := nil;
  itAddtoTree(treen, s);
  traversal(treen);
  writeln('---------------');
end.