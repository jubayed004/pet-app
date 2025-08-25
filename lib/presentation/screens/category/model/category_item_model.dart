import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'category_model.dart';

class CategoryItem {
  final Widget icon;
  final String title;
  final String type;

  CategoryItem({
    required this.icon,
    required this.title,
    required this.type,
  });
}