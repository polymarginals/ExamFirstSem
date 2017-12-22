procedure p2(S:ptwin;FF:string;direct:boolean);
var
spisokFF:TEXT;
pc:ptwin;
begin
assign(spisokFF,FF);
rewrite(spisokFF);
pc:=S;
if direct then while PC^.n<>nil do pc:=pc^.n;
case direct of
   TRUE : while pc<>nil do
          begin
          writeln(spisokFF,pc^.K,#32,pc^.fam);
          pc:=pc^.p;
          end;
   FALSE: while pc<>nil do
          begin
          writeln(spisokFF,pc^.K,#32,pc^.fam);
          pc:=pc^.n;
          end;
   end;
close(spisokFF);
end;

procedure p3(var S:ptwin;var S1,S2:pone);{sort}
var
PC,PT:ptwin;
OC,OT:pone;
min:integer;
mins:string[15];
b:boolean;
begin
b:=true;
while b do {s1}
 begin
 while s<>nil do
  begin
  pc:=s;
  min:=pc^.K;
  if pc^.n=nil then
    begin
    new(ot);
    ot^.K:=pc^.K;
    ot^.fam:=pc^.fam;
    ot^.n:=nil;
    b:=false;
    oc^.n:=ot;
    dispose(pc);
    s:=nil;
    break;
    end;
  while pc^.n<> nil do
   begin
   if min>pc^.n^.K then min:=pc^.n^.K;
   pc:=pc^.n
   end;
  pc:=s;
  while (pc^.n^.k<>min)and(pc<>nil) do pc:=pc^.n;
  if pc=nil then pc:=s;
  if min=pc^.k then
    begin
    new(ot);
    ot^.K:=pc^.K;
    ot^.fam:=pc^.fam;
    ot^.n:=nil;
    if s1=nil then s1:=ot
    else if oc^.n=nil then oc^.n:=ot;
    oc:=ot;
    s:=pc^.n;
    dispose(pc);
    end
  else
    begin
    new(ot);
    ot^.K:=pc^.n^.K;
    ot^.fam:=pc^.n^.fam;
    ot^.n:=nil;
    if s1=nil then s1:=ot
    else if oc^.n=nil then oc^.n:=ot;
    oc:=ot;
    pt:=pc^.n;
    pc^.n:=pc^.n^.n;
    end;
  end;
 end;{end sort 1st}
s:=nil;
p1(S,'in.xxx');
oc:=nil;
ot:=nil;
b:=true;
while b do {s2}
 begin
 while s<>nil do
  begin
  pc:=s;
  mins:=pc^.fam;
  if pc^.n=nil then
    begin
    new(ot);
    ot^.K:=pc^.K;
    ot^.fam:=pc^.fam;
    ot^.n:=nil;
    b:=false;
    oc^.n:=ot;
    dispose(pc);
    s:=nil;
    break;
    end;
  while pc^.n<> nil do
    begin
    if minstring(pc^.n^.fam,mins) then mins:=pc^.n^.fam;
    pc:=pc^.n;
    end;
  pc:=s;
  while (pc^.n^.fam<>mins)and(pc<>nil) do pc:=pc^.n;
  if pc=nil then pc:=s;
  if mins=pc^.fam then
    begin
    new(ot);
    ot^.K:=pc^.K;
    ot^.fam:=pc^.fam;
    ot^.n:=nil;
    if s2=nil then s2:=ot
    else if oc^.n=nil then oc^.n:=ot;
    oc:=ot;
    s:=pc^.n;
    dispose(pc);
    end
  else
    begin
    new(ot);
    ot^.K:=pc^.n^.K;
    ot^.fam:=pc^.n^.fam;
    ot^.n:=nil;
    if s2=nil then s2:=ot
    else if oc^.n=nil then oc^.n:=ot;
    oc:=ot;
    pt:=pc^.n;
    pc^.n:=pc^.n^.n;
    end;
  end;
 end;{end sort 2nd}
end;

procedure p4(S:pone;GG:string);
var
FileGG:TEXT;
oc:pone;
begin
assign(FileGG,GG);
rewrite(FileGG);
oc:=S;
while oc<>nil do
  begin
  writeln(FileGG,oc^.K,#32,oc^.fam);
  oc:=oc^.n;
  end;
close(FileGG);
end;
