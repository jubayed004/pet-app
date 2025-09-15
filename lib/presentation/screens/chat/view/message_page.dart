import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/chat/chat_message_model/message_model.dart';
import '../widgets/message_card_item_widget.dart';

class MessageListPage extends StatelessWidget {
  static const String routeName = '/message';

  MessageListPage({super.key});

  final messageController = GetControllers.instance.getMessageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Messages"),
          SliverFillRemaining(
            child: RefreshIndicator(
              onRefresh: () async {
                messageController.pagingController.refresh();
              },
              child: PagedListView<int, MessageItem>(
                pagingController: messageController.pagingController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                builderDelegate: PagedChildBuilderDelegate<MessageItem>(
                  itemBuilder: (context, item, index) {
                    // final time = GetTimeAgo.parse(item.updatedAt ?? DateTime.now());
                    final name = item.participant?.name ?? "";
                    final isRead = item.lastMessage?.seen ?? false;
                    final message = item.lastMessage?.text ?? "";
                    final image = item.participant?.profileImage;
                    final photo = image != null && image.isNotEmpty ? image ?? "" : "";
                    final date = DateFormat("dd-MM-yyyy").format(item.lastMessage?.createdAt ?? DateTime.now());
                    return MessageCardItemWidget(
                        isRead: isRead,
                        name: name,
                        message: message,
                        date: date,
                        image: photo
                    );
                  },
                  firstPageErrorIndicatorBuilder:
                      (context) => Center(
                        child: ErrorCard(
                          onTap: () => messageController.pagingController.refresh(),
                          text: messageController.pagingController.error.toString(),
                        ),
                      ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
