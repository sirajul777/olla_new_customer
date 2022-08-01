import 'dart:ffi';

import 'package:customer/View/Components/appProperties.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmojiText extends StatelessWidget {
  EmojiText({
    Key? key,
    @required this.size,
    @required this.text,
  })  : assert(text != null),
        super(key: key);
  double? size;
  String? text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _buildText(this.text!, this.size!),
    );
  }

  TextSpan _buildText(String text, double size) {
    final children = <TextSpan>[];
    final runes = text.runes;

    for (int i = 0; i < runes.length; /* empty */) {
      int current = runes.elementAt(i);

      // we assume that everything that is not
      // in Extended-ASCII set is an emoji...
      final isEmoji = current > 255;
      final shouldBreak = isEmoji ? (x) => x <= 255 : (x) => x > 255;

      final chunk = <int>[];
      while (!shouldBreak(current)) {
        chunk.add(current);
        if (++i >= runes.length) break;
        current = runes.elementAt(i);
      }

      children.add(
        TextSpan(
          text: String.fromCharCodes(chunk),
          style: TextStyle(fontFamily: isEmoji ? 'EmojiOne' : null, color: softGrey, fontSize: size),
        ),
      );
    }

    return TextSpan(children: children);
  }
}
