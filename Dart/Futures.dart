void main(){
  print("Estamos a punto de pedir datos");
  httpGet('http://api.nasa.com/aliens').then( (data) {
    print(data);
  });
  print('Última línea');
}

Future<String> httpGet(String url) {
  return Future.delayed(new Duration(seconds: 4), () {
    return 'Hola Mundo';
  });
}

