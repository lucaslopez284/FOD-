program ej2;

const M = 43 // orden del arbol

type

  alumno = record
    nombre: string;
    apellido: string;
    dni: string;
    legajo: integer;
    ingreso: integer;
  end;
  
  nodo = record
    cantClaves: integer;
    claves: array [1..M-1] of integer;
    enlaces: array [1..M-1] of integer;
    hijos: array [1..M] of integer;
  end;
  
  archivo = file of alumno
  arbolB = file of nodo;
  
var
    arc: archivo;
    indice: arbolB;
    
  {
    Punto B: 
    
      N = (M-1) * A + (M-1) * B +  M * C + D
      512 = (M-1) * 4 + (M-1) * 4 + M * 4 + 4
      512 = (M-1) * 4 + (M-1) * 4 + 4M + 4
      512 = 4M - 4 + 4M - 4 + 4M + 4
      512 = 12M - 4
      512 + 4 = 12M
      516 = 12M
      516 : 12 = M
      42.6 = M
      
    En un nodo del arbol B entrarian 42 registros persona, al ser un arbol B de orden 43. 
  }
  
  
  {C. Incrementar el orden del árbol B significa aumentar la cantidad de registros que caben en un nodo, en este caso índices a registros, 
en consecuencia, esto implica que nuestro árbol sea menos profundo, y que se requieran menos accesos (lecturas) a los nodos.}

{D. Se busca en el árbol la clave con DNI 12345678, aprovechando el criterio de orden, moviéndonos a la izquierda si es menor o igual, y en caso 
contrario, a la derecha. Una vez hallada la clave, uso el NRR guardado en el enlace para buscar el registro en el archivo de datos.}

{E. Si se deseara buscar un alumno por su numero de legajo se deberia realizar una búsqueda secuencial hasta encontrar el alumno con el legajo
solicitado. No tendría sentido en este caso, usar el índice que organiza el acceso al archivo de alumnos por DNI. Para brindar acceso indizado
al archivo de alumnos por número de legajos, lo más conveniente sería armar un nuevo árbol B pero con criterio de orden en base al legajo.}

{F. El problema al buscar los alumnos que tienen DNI en el rango entre 40000000 y 45000000 es que debe acceder n veces al arbol segun la cantidad n de alumnos 
que cumplan con la condicion y se encuentren registrados.}

