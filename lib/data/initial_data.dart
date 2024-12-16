import 'package:flutter_application_3/buku.dart';
import 'package:flutter_application_3/majalah.dart';
import 'package:flutter_application_3/item.dart';

class InitialData {
  static List<Item> getInitialItems() {
    return [
      Buku(
        isbn: "978-602-8519-93-9",
        judul: "Laskar Pelangi",
        pengarang: "Andrea Hirata",
      ),
      Buku(
        isbn: "979-3062-92-4",
        judul: "Bumi Manusia",
        pengarang: "Pramoedya Ananta Toer",
      ),
    
      Majalah(
        edisi: "Edisi 45 - Jan 2024",
        judul: "Geographic Indonesia",
        pengarang: "National Geographic",
      ),
      Majalah(
        edisi: "Edisi 234 - Des 2023",
        judul: "Tempo",
        pengarang: "Tempo Media Group",
      ),
    ];
  }
}
