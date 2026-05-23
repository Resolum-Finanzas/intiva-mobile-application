import 'package:flutter/material.dart';

class IntivaText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final Color? color;

  const IntivaText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.color,
  });

  const IntivaText.display(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  const IntivaText.title(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  const IntivaText.subtitle(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  const IntivaText.body(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = const TextStyle(fontSize: 14);

  const IntivaText.caption(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : style = const TextStyle(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ?? const TextStyle(fontSize: 14);
    return Text(
      text,
      style: color != null ? baseStyle.copyWith(color: color) : baseStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }
}
