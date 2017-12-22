program p;
type
 ptree=^tree;
 tree=record
 fam:integer;
 lf,rt:ptree
 end;

 next=^uk;
 uk=record
 ad:ptree;
 sled:next
 end;
var uksp,uksp1:ptree;c:integer;

procedure formir(var uksp:ptree);
var ukzv,ukzv2:ptree; c:integer;
begin
 new(ukzv);
 uksp:=ukzv;
 ukzv^.lf:=nil;
 ukzv^.rt:=nil;
 readln(ukzv^.fam);
  while not eof do
   begin
   readln(c);
   ukzv:=uksp;
   while ukzv<>nil do
   begin
   ukzv2:=ukzv;
   if ukzv^.fam>c then ukzv:=ukzv^.lf
                  else ukzv:=ukzv^.rt;
   end;


  new(ukzv);
  ukzv^.fam:=c;
  ukzv^.lf:=nil;
  ukzv^.rt:=nil;
  if ukzv2^.fam>c then ukzv2^.lf:=ukzv
                  else ukzv2^.rt:=ukzv;
        end;
end;

procedure formir2(var uksp:ptree;c:integer);
var ukzv:ptree;
begin
 if uksp=nil then
 begin
 new(ukzv);
 ukzv^.fam:=c;
 ukzv^.rt:=nil;
 ukzv^.lf:=nil;
 uksp:=ukzv;

 end
             else
             begin
             if uksp^.fam>c then formir2(uksp^.lf,c)
                            else formir2(uksp^.rt,c);
 end;
 end;

procedure vivod(var uksp:ptree);
begin
if uksp^.lf<>nil then vivod(uksp^.lf);
if uksp<>nil then writeln(uksp^.fam);
if uksp^.rt<>nil then vivod(uksp^.rt);
end;

procedure vivod2(var uksp:ptree);
label 1,2,3;
var ukz,uks,ukz1:next; ukzv,ukzv1:ptree;
begin

 ukzv:=uksp;
 while ukzv^.rt<>nil do
 begin
 ukzv:=ukzv^.rt;
 end;
 ukzv1:=ukzv;

 new(ukz);
 ukz^.sled:=nil;
 uks:=ukz;
 ukz1:=uks;
 ukzv:=uksp;

1: while ukzv<>nil do
 begin
 new(ukz);
 ukz^.ad:=ukzv;
 ukz^.sled:=uks;
 uks:=ukz;
 ukzv:=ukzv^.lf;
 end;

 ukzv:=ukz^.ad;
 if (ukzv^.rt=nil) and (uks=ukz1) then goto 2;

 {if (ukzv^.rt=nil) and (ukzv^.lf=nil) then
 begin
 writeln(ukzv^.fam);

 end};
 if (ukzv^.lf=nil) and (ukzv^.rt=nil) then
 begin
 writeln(ukzv^.fam);
 uks:=ukz^.sled;
 ukz:=uks;
 end
                                  else
                                  goto 3;
 if ukzv=ukzv1 then goto 2;

 uks:=ukz^.sled;
 ukz:=uks;
 ukzv:=ukz^.ad;
 3:                writeln(ukzv^.fam);

  if (ukzv^.rt=nil) and (ukzv^.lf=nil) and (uks^.sled^.sled=nil) then goto 2;

 {
 uks:=ukz^.sled;}{
 ukzv:=uks^.ad;}
  if ukzv^.rt<>nil then
                   begin
                   ukzv:=ukzv^.rt;
                   goto 1;
                   end
                   else
                   begin
                   ukz:=uks^.sled;
                   uks:=ukz;
                   ukzv:=ukz^.ad;

                   goto 3;
                   end;

2: end;

begin
assign(input,'ex.inp');
reset(input);
assign(output,'vi.out');
rewrite(output);
{formir(uksp);
vivod(uksp);
close(output);

}
{assign(output,'vi1.out');
rewrite(output);
}
uksp1:=nil;
while not eof do
begin
readln(c);
formir2(uksp1,c);
end;
vivod2(uksp1);

close(input);
close(output);
end.