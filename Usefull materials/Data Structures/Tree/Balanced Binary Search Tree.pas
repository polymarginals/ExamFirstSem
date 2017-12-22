program exam_avl;
  
  type
     Tinf = record
       numb : integer;
       age : integer;
     end;
     tree = ^rec;
     rec = record
       inf : Tinf;
       right, left : Tree;
     end;
  
        procedure Init(var f : text; var Head, tail : Tree);
    var
       p : tree;
       i : integer;
    begin
       p := head^.right;
       i := 0;
       head^.inf.numb := 0;
       while not eof(f) do
       begin
          inc(i);
          readln(f, p^.inf.age);
          p^.inf.numb := i;
          new(p^.right);
          tail := p^.right;
          tail^.left := p;
          p := tail;
       end;
       p^.inf.numb := i+1;
    end;

        procedure Sort(var head, tail : tree);
    var
       p, tmp : tree;
       a : integer;
    begin
       p := head^.right;
       while p^.right <> tail do
       begin
          tmp := p^.right;
          while tmp <> tail do
          begin
             if (p^.inf.age > tmp^.inf.age) then
               begin
               a := p^.inf.age;
               p^.inf.age := tmp^.inf.age;
               tmp^.inf.age := a
             end;
             tmp := tmp^.right;
          end;
          p := p^.right;
       end;
    end;

        function Numb(i : integer; head, tail : tree) : tree;
    var p : tree;
    begin
       if (i >= tail^.inf.numb) or (i <= head^.inf.numb) then
         begin
         writeln('number"s error');
         readln;
         halt;
       end;
       p := head^.right;
       while (p^.inf.numb <> i) do
          p := p^.right;
       numb := p;
    end;
        
        procedure Avl(head, tail : tree; var root : tree);
    var
       p : tree;
       start, stop : integer;
       a : integer;
    begin
       start := head^.inf.numb;
       stop := tail^.inf.numb;
       a := stop - start;
       if (a > 1) then
       begin
         a := a div 2;
         a := a + start;
         p := Numb(a, head, tail);
         new(root);
         root^.inf := p^.inf;
         root^.left := nil;
         root^.right := nil;
         Avl(head, p, root^.left);
         Avl(p, tail, root^.right);
       end;
    end;
    
        procedure write_stack(var f : text; head, tail : tree);
    var p : tree;
    begin
       p := head^.right;
       while p <> tail do
       begin
          writeln(f, p^.inf.age);
          p := p^.right;
       end
    end;
    
        procedure prefics(var f : text; var p : tree);
    begin
       if (p <> nil) then
       begin
          writeln(f, p^.inf.age);
          prefics(f, p^.left);
          prefics(f, p^.right);
       end;
    end;
    
  var
    root, head, tail : tree;
    i : integer;
    f_inp, f_out : text;
begin
   assign(f_inp, 'inputAVL.txt');  reset(f_inp);
   assign(f_out, 'outputAVL.txt'); rewrite(f_out);
   new(head);       
   head^.left := nil;
   new(head^.right); 
   tail := head^.right;
   tail^.right := nil;
   Init(f_inp, head, tail);
   sort(head, tail);
   write_stack(f_out, head, tail);
   for i := 1 to 3 do writeln(f_out);   
   close(f_out);
   close(f_inp);
 {  readln;}
   append(f_out);
   Avl(head, tail, root);
   prefics(f_out, root);
   close(f_out);
end.