void main(){
  final wolverine = new Heroe(nombre: "Logan", poder: "Regeneración");
  
  print(wolverine);
  print(wolverine.nombre);
  print(wolverine.poder);
}

class Heroe{
  String nombre;
  String poder;
  
  Heroe({String nombre, String poder}){
    this.nombre = nombre;
    this.poder = poder;
  }
  
  String toString(){
    return 'nombre: ${this.nombre} - poder: ${this.poder}';
  }
}
