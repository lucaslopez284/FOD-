program ej1;

const M = 8 // orden del arbol

type

  alumno = record
    nombre: string;
    apellido: string;
    dni: string;
    legajo: integer;
    ingreso: integer;
  end;
  
  nodo = record
    cantDatos: integer;
    datos: array [1..M-1] of alumno;
    hijos: array [1..M] of integer;
  end;
  
  arbolB = file of nodo;
  
var
    archivoDatos: arbolB;
    
  {
    Punto B: 
    
      N = (M-1) * A + M * B + C
      512 = (M-1) * 64 + M * 4 + 4
      512 = (M-1) * 64 + 4M + 4
      512 = 64M - 64 + 4M + 4
      512 = 68M - 68
      512 + 68 = 68M
      580 = 68M
      580 : 68 = M
      8.5 = M
      
    En un nodo del arbol B entrarian 7 registros persona, al ser un arbol B de orden 8. 
  }
  
  
  {C. El valor de M determina la cantidad máxima de claves y de hijos que puede tener un nodo en el árbol B. Un valor mayor de 
M resultará en nodos más grandes y, por lo tanto, en una estructura de árbol B más ancha y menos profunda. Por otro lado, un valor menor de 
M resultará en nodos más pequeños y en una estructura de árbol B más profunda pero más estrecha.}

{D. Los datos que seleccionaría como clave de identificación para organizar los elementos en el árbol B serían tanto el DNI como el legajo
ya que ambos son campos únicos de alumnos de la Facultad.}

{E. En el mejor de los casos, se necesita de una única lectura para encontrar un alumno por su clave de identificación.
En el peor de los casos, se necesita de h lectureas (con h altura del árbol).}

{F. Si se desea buscar un alumno por un criterio diferente se debe tener en cuenta el árbol por completo, siendo necesarias n lecturas en el 
peor de los casos, siendo n la cantidad total de nodos que hay en el árbol.}


