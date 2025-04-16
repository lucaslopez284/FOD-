program ej14;

const 

  alto = 'ZZZZZ';
  
type
  
  infoMae = record
    destino : string;
    fecha: string;
    hora: integer;
    disponibles: integer;
  end;
  
  infoDet = record
    destino: string;
    fecha: string;
    hora: integer;
    comprados: integer;
  end;
  
  detalle = file of infoDet;
  maestro = file of infoMae;
  
  procedure leer (var arc: detalle;  var dato: infoDet);
  begin
    if (not eof (arc)) then read(arc,dato)
    else dato.destino:= alto;
  end;
  
  procedure minimo (var det1: detalle; var det2:detalle; var min: infoDet; var r1: infoDet; var r2: infoDet);
  begin
    if (r1.destino < r2.destino) then begin
      min:= r1;
      leer(det1,r1);
    end
    else begin
      min:= r2;
      leer(det2,r2);
    end;
  end;
   
  
  procedure actualizarMaestro(var mae: maestro; var det1: detalle; var det2:detalle);
  var aux: infoMae; cant: integer; r1,r2,min: infoDet; texto: text;
  begin
    writeln('Ingrese cantidad disponible');
    readln(cant);
    assign (mae,'prac2ej14Mae.dat');
    assign (det1,'prac2ej14Det1.dat');
    assign (det2,'prac2ej14Det2.dat');
    assign (texto,'prac2ej14Texto.txt');
    reset(mae);
    reset(det1);
    reset(det2);
    minimo(det1,det2,min,r1,r2);
    while (min.destino <> alto) do begin
      read(mae,aux);
      while (aux.destino < min.destino) do read(mae,aux);
      while ((aux.destino = min.destino) and (aux.fecha < min.fecha))do read(mae,aux);
      while ((aux.destino = min.destino) and (aux.fecha = min.fecha)and (aux.hora < min.hora)) do read(mae,aux);
      while ((aux.destino = min.destino) and (aux.fecha = min.fecha)and (aux.hora = min.hora)) do begin
        aux.disponibles:= aux.disponibles - min.comprados;
        minimo(det1,det2,min,r1,r2);
      end;
      seek(mae,filepos(mae)-1);
      write(mae,aux);
      if (aux.disponibles < cant) then
        write(texto, aux.destino,'', aux.fecha,'', aux.hora);
    end;
    close(mae);
    close(det1);
    close(det2);
    close(texto);
  end;
var mae: maestro; det1,det2:detalle;
begin
  actualizarMaestro(mae,det1,det2);
end.
