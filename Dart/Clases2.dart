void main(){
  final wolverine = new Heroe(nombre: "Logan", poder: "Regeneración");
  
  print(wolverine);
  print(wolverine.nombre);
  print(wolverine.poder);
}

class Heroe{
  String nombre;
  String poder;
  
  Heroe({this.nombre, this.poder});
  
  String toString() => 'nombre: $nombre - poder: $poder';
}
