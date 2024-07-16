import 'package:experimental_interfaces/extensions/context_extensions.dart';
import 'package:experimental_interfaces/extensions/spacers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.manropeTextTheme().copyWith(
          titleLarge: GoogleFonts.poppins(),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const restaurantList = [
    RestaurantData(
      name: "Cafe Milano",
      location: "GEC Circle",
      imageUrl:
          "https://images.unsplash.com/photo-1696489149180-bb53f8c38bdb?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDEzOHw2c01WalRMU2tlUXx8ZW58MHx8fHx8",
    ),
    RestaurantData(
      name: "La Delicia",
      location: "Agrabad",
      imageUrl:
          "https://images.unsplash.com/photo-1696610101250-f5933d2f616c?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDEzM3w2c01WalRMU2tlUXx8ZW58MHx8fHx8",
    ),
    RestaurantData(
      name: "Capeccino Zone",
      location: "Lal Khan Bazaar",
      imageUrl:
          "https://images.unsplash.com/photo-1696789738783-0f972304597e?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE0OXw2c01WalRMU2tlUXx8ZW58MHx8fHx8",
    ),
    RestaurantData(
      name: "Bon apetit",
      location: "GEC Circle",
      imageUrl:
          "https://images.unsplash.com/photo-1694161097721-07985d7a61bd?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDIxMHw2c01WalRMU2tlUXx8ZW58MHx8fHx8",
    ),
    RestaurantData(
      name: "Sunday Cuisine",
      location: "Tiger Pass",
      imageUrl:
          "https://images.unsplash.com/photo-1691414110536-a22e3bb38819?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDIwN3w2c01WalRMU2tlUXx8ZW58MHx8fHx8",
    ),
    RestaurantData(
      name: "Cafe Milano",
      location: "GEC Circle",
      imageUrl:
          "https://images.unsplash.com/photo-1695821449523-6929f4e61b6f?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDIxNXw2c01WalRMU2tlUXx8ZW58MHx8fHx8",
    ),
    RestaurantData(
      name: "Cafe Milano",
      location: "GEC Circle",
      imageUrl:
          "https://images.unsplash.com/photo-1696418799976-b079670f33de?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDI0MHw2c01WalRMU2tlUXx8ZW58MHx8fHx8",
    ),
  ];

  cacheImages(BuildContext context) {
    for (RestaurantData i in restaurantList) {
      precacheImage(NetworkImage(i.imageUrl), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    cacheImages(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const MacControlButton(
                        color: Colors.red,
                        icon: Icons.close,
                      ),
                      5.width,
                      const MacControlButton(
                        icon: Icons.remove,
                        color: Colors.yellow,
                      ),
                      5.width,
                      Transform.rotate(
                        angle: -45,
                        child: const MacControlButton(
                          color: Colors.green,
                          icon: Icons.unfold_more,
                        ),
                      ),
                    ],
                  ),
                  18.height,
                  Text(
                    "Local Restaurants",
                    style: context.textTheme?.titleLarge,
                  ),
                  Text(
                    "Restaurants that would make you walk to them.",
                    style: context.textTheme?.bodyMedium,
                  )
                ],
              ),
              24.height,
              Expanded(
                flex: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: restaurantList.length,
                    padding: const EdgeInsets.only(top: 12),
                    itemBuilder: (c, i) => RestaurantImagePortion(
                      restaurantData: restaurantList[i],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MacControlButton extends StatelessWidget {
  const MacControlButton({
    super.key,
    required this.color,
    required this.icon,
  });

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: SizedBox.square(
        dimension: 18,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}

class RestaurantData {
  final String name;
  final String location;
  final String imageUrl;

  const RestaurantData({
    required this.name,
    required this.location,
    required this.imageUrl,
  });
}

@immutable
class RestaurantImagePortion extends StatelessWidget {
  const RestaurantImagePortion({
    super.key,
    required this.restaurantData,
  });

  final RestaurantData restaurantData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [
              RestaurantParralaxImage(imageUrl: restaurantData.imageUrl),
              const BottomOverlayGradient(),
              RestaurantDescription(restaurantData: restaurantData),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantDescription extends StatelessWidget {
  const RestaurantDescription({
    super.key,
    required this.restaurantData,
  });

  final RestaurantData restaurantData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurantData.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            restaurantData.location,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomOverlayGradient extends StatelessWidget {
  const BottomOverlayGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }
}

class RestaurantParralaxImage extends StatefulWidget {
  const RestaurantParralaxImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;
  @override
  State<RestaurantParralaxImage> createState() =>
      _RestaurantParralaxImageState();
}

class _RestaurantParralaxImageState extends State<RestaurantParralaxImage> {
  late final GlobalKey imageKey;
  @override
  void initState() {
    super.initState();
    imageKey = GlobalKey(debugLabel: widget.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Flow(
        delegate: ParralaxFlowDelegate(
            debug: widget.imageUrl == HomePage.restaurantList[2].imageUrl,
            imageKey: imageKey,
            imageContext: context,
            scrollState: Scrollable.of(context)),
        children: [
          Image.network(
            widget.imageUrl,
            key: imageKey,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}

class ParralaxFlowDelegate extends FlowDelegate {
  final bool debug;
  final GlobalKey imageKey;
  final BuildContext imageContext;
  final ScrollableState scrollState;

  ParralaxFlowDelegate({
    this.debug = false,
    required this.imageKey,
    required this.imageContext,
    required this.scrollState,
  }) : super(repaint: scrollState.position);

  @override
  void paintChildren(FlowPaintingContext context) {
    /* Widget render boxes */
    final scrollView = scrollState.context.findRenderObject() as RenderBox;
    final imageWidget = imageContext.findRenderObject() as RenderBox;

    /* Get image postion in scrollView */
    final imageOffset = imageWidget.localToGlobal(
      ancestor: scrollView,
      imageWidget.size.centerLeft(Offset.zero),
    );

    if (debug) {
      print(
        "Image postion on ScrollView : ${imageOffset.toString()}",
      );
    }

    /* Percentage overed by image in viewport */
    final viewport = scrollState.position.viewportDimension;
    final percentage = (imageOffset.dy / viewport).clamp(0, 1);

    if (debug) {
      print(
        "Percentage in scrollview : $percentage",
      );
    }
    /* Calculate Vertical Alignment */
    final alignment = Alignment(0, percentage * 2 - 1);
    if (debug) {
      print(
        "Alignment : ${alignment.toString()}",
      );
    }
    /* Calculate Sizes and draw */
    final restaurantWidgetSize = imageContext.size;
    final imageSize =
        (imageKey.currentContext!.findRenderObject() as RenderBox).size;

    final position =
        alignment.inscribe(imageSize, Offset.zero & restaurantWidgetSize!);
    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0, position.top)).transform,
    );
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  bool shouldRepaint(covariant ParralaxFlowDelegate oldDelegate) {
    return oldDelegate.imageContext != imageContext ||
        oldDelegate.imageKey != imageKey ||
        oldDelegate.scrollState != scrollState;
  }
}
