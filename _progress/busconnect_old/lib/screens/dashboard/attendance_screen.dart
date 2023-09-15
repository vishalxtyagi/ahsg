import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';

class AttendanceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          // list of attendance history
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SlideAction(
            trackBuilder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    // Show loading if async operation is being performed
                    state.isPerformingAction
                        ? "Loading..."
                        : "Thumb fraction: ${state.thumbFractionalPosition.toStringAsPrecision(2)}",
                  ),
                ),
              );
            },
            thumbBuilder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  // Show loading indicator if async operation is being performed
                  child: state.isPerformingAction
                      ? const CupertinoActivityIndicator(
                    color: Colors.white,
                  )
                      : const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              );
            },
            action: () async {
              // Async operation
              await Future.delayed(
                const Duration(seconds: 2),
                    () => debugPrint("Hello World"),
              );
            },
          )
        )
      ],
    );
  }
}