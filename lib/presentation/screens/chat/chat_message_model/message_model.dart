
class MessageModel {
  final List<Message>? messages;
  final Pagination? pagination;

  MessageModel({
    this.messages,
    this.pagination,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Message {
  final String? id;
  final Receiver? sender;
  final Receiver? receiver;
  final String? message;
  final String? roomId;
  final DateTime? createdAt;
  final int? v;

  Message({
    this.id,
    this.sender,
    this.receiver,
    this.message,
    this.roomId,
    this.createdAt,
    this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["_id"],
    sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    message: json["message"],
    roomId: json["roomId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
    "message": message,
    "roomId": roomId,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}

class Receiver {
  final String? id;
  final String? role;

  Receiver({
    this.id,
    this.role,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    id: json["id"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
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
