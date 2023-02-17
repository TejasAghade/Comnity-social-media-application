import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;
  
  const LikeAnimation({super.key, required this.child, required this.isAnimating,  this.duration = const Duration(milliseconds: 150), this.onEnd,  this.smallLike = false});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController aniController; 
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    aniController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(aniController);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.isAnimating != oldWidget){
      startAnimation();
    }
  }

  startAnimation() async{
    if(widget.isAnimating || widget.smallLike){
      await aniController.forward(); 
      await aniController.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      
      if(widget.onEnd != null){
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    aniController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}