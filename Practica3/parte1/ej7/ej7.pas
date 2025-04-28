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
      writeln('Codigo de especie: ' , e.cod);
    end;
    writeln('------------------Finalizo la impresion-------------');
    close(arc);
  end;
  
  
  procedure borradoLogico (var arc: archivo);
  var e: especie; cod: integer;
  begin
    assign (arc,'especies.dat');
    reset(arc);
    writeln('-------------Inserte un codigo a eliminar -------------');
    readln(cod);
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
   
   
  procedure borradoFisicoA (var arc: archivo); // CONSULTAR
  var e,ult: especie; posAct, posUlt: integer;
  begin
    assign (arc,'especies.dat'); // asigno archivo
    reset(arc); // arranco desde el principio
    posUlt:= filesize(arc) - 1; 
    seek(arc, 0);
    leer(arc,e);
    while (e.cod <> alto) do begin
      if (e.cod <0) then begin
        posAct:= filepos(arc);
        seek(arc, posUlt);
        leer(arc,ult);
        while (ult.cod < 0) and (posUlt > 0) do begin // Busco un ult válido
          truncate(arc); // puede haber registros al final que haya que borrar, por lo que aprovecho y de una los elimino
          posUlt:= posUlt - 1;
          seek(arc, posUlt);
          leer(arc,ult);
        end;
        seek(arc, posAct-1);
        write(arc, ult);  // hago el intercambio
        seek(arc, filesize(arc) - 1); // voy a la pos final para intercambiar
        truncate(arc); // elimino el ultimo
        posUlt:= filesize(arc) - 1; // actualizo posUlt
        seek(arc,posAct - 1); // vuelvo una atras para no perder info
      end;
      leer(arc,e);
    end;  
    close(arc); 
  end; 
  
  procedure borradoFisicoB (var arc: archivo); // CONSULTAR
  var e,ult: especie; posAct,posFin, invalidos: integer;
  begin
    assign (arc,'especies.dat'); // asigno el archivo
    reset(arc); // arranco desde el principio
    posFin:= filesize(arc) -1; // pos del registro final
    posAct:= 0;
    invalidos:= 0; // total a eliminar
    leer(arc,e);
    while (posAct <= posFin) do begin // proceso hasta que posAct supere a posFin (donde arrancan los invalidos)
      if (e.cod < 0) then begin
        seek(arc,posFin);
        leer(arc,ult);
        posAct:= filepos(arc) - 1;
        while (ult.cod < 0) and (posAct < posFin) do begin // busco y sumo hasta encontrar un ult valido
          invalidos := invalidos + 1; // cada vez que encuentro un reg a borrar, incremento la variable que acumula
          posFin:= posFin - 1;
          seek(arc,posFin);
          leer(arc,ult);
        end;
        if (posAct< posFin) then begin
          seek(arc,posFin);
          write(arc,e); // paso 1 intercambio
          seek(arc,posAct);
          write(arc,ult); // paso 2 intercambio
          posFin:= posFin - 1;
         end;
      end;
      posAct:= posAct + 1; // actualizo posAct para la condicion de while
      leer(arc,e); // leo otro reg
    end;
    seek(arc, filesize(arc) - 1 - invalidos); // pos del ult registro - cant a borrar
    truncate(arc);
    close(arc);
  end; 


var arc: archivo;
begin
  Randomize;
  crearArchivo(arc);
  imprimirArchivo(arc);
  borradoLogico(arc);
  borradoFisicoB(arc);
  imprimirArchivo(arc);
end.
