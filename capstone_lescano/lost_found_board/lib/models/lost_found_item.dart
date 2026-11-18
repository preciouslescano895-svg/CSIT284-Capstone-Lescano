enum ItemType { lost, found }
class LostFoundItem {
 final String id;
 final String title;
 final String description;
 final String contact;
 final String imageUrl;
 final ItemType type;
 bool isClaimed;
 LostFoundItem({
   required this.id,
   required this.title,
   required this.description,
   required this.contact,
   required this.imageUrl,
   required this.type,
   this.isClaimed = false,
 });
}
List<LostFoundItem> demoItems() {
 return [
   LostFoundItem(
     id: '1',
     title: 'Black Wallet',
     description: 'Lost near the school library.',
     contact: 'demo01@example.com',
     imageUrl:
         'https://www.istockphoto.com/photos/black-leather-wallet-on-wooden-table',
     type: ItemType.lost,
   ),
   LostFoundItem(
     id: '2',
     title: 'Student ID Card',
     description: 'Found outside the cafeteria.',
     contact: 'demo02@example.com',
     imageUrl:
         'https://placehold.co/600x400/2563EB/FFFFFF.png?text=Student+ID',
     type: ItemType.found,
   ),
   LostFoundItem(
     id: '3',
     title: 'Blue Water Bottle',
     description: 'Lost inside Room 204.',
     contact: 'demo03@example.com',
     imageUrl:
         'https://placehold.co/600x400/0284C7/FFFFFF.png?text=Water+Bottle',
     type: ItemType.lost,
   ),
   LostFoundItem(
     id: '4',
     title: 'Silver Keys',
     description: 'Found near the main gate.',
     contact: 'demo04@example.com',
     imageUrl:
         'https://placehold.co/600x400/64748B/FFFFFF.png?text=Silver+Keys',
     type: ItemType.found,
   ),
   LostFoundItem(
     id: '5',
     title: 'White Earbuds',
     description: 'Lost near the computer laboratory.',
     contact: 'demo05@example.com',
     imageUrl:
         'https://placehold.co/600x400/94A3B8/FFFFFF.png?text=Earbuds',
     type: ItemType.lost,
   ),
   LostFoundItem(
     id: '6',
     title: 'Red Umbrella',
     description: 'Found near the covered court.',
     contact: 'demo06@example.com',
     imageUrl:
         'https://placehold.co/600x400/DC2626/FFFFFF.png?text=Umbrella',
     type: ItemType.found,
   ),
   LostFoundItem(
     id: '7',
     title: 'Math Notebook',
     description: 'Lost in the classroom.',
     contact: 'demo07@example.com',
     imageUrl:
         'https://placehold.co/600x400/1D4ED8/FFFFFF.png?text=Notebook',
     type: ItemType.lost,
   ),
   LostFoundItem(
     id: '8',
     title: 'USB Flash Drive',
     description: 'Found in the computer lab.',
     contact: 'demo08@example.com',
     imageUrl:
         'https://placehold.co/600x400/475569/FFFFFF.png?text=USB+Drive',
     type: ItemType.found,
   ),
   LostFoundItem(
     id: '9',
     title: 'Gray Cap',
     description: 'Lost near the school gym.',
     contact: 'demo09@example.com',
     imageUrl:
         'https://placehold.co/600x400/9CA3AF/FFFFFF.png?text=Gray+Cap',
     type: ItemType.lost,
   ),
   LostFoundItem(
     id: '10',
     title: 'Black Wristwatch',
     description: 'Found near the study area.',
     contact: 'demo10@example.com',
     imageUrl:
         'https://placehold.co/600x400/111827/FFFFFF.png?text=Wristwatch',
     type: ItemType.found,
   ),
 ];
}