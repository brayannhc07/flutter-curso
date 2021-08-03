void main() {
  String mensaje = saludar(texto: 'Hola', nombre: 'Fernando');
  print(mensaje);
}

String saludar({String texto, String nombre}){
  // print('Hola');
  return "$texto $nombre";
}

String saludar2({String texto, String nombre}) => "$texto $nombre";
