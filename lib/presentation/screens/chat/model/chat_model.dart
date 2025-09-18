class ChatModel {
  final bool? status;
  final Conversation? conversation;
  final String? message;
  final Participant? participant;
  final BlockStatus? blockStatus;

  ChatModel({
    this.status,
    this.conversation,
    this.message,
    this.participant,
    this.blockStatus,
  });

  ChatModel copyWith({
    bool? status,
    Conversation? conversation,
    String? message,
    Participant? participant,
    BlockStatus? blockStatus,
  }) =>
      ChatModel(
        status: status ?? this.status,
        conversation: conversation ?? this.conversation,
        message: message ?? this.message,
        participant: participant ?? this.participant,
        blockStatus: blockStatus ?? this.blockStatus,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    status: json["status"],
    conversation: json["conversation"] == null ? null : Conversation.fromJson(json["conversation"]),
    message: json["message"],
    participant: json["participant"] == null ? null : Participant.fromJson(json["participant"]),
    blockStatus: json["blockStatus"] == null ? null : BlockStatus.fromJson(json["blockStatus"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "conversation": conversation?.toJson(),
    "message": message,
    "participant": participant?.toJson(),
    "blockStatus": blockStatus?.toJson(),
  };
}

class BlockStatus {
  final bool? isBlockedByYou;
  final bool? isBlockedByPartner;
  final bool? isBlocked;

  BlockStatus({
    this.isBlockedByYou,
    this.isBlockedByPartner,
    this.isBlocked,
  });

  BlockStatus copyWith({
    bool? isBlockedByYou,
    bool? isBlockedByPartner,
    bool? isBlocked,
  }) =>
      BlockStatus(
        isBlockedByYou: isBlockedByYou ?? this.isBlockedByYou,
        isBlockedByPartner: isBlockedByPartner ?? this.isBlockedByPartner,
        isBlocked: isBlocked ?? this.isBlocked,
      );

  factory BlockStatus.fromJson(Map<String, dynamic> json) => BlockStatus(
    isBlockedByYou: json["isBlockedByYou"],
    isBlockedByPartner: json["isBlockedByPartner"],
    isBlocked: json["isBlocked"],
  );

  Map<String, dynamic> toJson() => {
    "isBlockedByYou": isBlockedByYou,
    "isBlockedByPartner": isBlockedByPartner,
    "isBlocked": isBlocked,
  };
}

class Conversation {
  final String? id;
  final List<Participant>? participants;
  final List<MessageItem>? messages;
  final List<dynamic>? blockedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Conversation({
    this.id,
    this.participants,
    this.messages,
    this.blockedBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Conversation copyWith({
    String? id,
    List<Participant>? participants,
    List<MessageItem>? messages,
    List<dynamic>? blockedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Conversation(
        id: id ?? this.id,
        participants: participants ?? this.participants,
        messages: messages ?? this.messages,
        blockedBy: blockedBy ?? this.blockedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["_id"],
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    messages: json["messages"] == null ? [] : List<MessageItem>.from(json["messages"]!.map((x) => MessageItem.fromJson(x))),
    blockedBy: json["blockedBy"] == null ? [] : List<dynamic>.from(json["blockedBy"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "blockedBy": blockedBy == null ? [] : List<dynamic>.from(blockedBy!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class MessageItem {
  final String? id;
  final String? conversationId;
  final String? sender;
  final String? receiver;
  final String? text;
  final List<String?>? images;
  final String? video;
  final String? videoCover;
  final bool? seen;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  MessageItem({
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

  MessageItem copyWith({
    String? id,
    String? conversationId,
    String? sender,
    String? receiver,
    String? text,
    List<String?>? images,
    String? video,
    String? videoCover,
    bool? seen,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      MessageItem(
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

  factory MessageItem.fromJson(Map<String, dynamic> json) => MessageItem(
    id: json["_id"],
    conversationId: json["conversationId"],
    sender: json["sender"],
    receiver: json["receiver"],
    text: json["text"],
    images: json["images"] == null ? [] : List<String?>.from(json["images"]!.map((x) => x)),
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
  final String? role;
  final String? profilePic;

  Participant({
    this.id,
    this.name,
    this.role,
    this.profilePic,
  });

  Participant copyWith({
    String? id,
    String? name,
    String? role,
    String? profilePic,
  }) =>
      Participant(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        profilePic: profilePic ?? this.profilePic,
      );

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["_id"],
    name: json["name"],
    role: json["role"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "role": role,
    "profilePic": profilePic,
  };
}
