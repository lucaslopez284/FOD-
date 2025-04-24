program ej2;
type
    asistente = record
        numero: integer;
        apellido: string;
        nombre: string;
        email: string;
        telefono: string;
        dni: integer;
    end;
    archivo = file of asistente;
procedure leerAsistente(var a: asistente);
begin  
    writeln('Ingrese un numero del asistente');
    readln(a.numero);
    if(a.numero <> -1) then
        begin
            writeln('Ingrese el apellido del asistente');
            readln(a.apellido);
            writeln('Ingrese el nombre del asistente');
            readln(a.nombre);
            writeln('Ingrese el email del asistente');
            readln(a.email);
            writeln('Ingrese el telefono del asistente');
            readln(a.telefono);
            writeln('Ingrese el dni del asistente');
            readln(a.dni);
        end;
end;
procedure crearArchivo(var arc: archivo);
var
    a: asistente;
begin
    assign(arc, 'prac3ej2.dat');
    rewrite(arc);
    leerAsistente(a);
    while(a.numero <> -1) do
        begin
            write(arc, a);
            leerAsistente(a);
        end;
    close(arc);
end;
procedure imprimirAsistente(a: asistente);
begin
    writeln('Numero: ', a.numero, ' Apellido: ', a.apellido, ' Nombre: ', a.nombre, ' DNI: ', a.dni);
end;
procedure imprimirArchivo(var arc: archivo);
var
    a: asistente;
begin
    reset(arc);    
    while(not eof(arc)) do
        begin
            read(arc, a);
            imprimirAsistente(a);
        end;
    close(arc);
end;

procedure bajaLogica (var arc: archivo);
var a:asistente;
begin
  reset (arc);
  while (not eof(arc)) do begin
    read(arc,a);
    if (a.numero < 1000) then begin
      a.nombre:= '@' + a.nombre;
      seek(arc,filepos(arc)-1);
      write(arc,a);
    end;
  end;
  close(arc);
end;

var
    arc: archivo;
begin
    crearArchivo(arc);
    writeln('Archivo original:');
    imprimirArchivo(arc);
    bajaLogica(arc);
    writeln('Archivo baja logica:');
    imprimirArchivo(arc);
end.
