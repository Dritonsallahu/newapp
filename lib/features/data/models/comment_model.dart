class CommentModel {
  dynamic id;
  dynamic user;
  dynamic username;
  String? post;
  String? phoneId;
  String? comment;
  String? createdAt;
  String? updatedAt;

  CommentModel(
      {this.id,
        this.user,
        this.username,
        this.post,
        this.phoneId,
        this.comment,
        this.createdAt,
        this.updatedAt});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      user: json['user'],
      username: json['username'],
      post: json['post'],
      phoneId: json['phone_id'],
      comment: json['comment'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
