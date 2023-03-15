import 'package:flutter/material.dart';

class GeneralLoadingBarrier extends StatelessWidget {
  const GeneralLoadingBarrier({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(
          color: Colors.black.withOpacity(0.2),
          barrierSemanticsDismissible: false,
          dismissible: false,
        ),
        const Center(child: CircularProgressIndicator())
      ],
    );
  }
}
