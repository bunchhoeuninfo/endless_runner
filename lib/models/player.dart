class Player {
  final String? id;
  final String? name;
  final String? imgUrl;

  Player({
    required this.id, required this.name, required this.imgUrl
  });

  factory Player.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw ArgumentError("data to Map is null, cannot create Category Article model.");
    }
    return Player(id: data['id'], name: data['name'], imgUrl: data['imgUrl']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
    };
  }
}