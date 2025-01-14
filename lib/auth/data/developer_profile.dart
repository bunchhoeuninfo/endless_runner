class DeveloperProfile {

  DeveloperProfile({    
    required this.name,
    required this.title,
    required this.expertise,
    required this.bio,
    required this.imageUrl,
    required this.email
  });

  final String name;
  final String title;
  final String expertise;
  final String bio;
  final String imageUrl;
  final String email;

  factory DeveloperProfile.fromMap(Map<String, dynamic>? data) {
    if (data ==null) {
      throw ArgumentError('Data to Map is null, cannot create Developer Profile');
    }
    return DeveloperProfile(
      name: data['name'], 
      title: data['title'], 
      expertise: data['expertise'], 
      bio: data['bio'], 
      imageUrl: data['imageUrl'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'expertise': expertise,
      'bio': bio,
      'imageUrl': imageUrl,
      'email': email,
    };
  }
}