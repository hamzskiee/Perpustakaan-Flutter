abstract class Item {
  String judul;
  String pengarang;
  bool tersedia;

  Item({
    required this.judul,
    required this.pengarang,
    this.tersedia = true,
  });
}
