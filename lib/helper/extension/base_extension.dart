

import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/presentation/screens/inbox/model/conversation_model.dart';

extension BasePathExtensions on String {
  String get addBasePath {
    return RoutePath.basePath + this;
  }
}


extension ConversationItemExtension on ConversationItem {
  Participant? getPartner(String myId) {
    if (participants == null || participants!.isEmpty) return null;
    final others = participants!.where((p) => p.id != myId).toList();
    return others.isNotEmpty ? others.first : null;
  }
}

