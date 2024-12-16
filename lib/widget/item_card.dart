import 'package:flutter/material.dart';
import 'package:flutter_application_3/item.dart';
import 'package:flutter_application_3/buku.dart';
import 'package:flutter_application_3/majalah.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ItemCard({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  String get itemType => item is Buku ? 'Buku' : 'Majalah';
  String get identifier => item is Buku
      ? 'ISBN: ${(item as Buku).isbn}'
      : 'Edisi: ${(item as Majalah).edisi}';

  IconData get itemIcon => item is Buku ? Icons.book : Icons.newspaper;
  Color get itemColor => item is Buku ? Colors.blue : Colors.green;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: itemColor.withOpacity(0.1),
          child: Icon(itemIcon, color: itemColor),
        ),
        title: Row(
          children: [
            Expanded(child: Text(item.judul)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: itemColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                itemType,
                style: TextStyle(
                  fontSize: 12,
                  color: itemColor,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.pengarang),
            SizedBox(height: 4),
            Text(
              identifier,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
