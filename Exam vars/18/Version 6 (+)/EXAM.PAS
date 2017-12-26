type
  pbook = ^book;

  book = record
    num: integer;
    author: string;
    name: string;
    year: integer;
    price: integer;
    inputnext: pbook;
    sortednext: pbook;
  end;

procedure sortlist(var head: pbook);
var
  i, j: pbook;
  iprev, jprev: pbook;
  temp: pbook;
begin
  i := head;
  iprev := i;
  while i^.sortednext <> nil do
  begin
    i := i^.sortednext;
    j := i;
    jprev := i;
    while j^.sortednext <> nil do
    begin
      j := j^.sortednext;
      if j^.author < i^.author then
      begin
        if i^.sortednext = j then
        begin
          iprev^.sortednext := j;
          i^.sortednext := j^.sortednext;
          j^.sortednext := i;
        end
        else
        begin
          iprev^.sortednext := j;
          jprev^.sortednext := i;
          temp := j^.sortednext;
          j^.sortednext := i^.sortednext;
          i^.sortednext := temp;
        end;
        temp := i;
        i := j;
        j := temp;
      end;
      jprev := j;
    end;
    iprev := i;
  end;
end;

procedure pushData(var cur:pbook;s:string);
var
 x,error:integer;
 tmp:string;
begin
  x:=pos(' ',s);
  tmp:=copy(s,1,x-1);
  val(tmp, cur^.num,error);
  delete(s,1,x);

  x:=pos(' ',s);
  cur^.author:=copy(s,1,x-1);
  delete(s,1,x);

  x:=pos(' ',s);
  cur^.name:=copy(s,1,x-1);
  delete(s,1,x);

  x:=pos(' ',s);
  tmp:=copy(s,1,x-1);
  val(tmp, cur^.year,error);
  delete(s,1,x);

  val(s, cur^.price,error);

end;

procedure p1(var inputfile: text; var head: pbook);
var
  cur: pbook; s:string;
begin
  cur := head;
  s:='';
  while not eof(inputfile) do
  begin
    new(cur^.inputnext);
    cur^.sortednext := cur^.inputnext;
    cur := cur^.inputnext;
    readln(inputfile, s);
    pushData(cur,s);
  end;
  cur^.inputnext := nil;
  cur^.sortednext := nil;
  sortlist(head);
end;

procedure p2(var head: pbook);
var i,j: pbook; s:string;
begin
  i := head;
  j := head;
  while i^.inputnext <> nil do
  begin
    i := i^.inputnext;
    j := j^.sortednext;
  end;
  new(i^.inputnext);
  j^.sortednext := i^.inputnext;
  i := i^.inputnext;
  writeln('Enter new book:');
  readln(s);
  pushData(i,s);
  i^.inputnext := nil;
  i^.sortednext := nil;
  sortlist(head);
end;

procedure p3(var outputfile: text; var head: pbook);
var
  i: pbook;
begin

  writeln(outputfile, 'Input books:');
  i := head;
  while i^.inputnext <> nil do
  begin
    i := i^.inputnext;
    write(outputfile, i^.num,' ');
    write(outputfile, i^.author,' ');
    write(outputfile, i^.name,' ');
    write(outputfile, i^.year,' ');
    writeln(outputfile, i^.price);
  end;

  writeln(outputfile, 'Output books:');
  i := head;
  while i^.sortednext <> nil do
  begin
    i := i^.sortednext;
    write(outputfile, i^.num, ' ');
    write(outputfile, i^.author, ' ');
    write(outputfile, i^.name, ' ');
    write(outputfile, i^.year, ' ');
    write(outputfile, i^.price, ' ');
    writeln(outputfile);
  end;
end;

var
  inputfile, outputfile: text;
  head: pbook;

begin
  assign(inputfile, 'input.txt');
  assign(outputfile, 'output.txt');
  reset(inputfile);
  rewrite(outputfile);
  new(head);
  p1(inputfile, head);
  close(inputfile);
  p3(outputfile, head);
  p2(head);
  writeln(outputfile,'------------------------');
  p3(outputfile, head);
  close(outputfile);
end.
