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
  // State<BookAppConcept> createState() => _BookAppConceptState();
  _BookAppConceptState createState() => _BookAppConceptState();
}

class _BookAppConceptState extends State<BookAppConcept> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bookHeight = size.height * 0.45;
    final bookWidth = size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 0,
        title: const Text(
          'Bookio',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              bookAppBackground,
              fit: BoxFit.fill,
            ),
          ),
          PageView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          book.image,
                          fit: BoxFit.cover,
                          height: bookHeight,
                          width: bookWidth,
                        ),
                      ),
                      const SizedBox(height: 90),
                      Text(
                        book.title,
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'By ${book.author}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
