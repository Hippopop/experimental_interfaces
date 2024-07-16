// MIT License
//
// Copyright (c) 2024 [Mostafijul Islam]
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'dart:developer';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResponsiveStateDebuggerChild extends StatefulWidget {
  const ResponsiveStateDebuggerChild({
    super.key,
    required this.state,
    required this.childColor,
  });
  final ResponsiveState state;
  final Color childColor;

  @override
  State<ResponsiveStateDebuggerChild> createState() =>
      _ResponsiveStateDebuggerChildState();
}

class _ResponsiveStateDebuggerChildState
    extends State<ResponsiveStateDebuggerChild> {
  @override
  void initState() {
    super.initState();
    log("Just initialized : ${widget.state.name}");
  }

  @override
  void didUpdateWidget(covariant ResponsiveStateDebuggerChild oldWidget) {
    log("Just updated : (Old => ${oldWidget.state.name}) || (New => ${widget.state.name})");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    log("Just disposed : ${widget.state.name}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.childColor,
      child: SizedBox.expand(
        child: Center(
          child: Text(
            "Screen State: ${widget.state.name}",
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveParentWrapper(
        useMaterialTwoSpecifications: true,
        builder: (context, currentState) => switch (currentState) {
          ResponsiveState.ts => ResponsiveStateDebuggerChild(
              state: currentState,
              childColor: Colors.white,
            ),
          ResponsiveState.xs => ResponsiveStateDebuggerChild(
              state: currentState,
              childColor: Colors.grey,
            ),
          ResponsiveState.sm => ResponsiveStateDebuggerChild(
              state: currentState,
              childColor: Colors.blue,
            ),
          ResponsiveState.md => ResponsiveStateDebuggerChild(
              state: currentState,
              childColor: Colors.green,
            ),
          ResponsiveState.lg => ResponsiveStateDebuggerChild(
              state: currentState,
              childColor: Colors.teal,
            ),
          ResponsiveState.xl => ResponsiveStateDebuggerChild(
              state: currentState,
              childColor: Colors.purple,
            ),
        },
      ),
    );
  }
}

enum ResponsiveState {
  ts(
    min: 0,
    max: 360,
    bodyMargin: 8,
    layoutColumn: 4,
    contentBody: null,
  ),
  xs(
    min: 361,
    max: 600,
    bodyMargin: 16,
    layoutColumn: 4,
    contentBody: null,
  ),
  sm(
    min: 601,
    max: 900,
    bodyMargin: 32,
    layoutColumn: 8,
    contentBody: null,
  ),
  md(
    min: 901,
    max: 1250,
    bodyMargin: null,
    layoutColumn: 12,
    contentBody: 840,
  ),
  lg(
      min: 1250,
      max: 1500,
      bodyMargin: 200,
      layoutColumn: 12,
      contentBody: null),
  xl(
    min: 1500,
    max: double.infinity,
    bodyMargin: null,
    layoutColumn: 8,
    contentBody: 1080,
  );

  const ResponsiveState({
    required this.min,
    required this.max,
    required this.bodyMargin,
    required this.layoutColumn,
    required this.contentBody,
  });

  final double max;
  final double min;

  /* Material 2 Specifications [https://arc.net/l/quote/qtcvlqts] */
  final int? bodyMargin;
  final int? layoutColumn;
  final int? contentBody;

  bool inRange(double screenWidth) => min <= screenWidth && screenWidth <= max;
}

typedef ResponsiveWidgetCallback = Widget Function(
    BuildContext context, ResponsiveState currentState);

class ResponsiveParentWrapper extends StatefulWidget {
  const ResponsiveParentWrapper({
    super.key,
    required this.builder,
    this.useMaterialTwoSpecifications = false,
  });
  final bool useMaterialTwoSpecifications;
  final ResponsiveWidgetCallback builder;

  @override
  State<ResponsiveParentWrapper> createState() =>
      _ResponsiveParentWrapperState();
}

class _ResponsiveParentWrapperState extends State<ResponsiveParentWrapper> {
  late Widget child;
  ResponsiveState? currentState;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final state = ResponsiveState.values.firstWhere(
          (element) => element.inRange(constraints.maxWidth),
        );
        if (currentState != state) {
          currentState = state;
          child = widget.builder(context, state);
        }
        return widget.useMaterialTwoSpecifications
            ? MaterialTwoSpecificationWrapper(state: state, child: child)
            : child;
      },
    );
  }
}

class MaterialTwoSpecificationWrapper extends StatelessWidget {
  const MaterialTwoSpecificationWrapper({
    super.key,
    required this.child,
    required this.state,
  });

  final Widget child;
  final ResponsiveState state;

  @override
  Widget build(BuildContext context) {
    Widget widget = child;
    if (state.bodyMargin != null) {
      widget = Padding(
        padding: EdgeInsets.symmetric(horizontal: state.bodyMargin!.toDouble()),
        child: widget,
      );
    }
    if (state.contentBody != null) {
      widget = Center(
        child: SizedBox(
          width: state.contentBody!.toDouble(),
          child: widget,
        ),
      );
    }
    return widget;
  }
}
