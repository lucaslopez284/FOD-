program ej6;
type
  celular = record
    cod: integer;
    precio : real;
    marca: String [10];
    stockDis: integer;
    stockMin: integer;
    descripcion: String [30];
    nombre: String;
  end; 
  
  archivo = file of celular;
  
  procedure imprimirCelular (var c: celular);
  begin
    writeln('Codigo de celular ', c.cod, ' precio ' , c.precio:2:2 , ' marca ' , c.marca, ' stock disponible ' , c.stockDis, 
                  ' stock minimo ', c.stockMin , ' descripcion ' , c.descripcion , ' nombre ' , c.nombre);
  end;
  
  procedure leerCelular (var c: celular);
  begin
    writeln('Comienzo lectura de celular');
    writeln('Ingrese codigo ');
    readln(c.cod);
    writeln('Ingrese precio ');
    readln(c.precio);
    writeln('Ingrese marca ');
    readln(c.marca);
    writeln('Ingrese stock disponible ');
    readln(c.stockDis); 
    writeln('Ingrese stock minimo ');
    readln(c.stockMin);
    writeln('Ingrese descripcion');
    readln(c.descripcion);
    writeln('Ingrese nombre ');
    readln(c.nombre);
    writeln('Finalizo lectura de celular');
  end;
  
  procedure nuevoArchivoBinario (var logico: archivo; var texto: Text);
  var c: celular;
  begin
    assign (logico,'binarioCelulares.dat');
    assign (texto, 'celulares.txt');
    reset (texto);
    rewrite(logico);
    writeln('---Archivo inicializado---');
    while (not eof (texto)) do begin 
      with c do begin
       readln (texto,cod,precio,marca);
       readln(texto,stockDis, stockMin, descripcion);
       readln (texto,nombre);
      end;
      write(logico,c);
    end;
    writeln('---Archivo cargado---');
    readln; 
    close (logico); 
    close (texto);
  end;
  
  procedure listarFaltaStock(var logico: archivo);
  var c: celular;
  begin
    assign (logico,'binarioCelulares.dat');
    reset (logico);
    writeln('Listado de celulares con menor stock disponible que el minimo: ');
    while not eof (logico) do begin
       read (logico,c);
       if (c.stockDis < c.stockMin) then 
         imprimirCelular(c);
    end;
    close (logico);
  end;
  
  procedure cadenaDeCaracteres(var logico: archivo);
  var c: celular; d: string [30];
  begin
    assign (logico,'binarioCelulares.dat');
    reset (logico);
    writeln('Ingrese descripcion');
    readln(d);
    writeln('Listado de que coinciden con la descripcion anterior: ');
    while not eof (logico) do begin
       read (logico,c);
       if (c.descripcion = d) then 
         imprimirCelular(c);
    end;
    close (logico);
  end;
  
  procedure exportarATexto(var logico: archivo; var texto: Text);
  var c: celular;
  begin
    assign (logico,'binarioCelulares.dat');
    assign (texto, 'celulares.txt');
    reset (logico);
    rewrite(texto);
    while not eof (logico)do begin
      read (logico, c);
      imprimirCelular(c);
      with c do writeln(texto, 'Codigo de celular ', c.cod, ' precio ' , c.precio , ' marca ' , c.marca);
      with c do writeln(texto, ' stock disponible ' , c.stockDis, ' stock minimo ', c.stockMin , ' descripcion ' , c.descripcion );
      with c do writeln(texto, ' nombre ', c.nombre);
  end;
  
  close (logico);
  close (texto);
 end;
 
 procedure agregarAlFinal (var al: archivo; c: celular);
 var celu: celular;
 begin
   assign (al,'binarioCelulares.dat');
   reset (al);
   while (not eof (al)) do begin
     read (al,celu)
   end;
   write(al,c);
   close (al);
 end;
 
 procedure agregarCelulares(var al: archivo);
 var c: celular; cant,i: integer;
 begin
   writeln('Inserte la cantidad de celulares a agregar');
   readln(cant);
   for i:= 1 to cant do begin
     leerCelular(c);
     agregarAlFinal(al,c);
   end;
 
 end;
 
 
 procedure modificarStock (var al: archivo);
 var cod, cant: integer; esta : boolean; c: celular;
 begin
   writeln('Ingrese el codigo de celular a modificar ');
   readln(cod);
   writeln('Ingrese stock');
   readln(cant);
   assign (al,'binarioCelulares.dat');
   reset (al);
   esta:= false;
   while ((esta = false) and (not eof (al)))do begin
     read(al,c);
     if (c.cod = cod) then begin
       esta:= true;
       c.stockDis:= cant;
       seek (al,filepos(al)-1);
       write (al,c); 
     end;  
   end;
   close (al); 
 end;  
   
 procedure exportarSinStock(var al: archivo; var texto: Text);
 var c: celular;
 begin
   assign (al,'binarioCelulares.dat');
   assign (texto,'SinStock.txt');
   reset (al); 
   while (not eof (al)) do begin 
        read(al,c);
        if (c.stockDis = 0) then begin
          with c do writeln(texto, 'Codigo de celular ', c.cod, ' precio ' , c.precio , ' marca ' , c.marca);
          with c do writeln(texto, ' stock disponible ' , c.stockDis, ' stock minimo ', c.stockMin , ' descripcion ' , c.descripcion );
          with c do writeln(texto, ' nombre ', c.nombre);
        end;
   end;
   close (al); 
   close (texto);
 end;
  
var op: integer; al: archivo; texto: Text; 
begin

  writeln('------------MENU DE OPCIONES --------------');
  writeln('1: nuevo archivo de registros de celulares');
  writeln('2: listar celulares con stock menor al minimo');
  writeln('3: buscar celulares por cadena de descripcion');
  writeln('4: exportar el archivo binario a uno de texto');
  writeln('5: agregar celulares al archivo');
  writeln('6: modificar stock de un celular disponible');
  writeln('7: exportar productos sin stock a archivo de texto');
  readln(op);
  case op of
  1 : nuevoArchivoBinario(al,texto);
  2 : listarFaltaStock(al);
  3 : cadenaDeCaracteres(al);
  4: exportarATexto(al,texto);
  5: agregarCelulares(al);
  6: modificarStock(al);
  7: exportarSinStock(al,texto);
  else writeln('Opcion no valida');
  end;
end.
