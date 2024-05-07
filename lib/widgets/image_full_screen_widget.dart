import 'package:flutter/material.dart';
import '../app/utlis/utils.dart';

class ImageFullScreenWidget extends StatefulWidget {
  static const route = '/image_full_screen';

  const ImageFullScreenWidget({Key? key}) : super(key: key);

  @override
  State<ImageFullScreenWidget> createState() => _ImageFullScreenWidgetState();
}

class _ImageFullScreenWidgetState extends State<ImageFullScreenWidget> {
  final bool dark = true;
  late String image;

  @override
  void initState() {
    super.initState();
    image = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 333),
                curve: Curves.fastOutSlowIn,
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4,
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: MaterialButton(
                padding: const EdgeInsets.all(15),
                elevation: 0,
                color: dark ? Colors.black12 : Colors.white70,
                highlightElevation: 0,
                minWidth: double.minPositive,
                height: double.minPositive,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: dark ? Colors.white : Colors.black,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

