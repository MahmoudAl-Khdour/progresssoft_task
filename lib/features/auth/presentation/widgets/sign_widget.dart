import 'package:flutter/material.dart';

class SignWidget extends StatelessWidget {
  final Widget body;
  final String title;
  final bool withAppBar;
  const SignWidget({
    super.key,
    required this.title,
    required this.body,
    this.withAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: withAppBar
          ? AppBar(
              title: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              iconTheme: const IconThemeData(
                size: 25,
              ),
            )
          : null,
      body: body,
    );
  }
}
