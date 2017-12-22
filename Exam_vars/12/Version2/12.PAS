type
  list = ^l;
  l = record
    n: string[5];
    author: string[11];
    book: string[10];
    year: string[4];
    price: integer;
    sled: list;
    pred: list;
  end;

procedure P1(var F: text; var Head: list);
  var
    tmp: list;
    c: char;
  begin
    new(head);
    head^.pred:=nil;
    tmp:=head;
    while not eof(F) do begin
      new(tmp^.sled);
      tmp^.sled^.pred:=tmp;
      tmp:=tmp^.sled;
      readln(F,tmp^.n, tmp^.author, tmp^.book, tmp^.year, tmp^.price);
    end;
    tmp^.sled:=nil;
  end;