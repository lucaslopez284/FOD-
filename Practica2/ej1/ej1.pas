program ej1;
const alto = 999;

type
 empleado = record
    cod: integer;
    nombre: String [20];
    monto: real;
  end;
  
  archivo= file of empleado;
  
  
  procedure leer (var d: archivo; var e: empleado);
  begin
    if (not eof (d)) then
      read(d,e)
    else e.cod := alto; 
  end; 
  
  procedure imprimirArchivo (var arc: archivo);
  var e: empleado;
  begin
    assign (arc,'maestro1.dat');
    reset (arc);
    writeln('Listado de empleados');
    while (not eof(arc)) do begin
      read(arc,e);
      writeln('Codigo ' , e.cod, ', monto ' , e.monto:2:2 , ', nombre ' , e.nombre);
    end;
    close (arc);
  end;
  
  procedure compactar (var det: archivo; var texto: Text);
  var e: empleado;
  begin
    assign (det,'detalle1.dat');
    reset (texto);
    rewrite(det);
    while (not eof (texto)) do begin
      with e do readln(texto,cod,monto,nombre);
      write(det,e);
    end;
    writeln('Archivo binario creado');
    close (det);
    close (texto);
  end;
  
  procedure nuevoArchivo(var mae: archivo; var det: archivo);
  var e, aux, eTotal:empleado;  total: real;
  begin
    assign (det,'detalle1.dat');
    assign (mae,'maestro1.dat');
    reset(det);
    rewrite(mae);
    leer(det,e);
    while (e.cod <> alto) do begin
      aux := e;
      total:= 0;
      while (aux.cod = e.cod) do begin
        total:= total + e.monto;
        leer(det,e);
     end;
     eTotal:= aux;
     eTotal.monto:= total;
     write(mae, eTotal);
     writeln('cargado empleado de codigo ' , aux.cod);
    end;
    close (mae);
    close(det);
  end;
  
var det: archivo; mae: archivo; carga: Text;
begin
  assign(carga, 'empleados.txt');
  writeln('---');
  compactar(det,carga);
  nuevoArchivo(mae,det);
  imprimirArchivo(mae);
end.
