import 'item.dart';

class Majalah extends Item {
  String edisi;

  Majalah({
    required this.edisi,
    required super.judul,
    required super.pengarang,
  });
}
