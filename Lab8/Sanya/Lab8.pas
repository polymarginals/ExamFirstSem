program lab3;

const
    FILE1   = 'f1.txt';
    FILE2   = 'f2.dat';
    FILE3   = 'f3.txt';
    LOGFILE = 'log.out';

type
  PtrPerson = ^TPerson;
  TPerson   = record
      Surname   : array[1..10] of char;
      BirthYear : integer;
      Next      : PtrPerson;
  end;

  db = file of TPerson;

  TQueue = Object
  private
      Front  : PtrPerson;
      Mirror : PtrPerson;
  public
      Size   : integer;
      constructor Initialize;
      procedure   Enqueue(    P   : TPerson);
      procedure   Dequeue(var P   : PtrPerson);
      procedure   Print  (var out : Text);
      procedure   Clean;
  end;

  constructor TQueue.Initialize;
  begin
      Front  := nil;
      Mirror := nil;
      Size   := 0;
  end;

  procedure TQueue.Enqueue(P : TPerson);
  var
      PtrNew, PtrCurrent : PtrPerson;

  begin
      new(PtrNew);
      PtrNew^.Surname   := P.Surname;
      PtrNew^.BirthYear := P.BirthYear;
      PtrNew^.Next      := nil;
      if (Front = nil) then
      begin
          Front  := PtrNew;
          Mirror := Front;
      end
      else
      begin
          PtrCurrent  := Front;
          while Front^.Next <> nil do
          begin
             Front := Front^.Next;
          end;
          Front^.Next := PtrNew;
          Front       := PtrCurrent;
      end;
      inc(Size);
  end;

  procedure TQueue.Dequeue(var P : PtrPerson);
  begin
      P := Front;
      if Front <> nil then
          Front := Front^.Next;
  end;

  procedure TQueue.Clean;
  var
      tmpPtr : PtrPerson;

  begin
      while (Mirror <> nil) do
      begin
          tmpPtr := Mirror^.Next;
          Release(Mirror);
          Mirror := tmpPtr;
          dec(Size);
      end;
  end;

  procedure TQueue.Print(var out : Text);
  var
     tmpQ   : TQueue;
     tmpPtr : PtrPerson;
     Person : TPerson;
     i, j   : integer;

  begin
      if (Size = 0) then
      begin
          writeln(out, 'Queue is empty!');
      end
      else
      begin
          tmpQ.Initialize;
          tmpQ.Front := Mirror;
          tmpQ.Size  := Size;
          while (tmpQ.Front <> nil) do
          begin
              tmpQ.Dequeue(tmpPtr);
              Person.Surname   := tmpPtr^.Surname;
              Person.BirthYear := tmpPtr^.BirthYear;
              for j := 1 to 10 do
                  write(out, Person.Surname[j]);
              writeln(out, ' ', Person.BirthYear);
          end;
          writeln(out, '===============');
      end;
  end;

function pow(base: integer; power: integer) : integer;
var
  result : integer;
  i      : integer;

begin
  result := 1;
  for i  := 1 to power do
    result := result * base;
  pow    := result;
end;

procedure P1(var Q : TQueue; var src : Text);
var
  tmpString : String[15];
  tmpPerson : TPerson;
  i         : integer;

begin
  while not eof(src) do
  begin
      readln(src, tmpString);
      tmpPerson.BirthYear      := 0;
      for i := 1 to 10 do
          tmpPerson.Surname[i] := tmpString[i];
      for i := 1 to 4 do
          tmpPerson.BirthYear  := tmpPerson.BirthYear + (ord(tmpString[10 + i]) - 48) * pow(10, 4 - i);
      Q.Enqueue(tmpPerson);
  end;
end;

procedure P2(var Q : TQueue; var out : db);
var
  tmpPtr : PtrPerson;
  Person : TPerson;
  i      : integer;

begin
  for i := 1 to Q.size do
  begin
    Q.Dequeue(tmpPtr);
    Person.Surname   := tmpPtr^.Surname;
    Person.BirthYear := tmpPtr^.BirthYear;
    write(out, Person);
  end;
end;

procedure P3(var src : db; var out : Text);
var
  Queue  : TQueue;
  tmpPtr : PtrPerson;
  Person : TPerson;
  i, j   : integer;

begin
  Queue.Initialize;
  while not eof(src) do
  begin
    read(src, Person);
    Queue.Enqueue(Person);
  end;

  for i := 1 to Queue.size do
  begin
    Queue.Dequeue(tmpPtr);
    Person.Surname   := tmpPtr^.Surname;
    Person.BirthYear := tmpPtr^.BirthYear;
    for j := 1 to 10 do
      write(out, Person.Surname[j]);
    write(out, ' ');
    writeln(out, Person.BirthYear);
  end;
end;

var
    Q           : TQueue;
    f1, f3, log : Text;
    f2          : db;

begin
    assign(f1,  FILE1  );
    assign(f2,  FILE2  );
    assign(f3,  FILE3  );
    assign(log, LOGFILE);

    Q.Initialize;

    reset(f1);
    P1(q, f1);
    close(f1);

    rewrite(f2);
    P2(q, f2);
    close(f2);

    reset(f2);
    rewrite(f3);
    P3(f2, f3);
    close(f2);
    close(f3);

    rewrite(log);
    q.Print(log);
    q.Clean;
    q.Print(log);
    close(log);
end.
