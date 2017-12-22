program exam_7;

 type
   Tinf = record
     name : string[10];
     numb : integer;
   end;
   Tree = ^rec;
   Rec = record
     inf : Tinf;
     left, right : tree;
   end;
   
        procedure init(var f : text; p : tree);
      procedure add(a : Tinf; p : tree); 
      begin
         if (a.numb <= p^.inf.numb) then
           if (p^.left <> nil) then
             add(a, p^.left)
           else begin
             new(p^.left);
             p := p^.left;
             p^.left := nil;
             p^.right := nil;
             p^.inf := a;
           end
         else 
           if (p^.right <> nil) then
             add(a, p^.right)
           else begin
             new(p^.right);
             p := p^.right;
             p^.left := nil;
             p^.right := nil;
             p^.inf := a;
           end;
      end;
    var
       a : Tinf;       
    begin
       readln(f, p^.inf.name, p^.inf.numb);
       while not eof(f) do 
       begin
          readln(f, a.name, a.numb);
          add(a, p);
       end;
    end;
    
        procedure infics(var f : text; p : tree);   
    begin
       if (p <> nil) then
       begin
          infics(f, p^.left);
          writeln(f, p^.inf.name, p^.inf.numb);
          infics(f, p^.right);
       end;
    end;
    
        procedure leaf(var f : text; p : tree);
    begin
       if (p <> nil) then
         begin
         leaf(f, p^.right);
         leaf(f, p^.left);       
         if (p^.left = nil) and (p^.right = nil) then
           writeln(f, p^.inf.name, p^.inf.numb);
       end;
    end;
    
var
   root : tree;
   f_inp, f_out : text;
   i : integer;
begin
   assign(f_inp, 'input7.txt');  reset(f_inp);
   assign(f_out, 'output7.txt'); rewrite(f_out);
   new(root);
   root^.left := nil;
   root^.right := nil;
   
   init(f_inp, root);
   infics(f_out, root);
   for i := 1 to 3 do
      writeln(f_out);
   leaf(f_out, root);
   close(f_inp);
   close(f_out);
end.