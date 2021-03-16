class CommentModel {
  final String id;
  final String content;
  final List<CommentModel> subComments;
  final int points;
  final String username;
  final String userId;
  final String parentId;

  CommentModel(
      {this.id,
      this.content,
      this.subComments,
      this.points,
      this.username,
      this.userId,
      this.parentId});

  static CommentModel of(dynamic commentSnapshot) {
    return CommentModel(
        id: commentSnapshot['id'],
        content: commentSnapshot['content'],
        parentId: commentSnapshot['parentId'],
        points: commentSnapshot['points'],
        userId: commentSnapshot['userId'],
        username: commentSnapshot['username'],
        subComments: (commentSnapshot['subComments'] as List).map((e) => CommentModel.of(e)).toList(),
    );
  }
}