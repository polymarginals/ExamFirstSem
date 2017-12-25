type

ptrL = ^ItemL; {type DoubleLinked list}
  ItemL = record {item of DoubleLinked list}
    name       : string; {Name}
    date       : string;
    price      : integer;
    quantity   : integer;
    next       : ptrL;
  end;  

var
  head          : ptrL;
  input, output : text;


Procedure pushData(var currPtr: ptrL; s: string);
var
  x, error    : integer;
  tmpS        : string; 
begin
  x:=pos(' ',s);
  currPtr^.name:=copy(s,1,x-1);
  delete(s,1,x);
  
  x:=pos(' ',s);
  currPtr^.date:=copy(s,1,x-1);
  delete(s,1,x);
  
  x:=pos(' ',s);
  tmpS:=copy(s,1,x-1);
  val(tmpS, currPtr^.price, error);
  delete(s,1,x);
  
  val(s, currPtr^.quantity, error);
end; 
  
Procedure P1(var input: text; var head: ptrL);
var
  tmpPtr  : ptrL;
  x       : integer;
  s       : string;
begin
  new(head);
  head^.next:= nil;
  tmpPtr:=head;
  while not eof(input) do
    begin
      new(tmpPtr^.next);
      tmpPtr:=tmpPtr^.next;
      readln(input, s);
      pushData(tmpPtr, s);
    end;
  tmpPtr^.next:=nil;
end;

Procedure P2(var head: ptrL);
var
  tmpPtr, searchPtr : ptrL;
  readS  : string;
begin
  new(tmpPtr);
  writeln('Write record:');
  readln(readS);
  pushData(tmpPtr, readS);

  searchPtr:=head;
  while ((searchPtr^.next <> nil) and (tmpPtr^.name > searchPtr^.next^.name))
 and not ((searchPtr^.next^.name = tmpPtr^.name)
      and (searchPtr^.next^.date = tmpPtr^.date)
      and (searchPtr^.next^.price = tmpPtr^.price))   do
    searchPtr:=searchPtr^.next;

  if ((searchPtr^.next^.name = tmpPtr^.name)
  and (searchPtr^.next^.date = tmpPtr^.date)
  and (searchPtr^.next^.price = tmpPtr^.price)) then
    begin
      searchPtr^.next^.quantity := searchPtr^.next^.quantity + tmpPtr^.quantity;
    end
  else
    begin

      tmpPtr^.next:=searchPtr^.next;
      searchPtr^.next:=tmpPtr;
    end;
end;

Procedure P3(var head: ptrL);
var
  outerPtr, innerPtr          : PTrL;
  prevOuterPtr, prevInnerPtr  : PTrL;
  tmpPtr                      : PTrL;
begin
  outerPtr := head;
  prevOuterPtr := outerPtr;
  while outerPtr^.next <> nil do
    begin
      outerPtr := outerPtr^.next;
      innerPtr := outerPtr;
      prevInnerPtr := outerPtr;
      while innerPtr^.next <> nil do
        begin
          innerPtr := innerPtr^.next;
          if innerPtr^.date < outerPtr^.date then
            begin
              if outerPtr^.next = innerPtr then
                begin
                  prevOuterPtr^.next := innerPtr;
                  outerPtr^.next := innerPtr^.next;
                  innerPtr^.next := outerPtr;
                end
              else
                begin
                  prevOuterPtr^.next := innerPtr;
                  prevInnerPtr^.next := outerPtr;
                  tmpPtr := innerPtr^.next;
                  innerPtr^.next := outerPtr^.Next;
                  outerPtr^.next := tmpPtr;
                end;
              tmpPtr   := outerPtr;
              outerPtr := innerPtr;
              innerPtr := tmpPtr;
            end;
          prevInnerPtr := innerPtr;
        end;
        prevOuterPtr := outerPtr;
    end;
end;

Procedure P4(var output: text; head: ptrL);
begin
  head:=head^.next;
  while head <> nil do
    begin
      writeln(output, head^.name, ' ', head^.date, ' ', head^.price, ' ', head^.quantity);
      head:=head^.next;
    end;
  writeln(output);  
end; 

Begin
  assign(input, 'input.txt');
  reset(input);
  P1(input, head);
  
  close(input);
  
  assign(output, 'output.txt');
  rewrite(output);

  P4(output, head);
  
  P2(head);
  P4(output, head);
 
  P3(head);
  P4(output, head);
  close(output);
End.