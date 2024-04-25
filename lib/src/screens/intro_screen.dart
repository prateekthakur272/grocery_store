import 'package:flutter/material.dart';
import 'package:grocery_store/src/extensions/build_context_extension.dart';
import 'package:video_player/video_player.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/intro.mp4')
          ..initialize().then((_) {
            _videoPlayerController.play();
            _videoPlayerController.setLooping(true);
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                      height: _videoPlayerController.value.size.height,
                      width: _videoPlayerController.value.size.width,
                      child: VideoPlayer(_videoPlayerController)))),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Grocery Store',
                textAlign: TextAlign.center,
                style: context.textTheme.displayLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text('Get delivered in minutes in few taps', style: context.textTheme.bodyLarge!.copyWith(
                color: Colors.white
              ),)
            ],
          ),
          Positioned(
            bottom: 56,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FilledButton(onPressed: (){}, child: const Text('Login Or Register')),
                const SizedBox(width: 24,),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                    onPressed: (){}, child: const Text('Continue As Guest')),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
