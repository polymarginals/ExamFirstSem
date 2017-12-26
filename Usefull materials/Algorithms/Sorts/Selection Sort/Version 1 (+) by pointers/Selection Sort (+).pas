procedure SortList(var BooksHead: PTBook);
var
    BooksI   : PTBook;
    BooksJ   : PTBook;
    PrevI    : PTBook;
    PrevJ    : PTBook;
    TempBook : PTBook;

begin
    BooksI := BooksHead;
    PrevI  := BooksI;

    while BooksI^.SortedNext <> nil do
    begin
        BooksI := BooksI^.SortedNext;
        BooksJ := BooksI;
        PrevJ  := BooksI;

        while BooksJ^.SortedNext <> nil do
        begin
            BooksJ := BooksJ^.SortedNext;

            if BooksJ^.Author < BooksI^.Author then
            begin
                if BooksI^.SortedNext = BooksJ then
                begin
                    PrevI ^.SortedNext := BooksJ;
                    BooksI^.SortedNext := BooksJ^.SortedNext;
                    BooksJ^.SortedNext := BooksI;
                end
                else
                begin
                    PrevI^.SortedNext  := BooksJ;
                    PrevJ^.SortedNext  := BooksI;

                    TempBook           := BooksJ^.SortedNext;

                    BooksJ^.SortedNext := BooksI^.SortedNext;
                    BooksI^.SortedNext := TempBook;
                end;
                TempBook := BooksI;
                BooksI   := BooksJ;
                BooksJ   := TempBook;
            end;

            PrevJ := BooksJ;
        end;

        PrevI := BooksI;
    end;
end;