import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';


class HelpDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const HelpDetailScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: CommonScreenContainer(
          title: title,
          scrollable: true,
          child: HtmlWidget(
            content.isNotEmpty ? content : "<p>No content available</p>",
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
