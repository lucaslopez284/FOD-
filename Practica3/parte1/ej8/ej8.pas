program ej8;

const alto = 9999;

type 
  distribucion = record
    nombre: string[20];
    anio: integer;
    version: integer;
    cant: integer;
    desc: string [50];
  end;
  
  archivo = file of distribucion;
  
  procedure imprimirDistribucion(d: distribucion);
  begin
    writeln('Nombre: ' , d.nombre, ' Lanzamiento: ', d.anio, ' Version: ', d.version, ' Cantidad de desarrolladores ' , d.cant, ' Descripcion ', d.desc);
  end;
  
  procedure imprimirArchivo(var arc: archivo);
  var d: distribucion;
  begin
    assign (arc, 'distribuciones.dat');
    reset(arc);
    writeln('----------------LISTADO DE DISTRIBUCIONES-------------');
    while (not eof(arc)) do begin
      read(arc,d);
      imprimirDistribucion(d);
    end;
    close(arc);
  end;
  
  procedure leerDistribucion(var d: distribucion);
  begin
    writeln('-------------Inicio lectura de distribucion --------------');
    writeln('Inserte nombre');
    readln(d.nombre);
    if (d.nombre <> 'zzz') then begin
      d.anio:= Random (25) + 2000;
      d.version:= Random (5) + 1;
      d.cant:= Random(10) + 4;
      d.desc:= 'Mejor que la anterior'; 
    end;
    writeln('-------------Finalizo lectura de distribucion --------------');
  end;
  
  procedure crearArchivo(var arc: archivo);
  var d: distribucion;
  begin
    assign (arc, 'distribuciones.dat');
    rewrite(arc);
    d.nombre:= '';
    d.anio:= 0;
    d.version:= 0;
    d.cant:= 0;
    d.desc:= ''; 
    write(arc,d);
    leerDistribucion(d);
    while (d.nombre <> 'zzz') do begin
      write(arc,d);
      leerDistribucion(d);
    end;
    close(arc);
  end;
  
  procedure buscarDistribucion (var arc: archivo; var pos: integer;nom: string);
  var d:distribucion;
  begin
    pos:= -1;
    assign (arc, 'distribuciones.dat');
    reset(arc);
    while ((not eof(arc)) and (pos = -1)) do begin
      read(arc,d);
      if (d.nombre = nom) then
        pos:= filepos(arc) - 1;
    end;
    close(arc);
    if (pos <> -1) then writeln('La distribucion se encontro en la posicion ', pos)
    else writeln('No se encontro la distribucion ');
  end;
  
  procedure altaDistribucion (var arc: archivo);
  var dis,aux: distribucion; pos: integer; 
  begin
    leerDistribucion(dis);
    buscarDistribucion(arc,pos,dis.nombre);
    if (pos = -1) then begin
      assign (arc, 'distribuciones.dat');
      reset(arc);
      read(arc,aux);
      if (aux.cant < 0) then begin
        pos:= aux.cant *(-1);
        seek(arc,pos);
        read(arc,aux);
        seek(arc,pos-1);
        write(arc,dis);
        seek(arc,0);
        write(arc,aux);
      end
      else begin
        seek(arc,filesize(arc));
        write(arc,dis);
      end;
      writeln('Distribucion insertada');
      close(arc);
    end
    else writeln('Ya existe la distribución');
  end; 
  
  procedure bajaDistribucion(var arc: archivo);
  var dis,aux: distribucion; pos: integer; 
  begin
    leerDistribucion(dis);
    buscarDistribucion(arc,pos,dis.nombre);
    if (pos > -1) then begin
      assign (arc, 'distribuciones.dat');
      reset(arc);
      read(arc,aux);
      seek(arc,pos);
      read(arc,dis);
      seek(arc,pos);
      write(arc,aux);
      seek(arc,0);
      dis.cant:= pos *(-1);
      write(arc,dis);
      close(arc);
    end;
  
  end;
  
  
var arc: archivo; 
begin
  Randomize;
  crearArchivo(arc);
  imprimirArchivo(arc);
  
  altaDistribucion(arc);
  imprimirArchivo(arc);
  
  bajaDistribucion(arc);
  imprimirArchivo(arc);
  
end.
