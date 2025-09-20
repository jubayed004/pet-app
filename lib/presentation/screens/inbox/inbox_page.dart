import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/extension/base_extension.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/service/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'model/conversation_model.dart';
import 'widget/message_card_item_widget.dart';

class InboxPage extends StatefulWidget {
  static const String routeName = '/message';
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final controller = GetControllers.instance.getMessageController();

  final pagingController = PagingController<int, ConversationItem>(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      controller.getAllConversation(pageKey: pageKey, pagingController: pagingController);
    });

    listenApi();
    super.initState();
  }

  Future<void> listenApi() async {
    await SocketApi.init();
    controller.listenForNewConversation(pagingController: pagingController);
    // Ensure socket is connected before listening
    if (SocketApi.socket?.connected == true) {

      // Debug all events
      SocketApi.socket!.onAny((event, data) {
        debugPrint("EVENT: $event -> $data");
      });
    }else{
      debugPrint("Socket Not Connected ---------------------------------------------------------------------");
    }
  }


  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: DBHelper().getUserId(),
        builder: (_, AsyncSnapshot<String> id){
          if(id.data == null){
            return Center(child: CircularProgressIndicator(),);
          }
          return CustomScrollView(
            slivers: [
              CustomDefaultAppbar(title: "Inbox"),
              SliverFillRemaining(
                child: RefreshIndicator(
                  onRefresh: () async {
                    pagingController.refresh();
                  },
                  child: PagedListView<int, ConversationItem>(
                    pagingController: pagingController,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    builderDelegate: PagedChildBuilderDelegate<ConversationItem>(
                      itemBuilder: (context, item, index) {
                        print(item.toJson());
                        print(id.data ?? "Id Null");
                        final partner = item.getPartner(id.data ?? "");
                        print(partner?.toJson());
                        final name = partner?.name ?? "";
                        final isRead = item.lastMessage?.seen ?? false;
                        final message = item.lastMessage?.text ?? "";
                        final image = partner?.profileImage;
                        final photo = image != null && image.isNotEmpty ? image : "";
                        final date = DateFormat("dd-MM-yyyy").format(item.lastMessage?.createdAt ?? DateTime.now());
                        return MessageCardItemWidget(
                          isRead: isRead,
                          name: name,
                          message: message,
                          date: date,
                          image: photo,
                          senderId: partner?.id ?? "",
                        );
                      },
                      firstPageErrorIndicatorBuilder: (context) => Center(
                        child: ErrorCard(
                          onTap: () => pagingController.refresh(),
                          text: pagingController.error.toString(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
