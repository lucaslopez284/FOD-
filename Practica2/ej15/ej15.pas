program ej15;
const
  alto = 9999;
  df = 10;
type 
  infoMae = record
    codProvincia : integer;
    provincia: string;
    codLocalidad: integer;
    localidad: integer;
    sinLuz: integer;
    sinGas: integer;
    deChapa: integer;
    sinAgua: integer;
    sinSanitarios: integer;
  end;
  
  infoDet = record
    codProvincia : integer;
    codLocalidad: integer;
    conLuz: integer;
    construidas: integer;
    conAgua: integer;
    conGas: integer;
    entregaSanitarios: integer;
  end;
  
  maestro = file of infoMae;
  detalle = file of infoDet;
  detalles = array [1..df] of detalle;
  registros = array [1..df] of infoDet;
  
  procedure leer (var arc: detalle;  var dato: infoDet);
  begin
    if (not eof (arc)) then read(arc,dato)
    else dato.codProvincia:= alto;
  end;
   
  procedure minimo(var d:detalles; var r: registros; var min: infoDet);
  var i,pos: integer;
  begin
    min.codProvincia:= alto;
    min.codLocalidad:= alto;
    for i:= 1 to df do begin
      if (r[i].codProvincia < min.codProvincia) or ((r[i].codProvincia = alto)and (r[i].codLocalidad < min.codLocalidad)) then begin
        pos:= i;
        min:= r[i];
      end;
    end;
    leer(d[pos], r[pos]);
  end;
   
  procedure actualizarMaestro(var mae : maestro ;var d: detalles);
  var i: integer; r: registros; min: infoDet; aux: infoMae; loc,pro,cant: integer;
  begin
    assign (mae,'prac2ej15Mae.dat');
    reset (mae);
    for i:= 1 to df do begin
      reset (d[i]);
      leer(d[i],r[i]);
    end;
    minimo(d,r,min);
    cant:= 0;
    writeln('------------------------------------------'); 
    while (min.codProvincia <> alto) do begin
      pro:= min.codProvincia;
      read(mae,aux);
      while (aux.codProvincia < pro) do begin
         if (aux.deChapa = 0) then cant:= cant + 1;
         read(mae,aux);
      end;
      while (min.codProvincia = pro)do begin
          loc:= min.codLocalidad;
          while(aux.codLocalidad < loc) do begin
             if (aux.deChapa = 0) then cant:= cant + 1;
             read (mae,aux);
          end;
          while (min.codProvincia = pro) and (min.codLocalidad = loc) do begin
            aux.sinluz:= aux.sinLuz - min.conLuz;
            aux.sinGas:= aux.sinGas - min.conGas;
            aux.sinAgua:= aux.sinAgua - min.conAgua;
            aux.deChapa:= aux.deChapa - min.construidas;
            aux.sinSanitarios:= aux.sinSanitarios - min.entregaSanitarios;
            minimo(d,r,min);
          end; 
        seek(mae,filepos(mae)-1);
        write(mae,aux);
        if (aux.deChapa = 0) then cant:= cant + 1;
      end;
    end;
    writeln('------------------------------------------');
    writeln('Cantidad de localidades sin viviendas de chapa: ', cant);
    close (mae);
    for i:= 1 to df do close(d[i]);
  end;

var mae: maestro; d: detalles;
begin
  actualizarMaestro(mae,d);
end.
