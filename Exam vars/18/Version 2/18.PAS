type
  list = ^l;
  l = record
    num: integer;
    author: string[10];
    inf: string;
    sled1, sled2: list;
  end;

procedure p1(filename: string; var head: list);
  var
    tmp1,tmp2,t: list;
    c: char;
  begin
    assign(input,filename); reset(input);

    new(head);
    head^.sled1:=nil;
    head^.sled2:=nil;
    tmp1:=head;

    while not eof(input) do begin
      new(t);
      readln(input,t^.num, c, t^.author, t^.inf);
      t^.sled:=tmp1^.sled1;
      tmp1^.sled1:=t;
      tmp1:=t;

      tmp2:=head;
      while (t^.author < tmp2^.sled2^.author) and (tmp2^.sled2 <> nil) do
        tmp2:=tmp2^.sled2;
      t^.sort:=tmp2^.sled2;
      tmp2^.sled2:=t;
    end;

    close(input);
  end;

procedure p2(var head: list);
  var
    tmp1, tmp2, t: list;
  begin
    new(t);
    writeln('Введите новую книгу:');
    readln(t^.num, c, t^.author, t^.inf);

    tmp1:=head;
    while tmp1^.sled1 <> nil do
      tmp1:=tmp1^.sled1;
    t^.sled:=tmp1^.sled1;
    tmp1^.sled1:=t;
    tmp1:=t;

      tmp2:=head;
      while (t^.author < tmp2^.sled2^.author) and (tmp2^.sled2 <> nil) do
        tmp2:=tmp2^.sled2;
      t^.sort:=tmp2^.sled2;
      tmp2^.sled2:=t;
    end;

procedure p3(filename: string; var head: list);
  var
    tmp: list;
  begin
    assign(output, filename); rewrite(output);

    tmp: head^.sled1;
    while tmp <> nil do begin
      writeln(output,tmp^.num, tmp^.author, tmp^.inf);
      tmp:=tmp1^.sled;
    end;

    writeln(output,'------------------);

    tmp: head^.sled2;
    while tmp <> nil do begin
      writeln(output,tmp^.num, tmp^.author, tmp^.inf);
      tmp:=tmp^.sled2;
    end;

  end;








