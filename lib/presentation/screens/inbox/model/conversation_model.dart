class ConversationModel {
  final bool? success;
  final List<ConversationItems>? data;
  final Pagination? pagination;

  ConversationModel({
    this.success,
    this.data,
    this.pagination,
  });

  ConversationModel copyWith({
    bool? success,
    List<ConversationItems>? data,
    Pagination? pagination,
  }) =>
      ConversationModel(
        success: success ?? this.success,
        data: data ?? this.data,
        pagination: pagination ?? this.pagination,
      );

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<ConversationItems>.from(json["data"]!.map((x) => ConversationItems.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class ConversationItems {
  final String? conversationId;
  final List<dynamic>? blockedBy;
  final List<Participant>? participants;
  final LastMessage? lastMessage;
  final int? unreadCount;
  final DateTime? updatedAt;

  ConversationItems({
    this.conversationId,
    this.blockedBy,
    this.participants,
    this.lastMessage,
    this.unreadCount,
    this.updatedAt,
  });

  ConversationItems copyWith({
    String? conversationId,
    List<dynamic>? blockedBy,
    List<Participant>? participants,
    LastMessage? lastMessage,
    int? unreadCount,
    DateTime? updatedAt,
  }) =>
      ConversationItems(
        conversationId: conversationId ?? this.conversationId,
        blockedBy: blockedBy ?? this.blockedBy,
        participants: participants ?? this.participants,
        lastMessage: lastMessage ?? this.lastMessage,
        unreadCount: unreadCount ?? this.unreadCount,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ConversationItems.fromJson(Map<String, dynamic> json) => ConversationItems(
    conversationId: json["conversationId"],
    blockedBy: json["blockedBy"] == null ? [] : List<dynamic>.from(json["blockedBy"]!.map((x) => x)),
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    unreadCount: json["unreadCount"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "blockedBy": blockedBy == null ? [] : List<dynamic>.from(blockedBy!.map((x) => x)),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
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

  LastMessage copyWith({
    String? id,
    String? conversationId,
    String? sender,
    String? receiver,
    String? text,
    List<dynamic>? images,
    String? video,
    String? videoCover,
    bool? seen,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      LastMessage(
        id: id ?? this.id,
        conversationId: conversationId ?? this.conversationId,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        text: text ?? this.text,
        images: images ?? this.images,
        video: video ?? this.video,
        videoCover: videoCover ?? this.videoCover,
        seen: seen ?? this.seen,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

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

  Participant copyWith({
    String? id,
    String? name,
    String? profileImage,
    bool? online,
  }) =>
      Participant(
        id: id ?? this.id,
        name: name ?? this.name,
        profileImage: profileImage ?? this.profileImage,
        online: online ?? this.online,
      );

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

  Pagination copyWith({
    int? currentPage,
    int? totalPages,
    int? totalConversations,
  }) =>
      Pagination(
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        totalConversations: totalConversations ?? this.totalConversations,
      );

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
