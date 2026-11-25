enum ItemType { lost, found }class LostFoundItem {
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

  // Convert item data for saving to Firebase
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'contact': contact,
      'imageUrl': imageUrl,
      'type': type.name,
      'isClaimed': isClaimed,
    };
  }

  // Retrieve item data from Firebase
  factory LostFoundItem.fromMap(
    String id,
    Map<String, dynamic> data,
  ) {
    return LostFoundItem(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      contact: data['contact'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      type: data['type'] == 'lost'
          ? ItemType.lost
          : ItemType.found,
      isClaimed: data['isClaimed'] ?? false,
    );
  }
}