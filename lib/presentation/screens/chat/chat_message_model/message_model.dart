

class MessageModel {
  final List<Conversation>? conversations;
  final Pagination? pagination;

  MessageModel({
    this.conversations,
    this.pagination,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    conversations: json["conversations"] == null ? [] : List<Conversation>.from(json["conversations"]!.map((x) => Conversation.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "conversations": conversations == null ? [] : List<dynamic>.from(conversations!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Conversation {
  final LastMessage? lastMessage;
  final int? unreadCount;
  final String? roomId;
  final OtherUser? otherUser;

  Conversation({
    this.lastMessage,
    this.unreadCount,
    this.roomId,
    this.otherUser,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    unreadCount: json["unreadCount"],
    roomId: json["roomId"],
    otherUser: json["otherUser"] == null ? null : OtherUser.fromJson(json["otherUser"]),
  );

  Map<String, dynamic> toJson() => {
    "lastMessage": lastMessage?.toJson(),
    "unreadCount": unreadCount,
    "roomId": roomId,
    "otherUser": otherUser?.toJson(),
  };
}

class LastMessage {
  final String? id;
  final OtherUser? sender;
  final OtherUser? receiver;
  final String? message;
  final String? roomId;
  final bool? isRead;
  final DateTime? createdAt;
  final int? v;

  LastMessage({
    this.id,
    this.sender,
    this.receiver,
    this.message,
    this.roomId,
    this.isRead,
    this.createdAt,
    this.v,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["_id"],
    sender: json["sender"] == null ? null : OtherUser.fromJson(json["sender"]),
    receiver: json["receiver"] == null ? null : OtherUser.fromJson(json["receiver"]),
    message: json["message"],
    roomId: json["roomId"],
    isRead: json["isRead"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
    "message": message,
    "roomId": roomId,
    "isRead": isRead,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}

class OtherUser {
  final String? id;
  final String? role;
  final String? name;
  final String? profilePic;

  OtherUser({
    this.id,
    this.role,
    this.name,
    this.profilePic,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
    id: json["id"],
    role: json["role"],
    name: json["name"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "name": name,
    "profilePic": profilePic,
  };
}

class Pagination {
  final int? total;
  final int? page;
  final int? limit;

  Pagination({
    this.total,
    this.page,
    this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
  };
}
