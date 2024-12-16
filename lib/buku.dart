import 'item.dart';

class Buku extends Item {
  String isbn;

  Buku({
    required this.isbn,
    required super.judul,
    required super.pengarang,
  });
}
