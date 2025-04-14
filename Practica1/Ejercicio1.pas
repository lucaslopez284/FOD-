program archivo1;
 
type archivo = file of integer;
 
procedure cargarNumeros(var al: archivo);
  var n: integer;
  begin
    writeln('Ingrese numero');
    readln(n);
    while (n < 30000) do begin
      write(al,n);
      writeln('Ingrese numero');
      readln(n)
    end;
    
  end;


var al: archivo ;

  

begin
   assign(al, 'enteros.dat');
   rewrite (al);
   cargarNumeros(al);
   close (al);
end.

