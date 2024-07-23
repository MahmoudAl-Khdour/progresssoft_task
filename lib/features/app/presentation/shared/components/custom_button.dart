import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color background;
  final bool isUpperCase;
  final double radius;
  final Function()? onTap;
  final String text;
  final bool withIcon;
  final double textSize;
  final Color textColor;
  final IconData? icon;
  final Color colorIcon;
  final double iconSize;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textSize = 13,
    this.icon,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 60,
    required this.background,
    this.isUpperCase = false,
    this.radius = 0,
    this.withIcon = false,
    this.colorIcon = Colors.white,
    this.borderColor,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(1),
            maximumSize: Size(width, height),
            minimumSize: Size(width, height),
            backgroundColor: background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: borderColor == null
                  ? BorderSide.none
                  : BorderSide(
                      color: borderColor!,
                      width: 1.0,
                    ),
            ),
          ),
          onPressed: onTap,
          child: withIcon
              ? Row(
                  children: [
                    Icon(
                      icon,
                      color: colorIcon,
                      size: iconSize,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      text,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: textColor,
                            fontSize: textSize,
                          ),
                    ),
                  ],
                )
              : Text(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  text,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: textColor,
                        fontSize: textSize,
                      ),
                ),
        )),
      ),
    );
  }
}
