import 'package:flutter/material.dart';

class PanelLoadingIndicator extends StatelessWidget {
  const PanelLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(
          dismissible: false,
          color: Colors.black.withValues(alpha: 0.2),
        ),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
