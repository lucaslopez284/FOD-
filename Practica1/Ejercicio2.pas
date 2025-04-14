program archivos2;

type archivo = file of integer;  

 function esMenor (n: integer): boolean;
 begin
   if (n < 1500) then esMenor:= true
                 else esMenor:= false
   
 end;
 
 procedure recorrido(var al: archivo; var cant: integer; var prom: real);
 var n,suma: integer;
 begin
   reset (al);
   suma:= 0;
   cant:= 0;
   while not eof (al) do begin
     read (al,n);
     suma:= suma + n;
     if (esMenor(n)) then
       cant:= cant + 1;
     writeln(n);
   end;
   prom:= suma/ filesize (al);
   close (al);
 
 end;

var al: archivo;af: string; cant: integer; prom: real;
begin
  writeln('Ingrese archivo a trabajar');
  readln(af);
  assign (al,af);
  recorrido(al,cant, prom);
  writeln('El archivo contiene ' , cant , ' numeros menores a 1500');
  writeln('El promedio de los numeros del archivo es igual a ', prom:2:2);
end.
