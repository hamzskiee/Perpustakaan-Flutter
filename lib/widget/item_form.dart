import 'package:flutter/material.dart';

class ItemForm extends StatefulWidget {
  final bool isBuku;
  final TextEditingController judulController;
  final TextEditingController pengarangController;
  final TextEditingController identifierController;
  final Function(bool) onTypeChanged;
  final GlobalKey<FormState> formKey;

  const ItemForm({
    super.key,
    required this.isBuku,
    required this.judulController,
    required this.pengarangController,
    required this.identifierController,
    required this.onTypeChanged,
    required this.formKey,
  });

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<bool>(
                value: widget.isBuku,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: true, child: Text('Buku')),
                  DropdownMenuItem(value: false, child: Text('Majalah')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    widget.onTypeChanged(value);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.judulController,
            decoration: const InputDecoration(
              labelText: 'Judul',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Judul tidak boleh kosong' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.pengarangController,
            decoration: const InputDecoration(
              labelText: 'Pengarang',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Pengarang tidak boleh kosong' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.identifierController,
            decoration: InputDecoration(
              labelText: widget.isBuku ? 'ISBN' : 'Edisi',
              border: const OutlineInputBorder(),
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Bidang tidak boleh kosong' : null,
          ),
        ],
      ),
    );
  }
}
