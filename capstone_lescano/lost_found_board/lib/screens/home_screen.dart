import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/lost_found_item.dart';
import '../widgets/item_card.dart';
import 'post_item_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _itemsCollection =
      FirebaseFirestore.instance.collection('items');

  late final Stream<QuerySnapshot<Map<String, dynamic>>>
      _itemsStream;

  ItemType? _selectedType;

  @override
  void initState() {
    super.initState();
    _itemsStream = _itemsCollection.snapshots();
  }

  Future<void> _openPostScreen() async {
    final newItem = await Navigator.push<LostFoundItem>(
      context,
      MaterialPageRoute(
        builder: (context) => const PostItemScreen(),
      ),
    );

    if (!mounted || newItem == null) return;

    try {
      await _itemsCollection.add(newItem.toMap());

      if (!mounted) return;

      setState(() {
        _selectedType = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item posted successfully!'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error posting item: $e')),
      );
    }
  }

  Future<void> _markClaimed(LostFoundItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Mark as Claimed'),
          content: Text(
            'Are you sure you want to mark ${item.title} as claimed?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) return;

    try {
      await _itemsCollection.doc(item.id).update({
        'isClaimed': true,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item marked as claimed!'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lost & Found Board'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _itemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final items = snapshot.data!.docs.map((doc) {
            return LostFoundItem.fromMap(
              doc.id,
              doc.data(),
            );
          }).toList();

          final filteredItems = items.where((item) {
            return _selectedType == null ||
                item.type == _selectedType;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${filteredItems.length} Lost & Found Posts',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 10,
                      children: [
                        ChoiceChip(
                          label: const Text('All'),
                          selected: _selectedType == null,
                          onSelected: (_) {
                            setState(() {
                              _selectedType = null;
                            });
                          },
                        ),

                        ChoiceChip(
                          label: const Text('Lost'),
                          selected:
                              _selectedType == ItemType.lost,
                          onSelected: (_) {
                            setState(() {
                              _selectedType = ItemType.lost;
                            });
                          },
                        ),

                        ChoiceChip(
                          label: const Text('Found'),
                          selected:
                              _selectedType == ItemType.found,
                          onSelected: (_) {
                            setState(() {
                              _selectedType = ItemType.found;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: filteredItems.isEmpty
                    ? const Center(
                        child: Text('No items found.'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];

                          return ItemCard(
                            item: item,
                            onClaim: () => _markClaimed(item),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openPostScreen,
        icon: const Icon(Icons.add),
        label: const Text('Post Item'),
      ),
    );
  }
}
