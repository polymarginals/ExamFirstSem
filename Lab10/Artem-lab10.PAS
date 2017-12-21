Type
  ut=^tree;
  tree=record
    inf: integer;
    left, right: ut;
  end;

  ust=^stack;
  stack=record
    l: integer;
    utree: ut;
    next: ust;
  end;

  ul=^list;
  list=record
    s: string;
    txtlvl: integer;
    next: ul;
  end;

Var
  depth: integer;
  root: ut;
  head: ul;
  input, output: text;

Procedure insertSpace(tmpList: ul; x: integer);
var
  i: integer;
begin
  for i:=1 to x do
    tmpList^.s:=tmpList^.s+' ';
end;

Procedure NodeHardInsert(checkList, insList: ul);
var
  sl: char;
  i, cn: integer;
begin
  for i:=1 to length(checkList^.s) do
    begin
      if (checkList^.s[i] <> ' ') and ((length(insList^.s) + 1 ) < i ) then
        begin
          if (checkList^.s[i] = '/') then
            begin
              if insList^.s = '' then
                insertSpace(insList, i - 2)
              else
                insertSpace(insList, i - length(insList^.s) -  2);
            end
          else
            begin
              if insList^.s = '' then
                insertSpace(insList, i)
              else
                insertSpace(insList, i - length(insList^.s));
            end;
          break;
        end;
    end;
end;

Procedure push(var head : ust; tmpTree: ut; x:integer);
var
  tmpStack: ust;
begin
  new(tmpStack);
  tmpStack^.utree:=tmpTree;
  tmpStack^.l:=x;
  tmpStack^.next:=head;
  head:=tmpStack;
end;

Procedure pop(var head: ust; var tmpTree: ut; var x : integer);
var
  tmpStack: ust;
begin
  x:= head^.l;
  tmpTree:=head^.utree;
  tmpStack:=head;
  head:=head^.next;
  dispose(tmpStack);
end;

Procedure formList(var head: ul; depth:integer);
var
  tmpList: ul;
  i: integer;
begin
  new(tmpList);
  tmpList^.s:='';
  tmpList^.txtlvl:=1;
  head:=tmpList;
  new(tmpList^.next);
  for i:=2 to depth*2 do
    begin
      tmpList:=tmpList^.next;
      tmpList^.s:='';
      if i mod 2 <> 0 then
        tmpList^.txtlvl:=(i div 2 ) + 1
      else
        tmpList^.txtlvl:=0;
      new(tmpList^.next);
    end;
  tmpList^.next:=nil;
end;

Procedure deleteList(var head: ul);
begin
  if head^.next<>nil then
    deleteList(head^.next);
  dispose(head);
end;

Procedure deleteTree(var root: ut);
begin
  if root^.left <> nil then
    deleteTree(root^.left);
  if root^.right <> nil then
    deleteTree(root^.right);
  dispose(root);
end;  
  
Procedure P1(var input: text; var root: ut);
var
  x: integer;
  tmpTree, t: ut;
begin

    while not eof(input) do
      begin

        read(input, x);
        new(tmpTree);
        tmpTree^.inf:=x;
        tmpTree^.left:=nil;
        tmpTree^.right:=nil;

        if root = nil then
          root:=tmpTree
        else
          begin
            t:=root;

            while t <> nil do
              if tmpTree^.inf < t^.inf then
                begin
                  if t^.left=nil then
                    begin
                      t^.left:=tmpTree;
                      t:=tmpTree^.left;
                    end
                  else
                    t:=t^.left;
                end
              else
                if t^.right=nil then
                  begin
                    t^.right:=tmpTree;
                    t:=tmpTree^.right;
                  end
                else
                  t:=t^.right;
          end;
      end;
end;

Procedure P2(root: ut; var depth: integer);
var
  x: integer;
  curTree: ut;
  head: ust;

begin
  head:=nil;
  head^.l:=0;
  head^.utree:=nil;
  curTree:=root;
  x:=1;
  push(head, curTree, x);
  if curTree^.right <> nil then
    push(head, curTree^.right, x+1);
  curTree:=curTree^.left;
  if curTree^.left <> nil then
    inc(x);
  while (head <> nil) do
    begin
      if curTree^.right <> nil then
            push(head, curTree^.right, x+1);
      if curTree^.left <> nil then
        begin
          curTree:=curTree^.left;
          inc(x);
        end
      else
        begin
          if x > depth then
            depth:=x;
          pop(head, curTree, x);
        end;
    end;
end;

Procedure P3(var output:text; tmpList: ul; preList: ul; curTree: ut; depth:integer);
var
  i, cn, error: integer;
  ts : string;
  sl : char;
begin
  If tmpList^.s='' then
    begin
      if tmpList^.txtlvl=1 then
        insertSpace(tmpList, (depth*2))
      else
        NodeHardInsert(preList, tmpList);
      str(curTree^.inf, ts);
      tmpList^.s:=tmpList^.s + ts;

      if curTree^.left <> nil then
        begin
          insertSpace(tmpList^.next, length(tmpList^.s)-2);
          tmpList^.next^.s:=tmpList^.next^.s + '/';
        end
      else
        if curTree^.right <> nil then
          begin
            insertSpace(tmpList^.next, length(tmpList^.s));
            tmpList^.next^.s:=tmpList^.next^.s + '\';
          end;

      if ((curTree^.left <> nil) and (curTree^.right <> nil)) then
        begin
          insertSpace(tmpList^.next, 1);
          tmpList^.next^.s:=tmpList^.next^.s + '\';
        end;
    end
  else
    begin
      NodeHardInsert(preList, tmpList);
      str(curTree^.inf, ts);
      tmpList^.s:=tmpList^.s + ts;
      if tmplist^.next^.s='' then
        begin
          if curTree^.left <> nil then
            begin
              insertSpace(tmpList^.next, length(tmpList^.s) - 2);
              tmpList^.next^.s:=tmpList^.next^.s + '/';
            end
          else
            if curTree^.right <> nil then
              begin
                insertSpace(tmpList^.next, length(tmpList^.s) - length(tmpList^.next^.s));
                tmpList^.next^.s:=tmpList^.next^.s + '\';
              end;
          if ((curTree^.left <> nil) and (curTree^.right <> nil)) then
            begin
              insertSpace(tmpList^.next, 1);
              tmpList^.next^.s:=tmpList^.next^.s + '\';
            end

        end
      else
        begin
          if curTree^.left <> nil then
            begin
              insertSpace(tmpList^.next, length(tmpList^.s) - length(tmpList^.next^.s) - 2);
              tmpList^.next^.s:=tmpList^.next^.s + '/';
            end
          else
            if curTree^.right <> nil then
              begin
                insertSpace(tmpList^.next, length(tmpList^.s) - length(tmpList^.next^.s));
                tmpList^.next^.s:=tmpList^.next^.s + '\';
              end;
          if ((curTree^.left <> nil) and (curTree^.right <> nil)) then
            begin
              insertSpace(tmpList^.next, 1);
              tmpList^.next^.s:=tmpList^.next^.s + '\';
            end;
        end;
    end;
  if curTree^.left <> nil then
    P3(output, tmpList^.next^.next, tmpList^.next, curTree^.left, depth-1);
  if curTree^.right <> nil then
    P3(output, tmpList^.next^.next, tmpList^.next, CurTree^.right, depth-1);

  if (tmpList^.txtlvl = 1) then
    begin
      tmpList:=head;
      for i:=1 to depth*2 do
        begin
          writeln(output, tmpList^.s);
          tmpList:=tmpList^.next;
        end;
    end;
end;

Begin
  depth:=0;
  root:=nil;
  head:=nil;
  assign(input,'input10.txt');
  reset(input);
  P1(input, root);
  close(input);

  assign(output,'output10.txt');
  rewrite(output);
  P2(root, depth);
  writeln(output, 'Depth: ', depth);
  writeln(output);

  formList(head, depth);
  P3(output, head, head, root, depth);
  deleteList(head);
  deleteTree(root);
  close(output);
End.
66
