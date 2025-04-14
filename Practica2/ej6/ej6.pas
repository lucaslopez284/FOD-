program ej6;

const alto = 999;
      df = 5;

type
  recuento = record
    codLocalidad: integer;
    codCepa: integer;
    activos: integer;
    nuevos: integer;
    recuperados: integer;
    fallecidos: integer;
  end;
  
  archivo = file of recuento;
  reg = array [1..df] of recuento ;
  vector = array [1..df] of archivo;
  
  procedure leer (var arc: archivo; var dato: recuento); 
  begin
    if (not eof (arc)) then read (arc,dato)
    else dato.codLocalidad:= alto;
  end;
  
  procedure minimo (var vec: vector; var r: reg; var min: recuento);
  var i,pos: integer;
  begin
    min.codLocalidad:= alto;
    for i:= 1 to df do begin
      if (r[i].codLocalidad < min.codLocalidad) then begin
       pos:= i;
       min:= r[i];
    end; 
   end; 
   leer(vec[pos], r[pos]);
  end;
  
  procedure actualizarMaestro(var mae: archivo; var vec: vector);
  var i, cant: integer; aux,min: recuento; r: reg;
  begin
    cant:= 0;
    reset (mae);
    for i:= 1 to df do begin
      reset (vec[i]);
      leer(vec[i], r[i]);
    end;
    minimo (vec,r,min);
    read(mae,aux);
    while (min.codLocalidad <> alto) do begin
        while (aux.codLocalidad <> min.codLocalidad) do read (mae,aux);
        aux.nuevos:= 0;
        aux.activos:= 0;
        while (min.codLocalidad = aux.codLocalidad) and (min.codCepa = aux.codCepa) do begin
          aux.nuevos:= aux.nuevos + min.nuevos;
          aux.activos:= aux.activos + min.activos;
          aux.recuperados:= aux.recuperados + min.recuperados;
          aux.fallecidos:= aux.fallecidos + min.fallecidos;
          minimo (vec,r,min);
        end; 
        if (aux.activos > 50) then 
          cant:= cant + 1;
        seek(mae,filepos(mae) - 1);
        write(mae,aux);
    end;
    close (mae);
    for i:= 1 to df do close (vec[i]);
     writeln('La cantidad de localidades con mas de 50 casos activos es: ', cant);
  end;
  
var mae: archivo ; vec: vector;
begin
  assign (mae,'p2-maestro5.dat');
  actualizarMaestro(mae,vec);
end.
