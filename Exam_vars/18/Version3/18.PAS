uses
  crt;
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
  begin
    assign(input,filename); reset(input);

    new(head);
    head^.sled1:=nil;
    head^.sled2:=nil;
    tmp1:=head;

    while not eof(input) do begin
      new(t);
      readln(input,t^.num, t^.author, t^.inf);
      t^.sled1:=tmp1^.sled1;
      tmp1^.sled1:=t;
      tmp1:=t;

      tmp2:=head;
      while (t^.author > tmp2^.sled2^.author) and (tmp2^.sled2 <> nil) do
        tmp2:=tmp2^.sled2;
      t^.sled2:=tmp2^.sled2;
      tmp2^.sled2:=t;
    end;

    close(input);
  end;

procedure p2(filename: string; var head: list);
  var
    tmp1, tmp2, t: list;
  begin
    assign(input,filename); reset(input);
    new(t);
    {writeln('Введите новую книгу:');}
    readln(t^.num, t^.author, t^.inf);

    tmp1:=head;
    while tmp1^.sled1 <> nil do
      tmp1:=tmp1^.sled1;
    t^.sled1:=tmp1^.sled1;
    tmp1^.sled1:=t;
    tmp1:=t;

      tmp2:=head;
      while (t^.author > tmp2^.sled2^.author) and (tmp2^.sled2 <> nil) do
        tmp2:=tmp2^.sled2;
      t^.sled2:=tmp2^.sled2;
      tmp2^.sled2:=t;
    close(input);

  end;

procedure p3(filename: string; var head: list);
  var
    tmp: list;
  begin
    assign(output, filename); rewrite(output);

    writeln(output,'------------------');

    tmp:=head^.sled1;
    while tmp <> nil do begin
      writeln(output,tmp^.num, tmp^.author, tmp^.inf);
      tmp:=tmp^.sled1;
    end;

    writeln(output,'------------------');

    tmp:=head^.sled2;
    while tmp <> nil do begin
      writeln(output,tmp^.num, tmp^.author, tmp^.inf);
      tmp:=tmp^.sled2;
    end;

    writeln(output,'------------------');

  end;

var
  Head: list;
begin
  p1('in.txt',head);
  p3('out1.txt',head);
  p2('in.txt',head);
  p3('out2.txt',head);
end.








