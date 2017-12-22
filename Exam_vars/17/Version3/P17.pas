Program ekz17;
type t=record
        nom:integer;
        fn:string[20]
     end;
     tipf=file of t;
     spisok=^tt;
     tt=record
        nom:integer;
        fn:string[20];
        next:spisok;
     end;
var f1,f2:tipf;
    sp1,sp2,sp3:spisok;

{формирование типизированного файла}
procedure P1(var inp:tipf);
var zap:t;
begin
   while not eof do
   begin
      read (zap.nom,zap.fn);
      readln;
      write (inp,zap);
   end;
end;

{формирование списка с одновременной сортировкой}
procedure P2(var ukstr:spisok; var inp:tipf);
var  ukzv,uk1,uk2:spisok;
     elem:t;
label 1;
begin
   new(ukzv);
   ukzv:=ukstr;
   read(inp,elem);
   ukzv^.nom:=elem.nom;
   ukzv^.fn:=elem.fn;
   ukzv^.next:=nil;
   while not eof(inp) do
   begin
      read (inp,elem);
      uk1:=ukstr;
      if elem.fn<=uk1^.fn then
      begin
         new(ukzv);
         ukzv^.nom:=elem.nom;
         ukzv^.fn:=elem.fn;
         ukzv^.next:=uk1;
         ukstr:=ukzv;
      end
      else
      begin
         1:uk2:=uk1;
         uk1:=uk1^.next;
         if (elem.fn<=uk1^.fn) or (uk1=nil) then
         begin
            new(ukzv);
            ukzv^.nom:=elem.nom;
            ukzv^.fn:=elem.fn;
            ukzv^.next:=uk1;
            uk2^.next:=ukzv;
         end
         else goto 1;
      end;
   end;
end;

procedure P4(ukstr1,ukstr2:spisok; var ukstr:spisok);
var ukzv,uk1,uk2:spisok;
label 2;
begin
   while ukstr2<>nil do
   begin
      uk1:=ukstr1;
      if ukstr2^.fn<=uk1^.fn then
      begin
         new(ukzv);
         ukzv^.nom:=ukstr2^.nom;
         ukzv^.fn:=ukstr2^.fn;
         ukzv^.next:=uk1;
         ukstr1:=ukzv;
      end
      else
      begin
         2:uk2:=uk1;
         uk1:=uk1^.next;
         if (ukstr2^.fn<=uk1^.fn) or (uk1=nil) then
         begin
            new(ukzv);
            ukzv^.nom:=ukstr2^.nom;
            ukzv^.fn:=ukstr2^.fn;
            ukzv^.next:=uk1;
            uk2^.next:=ukzv;
         end
         else goto 2;
      end;
      ukstr2:=ukstr2^.next;
   end;
   ukstr:=ukstr1;
end;

procedure P5(ukstr:spisok);
var ukzv:spisok;
begin
   ukzv:=ukstr;
   while ukzv<>nil do
   begin
      writeln (ukzv^.nom,' ',ukzv^.fn);
      ukzv:=ukzv^.next;
   end;
end;

begin
   {создание 1ого списка}
   assign (input,'in1.inp');
   reset (input);
   assign (f1,'f1');
   rewrite (f1);
   P1(f1);
   close (input);
   close (f1);

   new(sp1);

   assign (f1,'f1');
   reset (f1);
   P2(sp1,f1);
   close (f1);

   assign (output,'res1.out');
   rewrite (output);
   P5(sp1);
   close (output);

   {создание 2ого списка}
   assign (input,'in2.inp');
   reset (input);
   assign (f2,'f2');
   rewrite (f2);
   P1(f2);
   close (input);
   close (f2);

   new(sp2);

   assign (f2,'f2');
   reset (f2);
   P2(sp2,f2);
   close (f2);

   assign (output,'res2.out');
   rewrite (output);
   P5(sp2);
   close (output);

   {слияние 2х списков и вывод общего}
   new(sp3);
   P4(sp1,sp2,sp3);

   assign (output,'res3.out');
   rewrite (output);
   P5(sp3);
   close (output);
end.