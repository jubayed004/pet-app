class MessageForChatModel {
  final bool? success;
  final Conversation? conversation;
  final Participant? participant;
  final BlockStatus? blockStatus;

  MessageForChatModel({
    this.success,
    this.conversation,
    this.participant,
    this.blockStatus,
  });

  factory MessageForChatModel.fromJson(Map<String, dynamic> json) => MessageForChatModel(
    success: json["success"],
    conversation: json["conversation"] == null ? null : Conversation.fromJson(json["conversation"]),
    participant: json["participant"] == null ? null : Participant.fromJson(json["participant"]),
    blockStatus: json["blockStatus"] == null ? null : BlockStatus.fromJson(json["blockStatus"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "conversation": conversation?.toJson(),
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
  final List<String>? participants;
  final List<MessageItems>? messages;
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

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["_id"],
    participants: json["participants"] == null ? [] : List<String>.from(json["participants"]!.map((x) => x)),
    messages: json["messages"] == null ? [] : List<MessageItems>.from(json["messages"]!.map((x) => MessageItems.fromJson(x))),
    blockedBy: json["blockedBy"] == null ? [] : List<dynamic>.from(json["blockedBy"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x)),
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "blockedBy": blockedBy == null ? [] : List<dynamic>.from(blockedBy!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class MessageItems {
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

  MessageItems({
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

  factory MessageItems.fromJson(Map<String, dynamic> json) => MessageItems(
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
  final String? address;
  final String? profilePic;

  Participant({
    this.id,
    this.name,
    this.address,
    this.profilePic,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["_id"],
    name: json["name"],
    address: json["address"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "profilePic": profilePic,
  };
}
