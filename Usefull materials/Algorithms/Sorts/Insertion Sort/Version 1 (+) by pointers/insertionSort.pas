program single_linked_list_with_insertion_sort_by_pointers;

type
    { Single Linked List }
    PTList = ^TList;
    TList = record
        key  : Integer;
        next : PTList;
    end;

    procedure List_Initialization(var head: PTList);
    begin
        New(head); { Not empty head }
    end;

    procedure List_Print(var f: Text; head: PTList);
    var
        tmpList : PTList;

    begin
        tmpList := head;

        while (tmpList^.next <> nil) do
        begin
            Write(f, tmpList^.key, ' ');
            tmpList := tmpList^.next;
        end;
    end;

    procedure List_Add(var head: PTList; value: Integer);
    var
        tmpList : PTList;

    begin
        tmpList := head;

        while (tmpList^.next <> nil) do
        begin
            tmpList := tmpList^.next;
        end;

        tmpList^.key := value;

        New(tmpList^.next);
        tmpList := tmpList^.next;
    end;

    procedure List_CreateFromFile(var f: Text; var head: PTList);
    var
        value : Integer;

    begin
        List_Initialization(head);
        while not Eof(f) do
        begin
            ReadLn(f, value);
            List_Add(head, value);
        end;
    end;

    procedure List_SortedInsert(var head: PTList; newItem: PTList);
    var
        currentItem : PTList;

    begin
        { Special case for the head end }
        if ((head = nil) OR (head^.key >= newItem^.key)) then
        begin
            newItem^.next := head;
            head          := newItem;
        end
        else
        begin
            { Locate the node before the point of insertion }
            currentItem := head;
            while ((currentItem^.next <> nil             ) AND
                   (currentItem^.next^.key < newItem^.key)) do
            begin
                currentItem := currentItem^.next;
            end;

            newItem^.next := currentItem^.next;
            currentItem^.next := newItem;
        end;
    end;

    { procedure to sort a singly linked list using insertion sort }
    function List_InsertionSortByPointers(var head: PTList) : PTList;
    var
        sorted   : PTList;
        current  : PTList;
        nextItem : PTList;

    begin
        List_Initialization(sorted);
        current := head;

        { Traverse the given linked list and insert every node to sorted list }
        while (current^.next <> nil) do
        begin
            nextItem := current^.next; { Store next for next iteration }

            List_SortedInsert(sorted, current);

            current := nextItem; { Update current item }
        end;

        List_InsertionSortByPointers := sorted;
    end;

var
    list : PTList;
    listSorted : PTList;
    inp  : Text;
    outp : Text;

begin
    Assign(inp, 'file.in');
    Reset(inp);

    Assign(outp, 'file.out');
    Rewrite(outp);

    List_CreateFromFile(inp, list);
    List_Print(outp, list);

    WriteLn(outp);
    listSorted := List_InsertionSortByPointers(list);
    List_Print(outp, listSorted);

    Close(inp);
    Close(outp);
end.