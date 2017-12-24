program var11;

type
    PTTreeDataRecord = ^TTreeDataRecord;
    TTreeDataRecord = record
        age       : Integer;
        count     : Integer;
    end;

    PTBSTree = ^TBSTree;
    TBSTree = record
        data  : PTTreeDataRecord;
        left  : PTBSTree;
        right : PTBSTree;
    end;

    PTStack = ^TStack;
    TStack  = record
        data  : PTBSTree;
        prev  : PTStack;
    end;

procedure Tree_CreateFromFile(var f: Text; var root: PTBSTree);
var
    tmpRoot     : PTBSTree;
    lastRoot    : PTBSTree;
    tmpString   : String;
    value       : PTTreeDataRecord;
    i, err      : Integer;

begin
    New(tmpRoot);

    Readln(f, tmpString);
    i := 1;
    while (tmpString[i] <> ',') do
        inc(i);
    Val(Copy(tmpString, i + 1, Length(tmpString)), value^.age, err);
    value^.count := 1;
    tmpRoot^.data := value;

    root := tmpRoot;
    tmpRoot^.left := nil;
    tmpRoot^.right := nil;

    while not Eof(f) do
    begin
        tmpRoot := root;
        New(value);
        Readln(f, tmpString);
        i := 1;
        while (tmpString[i] <> ',') do
            inc(i);
        Val(Copy(tmpString, i + 2, Length(tmpString)), value^.age, err);
        value^.count := 1;

        while (tmpRoot <> nil) do
        begin
            lastRoot := tmpRoot;
            if (tmpRoot^.data^.age = value^.age) then
            begin
                break;
            end;

            lastRoot := tmpRoot;
            if (tmpRoot^.data^.age > value^.age) then
            begin
                tmpRoot := tmpRoot^.left;
            end
            else
            begin
                tmpRoot := tmpRoot^.right;
            end;
        end;

        if (tmpRoot <> nil) then begin
            tmpRoot^.data^.count := tmpRoot^.data^.count + 1
        end
        else
        begin
            New(tmpRoot);
            tmpRoot^.left  := nil;
            tmpRoot^.right := nil;
            tmpRoot^.data  := value;

            if (value^.age > lastRoot^.data^.age) then
                lastRoot^.right := tmpRoot
            else
                lastRoot^.left  := tmpRoot;
        end;
    end;
end;

procedure Stack_Init(var top: PTStack);
begin
    New(top);
    New(top^.data);
end;

procedure Stack_Push(var top: PTStack; element: PTBSTree);
var
    tmpStack : PTStack;

begin
    New(tmpStack);
    tmpStack^.data := element;
    tmpStack^.prev := top;
    top := tmpStack;
end;

function Stack_Pop(var top: PTStack): PTBSTree;
var
    tmpStack : PTStack;
    element  : PTBSTree;

begin
    element := top^.data;
    tmpStack := top;
    top := top^.prev;
    dispose(tmpStack);

    Stack_Pop := element;
end;

function Stack_Top(top: PTStack): PTBSTree;
begin
    Stack_Top := top^.data;
end;

{ traversing tree by inorder right-to-left rule }
procedure Tree_InorderTraversalRecursively(var f: Text; root: PTBSTree);
begin
    if (root = nil) then { reached end of tree }
        exit;

    Tree_InorderTraversalRecursively(f, root^.right); { right subtree first }
    WriteLn(f, 'Возраст: ', root^.data^.age, '. Количество - ', root^.data^.count); { when right subtree is out printing current root }
    Tree_InorderTraversalRecursively(f, root^.left); { finally traversing and printing current root' left subtree }
end;

function Tree_IterativeInorderTraversal(var f: Text; var root: PTBSTree; limitAge: Integer): Integer;
var
    stack   : PTStack;
    tmpRoot : PTBSTree;
    count   : Integer;

begin
    Stack_Init(stack);
    tmpRoot := root;
    count   := 0;

    while ((Stack_Top(stack) <> nil) or (tmpRoot <> nil)) do
    begin
        if (tmpRoot <> nil) then
        begin
            Stack_Push(stack, tmpRoot);
            tmpRoot := tmpRoot^.left;
            WriteLn(f, 'Push: ', Stack_Top(stack)^.data^.age);
        end
        else
        begin
            tmpRoot := Stack_Pop(stack);
            WriteLn(f, 'After Pop: ', Stack_Top(stack)^.data^.age);
            if (tmpRoot^.data^.age < limitAge) then
                inc(count);
            WriteLn(f, 'Возраст: ', tmpRoot^.data^.age, '. Количество - ', tmpRoot^.data^.count);
            Writeln(f, 'is nil? ', tmpRoot^.right = nil);
            tmpRoot := tmpRoot^.right;
        end;
    end;

    Tree_IterativeInorderTraversal := count;
end;

var
    tree  : PTBSTree;
    count : Integer;
    inp   : Text;
    outp  : Text;

begin
    Assign(inp, 'input.dat');
    Reset(inp);
    Assign(outp, 'output.dat');
    Rewrite(outp);

    Tree_CreateFromFile(inp, tree);
    Tree_InorderTraversalRecursively(outp, tree);
    count := Tree_IterativeInorderTraversal(outp, tree, 20);

    WriteLn(outp, 'Людей с возрастом меньше 20: ', count);

    Close(inp);
    Close(outp);
end.