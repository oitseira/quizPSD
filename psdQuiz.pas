Program quizPSD;

var
  data: array of Integer;
  n, i, j, temp, cari, pos, pilih: Integer;

{ Procedure Bubble Sort }
procedure BubbleSort(var data: array of Integer; n: Integer);
begin
  for i := 0 to n - 2 do
  begin
    for j := 0 to n - i - 2 do
    begin
      if data[j] > data[j + 1] then
      begin
        temp := data[j];
        data[j] := data[j + 1];
        data[j + 1] := temp;
      end;
    end;
  end;
end;

{ Procedure Insertion Sort }
procedure InsertionSort(var data: array of Integer; n: Integer);
var
  key, j: Integer;
begin
  for i := 1 to n - 1 do
  begin
    key := data[i];
    j := i - 1;

    while (j >= 0) and (data[j] > key) do
    begin
      data[j + 1] := data[j];
      j := j - 1;
    end;

    data[j + 1] := key;
  end;
end;

{ Procedure Merge Sort }
procedure Merge(var data: array of Integer; left, mid, right: Integer);
var
  n1, n2, i, j, k: Integer;
  L, R: array of Integer;
begin
  n1 := mid - left + 1;
  n2 := right - mid;

  SetLength(L, n1);
  SetLength(R, n2);

  for i := 0 to n1 - 1 do
    L[i] := data[left + i];
  for j := 0 to n2 - 1 do
    R[j] := data[mid + 1 + j];

  i := 0;
  j := 0;
  k := left;

  while (i < n1) and (j < n2) do
  begin
    if L[i] <= R[j] then
    begin
      data[k] := L[i];
      i := i + 1;
    end
    else
    begin
      data[k] := R[j];
      j := j + 1;
    end;
    k := k + 1;
  end;

  while i < n1 do
  begin
    data[k] := L[i];
    i := i + 1;
    k := k + 1;
  end;

  while j < n2 do
  begin
    data[k] := R[j];
    j := j + 1;
    k := k + 1;
  end;
end;

procedure MergeSort(var data: array of Integer; left, right: Integer);
var
  mid: Integer;
begin
  if left < right then
  begin
    mid := left + (right - left) div 2;

    MergeSort(data, left, mid);
    MergeSort(data, mid + 1, right);

    Merge(data, left, mid, right);
  end;
end;

{ Function Binary Search }
function BinarySearch(data: array of Integer; n, cari: Integer): Integer;
var
  kiri, kanan, tengah: Integer;
begin
  kiri := 0;
  kanan := n - 1;
  while kiri <= kanan do
  begin
    tengah := (kiri + kanan) div 2;
    if data[tengah] = cari then
    begin
      BinarySearch := tengah + 1; { Mengembalikan indeks yang dimulai dari 1 }
      Exit;
    end
    else if data[tengah] < cari then
      kiri := tengah + 1
    else
      kanan := tengah - 1;
  end;
  BinarySearch := -1;
end;

begin
  Write('Berapa jumlah data? ');
  Readln(n);
  SetLength(data, n);

  for i := 0 to n - 1 do
  begin
    Write('Data ke-', i + 1, ' : ');
    Readln(data[i]);
  end;

    Writeln('Pilih Menu');
    Writeln('[1] SORTING:');
    Writeln('[A] BUBBLE SORT');
    Writeln('[B] INSERT SORT');
    Writeln('[C] MERGE SORT');

    Writeln('[2] SEARCHING:');
    Writeln('[2.1] SEQUENTIAL');
    Writeln('[2.2] BINARY');

    Writeln('[0] Keluar');
    Write('Pilihan: ');
    Readln(pilih);

    case UpCase(Chr(pilih)) of
      'A':
      begin
        BubbleSort(data, n);
        Writeln('Data setelah diurutkan: ');
        for i := 0 to n - 1 do
          Write(data[i], ' ');
        Writeln;
      end;

      'B':
      begin
        InsertionSort(data, n);
        Writeln('Data setelah diurutkan: ');
        for i := 0 to n - 1 do
          Write(data[i], ' ');
        Writeln;
      end;

      'C':
      begin
        MergeSort(data, 0, n - 1);
        Writeln('Data setelah diurutkan: ');
        for i := 0 to n - 1 do
          Write(data[i], ' ');
        Writeln;
      end;

      '2':
      begin
        Writeln('Pilih Metode Pencarian:');
        Writeln('[2.1] SEQUENTIAL');
        Writeln('[2.2] BINARY');
        Write('Pilihan: ');
        Readln(pilih);

        case UpCase(Chr(pilih)) of
          '1':
          begin
            Writeln('Data yang dicari: ');
            Readln(cari);
            pos := -1;
            for i := 0 to n - 1 do
            begin
              if data[i] = cari then
              begin
                pos := i + 1; { Mengembalikan indeks yang dimulai dari 1 }
                Break;
              end;
            end;

            if pos <> -1 then
              Writeln('Data ', cari, ' ditemukan di indeks ke ', pos)
            else
              Writeln('Data ', cari, ' tidak ditemukan');
          end;

          '2':
          begin
            Writeln('Data yang dicari: ');
            Readln(cari);
            pos := BinarySearch(data, n, cari);
            if pos <> -1 then
              Writeln('Data ', cari, ' ditemukan di indeks ke ', pos)
            else
              Writeln('Data ', cari, ' tidak ditemukan');
          end;
        end;
      end;
    end;
  Readln;
end.
