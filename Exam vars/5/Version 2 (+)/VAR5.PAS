program var5;

type
    DoubleLinkedList        = ^TDoubleLinkedListItem;
    TDoubleLinkedListItem   = record
        Number      : Integer         ;
        Name        : String          ;
        Next        : DoubleLinkedList;
        Prev        : DoubleLinkedList; { pointer to previous list element }
    end;

    SingleLinkedList        = ^TSingleLinkedListItem;
    TSingleLinkedListItem   = record
        Number      : Integer         ;
        Name        : String          ;
        Next        : SingleLinkedList;
    end;

{Initialization and creation of double list from input text file}
procedure P1(var headDL: DoubleLinkedList; var input: Text);
var
  currDL : DoubleLinkedList;

begin
    New(headDL);
    headDL^.Prev  := nil;
    readLn(input, headDL^.Number, headDL^.Name);
    currDL        := headDL;

    while not eof(input) do
    begin
        New (currDL^.Next);
        currDL^.Next^.Prev := currDL;
        currDL := currDL^.Next;
        ReadLn(input, currDL^.Number, currDL^.Name);
    end;

    currDL^.Next := nil;
end;


{ write double linked list in text file }
procedure P2(headDL: DoubleLinkedList; direction: Boolean; var output: Text);
begin
  { if inverse writing order is needed then go to the end of the List }
    if not (direction) then
        while headDL^.Next <> nil do
            headDL := headDL^.Next;

    while (direction and (headDL <> nil)) or (not(direction) and (headDL <> nil))  do
    begin
        writeLn(output, headDL^.Number, ' ', headDL^.Name);

        { Move head pointer due to direction value }
        if direction then
        begin
            headDL := headDL^.Next;
        end
        else begin
            headDL := headDL^.Prev;
        end;
    end;

    WriteLn(output);
end;


{Initialization and creation of two single Lists}
{SINGLE LIST have EMPTY HEAD}
procedure P3(headDL: DoubleLinkedList; var headName: SingleLinkedList; var headNumber: SingleLinkedList);
var
  currSL : SingleLinkedList; { Single List traversal for sorting }
  currDL : DoubleLinkedList; { Double List traversal }
  tmpSL  : SingleLinkedList; { Temporary pointer for creation of single List }

begin
    new(headName);
    headName^.Next := nil;

    new(headNumber);
    headNumber^.Next:= nil;

    currDL := headDL;

    {Double List traversal cycle for sorting by Number}
    while currDL <> nil do
    begin
        currSL := headNumber; {Single List traversal cycle}

        {Search insert space for single Leist}
        while currSL <> nil do
        begin
            if  (currSL^.Next^.Number > currDL^.Number) OR {If insertation space found}
                (currSL^.Next = nil) then {or if end of list}
            begin
                {creation of element}
                new(tmpSL);
                tmpSL^.Next := currSL^.Next; {creation of connections }
                currSL^.Next := tmpSL;

                tmpSL^.Number := currDL^.Number;
                tmpSL^.Name := currDL^.Name;
                break; {move to Next element of Double List}
            end;

            currSL := currSL^.Next;
        end;

        currDL := currDL^.Next;
    end;

    currDL := headDL;

    while currDL <> nil do
    begin
        currSL := headName; {Single List traversal cycle}

        {Search insert space for single Leist}
        while currSL <> nil do
        begin
            if  (currSL^.Next^.Name > currDL^.Name) OR {If insertation space found}
                (currSL^.Next = nil) then {or if end of list}
            begin
                {creation of element}
                new(tmpSL);
                tmpSL^.Next := currSL^.Next; {creation of connections }
                currSL^.Next := tmpSL;

                tmpSL^.Number := currDL^.Number;
                tmpSL^.Name := currDL^.Name;
                break; {move to Next element of Double List}
            end;
            currSL := currSL^.Next;
        end;
        currDL := currDL^.Next;
    end;
end;


procedure writeListInFile(head: SingleLinkedList; var output: Text);
begin
    head := head^.Next; {skip of empty head}

    while (head <> nil) do
    begin
        writeln(output, head^.Number, head^.Name);
        head := head^.Next;
    end;

    writeln(output);
end;

var
    headDList  : DoubleLinkedList; { pointer to head of Double List }
    headName   : SingleLinkedList; { pointer to heads of single Lists sorted by Name and Number}
    headNumber : SingleLinkedList;
    input      : Text            ;
    output     : Text            ;

begin
  assign(input, 'input.txt');
  reset(input);

  P1(headDL,input);             {Create double List from input text file }
  close(input);

  assign(output, 'output.txt');
  rewrite(output);

  P2(headDL, true, output);     {Write double List in straight order }
  P2(headDL, false, output);    {Write double List in inverse order}

  P3(headDL, headName, headNumber); {Creation of two sorted Single Lists}
  WriteList(headNumber, output);    {Write single list sorted by Number}
  WriteList(headName,   output);    {Write single list sorted by Name}


  close(output);

end.