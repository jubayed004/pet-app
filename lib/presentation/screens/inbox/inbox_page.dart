import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/extension/base_extension.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/service/socket_service.dart';
import 'model/conversation_model.dart';
import 'widget/message_card_item_widget.dart';

class InboxPage extends StatefulWidget {
  static const String routeName = '/message';
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> with WidgetsBindingObserver {
  final controller = GetControllers.instance.getMessageController();
  final pagingController = PagingController<int, ConversationItem>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    pagingController.addPageRequestListener((pageKey) {
      controller.getAllConversation(pageKey: pageKey, pagingController: pagingController);
    });

    listenApi();
  }

  // Called when app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh when user returns from another screen
      pagingController.refresh();
    }
  }

  // Reconnect and listen every time user comes back
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listenApi();
  }

  Future<void> listenApi() async {
    await SocketApi.init();
    controller.listenForNewConversation(pagingController: pagingController);

    if (SocketApi.socket?.connected == true) {
      SocketApi.socket!.onAny((event, data) {
        debugPrint("EVENT: $event -> $data");

        // If a new text message arrives, refresh conversations instantly
        if (event.toString().contains('conversation_update')) {
          pagingController.refresh();
        }
      });
    } else {
      debugPrint("Socket Not Connected ❌");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: DBHelper().getUserId(),
        builder: (_, AsyncSnapshot<String> id) {
          if (!id.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            slivers: [
              const CustomDefaultAppbar(title: "Inbox"),
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
                        final partner = item.getPartner(id.data ?? "");
                        final name = partner?.name ?? "";
                        final isRead = item.lastMessage?.seen ?? false;
                        final message = item.lastMessage?.text ?? "";
                        final image = partner?.profileImage;
                        final photo = (image != null && image.isNotEmpty) ? image : "";
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
