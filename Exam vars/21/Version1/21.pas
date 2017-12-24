program ex_21;
uses crt;

type
     data_pointer=^data;
     data = record
     name : string;
     next, last: data_pointer;
end;

var f_input, f_output:text;

procedure load_data(input_file_addr:string; d_root:data_pointer);
var c_data: data_pointer;
f:text;
begin
assign(f, input_file_addr);
reset(f);
c_data := d_root;
while not eoln(f) do begin
new(c_data^.next);
c_data^.next^.last := c_data;
readln(f, c_data^.name);
c_data := c_data^.next;
end;
c_data^.last^.next := nil;
close(f);
end;

procedure show_list(root:data_pointer; is_straight:boolean);
begin
while(root <> nil) do begin
writeln(root^.name);
if (is_straight) then
  root := root^.next
else
  root:=root^.last;
end;
end;

procedure restore_sorted_data(var root:data_pointer; insert_data:data_pointer);
var place, last, next:data_pointer;
found:boolean;
begin
found := false;
place := root;
while (place <> nil) and (not found) do
        begin
        if (place^.last = nil) and (insert_data^.name <= place^.name) then
            begin
                      found := true;
                      new (place^.last);
                      place^.last^.name := insert_data^.name;
                      place^.last^.next := place;
                      place^.last^.last :=nil;
                      root := place^.last;
                      exit;
            end
        else
        if (place^.next = nil) and (insert_data^.name >= place^.name) then
           begin
                      found := true;
                     new (place^.next);
                     place^.next^.name := insert_data^.name;
                     place^.next^.next := nil;
                     place^.next^.last := place;
                     exit;

           end
        else
        if (insert_data^.name > place^.name) and ( insert_data^.name < place^.next^.name) then
          begin
                found:=true;
                last :=place;
                next := place^.next;
                next^.last := insert_data;
                insert_data^.next := next;
                insert_data^.last := last;
                last^.next := insert_data;
                exit;
          end
        else
        place := place^.next;
        end;

end;


procedure restore_files(restore_file_addr:string; root_data:data_pointer);
var c_data, in_data, dest:data_pointer;
f:text;
begin

assign(f, restore_file_addr);
reset(f);
c_data := root_data;

while not eoln(f) do begin
new(in_data);
readln(f,in_data^.name);
restore_sorted_data(root_data, in_data);
end;

close(f);
end;


var f1_data_root, f2_data_root: data_pointer;
example, dest:data_pointer;

begin
clrscr;
writeln('_________________________');
writeln('F1 data:');
writeln('_________________________');

new(f1_data_root);
f1_data_root^.last := nil;
f1_data_root^.next := nil;


new(f2_data_root);
f2_data_root^.last := nil;
f2_data_root^.next := nil;


load_data('f1.txt', f1_data_root);
show_list(f1_data_root, true);

writeln('_________________________');
writeln('F2 data:');
writeln('_________________________');

load_data('f2.txt', f2_data_root);
show_list(f2_data_root, true);

restore_files
('f2.txt', f1_data_root);

writeln('_________________________');
writeln('Sorted list data:');
writeln('_________________________');

while (f1_data_root^.last <> nil) do
f1_data_root := f1_data_root^.last;
show_list(f1_data_root, true);
readkey;
end.