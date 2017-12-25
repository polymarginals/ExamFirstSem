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

procedure p1(var inputfile: text; var head: pbook);
var
  i: pbook;
begin
  reset(inputfile);
  i := head;
  while not eof(inputfile) do
  begin
    new(i^.inputnext);
    i^.sortednext := i^.inputnext;
    i := i^.inputnext;
    readln(inputfile, i^.num);
    readln(inputfile, i^.author);
    readln(inputfile, i^.name);
    readln(inputfile, i^.year);
    readln(inputfile, i^.price);
  end;
  i^.inputnext := nil;
  i^.sortednext := nil;
  close(inputfile);
  sortlist(head);
end;

procedure p2(var head: pbook);
var i: pbook;
var j: pbook;
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
  readln(i^.num);
  readln(i^.author);
  readln(i^.name);
  readln(i^.year);
  readln(i^.price);
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
    writeln(outputfile, i^.num);
    writeln(outputfile, i^.author);
    writeln(outputfile, i^.name);
    writeln(outputfile, i^.year);
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
  rewrite(outputfile);
  new(head);
  p1(inputfile, head);
  p3(outputfile, head);
  p2(head);
  p3(outputfile, head);
  close(outputfile);
end.
