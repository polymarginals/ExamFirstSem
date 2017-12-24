program var4;

type
  { Binary Search Tree }
  PBSTree = ^BSTree;
  BSTree  = record
    data  : Char;
    left  : PBSTree;
    right : PBSTree;
  end;

  { Single Linked List }
  PTList = ^TList;
  TList = record
    data  : Char;
    next  : PTList;
  end;

{ Insert new element (char) in tree }
procedure Tree_Insert(var root: PBSTree; element: Char);
var
  ptr       : PBSTree; { pointer to free leaf where new element will be inserted }
  ptrParent : PBSTree; { pointer to parent of ptr }
  newNode   : PBSTree;

begin
  if (root = nil) then
    begin
      New (root);
      root^.left  := nil;
      root^.right := nil;
      root^.data  := element;
    end
    else
    begin
      if (root^.data = element) then
        exit;

      if (element < root^.data) then
        Tree_Insert(root^.left, element)
      else
        Tree_Insert(root^.right, element)
    end;
end;

procedure Tree_CreateFromFile(var f: Text; var root: PBSTree);
var
  tmpChar  : Char;

begin
  while (not Eof(f)) do { reading file line by line }
  begin
    while (not Eoln(f)) do
    begin
      Read(f, tmpChar); { reading each character in file }
      if ((tmpChar >= 'A') And (tmpChar <= 'Z')) then
        Tree_Insert(root, tmpChar);
    end;
    ReadLn(f);
  end;
end;

{ traversing tree by inorder right-to-left rule }
procedure Tree_InorderTraversalRecursively(var f: Text; root: PBSTree);
begin
  if (root = nil) then { reached end of tree }
    exit;

  Tree_InorderTraversalRecursively(f, root^.right); { right subtree first }
  Write(f, root^.data, ' '); { when right subtree is out printing current root }
  Tree_InorderTraversalRecursively(f, root^.left); { finally traversing and printing current root' left subtree }
end;

procedure List_Initialization(var head: PTList; var tail: PTList);
begin
  New(head);
  tail := head;
end;

procedure List_Print(var f: Text; head: PTList; tail: PTList);
var
  tmpList : PTList;

begin
  tmpList := head;

  while (tmpList^.next <> tail^.next) do
  begin
    Write(f, tmpList^.data, ' ');
    tmpList := tmpList^.next;
  end;
end;

procedure List_Add(var f: Text; var head: PTList; var tail: PTList; value: Char);
begin
  tail^.data := value;
  New(tail^.next);
  tail := tail^.next; { move tail pointer to one item next }
end;

procedure List_CreateFromTree(var f: Text; var head: PTList; var tail: PTList; tree: PBSTree);
begin
  if (tree = nil) then { Way to exit from recursion }
    exit;

  List_CreateFromTree(f, head, tail, tree^.right );
  List_Add(f, head, tail, tree^.data);
  List_CreateFromTree(f, head, tail, tree^.left  );
end;

var
  mainTree      : PBSTree;
  mainListHead  : PTList;
  mainListTail  : PTList;
  inp, outp     : Text;

begin
  Assign  (inp, 'input.dat'   );
  Reset   (inp  );
  Assign  (outp, 'output.dat' );
  Rewrite (outp );

  { Creating Tree and its traversing including printing elements into file }
  Tree_CreateFromFile(inp, mainTree);
  Tree_InorderTraversalRecursively(outp, mainTree);

  { Creating List from tree and printing its elements into file }
  List_Initialization(mainListHead, mainListTail          );
  List_CreateFromTree(outp, mainListHead, mainListTail, mainTree);
  WriteLn(outp);
  List_Print(outp, mainListHead, mainListTail);

  Close(inp );
  Close(outp);
end.