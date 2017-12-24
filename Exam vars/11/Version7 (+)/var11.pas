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

procedure Tree_CreateFromFile(var fout: Text; var fin: Text; var root: PTBSTree);
var
    tmpRoot     : PTBSTree;
    lastRoot    : PTBSTree;
    tmpString   : String;
    value       : PTTreeDataRecord;
    i, err      : Integer;

begin
    New(tmpRoot);

    Readln(fin, tmpString);
    WriteLn(fout, tmpString);
    i := 1;
    while (tmpString[i] <> ',') do
        inc(i);
    Val(Copy(tmpString, i + 1, Length(tmpString)), value^.age, err);
    value^.count := 1;
    tmpRoot^.data := value;

    root := tmpRoot;
    tmpRoot^.left := nil;
    tmpRoot^.right := nil;

    while not Eof(fin) do
    begin
        tmpRoot := root;

        New(value);
        Readln(fin, tmpString);
        WriteLn(fout, tmpString);
        i := 1;
        while (tmpString[i] <> ',') do inc(i);
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
    top := nil;
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
    element     := top^.data;
    tmpStack    := top      ;
    top         := top^.prev;
    Dispose(tmpStack)       ;

    Stack_Pop   := element  ;
end;

function Stack_Top(top: PTStack): PTBSTree;
begin
    Stack_Top := top^.data;
end;

procedure Stack_Print(var stack: PTStack);
var
    tmpElement : PTBSTree;
begin
    while (stack <> nil) do
    begin
        tmpElement := Stack_Pop(stack);
        WriteLn(tmpElement^.data^.age, ' ', tmpElement^.data^.count);
    end;
end;

function Tree_IterativeInorderTraversal(var f: Text; var root: PTBSTree; limitAge: Integer): Integer;
var
    stack   : PTStack;
    tmpRoot : PTBSTree;
    count   : Integer;

begin
    tmpRoot := root;
    Stack_Init(stack);
    count   := 0;

    while ((stack <> nil) or (tmpRoot <> nil)) do
    begin
        if (tmpRoot <> nil) then
        begin
            Stack_Push(stack, tmpRoot);
            tmpRoot := tmpRoot^.left;
        end
        else
        begin
            tmpRoot := Stack_Pop(stack);
            if (tmpRoot^.data^.age < limitAge) then
                count := count + tmpRoot^.data^.count;
            WriteLn(f, 'Age: ', tmpRoot^.data^.age, '. Count - ', tmpRoot^.data^.count);
            tmpRoot := tmpRoot^.right;
        end;
    end;

    Tree_IterativeInorderTraversal := count;
end;

var
    tree  : PTBSTree;
    stack : PTStack;
    count : Integer;
    inp   : Text;
    outp  : Text;
    limit : Integer;

begin
    Assign(inp, 'input.dat');
    Reset(inp);
    Assign(outp, 'output.dat');
    Rewrite(outp);

    Tree_CreateFromFile(outp, inp, tree);
    Stack_Init(stack);
    WriteLn('Please, enter desired age: ');
    ReadLn(limit);
    count := Tree_IterativeInorderTraversal(outp, tree, limit);

    WriteLn(outp, 'People who are younger than ', limit, ': ', count);

    Close(inp);
    Close(outp);
end.