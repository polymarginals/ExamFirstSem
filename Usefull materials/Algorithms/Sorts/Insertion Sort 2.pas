procedure sort (p: plist);
var
  t: plist;
  X: integer;
begin
  t := p^.link;
  if t <> nil then

    if p^.info > t^.info then begin
      X := t^.info;
      t^.info := p^.info;
      p^.info := X;

      sort (first);
    end
    else sort (p^.link);
end;


program sort1;
uses crt;
type
    plist = ^tlist;
    tlist = record
        info: integer;
        link: plist;
    end;
var    first: plist;
procedure sort (p: plist);                    { BEFORE HIGH Процедура сортировки простыми вставками}
var t: plist;
begin
    while p<>nil do
        begin
            t:=p^.link;
            if p^.info>t^.info then
                begin
                    t^.link:=p;
                    p^.link:=t;
                    sort (first);
                    break;
                end;
            p:= p^.link;
        end;
end;
procedure print(p: plist);                    {Процедура вывода списка}
begin
    while p <> nil do
        begin
            write(p^.info, ' ');
            p := p^.link;
        end;
    writeln;
end;
procedure vvod (var first: plist);                {Процедура ввода списка}
var    s: integer;
    p, last: plist;
begin
    last := first;
    repeat
        write('Введите следующий элемент: ');
        readln(s);
        if s <> 0 then
            begin
                new(p);
                p^.info := s;
                p^.link := nil;
                if first = nil
                    then
                        first := p
                    else     last^.link := p;
                last := p;
            end;
    until s = 0;
end;
begin
    clrscr;
    writeln('Введите список:');
    first:=nil;
    vvod (first);
    sort (first);
    print(first);
    readkey;
end.