
class MessageModel {
  final bool? success;
  final List<MessageItem>? data;
  final Pagination? pagination;

  MessageModel({
    this.success,
    this.data,
    this.pagination,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<MessageItem>.from(json["data"]!.map((x) => MessageItem.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class MessageItem {
  final String? conversationId;
  final List<dynamic>? blockedBy;
  final Participant? participant;
  final LastMessage? lastMessage;
  final int? unreadCount;
  final DateTime? updatedAt;

  MessageItem({
    this.conversationId,
    this.blockedBy,
    this.participant,
    this.lastMessage,
    this.unreadCount,
    this.updatedAt,
  });

  factory MessageItem.fromJson(Map<String, dynamic> json) => MessageItem(
    conversationId: json["conversationId"],
    blockedBy: json["blockedBy"] == null ? [] : List<dynamic>.from(json["blockedBy"]!.map((x) => x)),
    participant: json["participant"] == null ? null : Participant.fromJson(json["participant"]),
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    unreadCount: json["unreadCount"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "blockedBy": blockedBy == null ? [] : List<dynamic>.from(blockedBy!.map((x) => x)),
    "participant": participant?.toJson(),
    "lastMessage": lastMessage?.toJson(),
    "unreadCount": unreadCount,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class LastMessage {
  final String? id;
  final String? conversationId;
  final String? sender;
  final String? receiver;
  final String? text;
  final List<dynamic>? images;
  final String? video;
  final String? videoCover;
  final bool? seen;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  LastMessage({
    this.id,
    this.conversationId,
    this.sender,
    this.receiver,
    this.text,
    this.images,
    this.video,
    this.videoCover,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["_id"],
    conversationId: json["conversationId"],
    sender: json["sender"],
    receiver: json["receiver"],
    text: json["text"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    video: json["video"],
    videoCover: json["videoCover"],
    seen: json["seen"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "conversationId": conversationId,
    "sender": sender,
    "receiver": receiver,
    "text": text,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "video": video,
    "videoCover": videoCover,
    "seen": seen,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Participant {
  final String? id;
  final String? name;
  final String? profileImage;
  final bool? online;

  Participant({
    this.id,
    this.name,
    this.profileImage,
    this.online,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["id"],
    name: json["name"],
    profileImage: json["profileImage"],
    online: json["online"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profileImage": profileImage,
    "online": online,
  };
}

class Pagination {
  final int? currentPage;
  final int? totalPages;
  final int? totalConversations;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalConversations,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    totalConversations: json["totalConversations"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalConversations": totalConversations,
  };
}
