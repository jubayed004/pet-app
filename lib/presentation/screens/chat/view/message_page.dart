import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import '../widgets/message_card_item_widget.dart';

class MessageListPage extends StatelessWidget {
  static const String routeName = '/message';
  const MessageListPage({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Chat",),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 2,
                  (context, index) =>Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                    child: MessageCardItemWidget(isRead:index==2?false: true),
                  ),
            ),
          ),

        ],
      )
    );
  }
}
