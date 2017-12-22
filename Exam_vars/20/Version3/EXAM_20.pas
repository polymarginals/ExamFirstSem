program exam20;

type 
   Tinf = record
     name : string[10];
     date : array [1..3] of integer;
     price, count : integer;
   end;
   Tlist = ^RecList;
   RecList = record
     inf : Tinf;
     next : Tlist;
   end;
   
        procedure Add_Sort(var f : text; var Head, Tail : Tlist);
      var
         tmp, prev, walker : Tlist;
         err : integer;
         ch : char;
         
         procedure pDate(var f : text; var point : Tlist);
         var
            i : integer;
            saver : string[2];
         begin
            for i := 1 to 2 do
            begin
               read(f, saver);
               val(saver, point^.inf.date[i], err);
               if err<>0 then
                 begin
                 writeln('error ', err);
                 readln;
               end;
               read(f, ch);
            end;
         end;
         
      begin
         new(tmp);
         while not eof(f) do
         begin
            read(f, tmp^.inf.name);
            pDate(f, tmp);
            readln(f, tmp^.inf.date[3], tmp^.inf.price, tmp^.inf.count);
            prev := head;
            walker := prev^.next;
            while (walker^.inf.name <= tmp^.inf.name) and (walker <> tail) do
            begin
               prev := walker;
               walker := walker^.next;
            end;
            walker := prev;
            prev := walker^.next;
            new(walker^.next);
            walker := walker^.next;
            walker^.next := prev;
            walker^.inf := tmp^.inf;
         end;
      end;

        procedure write_stack(var f : text; head, tail : Tlist);
      var
         p : Tlist;  
         i : integer;
      begin
         p := Head^.next;  
         while (p <> tail) do
         begin
            write(f, p^.inf.name);
            for i := 1 to 2 do
            begin
               write(f, p^.inf.date[i], '/');
            end;
            writeln(f, p^.inf.date[3], ' ', p^.inf.price, ' ', p^.inf.count);
            p := p^.next;
         end;
         writeln(f);
      end;

        procedure Date_sort(var Head, Tail : Tlist);
        var
           p, tmp, prev, pred, trans : Tlist;
           sp, st : real;
        begin
           pred := head;
           p := head^.next;           
           while (p <> tail) do
           begin
              tmp := p;
              sp := p^.inf.date[1] / 100 / 100;
              sp := sp + p^.inf.date[2] / 100;
              sp := sp + p^.inf.date[3];
              while (tmp^.next <> tail) do
              begin
                 prev := tmp;
                 tmp := tmp^.next;
                 st := tmp^.inf.date[1] / 100 / 100;
                 st := st + tmp^.inf.date[2] / 100;
                 st := st + tmp^.inf.date[3];
                 if (sp > st) then
                   begin
                   if (p = prev) then
                     begin
                     pred^.next := tmp;
                     p^.next := tmp^.next;
                     tmp^.next := p;
                   end
                   else begin
                     pred^.next := tmp;
                     prev^.next := p;
                     trans := p^.next;
                     p^.next := tmp^.next;
                     tmp^.next := trans;
                   end;
                   trans := tmp;
                   tmp := p;
                   p := trans;
                   sp := st;
                 end;                 
              end;
              pred := p;
              p := p^.next;
           end;
        end;
       
   var
      head, tail : Tlist;
      f_inp, f_out : text;

Begin
   assign(f_inp, 'input.txt');
   reset(f_inp);
   assign(f_out, 'output.txt');
   rewrite(f_out);
   
   new(head);
   new(head^.next);
   tail := head^.next;
   
   Add_Sort(f_inp, head, tail);
   write_stack(f_out, head, tail);
   Date_sort(head, tail);
   write_stack(f_out, head, tail);

   close(f_inp);
   close(f_out);
end.   