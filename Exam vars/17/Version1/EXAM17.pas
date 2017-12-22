program exam17;
type

 zap=record
 nom:integer;
 fam:string[20]
 end;

  h=file of zap;
 next=^uk;
 uk=record
 nom:integer;
 fam:string[20];
 sled:next
 end;

var tip1,tip2:h; ukz:zap; f:text; uksp1,ukzv1,ukzv,uksp:next;

procedure p1(var tip1:h);
var ukz:zap;
begin
 while not eof do
 begin
  read(ukz.nom, ukz.fam);
  readln;
  write(tip1,ukz);
 end;
 end;

procedure p2(var uksp:next; var tip1:h);
var pp,ukzv,ukzv1,m:next; ukz:zap;
 procedure uknadan(var ukzv:next;var uksp:next;var pp:next);
 var tt:next;
 begin
 tt:=uksp;
 while tt<>nil do
 begin
 if tt^.sled=ukzv then
                  begin
                  pp:=tt;
                  break
                  end
                  else
                  tt:=tt^.sled
 end;
 end;
begin
 new(ukzv);
 uksp:=ukzv;
  read(tip1,ukz);
  ukzv^.nom:=ukz.nom;
  ukzv^.fam:=ukz.fam;
  ukzv^.sled:=nil;

  while not eof(tip1) do
  begin

   read(tip1,ukz);
   new(ukzv1);
   ukzv1^.nom:=ukz.nom;
   ukzv1^.fam:=ukz.fam;
   ukzv1^.sled:=nil;
      ukzv:=uksp;
      m:=nil;
      while ukzv<> nil do
      begin
      if  ukzv1^.fam>ukzv^.fam then
                                begin
                                 m:=ukzv;

                                end
                                else
                                begin
                                if m=nil then
                                begin
                                  ukzv1^.sled:=ukzv;
                                  uksp:=ukzv1;
                                  break
                                end
                                  else
                                  begin
                                  m^.sled:=ukzv1;
                                  ukzv1^.sled:=ukzv;
                                  break
                                  end;

                                end;
                        if m^.sled=nil then
                        begin
                        m^.sled:=ukzv1;
                        ukzv1^.sled:=nil;
                        break
                        end;
                       ukzv:=ukzv^.sled;


                   end;

   end;
end;

procedure p4(var uksp:next; var uksp1:next);
var ukzv,ukzv1,m,t,ukzv2:next;
begin
  ukzv1:=uksp1;

    while ukzv1<>nil do
  begin
  t:=ukzv1;
  ukzv:=uksp;
  m:=nil;
     while ukzv<>nil do
    begin
    if ukzv^.fam<ukzv1^.fam then
                            begin
                            m:=ukzv;
                            end
                            else
                            begin
                            if m=nil then
                            begin
                            new(ukzv2);
                            ukzv2^.fam:=ukzv1^.fam;
                            ukzv2^.nom:=ukzv1^.nom;
                            ukzv2^.sled:=ukzv;
                            uksp:=ukzv2;

                            {ukzv1^.sled:=ukzv;
                            uksp:=ukzv1;}
                            break;
                            end
                                          else
                            begin
                            new(ukzv2);
                            ukzv2^.fam:=ukzv1^.fam;
                            ukzv2^.nom:=ukzv1^.nom;
                            ukzv2^.sled:=ukzv;
                            m^.sled:=ukzv2;
                            {ukzv1^.sled:=ukzv;}
                            break
                            end;
                          end;

                          if m^.sled=nil then
                          begin
                          new(ukzv^.sled);
                          ukzv:=ukzv^.sled;
                          ukzv^.fam:=ukzv1^.fam;
                          ukzv^.nom:=ukzv1^.nom;
                          ukzv^.sled:=ukzv;
                         { m^.sled:=ukzv1;
                          ukzv1^.sled:=nil;}
                          break
                          end;
                      ukzv:=ukzv^.sled;
                   end;

                     ukzv1:=ukzv1^.sled;
         end;

             end;


procedure p5(var uksp:next);
var ukzv:next;
begin
  ukzv:=uksp;
  while ukzv<>nil do
  begin
  writeln(ukzv^.nom,ukzv^.fam);
  ukzv:=ukzv^.sled;
  end;
end;


BEGIN
assign(input,'dan1.inp');
reset(input);
assign(tip1,'res1.tip');
rewrite(tip1);
p1(tip1);
close(input);
close(tip1);

assign(output,'res1.out');
rewrite(output);
reset(tip1);
p2(uksp1,tip1);
p5(uksp1);
close(tip1);
close(output);

assign(input,'dan2.inp');
reset(input);
assign(tip2,'res2.tip');
rewrite(tip2);
p1(tip2);
close(input);
close(tip2);

assign(output,'res2.out');
rewrite(output);
reset(tip2);
p2(uksp,tip2);
p5(uksp);
close(tip2);
close(output);

assign(output,'res3.out');
rewrite(output);
p4(uksp1,uksp);
p5(uksp1);
close(output);
end.