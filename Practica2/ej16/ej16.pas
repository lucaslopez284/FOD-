program ej16;

const 
  alto = 'ZZZ';
  df = 100;
  
type 

  emision = record
    fecha: string[30];
    cod: integer;
    nombre: string [10];
    descripcion: string [30] ;
    precio: real;
    total: integer;
    vendidos: integer;
  end;
  
  infoDet = record
    fecha: string;
    cod: integer;
    vendidos: integer;
  end;
  
  maestro = file of emision;
  detalle = file of infoDet;
  detalles = array [1..df] of detalle;
  registros = array [1..df] of infoDet;


procedure leer (var arc: detalle;  var dato: infoDet);
  begin
    if (not eof (arc)) then read(arc,dato)
    else dato.fecha:= alto;
  end;
  
  procedure minimo (var d: detalles; var r: registros; var min: infoDet);
  var i,pos: integer;
  begin
    min.fecha:= alto;
    min.cod:= 999;
    for i:= 1 to df do begin
      if( r[i].fecha < min.fecha) or ((r[i].fecha = min.fecha) and (r[i].cod < min.cod)) then begin
        min:= r[i];
        pos:= i;
      end;
    end;
    leer(d[pos],r[pos]);
  end;
  
  
  procedure actualizarMaestro (var mae: maestro; var d: detalles);
  var i: integer;
      min: infoDet;
      maxV, minV: integer;
      nombreMax, nombreMin: string;
      fechaMax, fechaMin: string;
      aux: emision;
      f: string;
      cod: integer;
      r: registros;
  begin
    reset (mae);
    for i:= 1 to df do begin
      reset (d[i]);
      leer(d[i],r[i]);
    end;
    minimo(d,r,min);
    maxV:= 0;
    minV:= 9999;
    writeln('----------------');
    while (min.fecha <> alto) do begin
      read(mae,aux);
      f:= min.fecha;
      while (aux.fecha < f) do begin
        if (aux.vendidos > maxV) then begin
          maxV:= aux.vendidos;
          fechaMax:= aux.fecha;
          nombreMax:= aux.nombre
        end;
        if (aux.vendidos < minV) then begin
          minV:= aux.vendidos;
          fechaMin:= aux.fecha;
          nombreMin:= aux.nombre;
        end;
        read(mae,aux);
      end;
      while (aux.fecha = f) do begin
        cod:= min.cod;
        while (aux.cod < cod) do begin
          if (aux.vendidos > maxV) then begin
            maxV:= aux.vendidos;
            fechaMax:= aux.fecha;
            nombreMax:= aux.nombre
          end;
          if (aux.vendidos < minV) then begin
            minV:= aux.vendidos;
            fechaMin:= aux.fecha;
            nombreMin:= aux.nombre;
          end;
          read(mae,aux);
        end;
        while (aux.fecha = f) and (aux.cod = cod) do begin
          aux.vendidos:= aux.vendidos + min.vendidos;
          minimo(d,r,min);
        end; 
        seek(mae,filepos(mae)-1);
        write(mae,aux);
        if (aux.vendidos > maxV) then begin
            maxV:= aux.vendidos;
            fechaMax:= aux.fecha;
            nombreMax:= aux.nombre
        end;
        if (aux.vendidos < minV) then begin
            minV:= aux.vendidos;
            fechaMin:= aux.fecha;
            nombreMin:= aux.nombre;
        end;
      end;
    end;
    writeln('----------------');
    writeln('Semanario con mas ventas: Fecha: ', fechaMax, ' nombre: ', nombreMax);
    writeln('Semanario con menos ventas: Fecha: ', fechaMin, ' nombre: ', nombreMin);
    close (mae);
    for i:= 1 to df do close (d[i]);
  end;
  
var mae: maestro; d: detalles;
begin
  assign (mae,'prac2ej16Mae.pas');
  actualizarMaestro(mae,d);
end.
