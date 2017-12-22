program bil19;

uses
  New_crt;

type
  pbook = ^tbook;
  tbook = record
    next, pred: pbook;
    nomer: integer;
    avtor: string[10];
    name : string[10];
    year : integer;
    chena : integer;

  end;

var
  book,
  beglist: pbook;
  rel: pointer;
  fbooks: file of tbook;
  input, output: text;

procedure sort(var beglist: pbook);
var
  stop, first: boolean;
  book1, book2: pbook;
begin

  repeat
    stop := true;
    book := beglist;
    first := true;
    while book^.next <> nil do
    begin
      if book^.nomer > book^.next^.nomer then
      begin
        book1 := book;
        book := book^.next;
        if first then
          beglist := book else
        begin
          book2 := beglist;
          while book2^.next <> book1 do
            book2 := book2^.next;
          book2^.next := book
        end;
        book1^.next := book^.next;
        book^.next := book1;
        stop := false;
      end;
      first :=false;
      book := book^.next
    end
  until stop;

end;


procedure p1(var beglist: pbook);
var
  book1: pbook;
begin

  assign(input, 'input.txt');
  reset(input);
  beglist := nil;
  while not eof(input) do
  begin
    book1 := book;
   { sort(beglist);
   } new(book);
    with book^ do
    begin
      next := nil;
      pred := nil;
      if beglist = nil then
        beglist := book
      else
        book1^.next := book;

        book1^.pred := ;


      readln(input, nomer, avtor, name, year, chena);
    end;
  end;

  close(input)
end;


procedure p3(var beglist: pbook);
begin


  assign(output, 'output.txt');
  rewrite(output);
  writeln(output);
  book := beglist;
  while book <> nil do
  begin
    with book^ do
      writeln(output, nomer:2, avtor:10, name:10, year:5, chena:5);
    book := book^.next;
  end;
  Writeln(output,'*****');

  while book <>  do
   begin
    with book^ do
      writeln(output, nomer:2, avtor:10, name:10, year:5, chena:5);
    book := book^. ;
  end;
  close(output);
end;



begin
  clrscr;
  assign(input, 'input.txt');
  reset(input);
  p1(beglist);
  p3(beglist);
end.