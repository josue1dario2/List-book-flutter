import 'dart:math';

import 'package:book_list_flutter/src/pages/book.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BookAppConcept(),
  ));
}

class BookAppConcept extends StatefulWidget {
  const BookAppConcept({Key? key}) : super(key: key);

  @override
  _BookAppConceptState createState() => _BookAppConceptState();
}

class _BookAppConceptState extends State<BookAppConcept> {
  final _controller = PageController();
  final _notifierScroll = ValueNotifier(0.0);

  void _listener() {
    _notifierScroll.value = _controller.page!;
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bookHeight = size.height * 0.45;
    final bookWidth = size.width * 0.6;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              bookAppBackground,
              fit: BoxFit.fill,
            ),
          ),
          const WidgetAppBar(),
          ValueListenableBuilder<double>(
              valueListenable: _notifierScroll,
              builder: (context, value, _) {
                return PageView.builder(
                    itemCount: books.length,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      final percentage = index - value;
                      final rotation = percentage.clamp(0.0, 1.0);
                      final fixRotation = pow(rotation, 0.35);
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Stack(
                              children: [
                                Container(
                                  height: bookHeight,
                                  width: bookWidth,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 20,
                                            offset: Offset(5.0, 5.0),
                                            spreadRadius: 10)
                                      ]),
                                ),
                                Transform(
                                  alignment: Alignment.centerLeft,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.002)
                                    ..rotateY(1.8 * fixRotation)
                                    ..translate(-rotation * size.width * 0.8)
                                    ..scale(1 + rotation),
                                  child: Image.asset(
                                    book.image,
                                    fit: BoxFit.cover,
                                    height: bookHeight,
                                    width: bookWidth,
                                  ),
                                ),
                              ],
                            )),
                            const SizedBox(height: 90),
                            TextBook(rotation: rotation, book: book)
                          ],
                        ),
                      );
                    });
              }),
        ],
      ),
    );
  }
}

class WidgetAppBar extends StatelessWidget {
  const WidgetAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: AppBar(
        centerTitle: false,
        leadingWidth: 0,
        title: const Text(
          'Bookio',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class TextBook extends StatelessWidget {
  const TextBook({
    Key? key,
    required this.rotation,
    required this.book,
  }) : super(key: key);

  final double rotation;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1 - rotation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 20),
          Text(
            'By ${book.author}',
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
