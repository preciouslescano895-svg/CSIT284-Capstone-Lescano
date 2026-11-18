import 'package:flutter/material.dart';
import '../models/lost_found_item.dart';
import '../widgets/item_card.dart';
import 'post_item_screen.dart';
class HomeScreen extends StatefulWidget {
 const HomeScreen({super.key});
 @override
 State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
 final List<LostFoundItem> _items = demoItems();
 ItemType? _selectedType;
 Future<void> _openPostScreen() async {
   final newItem = await Navigator.push<LostFoundItem>(
     context,
     MaterialPageRoute(
       builder: (context) => const PostItemScreen(),
     ),
   );
   if (!mounted || newItem == null) return;
   setState(() {
     _items.insert(0, newItem);
     _selectedType = null;
   });
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
   setState(() {
     item.isClaimed = true;
   });
 }
 @override
 Widget build(BuildContext context) {
   final filteredItems = _items.where((item) {
     return _selectedType == null ||
         item.type == _selectedType;
   }).toList();
   return Scaffold(
     appBar: AppBar(
       title: const Text('Lost & Found Board'),
       backgroundColor: Colors.teal,
       foregroundColor: Colors.white,
     ),
     body: Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(16),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 '${_items.length} Lost & Found Posts',
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
                     onSelected: (selected) {
                       setState(() {
                         _selectedType = null;
                       });
                     },
                   ),
                   ChoiceChip(
                     label: const Text('Lost'),
                     selected:
                         _selectedType == ItemType.lost,
                     onSelected: (selected) {
                       setState(() {
                         _selectedType = ItemType.lost;
                       });
                     },
                   ),
                   ChoiceChip(
                     label: const Text('Found'),
                     selected:
                         _selectedType == ItemType.found,
                     onSelected: (selected) {
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
     ),
     floatingActionButton: FloatingActionButton.extended(
       onPressed: _openPostScreen,
       icon: const Icon(Icons.add),
       label: const Text('Post Item'),
     ),
   );
 }
}