program ej13;

const alto = 999;

type
  
  infoMae = record
    numUsuario: integer;
    usuario: String;
    nombre: string;
    apellido: string;
    cant: integer;
  end;
  
  infoDet = record
    numUsuario: integer;
    cuentaDestino: string;
    cuerpoMensaje: string;
  end;
  
  maestro = file of infoMae;
  detalle = file of infoDet;
  
  procedure leer (var arc: detalle;  var dato: infoDet);
  begin
    if (not eof (arc)) then read(arc,dato)
    else dato.numUsuario:= 999;
  end;
  
  procedure actualizarMaestro(var mae: maestro; var det: detalle);
  var auxM: infoMae; auxD: infoDet; n: integer; texto: text;
  begin
    assign (mae, 'prac2ej13Mae.dat');
    assign (det, 'prac2ej13Det.dat');
    assign(texto, 'usuarios2.txt');
    reset (mae);
    reset (det); 
    rewrite(texto);
    leer(det,auxD);
    while (auxD.numUsuario <> alto) do begin
      read (mae, auxM);
      while (auxM.numUsuario < auxD.numUsuario) do read(mae,auxM);
      n:= auxD.numUsuario;
      while (n = auxD.numUsuario) do begin
        auxM.cant:= auxM.cant + 1;
        leer(det,auxD);
      end;
      seek (mae,filepos(mae)-1);
      write(mae,auxM);
      writeln(texto,auxM.usuario, ' ' , auxM.cant);
    end;
    reset(texto);
    close(mae);
    close(det);
  end;

var mae: maestro; det: detalle;

begin
  actualizarMaestro(mae,det);
end.
