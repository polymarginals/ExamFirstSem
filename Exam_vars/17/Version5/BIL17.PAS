program bilet17;

type
p=^zap;

zap=record
    f:string;
    sled,pred:p;
    end;

procedure p1(var uk1:p; var file1:text);
var uk,uk2:p;
begin

  new(uk1);
  uk:=uk1;
  uk2:=uk1;
  readln(file1,uk^.f);
  uk^.sled:=nil;
  uk^.pred:=nil;

while not eof(file1) do
  begin
    new(uk^.sled);
    uk:=uk^.sled;
    readln(file1,uk^.f);
    uk^.sled:=nil;
    uk^.pred:=uk2;
    uk2:=uk;
  end;
end;

procedure p4(var uk1,uk2:p);
var walk1,walk11,walk2,uk:p;
begin
walk2:=uk2;
repeat
walk1:=uk1;
walk11:=uk1^.sled;

new(uk);
uk^.sled:=nil;
uk^.pred:=nil;
uk^.f:=walk2^.f;

if (walk1^.pred=nil)
   and
   (length(walk1^.f)>=length(uk^.f)) then
  begin
   uk^.sled:=walk1;
   walk1^.pred:=uk;
   uk1:=uk;
  end
                                          else
begin
  while walk11<>nil do
    begin
      if (walk11^.sled=nil)
         and
         (length(walk11^.f)<=length(uk^.f)) then
        begin
         walk11^.sled:=uk;
         uk^.pred:=walk11;
         break;
        end
                                                  else
        begin
         if (length(walk1^.f)<=length(uk^.f))
             and
            (length(walk11^.f)>=length(uk^.f)) then
           begin
            walk1^.sled:=uk;
            uk^.sled:=walk11;
            uk^.pred:=walk1;
            walk11^.pred:=uk;
            break;
           end;
        end;
     walk1:=walk1^.sled;
     walk11:=walk11^.sled;
    end;
end;

walk2:=walk2^.sled;
until walk2=nil;
end;


procedure p5(uk1:p; var file2:text);
begin
while (uk1<>nil) do
    begin
     writeln(file2,uk1^.f);
     uk1:=uk1^.sled;
    end;
end;



var ukaz1,ukaz2:p;
    f1,f2,f3:text;

begin
assign(f1,'A.inp');
assign(f2,'B.inp');
reset(f1); reset(f2);
assign(f3,'C.out');
rewrite(f3);

p1(ukaz1,f1);
p1(ukaz2,f2);
p4(ukaz1,ukaz2);
p5(ukaz1,f3);

close(f1);
close(f2);
close(f3);
end.