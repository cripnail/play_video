import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50,
    width: 50,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.1), // foreground
      ),
      onPressed: onPressed,
      child: child,
    ),
  );
}