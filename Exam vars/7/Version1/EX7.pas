program p10;
type
 ptree=^uk;
 uk=record
 fam:string[10];
 nom:integer;
 lf,rt:ptree
 end;

 zap1=record
 fam:string[10];
 nom:integer
 end;

var uksp:ptree; f1,f3:text;

procedure p1(var uksp:ptree; var H:text);
var zap:zap1; ukzv,ukzv2:ptree;
begin
 while not eof(H) do
 begin
  if uksp=nil then
  begin
   new(ukzv);
   uksp:=ukzv;
   ukzv^.rt:=nil;
   ukzv^.lf:=nil;
   readln(H,zap.fam,zap.nom);
   ukzv^.fam:=zap.fam;
   ukzv^.nom:=zap.nom;
  end
             else
   begin
    ukzv:=uksp;
    readln(H,zap.fam,zap.nom);
    while ukzv<>nil do
    begin
    ukzv2:=ukzv;
     if ukzv^.nom>zap.nom then ukzv:=ukzv^.lf
                          else ukzv:=ukzv^.rt;
    end;
    new(ukzv);
    ukzv^.fam:=zap.fam;
    ukzv^.nom:=zap.nom;
    ukzv^.rt:=nil;
    ukzv^.lf:=nil;
    if ukzv2^.nom>ukzv^.nom then ukzv2^.lf:=ukzv
                            else ukzv2^.rt:=ukzv;
    end;
   end;
  end;

  procedure p2(var uksp:ptree; var G:text);
  begin
  if uksp^.lf<>nil then p2(uksp^.lf,G);
  if uksp<>nil then writeln(G,uksp^.fam,uksp^.nom);
  if uksp^.rt<>nil then p2(uksp^.rt,G);
  end;

  procedure p3(var uksp:ptree; var G:text);
  begin
  if uksp^.lf<>nil then p3(uksp^.lf,G);
  if (uksp^.lf=nil) and (uksp^.rt=nil) then writeln(G,uksp^.fam,uksp^.nom);
  if uksp^.rt<>nil then p3(uksp^.rt,G);
  end;

 begin
 assign(f1,'dan7.inp');
 reset(f1);
 assign(f3,'res7.out');
 rewrite(f3);
 uksp:=nil;
 p1(uksp,f1);
 writeln(f3);
 p2(uksp,f3);
 writeln(f3);
 p3(uksp,f3);
 close(f1);
 close(f3);
 end.