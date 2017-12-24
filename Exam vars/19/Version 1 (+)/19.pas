program ex19;
uses crt;

type
    a = ^dan;
      dan = record
      num: integer;
      author: string;
      name: string;
      year: string;
      cost: string;
      sled: a;
      pred: a;
      end;

procedure form(var head,ass: a);
var
ukzv,this: a;
f: text;
before: a;
i,j: integer;
str: string;
begin
assign(f,'vhod.txt');
reset(f);
{}
new(ukzv);
ukzv^.pred:=nil;
head:=ukzv;
before:=ukzv;
new(ukzv^.sled);
ukzv:=ukzv^.sled;
ukzv^.sled:=nil;
{}
while not eof(f) do begin
readln(f,str); {}
new(this);
i:=1;
this^.num:=0;
while str[i] <> ' ' do begin {}
this^.num:=this^.num*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1; {}
j:=i;
while str[j]<>' ' do {}
j:=j+1;
this^.author:=copy(str,i,j-i); {}
i:=j+1; {}
j:=i;
while str[j]<>' ' do
j:=j+1;
this^.name:=copy(str,i,j-i); {}
i:=j+1; {}
j:=i;
while str[j]<>' ' do
j:=j+1;
this^.year:=copy(str,i,j-i); {}
i:=j+1;
this^.cost:=copy(str,i,length(str)-i+1);

ukzv:=head;
while (ukzv^.sled^.sled<>nil) and (ukzv^.sled^.num < this^.num) do
ukzv:=ukzv^.sled;

this^.sled:=ukzv^.sled;
ukzv^.sled:=this;
end;

ukzv:=head^.sled;
before:=head;
while ukzv<>nil do begin
ukzv^.pred:=before;
before:=ukzv;
ukzv:=ukzv^.sled;
end;
ass:=before;
close(f);
end;

procedure newelem(var head:a);
var
mem,ukzv: a;
i,j: integer;
str: string;
begin
writeln('Number Avtor Name Year Cost');
readln(str);

new(mem);
i:=1;
mem^.num:=0;
while str[i] <> ' ' do begin
mem^.num:=mem^.num*10+ord(str[i])-48;
i:=i+1;
end;
i:=i+1;
j:=i;
while str[j]<>' ' do
j:=j+1;
mem^.author:=copy(str,i,j-i);
i:=j+1;
j:=i;
while str[j]<>' ' do
j:=j+1;
mem^.name:=copy(str,i,j-i);
i:=j+1;
j:=i;
while str[j]<>' ' do
j:=j+1;
mem^.year:=copy(str,i,j-i);
i:=j+1;
mem^.cost:=copy(str,i,length(str)-i+1);

ukzv:=head;
while (ukzv^.sled^.sled<>nil) and (ukzv^.sled^.num < mem^.num) do
ukzv:=ukzv^.sled;

mem^.sled:=ukzv^.sled;
mem^.pred:=ukzv;
ukzv^.sled:=mem;
ukzv:=mem^.sled;
ukzv^.pred:=mem;
end;

procedure poisk(head,ass: a);
var
ukzv:a;
i: integer;
avtor,nazv: string;
f: text;
begin
assign(f,'out.txt');
append(f);
writeln('Search by Nazv and Avtor');
write('Nazv: ');
readln(nazv);
write('Avtor: ');
readln(avtor);
i:=1;
if avtor[1] <= 'K' then begin
ukzv:=head^.sled;
while ukzv^.sled <> nil do begin

if (ukzv^.author = avtor) and (ukzv^.name = nazv) then begin
write(f,'Number ',i,' ');
write(f,'Name - ',ukzv^.name,' ');
write(f,'Cost  - ',ukzv^.cost,' ');
writeln(f,'Year - ',ukzv^.year);
i:=0;
break; end;
i:=i+1;
ukzv:=ukzv^.sled;
end;

if i<>0 then writeln(f,'Net Takogo?');
end;

if avtor[1] > 'K' then begin
ukzv:=ass^.pred;
while ukzv^.pred <> nil do begin
if (ukzv^.author = avtor) and (ukzv^.name = nazv) then begin
write(f,'Number ',i,' ');
write(f,'Name - ',ukzv^.name,' ');
write(f,'Cost  - ',ukzv^.cost,' ');
writeln(f,'Year - ',ukzv^.year);
i:=0;
break; end;
i:=i+1;
ukzv:=ukzv^.pred;
end;
if i<>0 then writeln(f,'Net Takogo?');
end;
writeln('Done');
writeln(f,' ');
close(f);
end;

procedure vivod(head,ass: a);
label 1;
var
ukzv: a;
co: string;
f: text;
begin
assign(f,'out.txt');
append(f);
writeln(f,'Data:');
writeln('right or left?');
readln(co);
while (co <> 'right') and (co <> 'left') do begin
writeln('Error');
writeln('right or left?');
readln(co);
end;

if co = 'right' then begin
ukzv:=head^.sled;
while ukzv^.sled <> nil do begin
write(f,ukzv^.num,' ');
write(f,ukzv^.author,' ',ukzv^.name,' ');
writeln(f,ukzv^.year,' ',ukzv^.cost);
ukzv:=ukzv^.sled;
end;
writeln('Done');
end;

if co = 'left' then begin
ukzv:=ass^.pred;
while ukzv^.pred <> nil do begin
write(f,ukzv^.num,' ');
write(f,ukzv^.author,' ',ukzv^.name,' ');
writeln(f,ukzv^.year,' ',ukzv^.cost);
ukzv:=ukzv^.pred;
end;
writeln('Done');
end;
writeln(f);
close(f);
end;

var
ukstr,last: a;
uksp: a;
i: integer;
f1: text;

begin
clrscr;
assign(f1,'out.txt');
rewrite(f1);
close(f1);
form(ukstr,last);
writeln('Vivod:');
vivod(ukstr,last);
newelem(ukstr);
vivod(ukstr,last);
poisk(ukstr,last);
vivod(ukstr,last);
readkey;
end.