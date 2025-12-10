import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';

class CustomAuthAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAuthAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true, title: CustomText(text: title));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomDefaultAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? titleWidget;
  final List<Widget>? action;
  final Widget? iconButton;

  const CustomDefaultAppbar({
    super.key,
    this.title,
    this.leading,
    this.action,
    this.titleWidget,
    this.backgroundColor,
    this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      //pinned: true,
      floating: true,
      snap: true,
      automaticallyImplyLeading: true,
      //floating: false,
      backgroundColor: backgroundColor ?? Colors.transparent,
      // foregroundColor: AppColors.kWhiteColor,
      centerTitle: true,
      leading: leading,
      actions: action,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          SizedBox(),
          titleWidget ??
              CustomText(
                text: title ?? "",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
          SizedBox(),
          iconButton ?? SizedBox(),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/*class CustomHomeAppbar extends StatelessWidget {
  final Function()? onActionTap;
  const CustomHomeAppbar({super.key, this.onActionTap});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: AppColors.kPrimaryAccentColor,
      foregroundColor: AppColors.kBlackColor,
      title: Row(
        children: [
          Image.asset(
            logo,

            height: kToolbarHeight - 6,
            width: kToolbarHeight - 6,
          ),
          space8W,
          Expanded(
            child: GestureDetector(
              onTap:() {
                Get.toNamed(SearchPage.routeName);
              } ,
              child: CustomTextField(
                height: kToolbarHeight-20 ,
                borderColor: AppColors.kLightTextColor,
                borderRadius: 12.r,
                isEnable: false,
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      titleSpacing: 0,
      actions: [
        CustomIconButton(
          onActionTap: onActionTap,
          icon: Icons.notifications_none_rounded,
        ),
        space8W,
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onActionTap,
    required this.icon,
  });

  final Function()? onActionTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding8.copyWith(right: 0),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryLightAccentColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(padding: padding2,
        onPressed: onActionTap,
        icon: Icon(icon, color: AppColors.kPrimaryColor,size: 25.sp,),
      ),
    );
  }
}*/
