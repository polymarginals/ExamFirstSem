program ex11;
uses crt;

type
    a = ^dan;
    dan = record
     age: integer;
     num: integer;
     lt,rt:a;
     check:boolean;
     end;

procedure create(var head: a; var co: integer); {��������}
label 1;
var
f: text;
str: string;
i,vozr: integer;
uksp: a;
buf: a;
begin
assign(f,'vhod.inp');
reset(f);
readln(f,str);
i:=1;
while str[i]<>' ' do      {���⠫� ��ப�}
i:=i+1;
vozr:=0;                  {���� �� ���}
i:=i+1;
while i<=length(str) do begin
vozr:=vozr*10+ord(str[i])-48;   {��⠥� ������}
i:=i+1;
end;
new(uksp);              {������� ������}
uksp^.age:=vozr;        {� ��� ������ � �᫮ 1(���㤭�� ����)}
uksp^.num:=1;
uksp^.rt:=nil; uksp^.lt:=nil;
head:=uksp;             {���������� ������}
co:=1;                  {�� ���稪 ������⮢ � ��ॢ�}

while not eof(f) do begin
readln(f,str);
i:=1;                   {�⥭�� ������ ��� ������� ������ �������}
while str[i]<>' ' do
i:=i+1;
vozr:=0;
i:=i+1;
while i<=length(str) do begin
vozr:=vozr*10+ord(str[i])-48;
i:=i+1;
end;
uksp:=head;           {���� ���� ���� � ������}

1: if uksp^.age = vozr then begin   {�᫨ � 㧫� 㦥 ���� ������}
   inc(uksp^.num); continue;        {� 㢥����� ��� ���㤭����}
   end;
   if vozr < uksp^.age then begin   {�᫨ ���� ������ ����� 㧫�����}
      if uksp^.lt = nil then begin  {�᫨ ����� �� ���, � ᮧ����}
         new(uksp^.lt);
         uksp:=uksp^.lt;
         uksp^.age:=vozr; uksp^.num:=1; {� ���� �����⮬ � �᫮� 1}
         uksp^.lt:=nil; uksp^.rt:=nil;
         inc(co);                   {������. �᫮ ������⮢ ��ॢ�}
      end
      else begin               {�᫨ ���� ���� ��⮬��, � ���� �� ����}
           uksp:=uksp^.lt;     {� �� ��⪥ ᭮�� �ࠢ������}
           goto 1;
      end;
   end
   else begin
      if uksp^.rt = nil then begin    {�������筮 ��� ����, �᫨ ����}
         new(uksp^.rt);               {������ ����� 㧫�}
         uksp:=uksp^.rt;
         uksp^.age:=vozr; uksp^.num:=1;
         uksp^.lt:=nil; uksp^.rt:=nil;
         inc(co);
      end
      else begin
           uksp:=uksp^.rt;
           goto 1;
      end;
   end;
end;
close(f);
end;

procedure gettree(var head: a);   {�����ᨢ��� ��楤�� ���� ���� check}
begin                             {��᫥ ��室� ���樥�}
if head^.lt<>nil then
gettree(head^.lt);
head^.check:=false;
if head^.rt<>nil then
gettree(head^.rt);
end;

procedure obhod(head: a; co: integer);  {���⨢�� ��室}
label 2;
var
uksp: a;                      {uksp - ����騩, high - ���孨� � ����}
high: a;
i: integer;
f: text;
begin
i:=0;
assign(f,'rez.out');
rewrite(f);
gettree(head);
while i<co do begin        {����, ���� ���稪 �� ࠢ�� ��� ������⮢}
      uksp:=head;
      high:=head;
2:    while (uksp^.lt<>nil) do   {����� �� ����� ��஭�}
      if (uksp^.lt^.check <> true) then begin {�᫨ ᫥�. ���� �� ��}
            high:=uksp;                                 {�뢥��}
            uksp:=uksp^.lt;
      end else break;          {�᫨ ᫥�. �뢥��, � ����� �஡���}
      if uksp^.check<>true then begin    {�᫨ ������ �� �� �뢮������}
      writeln(f,'������: ',uksp^.age,' ��᫮: ',uksp^.num);
      uksp^.check:=true;              {� �뢥�� � ���⠢��� 祪 + ���稪}
      i:=i+1;
      end;
      if (uksp^.rt<>nil) then begin  {�᫨ � 㧫� ���� �ࠢ� ��⮬��, �}
         high:=uksp;
         uksp:=uksp^.rt;             {��३� � ���� � ��⮬ �� ��⪥ ᭮��}
         goto 2;
         end;
end;        {��᫥ ��� �뢮��� ���� 祪�}
close(f);
end;

procedure count(var head: a; var co,b1: integer);  {������ ���㤭����}
begin
if head^.lt<> nil then
count(head^.lt,co,b1);
if head^.age < b1 then
co:=co+head^.num;
if head^.rt<> nil then
count(head^.rt,co,b1);
end;


var
uktree: a;
count1: integer;
c,b: integer;
f1: text;

begin
clrscr;
create(uktree,count1);
writeln('������⮢: ',count1);
obhod(uktree,count1);
write('������ ������: ');
readln(b);
c:=0;
count(uktree,c,b);
assign(f1,'ex11.out');
append(f1);
writeln(f1);
writeln(f1,'����㤭���� ����� ��������� ������: ',c);
close(f1);
writeln('�믮����� �ᯥ譮');
readkey;
end.
