type
  dataRecord = record
    number  : integer;
    name    : string;
  end;

  ptrL = ^list;
  list = record
    data: dataRecord;
    next: ptrL;
  end;

  typeFile = file of dataRecord;

procedure P1(var input: text; var tFile: typeFile);
var
  data: dataRecord;
begin
  while not eof(input) do begin
    readln(input, data.number, data.name);
    write(tFile, data);
  end;
end;

procedure P2(var tFile: typeFile; var head: ptrL);
var
  currPtr, tmpPtr: ptrL;
begin
  new(head);
  head^.next:=nil;
  currPtr:=head;

  while not eof(tFile) do begin
    new(tmpPtr);
    read(tFile,tmpPtr^.data);
    currPtr:=head;
    while (currPtr^.next <> nil) and (tmpPtr^.data.name > currPtr^.next^.data.name) do
      currPtr:=currPtr^.next;
    tmpPtr^.next:=CurrPtr^.next;
    CurrPtr^.next:=tmpPtr;
  end;



   {while (currPtr^.next <> nil) and (tmpPtr^.data.name < currPtr^.next^.data.name) do
      currPtr:=currPtr^.next;
    tmpPtr^.next:=currPtr^.next;
    currPtr^.next:=tmpPtr;
  end;
  }




end;

procedure P4(head1, head2: ptrL; var headRes: ptrL);
var
  currPtr1, currPtr2,tmpPtr: ptrL;
begin
  currPtr1:=head1^.next;
  currPtr2:=head2^.next;
  new(headRes);
  tmpPtr:=headRes;
  new(tmpPtr^.next);
  tmpPtr:=tmpPtr^.next;
  tmpPtr^.next:=nil;
  if currPtr1^.data.name < currPtr2^.data.name then
    begin
      tmpPtr^.data:=currPtr1^.data;
      currPtr1:=currPtr1^.next;
    end
  else
    begin
      tmpPtr^.data:=currPtr2^.data;
      currPtr2:=currPtr2^.next;
    end;
  while (currPtr1 <> nil) or (currPtr2 <> nil) do
    begin
      new(tmpPtr^.next);
      tmpPtr:=tmpPtr^.next;
          if ((currPtr1^.data.name < currPtr2^.data.name) or (currPtr2 = nil)) and (currPtr1 <> nil) then
            begin
              tmpPtr^.data.name:=currPtr1^.data.name;
              tmpPtr^.data.number:=currPtr1^.data.number;
              currPtr1:=currPtr1^.next;
            end
          else
            begin
              tmpPtr^.data.name:=currPtr2^.data.name;
              tmpPtr^.data.number:=currPtr2^.data.number;
              currPtr2:=currPtr2^.next;
            end;
    end;
  tmpPtr^.next:=nil;
end;

procedure P5(var output: text; head: ptrL);
begin
  head:=head^.next;
  while head <> nil do
    begin
      writeln(output, head^.data.number,head^.data.name);
      head:=head^.next;
    end;
  writeln(output);
end;

var
  head1,head2,headRes     : ptrL;
  input1, input2,output   : text;
  tFile1, tFile2          : typeFile;
begin
  assign(input1, 'input1.txt');
  reset(input1);

  assign(input2, 'input2.txt');
  reset(input2);

  assign(tFile1, 'typeFile1.txt');
  rewrite(tFile1);

  assign(tFile2, 'typeFile2.txt');
  rewrite(tFile2);

  assign(output, 'output.txt');
  rewrite(output);

  P1(input1,tFile1);
  reset(tFile1);
  P2(tFile1, head1);
  P5(output, head1);

  close(input1);
  close(tFile1);

  P1(input2,tFile2);
  reset(tFile2);
  P2(tFile2,head2);
  P5(output,head2);

  close(input2);
  close(tFile2);

  P4(head1,head2, headRes);
  P5(output,headRes);

  close(output);
end.





