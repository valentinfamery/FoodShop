import 'package:floor/floor.dart';

@entity
class ProductFloor {
  @primaryKey
  final int id;

  final String name;

  ProductFloor(this.id, this.name);
}
