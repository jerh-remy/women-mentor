class FirestorePath {
  static String users() => 'users';
  static String user(String uid) => 'users/$uid';
  static String mentor(String uid) => 'mentors/$uid';
  static String mentee(String uid) => 'mentees/$uid';
  static String registration(String uid) => 'registrations/$uid';
  static String interests() => 'interests/document';
  static String booking(String uid, String bookingId) =>
      'users/$uid/jobs/$bookingId';
  static String bookings() => 'bookings';
  static String posts(String postId) => 'posts/$postId';
  static String commentsOnPosts(String postId, String commentId) =>
      'posts/$postId/comments/$commentId';
}
