import 'dart:convert';

void main(){
  // final wolverine = new Heroe(nombre: "Logan", poder: "Regeneración");
  final rawJson = '{"nombre": "Logan", "poder": "Regeneración"}';
  
  Map parsedJson = json.decode(rawJson);
  print(parsedJson);
  
  final wolverine = new Heroe.fromJson(parsedJson);
  
  
  print(wolverine);
  print(wolverine.nombre);
  print(wolverine.poder);
}

class Heroe{
  String nombre;
  String poder;
  
  Heroe({this.nombre, this.poder});
  
  Heroe.fromJson( Map parsedJson){
    nombre = parsedJson['nombre'];
    poder = parsedJson['poder'];
  }
  
  String toString() => 'nombre: $nombre - poder: $poder';
}
