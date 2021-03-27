// Everything subject to change
class Comment {
  final String content;
  final String uid;

  Comment({required this.content, required this.uid});
}

class Post {
  final String mentorId;
  final String content;
  final List<Comment> comments;

  Post({
    required this.mentorId,
    required this.content,
    this.comments = const [],
  });

  factory Post.fromData(Map<String, dynamic>? data) {
    return Post(
      mentorId: data?['mentorId'],
      content: data?['content'],
      comments: data?['comments'].map((e) => e),
    );
  }

  Map<String, dynamic> toJson() {
    return {'mentorId': mentorId, 'content': content, 'comments': comments};
  }
}
