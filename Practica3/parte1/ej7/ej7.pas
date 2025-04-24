program ej7;
const alto = 9999;

type 
  
  especie = record
    cod: integer;
    //nombre: string[20];
    //familia: string [20];
    //descripcion: string [40];
    //zona: string[10];
  end;
  
  archivo = file of especie;
  
  procedure leer (var arc: archivo; var e: especie);
  begin
    if (not eof (arc)) then read(arc,e)
    else e.cod:= alto;
  end;
  
  procedure crearArchivo(var arc: archivo);
  var e: especie;
  begin
    assign (arc,'especies.dat');
    rewrite(arc);
    writeln('-------------Creacion archivo detalle------------');
    writeln('Ingrese codigo');
    readln(e.cod);
    while (e.cod > 0) do begin
      write(arc,e);
      writeln('Ingrese codigo');
      readln(e.cod);
    end;
    writeln('-------------Finalizo la carga------------');
    close(arc);
  end;
  
  procedure imprimirArchivo(var arc: archivo);
  var e:especie;
  begin
    assign (arc,'especies.dat');
    reset(arc);
    writeln('-------------Impresion de especies------------');
    while (not eof(arc)) do begin
      read(arc,e);
      if (e.cod > 0) then
       writeln('Codigo de especie: ' , e.cod);
    end;
    writeln('------------------Finalizo la impresion-------------');
    close(arc);
  end;
  
  
  procedure borradoLogico (var arc: archivo; cod: integer);
  var e: especie;
  begin
    assign (arc,'especies.dat');
    reset(arc);
    while (not eof (arc)) do begin
      read(arc,e);
      if (e.cod = cod) then begin
        seek(arc,filepos(arc)-1);
        e.cod := e.cod * -1;
        write(arc,e);
      end;
    end;
    close(arc);
  end;
   
   
  procedure borradoFisicoA (var arc: archivo; cod: integer); // CONSULTAR
  var e,ult: especie; pos: integer;
  begin
    assign (arc,'especies.dat');
    reset(arc);
    seek(arc, fileSize(arc)-1);
    read(arc, ult);
    seek(arc, 0);
    leer(arc,e);
    while (e.cod <> alto) do begin
      if (e.cod = cod) then begin
        pos:= filepos(arc);
        seek(arc,pos-1);
        write(arc,ult);
        seek(arc,filesize(arc)-1);
        truncate(arc);
        seek(arc, filepos(arc)-1);
        read(arc, ult);
        seek(arc,pos);
      end;
      leer(arc,e);
    end;
    close(arc);
  end; 
  

var arc: archivo;
begin
  Randomize;
  crearArchivo(arc);
  imprimirArchivo(arc);
  borradoFisicoA(arc,1);
  imprimirArchivo(arc);
end.
