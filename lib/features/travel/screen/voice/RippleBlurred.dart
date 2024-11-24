import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

/// You can use whatever widget as a [child], when you don't need to provide any
/// [child], just provide an empty Container().
/// [delay] is using a [Timer] for delaying the animation, it's zero by default.
/// You can set [repeat] to true for making a paulsing effect.
class RippleAnimationBlurred extends StatefulWidget {
  ///initialize the ripple animation
  const RippleAnimationBlurred({
    required this.child,
    this.color = Colors.black,
    this.delay = Duration.zero,
    this.repeat = false,
    this.minRadius = 60,
    this.ripplesCount = 5,
    this.duration = const Duration(milliseconds: 2300),
    super.key,
  });

  ///[Widget] this widget will placed at center of the animation
  final Widget child;

  ///[Duration] delay of the animation
  final Duration delay;

  /// [double] minimum radius of the animation
  final double minRadius;

  /// [Color] color of the animation
  final Color color;

  /// [int] number of circle that u want to display in the animation
  final int ripplesCount;

  /// [Duration]  of the animation
  final Duration duration;

  /// [bool] provide true if u want repeat ani9mation
  final bool repeat;

  @override
  RippleAnimationState createState() => RippleAnimationState();
}

///state of the animation
class RippleAnimationState extends State<RippleAnimationBlurred>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    Timer? animationTimer;

    animationTimer = Timer(widget.delay, () {
      if (_controller != null && mounted) {
        // repeating or just forwarding the animation once.
        widget.repeat ? _controller!.repeat() : _controller!.forward();
      }
      // Cancel the timer when it's no longer needed.
      animationTimer?.cancel();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      CustomPaint(
        painter: CirclePainter(
          _controller,
          color: widget.color,
          minRadius: widget.minRadius,
          wavesCount: widget.ripplesCount + 2,
        ),
        child: widget.child,
      ),
    ],
  );
}

/// Creating a Circular painter for clipping the rects and creating circle shape
class CirclePainter extends CustomPainter {
  ///initialize the painter
  CirclePainter(
      this.animation, {
        required this.wavesCount,
        required this.color,
        this.minRadius,
      }) : super(repaint: animation);

  ///[Color] of the painter
  final Color color;

  ///[double] minimum radius of the painter
  final double? minRadius;

  ///[int] number of wave count in the animation
  final int wavesCount;

  ///[Color] of the painter
  final Animation<double>? animation;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    for (int wave = 0; wave <= wavesCount; wave++) {
      circle(
        canvas,
        rect,
        minRadius,
        wave,
        animation!.value,
        wavesCount,
        color,
      );
    }
  }

  /// animating the opacity according to min radius and waves count.
  void circle(
      Canvas canvas,
      Rect rect,
      double? minRadius,
      int wave,
      double value,
      int? length,
      Color circleColor,
      ) {
    Color color = circleColor;
    double outerRadius;
    double innerRadius;

    // Check if wave is greater than 0 to ensure we have at least one ripple
    if (wave >= 0) {
      // Calculate the opacity based on the wave number and animation value
      final double opacity =
      (1 - ((wave - 1) / length!) - value).clamp(0.0, 1.0);
      color = color.withOpacity(opacity);

      // Calculate the radii for the outer and inner circles
      outerRadius = minRadius! * (1 + (wave * value)) * value;
      innerRadius = outerRadius * 0.5; // Make the inner circle half the size of the outer circle

      final Paint outerPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final Paint innerPaint = Paint()
        ..color = Colors.transparent // No color for the inner circle
        ..style = PaintingStyle.fill;

      // Draw the outer circle
      canvas.drawCircle(rect.center, outerRadius, outerPaint);

      // Draw the inner circle to create the void effect
      canvas.drawCircle(rect.center, innerRadius, innerPaint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}
