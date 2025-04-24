program ej6;

const alto = 9999;
 
type 

  prenda = record
    cod: integer;
   // desc: string [50];
   // colores: string [30];
   // tipo: string [20];
    stock: integer;
    precio: real;
  end;
  
  maestro = file of prenda;
  detalle = file of integer;
  
  
  procedure leerPrenda (var p: prenda);
  begin
    writeln('Inserte codigo');
    readln(p.cod);
    if (p.cod > 0) then begin
      p.stock:= Random (100) + 10;
      p.precio:= (Random (100) + 10) / (Random (5) + 2 );
    end;
  end;
  
  procedure imprimirPrenda(p: prenda);
  begin
    writeln('Codigo: ', p.cod, ' Stock: ', p.stock, ' Precio: ' , p.precio:2:2);
  end;
   
  procedure imprimirArchivoMaestro(var mae: maestro);
  var p: prenda;
  begin
    assign (mae,'prendas.dat');
    reset(mae);
    writeln('-------------Impresion de prendas------------');
    while (not eof(mae)) do begin
      read(mae,p);
      imprimirPrenda(p);
    end;
    writeln('------------------Finalizo la impresion-------------');
    close(mae);
  end;
  
  { si, lo se. se repite el codigo y el proceso es el mismo. lo unico que cambia es el assign }
  
  procedure imprimirArchivoNuevo(var arc: maestro);
  var p: prenda;
  begin
    assign (arc,'prendasNue.dat');
    reset(arc);
    writeln('-------------Impresion de prendas------------');
    while not (eof(arc)) do begin
      read(arc,p);
      imprimirPrenda(p);
    end;
    writeln('------------------Finalizo la impresion-------------');
    close(arc);
  end;
  
  procedure crearArchivoMaestro(var mae: maestro);
  var p: prenda;
  begin
    assign (mae,'prendas.dat');
    rewrite(mae);
    writeln('-------------Creacion archivo maestro------------');
    leerPrenda(p);
    while (p.cod > 0) do begin
      write(mae,p);
      leerPrenda(p);
    end;
    writeln('-------------Finalizo la carga------------');
    close(mae);
  end;
  
  procedure crearArchivoDetalle(var det: detalle);
  var cod: integer;
  begin
    assign (det,'prendasDetalle.dat');
    rewrite(det);
    writeln('-------------Creacion archivo detalle------------');
    writeln('Ingrese codigo');
    readln(cod);
    while (cod > 0) do begin
      write(det,cod);
      writeln('Ingrese codigo');
      readln(cod);
    end;
    writeln('-------------Finalizo la carga------------');
    close(det);
  end;
   
  procedure actualizarArchivo(var mae: maestro; var det: detalle);
  var p: prenda; cod: integer;
  begin
    assign (mae,'prendas.dat');
    assign (det,'prendasDetalle.dat');
    reset(mae);
    reset(det);
    while (not eof(det)) do begin
      read(mae,p);
      read(det,cod);
      while (p.cod < cod) do begin
        read(mae,p);
      end;
      seek(mae,filepos(mae) - 1);
      p.cod:= p.cod * (-1);
      write(mae,p);
    end;
    close(mae);
    close(det);  
  end;
  
  procedure exportar (var mae: maestro; var arc: maestro);
  var p: prenda;
  begin
    assign (mae,'prendas.dat');
    assign (arc,'prendasNue.dat');
    reset(mae);
    rewrite(arc);
    while (not eof(mae)) do begin
      read(mae,p);
      if (p.cod > 0) then
        write(arc,p);
    end;
    close(mae);
    close(arc);
  end;

var mae,arc: maestro; det: detalle;

begin
  crearArchivoMaestro(mae);
  crearArchivoDetalle(det);
  imprimirArchivoMaestro(mae);
  actualizarArchivo(mae,det);
  exportar(mae,arc);
  imprimirArchivoNuevo(arc);
end.
