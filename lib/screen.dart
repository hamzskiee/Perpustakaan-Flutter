import 'package:flutter/material.dart';
import 'item.dart';
import 'buku.dart';
import 'majalah.dart';
import 'perpustakaan_service.dart';
import 'package:flutter_application_3/widget/item_card.dart';
import 'package:flutter_application_3/widget/item_form.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PerpustakaanService _perpustakaanService = PerpustakaanService();
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _pengarangController = TextEditingController();
  final _identifierController = TextEditingController();
  bool _isBuku = true;

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_isBuku ? 'Tambah Buku' : 'Tambah Majalah',
        style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: _isBuku ? Colors.blue : Colors.green, 
          ),
        ),
        content: ItemForm(
          isBuku: _isBuku,
          judulController: _judulController,
          pengarangController: _pengarangController,
          identifierController: _identifierController,
          onTypeChanged: (value) {
            setState(() {
              _isBuku = value;
              Navigator.pop(context);
              _showAddDialog();
            });
          },
          formKey: _formKey,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  final item = _isBuku
                      ? Buku(
                          isbn: _identifierController.text,
                          judul: _judulController.text,
                          pengarang: _pengarangController.text,
                        )
                      : Majalah(
                          edisi: _identifierController.text,
                          judul: _judulController.text,
                          pengarang: _pengarangController.text,
                        );
                  _perpustakaanService.tambahItem(item);
                });
                _resetForm();
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(Item item) {
    _judulController.text = item.judul;
    _pengarangController.text = item.pengarang;
    _isBuku = item is Buku;
    _identifierController.text =
        _isBuku ? (item as Buku).isbn : (item as Majalah).edisi;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_isBuku ? 'Edit Buku' : 'Edit Majalah',
        style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: _isBuku ? Colors.blue : Colors.green, 
          ),
        ),
        content: ItemForm(
          isBuku: _isBuku,
          judulController: _judulController,
          pengarangController: _pengarangController,
          identifierController: _identifierController,
          onTypeChanged: (value) {
            setState(() {
              _isBuku = value;
            });
          },
          formKey: _formKey,
        ),
        actions: [
          TextButton(
            onPressed: () {
              _resetForm();
              Navigator.pop(context);
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  final newItem = _isBuku
                      ? Buku(
                          isbn: _identifierController.text,
                          judul: _judulController.text,
                          pengarang: _pengarangController.text,
                        )
                      : Majalah(
                          edisi: _identifierController.text,
                          judul: _judulController.text,
                          pengarang: _pengarangController.text,
                        );
                  _perpustakaanService.updateItem(item, newItem);
                });
                _resetForm();
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _judulController.clear();
    _pengarangController.clear();
    _identifierController.clear();
    _isBuku = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/128/2436/2436729.png',
              height: 32,
            ),
            const SizedBox(width: 12),
            const Text(
              'Aplikasi Perpustakaan',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: _perpustakaanService.koleksiItem.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.library_books,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada item. Tekan tombol + untuk menambahkan.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.lightBlue[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _perpustakaanService.koleksiItem.length,
              itemBuilder: (context, index) {
                final item = _perpustakaanService.koleksiItem[index];
                return ItemCard(
                  item: item,
                  onDelete: () {
                    setState(() {
                      _perpustakaanService.hapusItem(item);
                    });
                  },
                  onEdit: () => _showEditDialog(item),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _resetForm();
          _showAddDialog();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add,
        color: Colors.white,),
      ),
    );
  }

  @override
  void dispose() {
    _judulController.dispose();
    _pengarangController.dispose();
    _identifierController.dispose();
    super.dispose();
  }
}

