import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/* Constables */
const animationDuration = Duration(milliseconds: 430);
const animationCurve = Curves.ease;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _controller;
  final _pages = const [
    "https://images.unsplash.com/photo-1534237710431-e2fc698436d0?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YnVpbGRpbmd8ZW58MHx8MHx8fDA%3D&w=500",
    "https://images.unsplash.com/photo-1542361345-89e58247f2d5?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGJ1aWxkaW5nfGVufDB8fDB8fHww&w=500",
    "https://plus.unsplash.com/premium_photo-1680157072705-bb7f72ab1aa0?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGJ1aWxkaW5nfGVufDB8fDB8fHww&w=500",
  ];

  double pagePosition = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(() {
      if (_controller.hasClients) {
        setState(() {
          pagePosition = _controller.page ?? 0;
        });
      }
    });
  }

  cacheImages() {
    for (var element in _pages) {
      precacheImage(NetworkImage(element), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // cacheImages();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: LayoutBuilder(builder: (context, constraints) {
                    final dividedWidth = (constraints.maxWidth / _pages.length);
                    final position = dividedWidth * pagePosition;
                    return Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        AnimatedPositioned(
                          left: position,
                          curve: animationCurve,
                          duration: animationDuration,
                          child: AnimatedPageNavigator(
                            width: dividedWidth,
                            pageCount: _pages.length,
                            pagePosition: pagePosition,
                            onItemClick: (value) {
                              _controller.animateToPage(
                                value,
                                curve: animationCurve,
                                duration: animationDuration +
                                    const Duration(milliseconds: 20),
                              );
                            },
                          ),
                        ),
                        const SizedBox.expand(),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: PageView.builder(
                  itemCount: _pages.length,
                  controller: _controller,
                  itemBuilder: (c, i) => Transform(
                    transform: Matrix4.identity()..rotateX(pagePosition - i),
                    child: SinglePage(
                      imageLink: _pages[i],
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

class AnimatedPageNavigator extends StatelessWidget {
  const AnimatedPageNavigator({
    super.key,
    required this.width,
    required this.pageCount,
    required this.pagePosition,
    required this.onItemClick,
  });

  final double width;
  final int pageCount;
  final double pagePosition;
  final ValueChanged<int> onItemClick;

  static const totalHeight = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: totalHeight.toDouble(),
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            top: 0,
            duration: animationDuration,
            curve: animationCurve,
            left: (width / pageCount) * pagePosition,
            child: Container(
              height: totalHeight.toDouble(),
              width: width / pageCount,
              color: Colors.grey,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              pageCount,
              (index) => Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => onItemClick(index),
                        child: SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: Text(
                              index.toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if ((index + 1) != pageCount)
                      const VerticalDivider(
                        width: 0,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SinglePage extends StatelessWidget {
  const SinglePage({
    super.key,
    required this.imageLink,
  });
  final String imageLink;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageLink,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
