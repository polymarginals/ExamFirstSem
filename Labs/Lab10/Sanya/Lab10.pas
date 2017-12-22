program LAB5;

type
    SubTree  = ^TreeRoot;
    TreeRoot =  record
        data           : integer;
        lChild, rChild : SubTree;
        height         : integer;
    end;

    StackPtr = ^Stack;
    Stack    =  record
        Tree : SubTree;
        Next : StackPtr;
        n    : integer;
    end;

procedure P1 (var f : Text; var root : SubTree);
var
   tmp, LastRoot : SubTree;
   value    : integer;

begin
    new  (tmp      );
    tmp^.height := -2;
    read (tmp^.data);
    root := tmp;
    write(f, tmp^.data, ' ');
    tmp^.lChild := Nil;
    tmp^.rChild := Nil;
    while not eoln do
    begin
        tmp  := root;
        read (value     );
        write(f, value, ' ');
        while tmp <> Nil do
        begin
            LastRoot := tmp;
            if value >  tmp^.data then
                tmp  := tmp^.rChild
            else
                tmp  := tmp^.lChild;
        end;
        new  (tmp);
        tmp^.height := -2;
        tmp^.lChild  := Nil;
        tmp^.rChild  := Nil;
        tmp^.data    := value;
        if  value    >  LastRoot^.data then
            LastRoot^.rChild := tmp
        else
            LastRoot^.lChild := tmp;
    end;
    writeln(f);
end;

procedure P2 (var root   : SubTree;
              var height : integer);
label outerLoop,innerLoop;
var
   mainStack, front, elToBeDeleted  : StackPtr;
   tmp                              : SubTree;
   maxHeight, tmpHeight             : integer;
begin
    tmp             := root     ;
    if (tmp <> nil) then
    begin
      tmpHeight               := 0        ;
      height                  := 0        ;

      new(mainStack)                      ;
      mainStack^.Next         := Nil      ;
      front                   := mainStack;
      new(mainStack)                      ;
      mainStack^.n            := 0        ;
      mainStack^.Next         := front    ;
      front                   := mainStack;
      mainStack^.Tree         := tmp      ;
      mainStack^.Tree^.height := tmpHeight;

  outerLoop:
      if mainStack^.Next <> Nil then
      begin
           if tmp^.lChild <> Nil then
	   begin
                inc(tmpHeight)                        ;
	        new(mainStack)                        ;
                mainStack^.n            := 0          ;
	        mainStack^.Next         := front      ;
	        front                   := mainStack  ;
	        tmp                     := tmp^.lChild;
	        mainStack^.Tree         := tmp        ;
                mainStack^.Tree^.height := tmpHeight  ;
	        goto                       outerLoop  ;
	  end
	  else
	  begin
          innerLoop:
               if tmp^.lChild = nil then
               begin
                  mainStack^.n  := mainStack^.n + 1;
               end;

               if mainStack^.Next <> nil then
               begin
      	          if tmp^.rChild  <> nil then
                  begin
                       if mainStack^.n < 2 then
		       begin
                            inc(tmpHeight)                        ;
			    new(mainStack)                        ;
                            mainStack^.n            := 0          ;
			    mainStack^.Next         := front      ;
			    front                   := mainStack  ;
			    tmp                     := tmp^.rChild;
                            mainStack^.Tree         := tmp        ;
                            mainStack^.Tree^.height := tmpHeight  ;

			    goto                       outerLoop  ;
		       end
		       else
		       begin
                            if (mainStack^.Tree^.height > -2) then
                            begin
                               dec(tmpHeight)                  ;
                               mainStack^.Tree^.height := -2   ;
                            end;

		            mainStack       := mainStack^.Next ;
			    mainStack^.n    := mainStack^.n + 1;
                            tmp             := mainStack^.Tree ;

                            goto               innerLoop       ;
                       end;
                  end
                  else
	          begin
                       if (tmpHeight > height) then
                          height := tmpHeight;

                       if (mainStack^.Tree^.height > -2) then
                       begin
                            dec(tmpHeight);
                            mainStack^.Tree^.height := -2;
                       end;

		       elToBeDeleted := mainStack       ;
		       mainStack     := mainStack^.Next ;
		       front         := mainStack       ;
		       dispose(elToBeDeleted)           ;
		       tmp           := mainStack^.Tree ;
                       mainStack^.n  := mainStack^.n + 1;

		       goto             innerLoop       ;
	          end;
               end;
          end;
      end;
    end
    else
        height := -1;
end;

procedure PrintNode(var f : Text; value : integer);
begin
     writeln(f, value);
end;

procedure PrintTree(var f : Text; root : SubTree; isRight : boolean; indent : String);
var
   tmp : SubTree;

begin
  tmp := root;
  if (tmp^.rChild <> nil) then
  begin
     if (isRight = true) then
        PrintTree(f, tmp^.rChild, true, Concat(indent, '        '))
     else
        PrintTree(f, tmp^.rChild, true, Concat(indent, ' |      '));
  end;
  write(f, indent);
  if (isRight = true) then
     write(f, ' /')
  else
     write(f, ' \');
  write(f, '----- ');
  PrintNode(f, tmp^.data);
  if (tmp^.lChild <> nil) then
  begin
     if (isRight = true) then
        PrintTree(f, tmp^.lChild, false, Concat(indent, ' |      '))
     else
        PrintTree(f, tmp^.lChild, false, Concat(indent, '        '));
  end;
end;

procedure PrintTreeBase(var f : Text; root : SubTree);
var
   tmp : SubTree;
begin
  tmp := root;
  if tmp^.rChild <> nil then
     PrintTree(f, tmp^.rChild, true, '');
  PrintNode(f, tmp^.data);
  if tmp^.lChild <> nil then
     PrintTree(f, tmp^.lChild, false, '');
end;

procedure P3 (var f : Text; root : SubTree; depth : integer; isRight : boolean);
var
   tmp : SubTree;
   i   : integer;

begin
  tmp := root;
    if (depth > 0) then
    begin
       writeln(f);
       write(f, '    |-- ')
    end
    else
       write(f, '    ');

  for i := 1 to depth - 1 do
      write(f, '-- ');
  write(f, tmp^.data);
  if (depth > 0) then
    if (isRight = true) then
       write(f, ' [R]')
    else
       write(f, ' [L]');
  if (tmp^.lChild <> nil) then
     P3(f, tmp^.lChild, depth + 1, false);
  if (tmp^.rChild <> nil) then
     P3(f, tmp^.rChild, depth + 1, true);
end;

var
   rootFirst, rootSecond, rootThird       : SubTree;
   firstHeight, secondHeight, thirdHeight : integer;
   res                                    : Text;

begin
assign (input , 'f1.txt'        );
reset  (input                   );
assign (res,    'f2.txt'        );
rewrite(res                     );

writeln(res, 'First String given:'   );
P1     (res, rootFirst          );
readln;
writeln(res);

writeln(res, 'Second String given:'  );
P1     (res, rootSecond         );
writeln(res);

writeln(res, 'Third String given:');
P1     (res, rootThird          );
writeln(res);

P2     (rootFirst , firstHeight                      );
writeln(res, 'Height of the first tree is ', firstHeight  );
P2     (rootSecond, secondHeight                     );
writeln(res, 'Height of the second tree is ', secondHeight);
P2     (rootThird , thirdHeight                      );
writeln(res, 'Height of the third tree is ', thirdHeight  );

writeln(res);
writeln(res, 'Tree Preorder Traversal (Tree - Left - Right)');
writeln(res);

writeln(res, 'First Tree ['         );
P3     (res, rootFirst , 0, false   );
writeln(res                         );
writeln(res, ']'                    );
writeln(res                         );

writeln(res, 'Second Tree ['        );
P3     (res, rootSecond, 0, false   );
writeln(res                         );
writeln(res, ']'                    );
writeln(res                         );

writeln(res, 'Third Tree ['         );
P3     (res, rootThird , 0, false   );
writeln(res                         );
writeln(res, ']'                    );
writeln(res                         );

writeln(res, 'Tree Pretty Printing' );
writeln(res, 'First Tree:'          );
PrintTreeBase(res, rootFirst        );
writeln(res                         );
writeln(res, 'Second Tree:'         );
PrintTreeBase(res, rootSecond       );
writeln(res                         );
writeln(res, 'Third Tree:'          );
PrintTreeBase(res, rootThird        );

close  (input                       );
close  (res                         );

end.
