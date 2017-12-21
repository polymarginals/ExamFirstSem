program ex3;
uses CRT;
Type
    point=^data;
    data=record
    somedata:string;
    next:point;
    nextS:point;
end;

var A,Asort:point;
    inp,out: text;

procedure P1(var A,Asort:point;var inp,out:text);
var s:string;
    i,j:integer;
    search,head,headS,temph,templ: point;
begin
new(A);
readln(inp,s);
if (s<>'') then begin
A^.somedata:=s;
A^.next:=nil;
A^.nextS:=nil;
readln(inp,s);
head:=A;
headS:=A;
search:=headS;
while (s<>'') do
      begin
      new(A^.next);
      A:=A^.next;
      A^.somedata:=s;
      A^.next:=nil;
      A^.nextS:=nil;
      templ:=headS;
      search:=headS;
      while(search<>nil) do
        begin
        if length(s) < length(search^.somedata) then
          begin
            if search=headS then
              begin
                headS:=A;
                A^.nextS:=search;
                break;
              end;
           templ^.nextS:=A;
           temph:=search;
           A^.nextS:=temph;
           break;
          end;
        templ:=search;
        search:=search^.nextS;
        end;
      readln(inp,s);
      end;
templ^.nextS:=A;
A^.next:=nil;
A:=head;
Asort:=headS;
close(inp);
while A<>nil do begin
    writeln(out,A^.somedata);
    A:=A^.next;
    end;
A:=head;
end;
end;

procedure P2(var headA,headS:point;var out:text);
var A,Asort:point;
    ch:integer;
begin
writeln(out,'-----------------------------');
A:=headA;
Asort:=headS;
write('Write in file sort list or not?(1/0): ');
readln(ch);
case ch of
     1 : while Asort<>nil do begin
    writeln(out,Asort^.somedata);
    Asort:=Asort^.nextS;
    end;
     0 : while A<>nil do begin
    writeln(out,A^.somedata);
    A:=A^.next;
    end;
end;
end;

procedure P3(var head:point);
var A,h:point;
begin
A:=head;
while A<>nil do begin
      h:=A;
      A:=A^.next;
      Dispose(h);
      end;
end;

BEGIN
ClrScr;
assign(inp,'input0.txt');
reset(inp);
assign(out,'output.txt');
rewrite(out);
P1(A,Asort,inp,out);
P2(A,Asort,out);
close(out);
P3(A);
END.
