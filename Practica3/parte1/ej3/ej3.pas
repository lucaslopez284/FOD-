program ej3;

type
   
   novela = record
     cod: integer;
     gen: string [20];
     nombre: string [20];
     duracion: real;
     director: string [20];
     precio: real;
   end;
   
   archivo = file of novela;
       
   procedure imprimirNovela(var n: novela);
   begin
     writeln('Codigo ', n.cod, ' Genero: ' , n.gen, ' Nombre: ', n.nombre, ' Duracion: ', n.duracion:2:2, ' Director: ', n.director, ' Precio ', n.precio:2:2);
   end;
   
   procedure leerNovela (var n: novela);
   begin
     writeln('----------Nueva novela -----------');
     writeln('Inserte codigo');
     readln(n.cod);
     if (n.cod> 0) then begin 
       n.gen:= 'literario';
       writeln('Inserte nombre');
       readln(n.nombre);
       n.duracion:= (Random (5) + 1);
       n.nombre:= 'Moretti';
       n.precio:= (Random (200) + 50) / (Random (20) + 25);
     end;
   end;
   
   procedure imprimirArchivo(var arc: archivo);
   var n: novela;
   begin
     assign (arc, 'prac3par1Arc.dat');
     reset (arc);
     writeln('---------------Impresion novelas-------------------');
     while (not eof(arc)) do begin
         read(arc,n);
         //if (n.cod > 0) then
           imprimirNovela(n);
     end;
     close(arc);
   end;
   
   procedure crearArchivo (var arc: archivo);
   var n: novela;
   begin
     assign (arc, 'prac3par1Arc.dat');
     rewrite(arc);
     n.cod:= 0;
     n.gen:= '';
     n.nombre:= '';
     n.duracion:= 0;
     n.director:= '';
     n.precio:= 0;
     write(arc,n);
     leerNovela(n);
     while (n.cod> 0) do begin
       write(arc,n);
       leerNovela(n);
     end;
     close(arc);
   end;
   
   procedure darDeAlta (var arc: archivo);
   var aux,nue: novela; pos: integer;
   begin
     reset(arc);
     leerNovela(nue);
     read(arc,aux);
     if (aux.cod < 0) then begin
       pos:= aux.cod * (-1);
       seek(arc,pos);
       read(arc, aux);
       seek(arc,filepos(arc)-1);
       write(arc,nue);
       seek(arc,0);
       write(arc,aux);
     end
     else begin
       seek(arc,filesize(arc));
       write(arc,nue);
     end;
     close(arc);
   end;
   
   procedure modificarNovela(var arc: archivo);
   var n,nue: novela; esta: boolean;
   begin
     reset(arc);
     writeln('Ingrese codigo de novela a modificar');
     readln(nue.cod);
     writeln('Ingrese genero');
     readln(nue.gen);
     writeln('Ingrese nombre');
     readln(nue.nombre);
     writeln('Ingrese duracion');
     readln(nue.duracion);
     writeln('Ingrese director');
     readln(nue.director);
     writeln('Ingrese precio');
     readln(nue.precio);
     esta:= false;
     while ((not eof (arc)) and (esta = false)) do begin
       read(arc,n);
       if (n.cod = nue.cod) then begin
         seek(arc,filepos(arc)-1);
         write(arc,nue);
         esta:= true;
       end;
     end;
     close (arc);
   end;
   
   procedure eliminarNovela(var arc: archivo);
   var aux,n: novela; encontre: boolean; pos,c: integer;
   begin
     reset (arc);
     writeln('Ingrese codigo de novela a eliminar');
     readln(c);
     encontre:= false;
     read(arc,aux);
     while (not eof(arc) and (encontre = false)) do begin
       read(arc,n);
       if (n.cod = c) then begin
         seek(arc,filepos(arc)-1);
         pos:= filepos(arc);
         write(arc,aux);
         seek(arc,0);
         aux.cod:= pos * (-1);
         write(arc,aux);
         encontre := true;
       end;
     end;
     close(arc);
   end;
   
   
   procedure opciones (var arc: archivo);
   var x: char;
   begin
     assign (arc, 'prac3par1Arc.dat');
     writeln('----------OPCIONES----------');
     writeln('A: Dar de alta una novela');
     writeln('B: Modificar una novela');
     writeln('C: Eliminar una novela');
     writeln('Seleccione cualquier otra tecla para finalizar la ejecucion de este inciso');
     readln(x);
     case x of
       'A': darDeAlta(arc);
       'B': modificarNovela(arc);
       'C': eliminarNovela(arc);
     else writeln('-------------CHAU-----------');
     end;
     if ((x = 'A') or (x = 'B') or (x = 'C')) then imprimirArchivo(arc);
     while ((x = 'A') or (x = 'B') or (x = 'C')) do begin
       writeln('----------OPCIONES----------');
       writeln('A: Dar de alta una novela');
       writeln('B: Modificar una novela');
       writeln('C: Eliminar una novela');
       writeln('Seleccione cualquier otra tecla para finalizar la ejecucion de este inciso');
       readln(x);
       case x of
         'A': darDeAlta(arc);
         'B': modificarNovela(arc);
         'C': eliminarNovela(arc);
        else writeln('-------------CHAU-----------');
       end;
       if ((x = 'A') or (x = 'B') or (x = 'C')) then imprimirArchivo(arc);
     end;
   end;
   
   
   
   
   
   procedure exportarATexto(var arc: archivo);
   var n: novela ;texto: text;
   begin
     assign (arc, 'prac3par1Arc.dat');
     assign (texto,'novelas.txt');
     reset(arc);
     rewrite(texto);
     while (not eof(arc)) do begin
       read(arc,n);
       writeln(texto,n.cod,'',n.duracion,'',n.precio);
       writeln(texto,n.gen);
       writeln(texto,n.nombre);
       writeln(texto,n.director);
     end;
     close(arc);
     close(texto);
   
   end;
   
   
var arc: archivo; x: char;
begin
  Randomize;
  writeln('----------MENU PRINCIPAL----------');
  writeln('A: Crear nuevo archivo de novelas');
  writeln('B: Modificar el archivo de novelas');
  writeln('C: Exportar a formato text el archivo de novelas');
  readln(x);
  case x of
   'A': crearArchivo(arc);      
   'B': opciones(arc);
   'C': exportarATexto(arc);
  end;
  imprimirArchivo(arc);
end.
