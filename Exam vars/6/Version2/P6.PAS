program pp;
type
TName = string[10];
TFile = text;
NList =^ PList;
PList = record
      Count:integer;
      Name:TName;
      Next:NList;
      end;

procedure AddToList(var UkFirst:NList; Count:integer; Name:TName);
var
   UkRun:NList;
begin
    if(UkFirst = nil) then
               begin
                   new(UkFirst);
                   UkFirst^.Count := Count;
                   UkFirst^.Name := Name;
                   UkFirst^.Next := nil;
               end
    else
        begin
                   UkRun := UkFirst;
                   while UkRun^.Next <> nil do
                         UkRun := UkRun^.Next;

                   new(UkRun^.Next);
                   UkRun^.Next^.Count := Count;
                   UkRun^.Next^.Name := Name;
                   UkRun^.Next^.Next := nil;
                   UkRun := UkRun^.Next;
        end
end;

procedure P1 (var List:NList; var f:text);
var
Count:integer;
Name:TName;
begin
        while NOT eof(f) do
        begin
             readln(f, Name, Count);
             AddToList(List, Count, Name);
        end
end;

procedure P2 (var List:NList; CheckCountOnNull:boolean);
var
    UkRun:NList;
begin
    UkRun := List;
    while UkRun <> nil do
    begin
        if NOT CheckCountOnNull then
           writeln(UkRun^.Name, UkRun^.Count)
        else
           if UkRun^.Count <> 0 then
              writeln(UkRun^.Name, UkRun^.Count);

        UkRun := UkRun^.Next;
    end;
end;
procedure P3(var List1:NList; var List2:NList); {List1 - zaayavki, List2 - sklad}
var
   UkRun1,UkRun2:NList;
begin
     UkRun1 := List1;
     while UkRun1 <> nil do
     begin
           UkRun2 := List2;
          while UkRun2 <> nil do
          begin
              if(UkRun1^.Name = UkRun2^.Name) then
              begin
                  if(UkRun2^.Count >= UkRun1^.Count) then
                  begin
                        UkRun2^.Count := UkRun2^.Count - UkRun1^.Count;
                        UkRun1^.Count := 0; {Need Delete this item}
                  end
                  else
                  begin
                       UkRun1^.Count := UkRun1^.Count - UkRun2^.Count;
                       UkRun2^.Count := 0;
                  end

              end;

              UkRun2 := UkRun2^.Next;
          end;
          UkRun1 := UkRun1^.Next;
     end;
end;

var
List1, List2:NList; {zav, base}
f1,f2:TFile         ;
begin
     assign(f1, 'zav.txt');
     assign(f2, 'base.txt');
     reset(f1);
     reset(f2);
     assign(output, 'output.txt');
     rewrite(output);
     List1 := nil;
     List2 := nil;
     P1(List1, f1);
     P1(List2, f2);
     writeln('List zav');
     P2(List1, false);
     writeln;
     writeln('List base');
     P2(List2, false);

     P3(List1,List2);
     writeln('RESULT:');
     writeln('List zav');
     P2(List1, true);
     writeln;
     writeln('List base');
     P2(List2, false);

end.