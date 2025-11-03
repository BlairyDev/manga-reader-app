import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/constants.dart';

class TopAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBarWidget({
    super.key,
    required this.title,
    this.actions = const [],
  });

  final String title;
  final List<Widget> actions;
  @override
  State<TopAppBarWidget> createState() => _TopAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopAppBarWidgetState extends State<TopAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      forceMaterialTransparency: true,
      actions: widget.actions.isEmpty ? [] : widget.actions,
    );
  }
}
