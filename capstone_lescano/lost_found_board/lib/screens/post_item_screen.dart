import 'package:flutter/material.dart';
import '../models/lost_found_item.dart';

class PostItemScreen extends StatefulWidget {
  const PostItemScreen({super.key});

  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactController = TextEditingController();
  final _imageUrlController = TextEditingController();

  ItemType _type = ItemType.lost;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contactController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final newItem = LostFoundItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      contact: _contactController.text.trim(),
      type: _type,
      imageUrl: _imageUrlController.text.trim(),
    );

    Navigator.pop(context, newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post an Item'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Item Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: const Text('Lost'),
                  selected: _type == ItemType.lost,
                  onSelected: (_) {
                    setState(() => _type = ItemType.lost);
                  },
                ),
                ChoiceChip(
                  label: const Text('Found'),
                  selected: _type == ItemType.found,
                  onSelected: (_) {
                    setState(() => _type = ItemType.found);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.inventory_2),
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Enter item name'
                      : null,
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description / Location',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Enter description'
                      : null,
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: _contactController,
              decoration: const InputDecoration(
                labelText: 'Contact Number or Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.contact_mail),
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Enter contact information'
                      : null,
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: _imageUrlController,
              keyboardType: TextInputType.url,
              onChanged: (value) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Image URL',
                hintText: 'https://example.com/image.jpg',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.image),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter an image URL';
                }

                final uri = Uri.tryParse(value.trim());

                if (uri == null ||
                    !uri.hasScheme ||
                    !(uri.scheme == 'http' ||
                        uri.scheme == 'https') ||
                    uri.host.isEmpty) {
                  return 'Enter a valid image URL';
                }

                return null;
              },
            ),

            const SizedBox(height: 15),

            if (_imageUrlController.text.trim().isNotEmpty)
              Image.network(
                _imageUrlController.text.trim(),
                height: 160,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Text('Image preview unavailable'),
              ),

            const SizedBox(height: 25),

            SizedBox(
              height: 50,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.publish),
                label: const Text('Publish Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
