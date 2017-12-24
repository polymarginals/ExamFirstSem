program bilet08;
uses crt;

type
    a = ^stack;
    stack = record
      fam: string;
      pred: a;
      check: boolean;
    end;

procedure makestack(var last: a);
var
f: text;
uk: a;
begin
assign(f,'ex8sort.inp');
reset(f);
new(uk);
uk^.pred:=nil;
readln(f,uk^.fam);
last:=uk;
uk^.check:=true;
while not eof(f) do begin
new(uk);
uk^.pred:=last;
readln(f,uk^.fam);
last:=uk;
end;
close(f);
end;

procedure vivod(var head1: a;var f: text);
label 1;
var
uk: a;
begin
uk:=head1;
1: while uk^.pred^.check<> true do
uk:=uk^.pred;
if uk<>head1 then begin
   writeln(f,uk^.pred^.fam);
   uk^.check:=true;
   uk:=head1;
goto 1;
end
else begin
   writeln(f,uk^.pred^.fam);
   uk^.check:=true;
   writeln(f,uk^.fam);
end;
uk:=head1;
while uk^.pred<>nil do begin
uk^.check:=false;
uk:=uk^.pred; end;
end;

procedure adding(var last: a);
var
f: text;
uk,obmen,temp: a;
begin
assign(f,'ex8.inp');
reset(f);
new(obmen);
while not eof(f) do begin
new(temp);
readln(f,temp^.fam);
uk:=last;
if uk^.fam < temp^.fam then begin
   obmen^.fam:=temp^.fam;
   temp^.fam:=uk^.fam;
   uk^.fam:=obmen^.fam;
   temp^.pred:=uk^.pred;
   uk^.pred:=temp^.pred;
end;
if uk^.fam >= temp^.fam then begin
   while (uk^.pred^.fam > temp^.fam) do begin
   if uk^.pred=nil then break;
   uk:=uk^.pred; end;
   if uk^.pred=nil then begin
   new(uk^.pred);
   uk^.check:=false;
   uk:=uk^.pred;
   uk^.fam:=temp^.fam;
   uk^.check:=true;
   dispose(temp);
   end else begin
   temp^.pred:=uk^.pred;
   uk^.pred:=temp;
   end;
end;
end;
close(f);
end;

var
head: a;
f1: text;

begin
clrscr;
makestack(head);
assign(f1,'ex8.out');
rewrite(f1);
writeln(f1,'Before the insertion');
vivod(head,f1);
adding(head);
writeln(f1,'After the insertion');
vivod(head,f1);
writeln('Done');
close(f1);
readkey;
end.