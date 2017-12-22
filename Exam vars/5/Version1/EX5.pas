program ex5;
type
 next=^uk;
 uk=record
 nom:integer;
 fam:string;
 sled,pred:next
 end;


var ukzv,uksp:next; uksp1,uksp2:next; f1,f3:text;

procedure p1(var uksp:next; var t:text);
var ukzv,s:next;
begin
 new(ukzv);
 uksp:=ukzv;
 ukzv^.pred:=nil;
 ukzv^.sled:=nil;
 s:=ukzv;
  while not eof(t) do
  begin
   new(ukzv^.sled);
   ukzv:=ukzv^.sled;
   readln(t,ukzv^.nom,ukzv^.fam);
   ukzv^.pred:=s;
   ukzv^.sled:=nil;
   s:=ukzv;
  end;
  new(ukzv^.sled);
  ukzv:=ukzv^.sled;
  ukzv^.pred:=s;
  ukzv^.sled:=nil;
end;

procedure p2(var uksp:next; var g:text);
var ukzv:next;
begin
ukzv:=uksp^.sled;
while ukzv^.sled<>nil do
 begin
 writeln(g, ukzv^.nom,ukzv^.fam);
 ukzv:=ukzv^.sled;
 end;
 writeln(f3);
 end;



procedure p3(var uksp:next; var uksp1:next; var uksp2:next);
var ukzv:next;ukzv1,ukzv2,ukzv3,m:next;
begin
 ukzv:=uksp^.sled;
 new(ukzv1);
 uksp1:=ukzv1;
 ukzv1^.sled:=nil;
 new(ukzv1^.sled);
 ukzv1:=ukzv1^.sled;
 ukzv1^.nom:=ukzv^.nom;
 ukzv1^.fam:=ukzv^.fam;
 ukzv1^.sled:=nil;
 ukzv:=ukzv^.sled;
 while ukzv^.sled<>nil do
    begin
    m:=uksp1;
    ukzv1:=uksp1^.sled;
    while ukzv1<>nil do
     begin
      if ukzv^.fam>ukzv1^.fam then begin
                                 if ukzv1^.sled=nil then begin
                                                         new(ukzv1^.sled);
                                                         ukzv1:=ukzv1^.sled;
                                                         ukzv1^.nom:=ukzv^.nom;
                                                         ukzv1^.fam:=ukzv^.fam;
                                                         ukzv1^.sled:=nil;
                                                         break
                                                         end
                                                         else
                                 m:=ukzv1;
                                 ukzv1:=ukzv1^.sled;

                                   end

                                 else
                                 begin

                                 new(ukzv3);
                                 ukzv3^.fam:=ukzv^.fam;
                                 ukzv3^.nom:=ukzv^.nom;
                                 ukzv3^.sled:=nil;
                                 m^.sled:=ukzv3;
                                 ukzv3^.sled:=ukzv1;
                                 break
                                 end;

       end;
       ukzv:=ukzv^.sled;
       end;
       new(ukzv1^.sled);
       ukzv1:=ukzv1^.sled;
       ukzv1^.sled:=nil;


  ukzv:=uksp^.sled;
 new(ukzv2);
 uksp2:=ukzv2;
 ukzv2^.sled:=nil;
 new(ukzv2^.sled);
 ukzv2:=ukzv2^.sled;
 ukzv2^.nom:=ukzv^.nom;
 ukzv2^.fam:=ukzv^.fam;
 ukzv2^.sled:=nil;
 ukzv:=ukzv^.sled;
 while ukzv^.sled<>nil do
    begin
    m:=uksp2;
    ukzv2:=uksp2^.sled;
    while ukzv2<>nil do
     begin
      if ukzv^.nom>ukzv2^.nom then begin
                                 if ukzv2^.sled=nil then begin
                                                         new(ukzv2^.sled);
                                                         ukzv2:=ukzv2^.sled;
                                                         ukzv2^.nom:=ukzv^.nom;
                                                         ukzv2^.fam:=ukzv^.fam;
                                                         ukzv2^.sled:=nil;
                                                         break
                                                         end
                                                         else
                                 m:=ukzv2;
                                 ukzv2:=ukzv2^.sled;

                                   end

                                 else
                                 begin

                                 new(ukzv3);
                                 ukzv3^.fam:=ukzv^.fam;
                                 ukzv3^.nom:=ukzv^.nom;
                                 ukzv3^.sled:=nil;
                                 m^.sled:=ukzv3;
                                 ukzv3^.sled:=ukzv2;
                                 break
                                 end;

       end;
       ukzv:=ukzv^.sled;
       end;
       new(ukzv2^.sled);
       ukzv2:=ukzv2^.sled;
       ukzv2^.sled:=nil;
       end;

begin
assign(f1,'ex5.inp');
reset(f1);
assign(f3,'rex5.out');
rewrite(f3);
p1(uksp,f1);
p2(uksp,f3);
p3(uksp,uksp1,uksp2);
p2(uksp1,f3);
p2(uksp2,f3);
close(f1);
close(f3);
end.
