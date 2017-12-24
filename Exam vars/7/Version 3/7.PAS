type
  tree = ^g;
  g = record
    fam: string[11];
    num: string[10];
    left: tree;
    right: tree;
  end;

procedure P1(var H: text; var head: tree);
  var
    tmp, tmp2, t: tree;
  begin
    new(head);
    head^.left:=nil;
    head^.right:=nil;
    readln(H,head^.fam,head^.num);
    while not eof (H) do begin
      new(t);
      t^.right:=nil;
      t^.left:=nil;
      readln(H,t^.fam,t^.num);

      tmp:=head;
      while tmp <> nil do begin
        tmp2:=tmp;
        if t^.num > tmp^.num then
          tmp:=tmp^.right
        else
          tmp:=tmp^.left;
      end;

      if t^.num > tmp2^.num then
        tmp2^.right:=t
      else
        tmp2^.left:=t;
    end;
  end;

procedure P2(var G: text; var head: tree; i: integer);
  begin
    if head<>nil then begin
      P2(G,head^.left,i+10);
      writeln(G,head^.fam:i,head^.num);
      writeln(G);
      P2(G,head^.right,i+10);
    end;
  end;

procedure P3(var G: text; var head: tree);
  begin
    if head <> nil then
      if (head^.left = nil) and (head^.right = nil) then
        writeln(G,head^.fam, head^.num)
      else
        begin
          P3(G,head^.right);
          P3(G,head^.left);
        end;
  end;

var
  D: tree;
begin
  assign(input,'f1.txt'); reset(input);
  assign(output, 'f2.txt'); rewrite(output);

  P1(input,D);
  P2(output,D,20);

  writeln(output,'---------------------');

  P3(output,D);

  close(input);
  close(output);
end.




