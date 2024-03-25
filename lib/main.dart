import 'package:flutter/material.dart';
import 'package:interview/models/customer.dart';
import 'package:interview/models/movie.dart';
import 'package:interview/models/rental.dart';
// Import your Customer class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movie Rental App',
      home: MovieListPage(),
    );
  }
}

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  MovieListPageState createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  final Customer customer = Customer(name: "John Doe");

  final List<Movie> movies = const [
    Movie(title: "Toy Story", priceCode: Movie.CHILDREN),
    Movie(title: "Inception", priceCode: Movie.NEW_RELEASE),
    Movie(title: "The Godfather", priceCode: Movie.REGULAR),
  ];

  void _rentMovie(Movie movie) {
    setState(() {
      customer.addRental(
          Rental(movie: movie, dayRented: 2)); // Example rental period
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Movie to Rent'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(movies[index].title),
            subtitle: Text('Price Code: ${movies[index].priceCode}'),
            onTap: () => _rentMovie(movies[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the customer's statement
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Rental Statement'),
                content: SingleChildScrollView(
                  child: Text(customer.statement()),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Show Statement',
        child: const Icon(Icons.receipt),
      ),
    );
  }
}
