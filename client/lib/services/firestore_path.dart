class FirestorePath {
  static String users() => 'users';
  static String user(String uid) => 'users/$uid';
  static String interests() => 'interests/document';
  static String booking(String uid, String bookingId) =>
      'users/$uid/jobs/$bookingId';
  static String bookings() => 'bookings';
  static String posts(String postId) => 'posts/$postId';
  static String commentsOnPosts(String postId, String commentId) =>
      'posts/$postId/comments/$commentId';
}
