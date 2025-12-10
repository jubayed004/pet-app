import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/presentation/screens/inbox/model/conversation_model.dart';

extension BasePathExtensions on String {
  String get addBasePath {
    return RoutePath.basePath + this;
  }
}

extension ConversationItemExtension on ConversationItems {
  Participant? getPartner(String myId) {
    // Printing participants before checking for null or empty
    print('Participants: ${participants}');

    if (participants == null || participants!.isEmpty) {
      print('Participants is null or empty');
      return null;
    }

    // Printing the list of participants that are not the current user
    final others = participants!.where((p) => p.id != myId).toList();
    print('Filtered others: ${others.map((p) => p.id).toList()}');

    // Check if there are participants besides the current user
    if (others.isNotEmpty) {
      print('Partner found: ${others.first.id}');
      return others.first; // Return the first "partner" found
    } else {
      print('No partner found');
      return null; // No partner if no one else is in the participants list
    }
  }
}
