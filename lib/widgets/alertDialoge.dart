// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:tictactoe/Helper/color.dart';
import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final Widget title;
  final bool isMultipleAction;
  final List<Widget>? multipleAction;
  final String defaultActionButtonName;
  final onTapActionButton;
  final Widget? content;

  const Alert(
      {Key? key,
      required this.title,
      required this.isMultipleAction,
      this.multipleAction,
      required this.defaultActionButtonName,
      required this.onTapActionButton,
      this.content})
      : assert(onTapActionButton != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: AlertDialog(
        backgroundColor: primaryColor.withOpacity(0.92),
        title: title,
        actionsPadding: EdgeInsets.zero,
        actions: isMultipleAction
            ? multipleAction
            : [
                SizedBox(
                  //width: MediaQuery.of(context).size.width - 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: onTapActionButton,
                      child: Text(defaultActionButtonName,
                          style: const TextStyle(color: primaryColor)),
                    ),
                  ),
                )
              ],
        content: content,
      ),
    );
  }
}
