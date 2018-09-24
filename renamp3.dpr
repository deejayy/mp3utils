program RenaMp3;

uses
  {Windows,} SysUtils, Crt;

{$R *.RES}

Type  Mp3Tag = Record
        Header  : Array[1..3] of Char;// = 'TAG';
        Title   : Array[1..30] of Char;
        Author  : Array[1..30] of Char;
        Album   : Array[1..30] of Char;
        Year    : Array[1..4] of Char;
        Comment : Array[1..30] of Char;
        Style   : Byte;
      End;

Var F: File of Byte;
    NewName: String;
    Author, Title: String;
    Ts: TSearchRec;
    Last: Integer;
    Mt: Mp3Tag;

begin
  {$I-}
  If FindFirst('*.mp3', $3F, Ts)=0 Then
  Begin
    AssignFile(F, Ts.Name);
    Reset(F);
    Seek(F, Ts.Size-128);
    BlockRead(F, Mt, 128);
    CloseFile(F);
    Author:=Mt.Author;
    Title:=Mt.Title;
    While Pos(#0,Author)<>0 Do Delete(Author, Pos(#0,Author), Length(Author));
    While Pos(#0,Title)<>0 Do Delete(Title, Pos(#0,Title), Length(Title));
    Rename(F, (Author + ' - ' + Title + '.mp3'));
      Repeat
        Last:=FindNext(Ts);
        AssignFile(F, Ts.Name);
        Reset(F);
        Seek(F, Ts.Size-128);
        BlockRead(F, Mt, 128);
        CloseFile(F);
         Author:=Mt.Author;
         Title:=Mt.Title;
         While Pos(#0,Author)<>0 Do Delete(Author, Pos(#0,Author), Length(Author));
         While Pos(#0,Title)<>0 Do Delete(Title, Pos(#0,Title), Length(Title));
        Rename(F, (Author + ' - ' + Title + '.mp3'));
      Until Last=18;
    FindClose(Ts);
  End;
  {$I+}
end.
