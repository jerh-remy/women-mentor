class Interests {
  final List<String>? hobbies;
  final List<String>? techInterests;

  Interests({
    this.hobbies = const [],
    this.techInterests = const [],
  });

  factory Interests.fromMap(Map<String, dynamic>? data, String documentId) {
    return Interests(
        hobbies: List<String>.from(data?['hobbies'].map((e) => e)),
        techInterests: List<String>.from(data?['techInterests'].map((e) => e)));
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
    };
  }
}
