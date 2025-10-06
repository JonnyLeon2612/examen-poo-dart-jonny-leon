import 'dart:async';
import 'dart:math';

abstract class Preparable{
  void Preparar();
}

abstract class Imprimible{
  String descripcion();
}

//classe padre
abstract class Bebida implements Preparable, Imprimible{
  String Nombre;
  double precio;
  String tamano;

  Bebida(this.Nombre, this.precio, this.tamano);
}


abstract class Bocado implements Preparable, Imprimible {
  String nombreBocadillo;
  double precioBocadillo;

  Bocado(this.nombreBocadillo, this.precioBocadillo);
}

//clase hijas aqui
class Pepsi extends Bebida{
  String sabor;

  Pepsi(this.sabor, String Nombre,double precio, String tamano): super(Nombre, precio, tamano);

  @override
  void Preparar(){
    print("Sirviendo su $Nombre $sabor...");
  }

  @override
  String descripcion(){
    return ("$Nombre de $tamano, de $sabor tiene un precio de: $precio");
  }
}

class Cafe extends Bebida{
String tipo;

Cafe(this.tipo, String Nombre,double Precio, String tamano):super(Nombre,Precio,tamano);

@override
void Preparar(){
  print("Preparando su $Nombre de tipo $tipo...");
}

@override
  String descripcion(){
    return("$Nombre de $tamano y de tipo $tipo, tiene un precio de: $precio");
  }
}

class Agua extends Bebida{
  String Marca;

  Agua(this.Marca,String Nombre,double precio, String tamano): super(Nombre,precio,tamano);

@override
void Preparar(){
    print("Sirviendo su $Nombre...");
}

@override
String descripcion(){
  return("$Nombre de $tamano y de tipo $Marca, tiene un precio de: $precio");
}
}

class Pan extends Bocado{
String tipoPan;

Pan(this.tipoPan, String nombreBocadillo, double precioBocadillo):super(nombreBocadillo, precioBocadillo);

@override
void Preparar(){
    print("Sirviendo su $nombreBocadillo...");
}

@override
String descripcion(){
  return "$nombreBocadillo de tipo $tipoPan, tiene un precio de: $precioBocadillo";
}
}

class Galletas extends Bocado{
String tipoGalletas;

Galletas(this.tipoGalletas, String nombreBocadillo, double precioBocadillo):super(nombreBocadillo, precioBocadillo);

@override
void Preparar(){
    print("Sirviendo su $nombreBocadillo...");
}

@override
String descripcion(){
  return "$nombreBocadillo de tipo $tipoGalletas, tiene un precio de: $precioBocadillo";
}
}

class Pedido {
  //idificador unico
  static int _contador = 0; 
  int id;
  List<dynamic> items = []; 

  Pedido() : id = ++_contador;

  void agregarItem(dynamic item) {
    items.add(item);
    print("agregado exitosamente a su pedido#$id: ${item.descripcion()}");
  }

  void mostrarPedido() {
    print("Contenido del pedido #$id:");
    for (var item in items) {
      print("${item.descripcion()}");
    }
  }

  Future<void> procesarPedido() async {
  print("preparación del pedido #$id en proceso...");
  var random = Random();

  for (var item in items) {
    int tiempo = random.nextInt(4) + 2;
    print("EN ESPERA Preparando ${item.descripcion()} (tardará $tiempo seg)");
    await Future.delayed(Duration(seconds: tiempo)); 
    item.Preparar(); 
    print(" LISTO ${item.descripcion()} lista!\n");
  }

  print("pedido #$id completado con exxito");
}

}

Stream<Pedido> flujoPedidos() async* {
  Random random = Random();

  while (true) { 

    await Future.delayed(Duration(seconds: random.nextInt(5) + 3));
    var pedido = Pedido();

    
    List<Bebida> bebidas = [
      Pepsi("Regular", "Pepsi", 3.5, "Grande"),
      Cafe("Espresso", "Café", 3.0, "Mediano"),
      Agua("Minalba", "Agua", 1.5, "Pequeño"),
      Pepsi("0", "Pepsi", 1.5, "Grande"),
      Cafe("Espresso", "Café", 3.0, "Grande"),
      Agua("Minalba", "Agua", 2.5, "Grande"),
      Pepsi("0", "Pepsi", 1.5, "Pequeño"),
      Cafe("Negro", "Café", 3.0, "Mediano"),
      Agua("De pila", "Agua", 0.0, "Pequeño"),
      Pepsi("0", "Pepsi", 2.5, "Mediano")
    ];

    List<Bocado> bocados = [
      Pan("Canilla", "Pan", 1.0),
      Galletas("Chocolate", "Galletas", 1.5),
      Pan("frances", "Pan", 0.5),
      Galletas("oreo", "Galletas", 2.0),
      Galletas("charmy", "Galletas", 1.5),
      Pan("pata de gato", "Pan", 1.0),
      Galletas("fresa", "Galletas", 1.5),
      Pan("arequipe", "Pan", 3.0),
      Galletas("vainilla", "Galletas", 1.5)
    ];

    var bebidaRandom = bebidas[random.nextInt(bebidas.length)];
    var bocadoRandom = bocados[random.nextInt(bocados.length)];

    pedido.agregarItem(bebidaRandom);
    pedido.agregarItem(bocadoRandom);

    yield pedido; 
  }
}

void main() async {
  print("Bienvenidos a la cafeteria HOLLYWOD");

  await for (Pedido pedido in flujoPedidos()) {
    pedido.mostrarPedido();
    await pedido.procesarPedido();
  }
}
