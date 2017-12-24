type
ptrDL = ^ItemDL; {type DoubleLinked list}
  ItemDL = record {item of DoubleLinked list}
    number     : integer; {number}
    name       : string; {Name}
    next, prev : ptrDL
  end;

ptrSL =^ ItemSL;
  ItemSL = record
    number     :integer;
    name       : string;
    next       : ptrSL;
  end;

var
headDL                : ptrDL; {pointer to head of Double List}
headName, headNumber  : ptrSL; {pointer to heads of single Lists sorted by Name and Number}
input, output         : text;

{Initialization and creation of double list from input text file}
procedure P1(var headDL : ptrDL; var input: text);
var
  currDL : ptrDL;
begin
  new(headDL);
  headDL^.prev := nil;
  readLn(input, headDL^.number, headDL^.name);
  currDL := headDL;

  while not eof(input) do
  begin
    new (currDL^.next);
    currDL^.next^.prev := currDL;
    currDL := currDL^.next;
    readLn(input, currDL^.number, currDL^.name);
  end;

  currDL^.next := nil;
end;


{write double list in text file}
procedure P2(headDL : ptrDL; direction: boolean; var output: text);
begin
  {If inverse writing order needed then go to the end of List}
  if not (direction) then
    while headDL^.next <> nil do
      headDL := headDL^.next;

  while (direction and (headDL <> nil)) or (not(direction) and (headDL <> nil))  do
  begin
    writeLn(output, headDL^.number, ' ', headDL^.name);

    {Move head pointer due to direction value}
    if direction then
    begin
      headDL := headDL^.next;
    end
    else begin
      headDL := headDL^.prev;
    end;
  end;

  writeLn(output);
end;


{Initialization and creation of two single Lists}
{SINGLE LIST have EMPTY HEAD}
procedure P3(headDL : ptrDL; var headName : ptrSL; var headNumber : ptrSL);
var
  currSL  : ptrSL; {Single List traversal for sorting}
  currDL  : ptrDL; {Double List traversal}
  tmpSL   : ptrSL; {Temporary pointer for creation of single List}
begin
  new(headName);
  headName^.next := nil;

  new(headNumber);
  headNumber^.next:= nil;

  currDL := headDL;

  {Double List traversal cycle for sorting by number}
  while currDL <> nil do
  begin
    currSL := headNumber; {Single List traversal cycle}

    {Search insert space for single Leist}
    while currSL <> nil do
    begin
      if (currSL^.next^.number > currDL^.number) or {If insertation space found}
         (currSL^.next = nil) then {or if end of list}
      begin
      {creation of element}
        new(tmpSL);
        tmpSL^.next := currSL^.next; {creation of connections }
        currSL^.next := tmpSL;

        tmpSL^.number := currDL^.number;
        tmpSL^.name := currDL^.name;
        break; {move to next element of Double List}
      end;

      currSL := currSL^.next;
    end;

    currDL := currDL^.next;
  end;

  currDL := headDL;

  while currDL <> nil do
  begin
    currSL := headName; {Single List traversal cycle}

    {Search insert space for single Leist}
    while currSL <> nil do
    begin
      if (currSL^.next^.name > currDL^.name) or {If insertation space found}
          (currSL^.next = nil) then {or if end of list}
      begin
      {creation of element}
        new(tmpSL);
        tmpSL^.next := currSL^.next; {creation of connections }
        currSL^.next := tmpSL;

        tmpSL^.number := currDL^.number;
        tmpSL^.name := currDL^.name;
        break; {move to next element of Double List}
      end;

      currSL := currSL^.next;
    end;

    currDL := currDL^.next;
  end;
end;


Procedure writeList(head: ptrSL; var output: text);
begin
  head:=head^.next; {skip of empty head}
  while (head <> nil) do
    begin
      writeln(output, head^.number, head^.name);
      head:=head^.next;
    end;
  writeln(output);
end;


begin
  assign(input, 'input.txt');
  reset(input);

  P1(headDL,input); {Create double List from input text file }
  close(input);

  assign(output, 'output.txt');
  rewrite(output);

  P2(headDL, true, output); {Write double List in straight order }
  P2(headDL, false, output); {Write double List in inverse order}

  P3(headDL, headName, headNumber); {Creation of two sorted Single Lists}
  writeList(headNumber, output);  {Write single list sorted by Number}
  writeList(headName, output);  {Write single list sorted by Name}


  close(output);

end.