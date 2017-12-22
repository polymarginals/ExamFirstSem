program lists;
type list = ^listRecord;
     listRecord = record
                data : char;
                next : list;
                end;
procedure readList(head : list; var H : text);
var node : list;
begin
  node := head;
  while not eof(H) do
  begin
  new(node^.next);
  node := node^.next;
  readln(H, node^.data);
  end;
  node^.next := nil;
end;
procedure printList(var G : text; head : list);
var node : list;
begin
  node := head^.next;
  while node <> nil do
  begin
    writeln(G, node^.data);
    node := node^.next;
  end;
end;
procedure sortAdress(head : list);
var node, tail, tmp : list;
    flag : boolean;
begin
  flag := true;
  while flag do
  begin
    flag := false;
    node := head;
    tmp := head^.next;
    while tmp^.next <> nil do
    begin
      if tmp^.data < tmp^.next^.data then
      begin
        flag := true;
        tail := tmp^.next^.next;
        node^.next := tmp^.next;
        tmp^.next^.next := tmp;
        tmp^.next := tail;
      end;
      node := node^.next;
      tmp := node^.next;
    end;
  end;
end;

var head : list; textFile : text;
begin
  new(head);
  head^.next := nil;
  assign(textFile, 'f1.txt');
  reset(textFile);
  readList(head, textFile);
  close(textFile);
  assign(textFile, 'f2.txt');
  rewrite(textFile);
  sortAdress(head);
  printList(textFile, head);
  close(textFile);
end.