program lab4;

const
    Digits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ' ', '-', '.'];
    Accuracy = 0.0000000001;

type
    PtrPolynTerm    = ^TPolynomialTerm;
    TPolynomialTerm =  record
        Coefficient : real;
        Exponent    : integer;
        Next        : PtrPolynTerm;
    end;

    TPolynomial     = Object
    private
        Head   : PtrPolynTerm;
        Backup : PtrPolynTerm;
    public
        Size   : integer;
        MaxPwr : integer;
        constructor Initialize;
        procedure   Enqueue (    P   : TPolynomialTerm);
        procedure   Dequeue (var P   : PtrPolynTerm   );
        procedure   Print   (var res : Text           );
        procedure   DecMaxPwr;
    end;

    constructor TPolynomial.Initialize;
    begin
        Head   := nil;
        Backup := nil;
        Size   := 0;
        MaxPwr := 0;
    end;

    procedure   TPolynomial.DecMaxPwr;
    begin
        dec(MaxPwr);
    end;

    procedure   TPolynomial.Enqueue(P : TPolynomialTerm);
    var
        PtrNew, PtrCurrent : PtrPolynTerm;

    begin
        new(PtrNew);
        PtrNew^.Coefficient := P.Coefficient;
        PtrNew^.Exponent    := P.Exponent;
        PtrNew^.Next        := nil;

        if (Head = nil) then
        begin
            Head   := PtrNew;
            Backup := Head;
        end
        else
        begin
            PtrCurrent  := Head;
            while Head^.Next <> nil do
            begin
               Head := Head^.Next;
            end;
            Head^.Next  := PtrNew;
            Head        := PtrCurrent;
        end;

        inc(Size);
    end;

    procedure   TPolynomial.Dequeue(var P : PtrPolynTerm);
    begin
        P := Head;
        if Head <> nil then
            Head := Head^.Next;
    end;

    procedure   TPolynomial.Print(var res : Text);
    var
        tmpPol  : TPolynomial;
        tmpPtr  : PtrPolynTerm;
        PolTerm : TPolynomialTerm;
        i       : integer;

    begin
        if (Size = 0) then
        begin
            writeln(res, 'Polynomial is empty');
        end
        else
        begin
            tmpPol.Head   := Backup;

            tmpPol.Dequeue(tmpPtr);
            PolTerm.Coefficient := tmpPtr^.Coefficient;
            PolTerm.Exponent    := tmpPtr^.Exponent;
            write(res, PolTerm.Coefficient:1:3, 'x^(', PolTerm.Exponent, ')');

            i := 2;
            for i := i to Size do
            begin
                tmpPol.Dequeue(tmpPtr);
                if abs((tmpPtr^.Coefficient - 0)) < Accuracy then
                     continue;
                if (tmpPtr^.Coefficient >= 0.0) then
                    write(res, ' + ')
                else
                    write(res, ' ');
                PolTerm.Coefficient := tmpPtr^.Coefficient;
                PolTerm.Exponent    := tmpPtr^.Exponent;
                write(res, PolTerm.Coefficient:1:3, 'x^(', PolTerm.Exponent, ')');
            end;
            writeln(res);
        end;
  end;

procedure Subtract(var Base : TPolynomial; Subtrahend : TPolynomial);
var
   tmpBase  : TPolynomial;
   tmpSubt  : TPolynomial;
   resPolyn : TPolynomial;
   tmpTerm  : TPolynomialTerm;
   tmpBTerm : PtrPolynTerm;
   tmpSTerm : PtrPolynTerm;
   priority : byte;

begin
   tmpBase.Head   := Base.Head;
   tmpBase.Backup := Base.Backup;
   tmpBase.Size   := Base.Size;
   tmpBase.MaxPwr := Base.MaxPwr;

   tmpSubt.Head   := Subtrahend.Head;
   tmpSubt.Backup := Subtrahend.Backup;
   tmpSubt.Size   := Subtrahend.Size;
   tmpSubt.MaxPwr := Subtrahend.MaxPwr;

   resPolyn.Initialize;
   if (tmpBase.MaxPwr > tmpSubt.MaxPwr) then
      resPolyn.MaxPwr := tmpBase.MaxPwr
   else
      resPolyn.MaxPwr := tmpSubt.MaxPwr;

   priority := 2;
   while ((tmpBase.Head <> nil) AND (tmpSubt.Head <> nil)) do
   begin
        if (priority = 0) OR (priority = 2) then
           tmpBase.Dequeue(tmpBTerm);
        if (priority = 1) OR (priority = 2) then
           tmpSubt.Dequeue(tmpSTerm);

        if (tmpBTerm^.Exponent = tmpSTerm^.Exponent) then
        begin
             tmpTerm.Exponent    := tmpBTerm^.Exponent;
             tmpTerm.Coefficient := tmpBTerm^.Coefficient - tmpSTerm^.Coefficient;
             priority            := 2;
        end
        else if (tmpBTerm^.Exponent > tmpSTerm^.Exponent) then
        begin
             tmpTerm.Exponent    := tmpBTerm^.Exponent;
             tmpTerm.Coefficient := tmpBTerm^.Coefficient;
             priority            := 0;
        end
        else
        begin
             tmpTerm.Exponent    := tmpSTerm^.Exponent;
             tmpTerm.Coefficient := -1 * tmpSTerm^.Coefficient;
             priority            := 1;
        end;
        resPolyn.Enqueue(tmpTerm);
   end;
   while (tmpBase.Head <> nil) do
   begin
        tmpBase.Dequeue(tmpBTerm);
        tmpTerm.Exponent    := tmpBTerm^.Exponent;
        tmpTerm.Coefficient := tmpBTerm^.Coefficient;
        resPolyn.Enqueue(tmpTerm);
   end;
   while (tmpSubt.Head <> nil) do
   begin
        tmpSubt.Dequeue(tmpSTerm);
        tmpTerm.Exponent    := tmpSTerm^.Exponent;
        tmpTerm.Coefficient := -1 * tmpBTerm^.Coefficient;
        resPolyn.Enqueue(tmpTerm);
   end;

   Base := resPolyn;
end;

procedure Multiply(var tmp : TPolynomial; Base : TPolynomial; Multiplier : TPolynomialTerm);
var
  tmpBase  : TPolynomial;
  resPolyn : TPolynomial;
  tmpTermP : PtrPolynTerm;
  tmpTerm  : TPolynomialTerm;

begin
   tmpBase.Head       := Base.Backup;
   tmpBase.Size       := Base.Size;
   tmpBase.MaxPwr     := Base.MaxPwr;
   resPolyn.Initialize;

   while (tmpBase.Head <> nil) do
   begin
        tmpBase.Dequeue(tmpTermP);
        tmpTerm.Exponent    := tmpTermP^.Exponent + Multiplier.Exponent;
        tmpTerm.Coefficient := tmpTermP^.Coefficient * Multiplier.Coefficient;
        resPolyn.Enqueue(tmpTerm);
   end;

   tmp := resPolyn;
end;

procedure Divide (var Dividend, Quontity, Remainder : TPolynomial; Divisor : TPolynomial);
var
   dividendTerm : PtrPolynTerm;
   divisorTerm  : PtrPolynTerm;
   tmpTerm      : TPolynomialTerm;
   tmpBase      : TPolynomial;
   tmpDivisor   : TPolynomial;
   tmp          : TPolynomial;

begin
    tmpBase.Head   := Dividend.Head;
    tmpBase.Backup := Dividend.Backup;
    tmpBase.Size   := Dividend.Size;
    tmpBase.MaxPwr := Dividend.MaxPwr;

    tmpDivisor.Head   := Divisor.Head;
    tmpDivisor.Backup := Divisor.Backup;
    tmpDivisor.Size   := Divisor.Size;
    tmpDivisor.MaxPwr := Divisor.MaxPwr;

    if (Remainder.Size = 0) then
    begin
         if (tmpBase.MaxPwr < tmpDivisor.MaxPwr) then
         begin
              Remainder := Dividend;
              Remainder.Backup := Remainder.Backup^.Next;
              Remainder.Size := Remainder.Size - 1;
         end
         else
         begin
           tmpBase   .Dequeue(dividendTerm);
           tmpDivisor.Dequeue(divisorTerm);

           tmpTerm.Exponent    := dividendTerm^.Exponent - divisorTerm^.Exponent;
           tmpTerm.Coefficient := dividendTerm^.Coefficient / divisorTerm^.Coefficient;

           tmp.Initialize;
           Multiply(tmp, tmpDivisor, tmpTerm);
           Quontity.Enqueue(tmpTerm);
           Subtract(Dividend, tmp);
           Dividend.MaxPwr := Dividend.MaxPwr - 1;
           Dividend.Head   := Dividend.Head^.Next;
         end;
         Divide(Dividend, Quontity, Remainder, Divisor);
    end;
end;

procedure ParsePolynomial(var P : TPolynomial; var src, res : Text);
var
    tmpString : String;
    tmpTerm   : TPolynomialTerm;
    tmpCoeff  : real;
    tmpExp    : integer;
    i, j      : integer;
    tmpFile   : Text;

begin
    readln(src, tmpString);
    writeln(res, 'Original entry:');
    writeln(res, tmpString);

    for i := 1 to length(tmpString) do
    begin
        for j := 1 to length(tmpString) do
        begin
            if not(tmpString[j] in Digits) then
            begin
                 delete(tmpString, j, 1);
                 break;
            end;
        end;
    end;

    assign(tmpFile, 'tmp.txt');
    rewrite(tmpFile);
    write(tmpFile, tmpString);
    close(tmpFile);

    reset(tmpFile);
    read(tmpFile, tmpTerm.Coefficient);
    read(tmpFile, tmpTerm.Exponent);
    P.MaxPwr := tmpTerm.Exponent;
    P.Enqueue(tmpTerm);
    i        := P.MaxPwr - 1;

    while not eof(tmpFile) do
    begin
        read(tmpFile, tmpCoeff);
        read(tmpFile, tmpExp);
        while i > tmpExp do
        begin
            tmpTerm.Coefficient := 0;
            tmpTerm.Exponent    := i;
            dec(i);
            P.Enqueue(tmpTerm);
        end;

        tmpTerm.Coefficient := tmpCoeff;
        tmpTerm.Exponent    := tmpExp;
        P.Enqueue(tmpTerm);
        dec(i);
    end;

    Close(tmpFile);
    Erase(tmpFile);
end;

var
   src, res  : Text;
   Dividend  : TPolynomial;
   Divisor   : TPolynomial;
   Quotient  : TPolynomial;
   Remainder : TPolynomial;

begin
     assign(src, 'src.txt');
     reset(src);
     assign(res, 'out.txt');
     rewrite(res);

     writeln(res, 'Dividend Polynomial.');
     Dividend.Initialize;
     ParsePolynomial(Dividend, src, res);
     Dividend.Print(res);
     writeln(res);

     writeln(res, 'Divisor Polynomial.');
     Divisor.Initialize;
     ParsePolynomial(Divisor, src, res);
     Divisor.Print(res);
     writeln(res);

     Quotient.Initialize;
     Remainder.Initialize;
     Divide(Dividend, Quotient, Remainder, Divisor);

     writeln(res, 'Quontity: ');
     Quotient.Print(res);
     writeln(res);

     writeln(res, 'Remainder: ');
     Remainder.Print(res);

     close(src);
     close(res);
end.
