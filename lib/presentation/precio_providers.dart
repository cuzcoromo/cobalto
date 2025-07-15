

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'precio_providers.g.dart';

class PrecioData{
  final double? iva;
  final double precio;
  PrecioData({this.iva, required this.precio});
}

@Riverpod(keepAlive: true)
class PrecioConsumo extends _$PrecioConsumo {
  @override
   PrecioData build() => PrecioData( precio: 1.0, iva: 0.0);

  void setprecio(double precio) {
    state = PrecioData(precio: precio, iva: state.iva);
  }
  void setPrecioIns(double iva){
    state = PrecioData(iva: iva, precio: state.precio);
  }
}
