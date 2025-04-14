program ej7;

 type 
 
   novela = record
     cod: integer;
     precio: real;
     genero: String;
     nombre: String
   end;
   novela2 = record
     precio: real;
     genero: String;
     nombre: String
   end;
   
   archivo = file of novela;
   
   procedure leerNovela(var n: novela);
   begin 
     writeln('Comienzo lectura de novela ');
     writeln('Ingrese codigo de novela');
     readln(n.cod);
     writeln('Ingrese precio de novela');
     readln(n.precio);
     writeln('Ingrese genero de novela');
     readln(n.genero);
     writeln('Ingrese nombre de novela');
     readln(n.nombre);
     writeln('Finalizo lectura de novela');
   end;
   procedure leerNovela2(var n: novela2);
   begin 
     writeln('Comienzo lectura de novela ');
     writeln('Ingrese precio de novela');
     readln(n.precio);
     writeln('Ingrese genero de novela');
     readln(n.genero);
     writeln('Ingrese nombre de novela');
     readln(n.nombre);
     writeln('Finalizo lectura de novela');
   end; 
   
   procedure asignar (var n: novela; n2: novela2);
   begin
     n.precio:= n2.precio;
     n.genero:= n2.genero;
     n.nombre:= n2.nombre;
   
   end;
   
   procedure imprimirNovela (n: novela);
   begin
     writeln('Codigo ', n.cod, ' , precio: ', n.precio:2:2, ' , genero ', n.genero, ' , nombre ' , n.nombre);
   end;
   
   procedure imprimirArchivo (var logico: archivo);
   var n: novela;
   begin
     reset (logico);
     writeln('-------------Listado de novelas--------------');
     while (not eof (logico)) do begin
       read (logico,n);
       imprimirNovela(n);
     end;
     writeln('-------------Fin del listado de novelas--------------');
   end;
   
   procedure nuevoArchivoBinario (var logico: archivo; var nom: String);
   var n: novela; texto: Text;
   begin
     writeln('Inserte nombre para el archivo binario');
     readln(nom);
     assign (logico,nom);
     assign (texto, 'novelas.txt');
     reset (texto);
     rewrite(logico);
     while (not eof (texto)) do begin
       with n do begin
         readln(texto,cod,precio,genero);
         readln(texto,nombre);
       end;
     end;
     writeln('FINALIZO LA CARGA DE DATOS');
     close(logico);
     close(texto);
   end;
   
   procedure agregarNovela (var logico: archivo);
   var n: novela;
   begin
     leerNovela(n);
     reset(logico);
     seek(logico,filesize(logico));
     write(logico,n);
     close (logico);
     imprimirArchivo(logico);
   end; 
   
   procedure modificarNovela (var logico: archivo);
   var n: novela; n2: novela2; esta: boolean; cod: integer;
   begin
     reset (logico); 
     esta:= false;
     write('Ingrese codigo de novela a modificar: '); 
     readln(cod);
     while ((not eof (logico)) and (esta = false)) do begin
       read(logico, n);
       if (n.cod = cod) then begin
         leerNovela2(n2);
         asignar(n,n2);
         seek(logico, filepos(logico)-1);
         write(logico,n);
         esta:= true;
         writeln('Modificacion realizada');
       end;
       
     end;
     if (esta = false) then writeln('Codigo de novela inexistente');
     imprimirArchivo(logico);
   end;
   
   procedure actualizar (var logico: archivo; nom: String);
   var op: integer; 
   begin
     op:= 3;
     assign (logico,nom);
     imprimirArchivo(logico);
     while (op <> 99) do begin
       writeln('MENU DE OPCIONES ');
       writeln('1: agregar novela');
       writeln('2: modificar novela');
       readln(op);
       case op of
         1: agregarNovela(logico);
         2: modificarNovela(logico);
         99: writeln('Programa finalizado.');
       else
         writeln('(!) ERROR: Opcion incorrecta');
       end;
   end;
  end;
  
  
var a: archivo; nom: string;
begin
  nuevoArchivoBinario(a,nom);
  actualizar(a,nom);
end.
