import 'package:flutter/material.dart';
import '../models/lost_found_item.dart';
class ItemCard extends StatelessWidget {
 final LostFoundItem item;
 final VoidCallback onClaim;
 const ItemCard({
   super.key,
   required this.item,
   required this.onClaim,
 });
 @override
 Widget build(BuildContext context) {
   final isLost = item.type == ItemType.lost;
   return Card(
     margin: const EdgeInsets.only(bottom: 15),
     clipBehavior: Clip.antiAlias,
     child: Padding(
       padding: const EdgeInsets.all(15),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Image.network(
             item.imageUrl,
             height: 180,
             width: double.infinity,
             fit: BoxFit.cover,
             errorBuilder: (context, error, stackTrace) {
               return Container(
                 height: 180,
                 width: double.infinity,
                 color: Colors.grey.shade200,
                 child: const Icon(
                   Icons.broken_image,
                   size: 50,
                   color: Colors.grey,
                 ),
               );
             },
           ),
           const SizedBox(height: 12),
           Row(
             children: [
               Expanded(
                 child: Text(
                   item.title,
                   style: const TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
               Chip(
                 label: Text(isLost ? 'LOST' : 'FOUND'),
                 backgroundColor: isLost
                     ? Colors.red.shade100
                     : Colors.green.shade100,
               ),
             ],
           ),
           const SizedBox(height: 8),
           Text(item.description),
           const SizedBox(height: 8),
           SelectableText(
             'Contact: ${item.contact}',
           ),
           const SizedBox(height: 12),
           Row(
             children: [
               Expanded(
                 child: Text(
                   item.isClaimed
                       ? 'Status: Claimed'
                       : 'Status: Available',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: item.isClaimed
                         ? Colors.green
                         : Colors.teal,
                   ),
                 ),
               ),
               ElevatedButton(
                 onPressed: item.isClaimed ? null : onClaim,
                 child: Text(
                   item.isClaimed
                       ? 'Claimed'
                       : 'Mark Claimed',
                 ),
               ),
             ],
           ),
         ],
       ),
     ),
   );
 }
}