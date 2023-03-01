import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class AtakSearch extends StatefulWidget {
  @override
  _AtakSearchState createState() => _AtakSearchState();
}

class _AtakSearchState extends State<AtakSearch> {
  final _controller = TextEditingController();
  List<Map<String, dynamic>> _results = [];

  void _search() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    final response =
        await http.get(Uri.parse('https://www.google.com/search?q=$query'));
    final document = html.parse(response.body);

    final results = <Map<String, dynamic>>[];

    for (final element in document.querySelectorAll('div.g')) {
      final titleElement = element.querySelector('h3');
      final linkElement = element.querySelector('a');
      final descriptionElement = element.querySelector('span.aCOpRe');

      if (titleElement != null && linkElement != null) {
        final title = titleElement.text;
        final link = linkElement.attributes['href'] ?? '';
        final description = descriptionElement?.text ?? '';

        results.add({
          'title': title,
          'link': link,
          'description': description,
        });
      } else {
        throw Exception('Falha ao carregar um post');
      }
    }

    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 7, 17),
      // appBar: AppBar(
      //   title: Text('Atak Search'),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(3)),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: '  Pesquisar?',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _search,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final result = _results[index];
                return ListTile(
                  title: Text(result['title']),
                  subtitle: Text(result['description']),
                  onTap: () {
                    // Abrir el enlace en un navegador
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
