// To parse this JSON data, do
//
//     final postData = postDataFromJson(jsonString);

import 'dart:convert';

PostData postDataFromJson(String str) => PostData.fromJson(json.decode(str));

String postDataToJson(PostData data) => json.encode(data.toJson());

class PostData {
  PostData({
    required this.error,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool error;
  final int statusCode;
  final String message;
  final Data data;

  PostData copyWith({
    bool? error,
    int? statusCode,
    String? message,
    Data? data,
  }) =>
      PostData(
        error: error ?? this.error,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        error: json["error"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.currentPage,
    this.nextPage,
    required this.totalPage,
    required this.totalItems,
    required this.posts,
  });

  final int currentPage;
  final int? nextPage;
  final int totalPage;
  final int totalItems;
  final List<Post> posts;

  Data copyWith({
    int? currentPage,
    int? nextPage,
    int? totalPage,
    int? totalItems,
    List<Post>? posts,
  }) =>
      Data(
        currentPage: currentPage ?? this.currentPage,
        nextPage: nextPage ?? this.nextPage,
        totalPage: totalPage ?? this.totalPage,
        totalItems: totalItems ?? this.totalItems,
        posts: posts ?? this.posts,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        totalPage: json["totalPage"],
        totalItems: json["totalItems"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "nextPage": nextPage,
        "totalPage": totalPage,
        "totalItems": totalItems,
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.postType,
    required this.location,
    required this.foodType,
    required this.cuisineType,
    required this.fileUrl,
    required this.likeCount,
    required this.isLiked,
    required this.isFavourite,
    required this.postBy,
  });

  final int id;
  final String title;
  final String shortDescription;
  final String postType;
  final String location;
  final String foodType;
  final String cuisineType;
  final String fileUrl;
  final String likeCount;
  final bool isLiked;
  final bool isFavourite;
  final PostBy postBy;

  Post copyWith({
    int? id,
    String? title,
    String? shortDescription,
    String? postType,
    String? location,
    String? foodType,
    String? cuisineType,
    String? fileUrl,
    String? likeCount,
    bool? isLiked,
    bool? isFavourite,
    PostBy? postBy,
  }) =>
      Post(
        id: id ?? this.id,
        title: title ?? this.title,
        shortDescription: shortDescription ?? this.shortDescription,
        postType: postType ?? this.postType,
        location: location ?? this.location,
        foodType: foodType ?? this.foodType,
        cuisineType: cuisineType ?? this.cuisineType,
        fileUrl: fileUrl ?? this.fileUrl,
        likeCount: likeCount ?? this.likeCount,
        isLiked: isLiked ?? this.isLiked,
        isFavourite: isFavourite ?? this.isFavourite,
        postBy: postBy ?? this.postBy,
      );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        shortDescription: json["shortDescription"],
        postType: json["postType"],
        location: json["location"],
        foodType: json["foodType"],
        cuisineType: json["cuisineType"],
        fileUrl: json["fileUrl"],
        likeCount: json["likeCount"],
        isLiked: json["isLiked"],
        isFavourite: json["isFavourite"],
        postBy: PostBy.fromJson(json["postBy"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "shortDescription": shortDescription,
        "postType": postType,
        "location": location,
        "foodType": foodType,
        "cuisineType": cuisineType,
        "fileUrl": fileUrl,
        "likeCount": likeCount,
        "isLiked": isLiked,
        "isFavourite": isFavourite,
        "postBy": postBy.toJson(),
      };
}

class PostBy {
  PostBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.picUrl,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String picUrl;

  PostBy copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? picUrl,
  }) =>
      PostBy(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        picUrl: picUrl ?? this.picUrl,
      );

  factory PostBy.fromJson(Map<String, dynamic> json) => PostBy(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        picUrl: json["picUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "picUrl": picUrl,
      };
}
