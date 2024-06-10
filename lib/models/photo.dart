class Photo {
  final String? id;
  final String url;
  

  Photo({
    this.id,
    required this.url,
  });

  // Método para crear un objeto Photo desde un Map
  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'].toString(),
      url: map['url'],
    );
  }

  // Método estático para convertir una lista de Map en una lista de Photo
  static List<Photo> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => Photo.fromMap(map)).toList();
  }

  @override
  String toString() {
    return 'Photo{id: $id, url: $url}';
  }
}
