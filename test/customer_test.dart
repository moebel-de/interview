import 'package:flutter_test/flutter_test.dart';
import 'package:interview/models/movie.dart';
import 'package:interview/models/rental.dart';
import 'package:interview/models/customer.dart';

void main() {
  group('Customer Statement Tests', () {
    test('Regular Movie Rental - Less Than 2 Days', () {
      var regularMovie =
          const Movie(title: "Regular Movie", priceCode: Movie.REGULAR);
      var customer = Customer(name: "Test Customer");
      customer.addRental(Rental(movie: regularMovie, dayRented: 1));

      var expectedStatement =
          "Rental Record for Test Customer\n\tRegular Movie\t2.0\n"
          "Amount owed is 2.0\n"
          "You earned 1 frequent renter points";

      expect(customer.statement(), equals(expectedStatement));
    });

    test('Regular Movie Rental - More Than 2 Days', () {
      var regularMovie =
          const Movie(title: "Regular Movie", priceCode: Movie.REGULAR);
      var customer = Customer(name: "Test Customer");
      customer.addRental(Rental(movie: regularMovie, dayRented: 3));

      var expectedStatement =
          "Rental Record for Test Customer\n\tRegular Movie\t3.5\n"
          "Amount owed is 3.5\n"
          "You earned 1 frequent renter points";

      expect(customer.statement(), equals(expectedStatement));
    });

    test('New Release Movie Rental - More Than 1 Day', () {
      var newReleaseMovie =
          const Movie(title: "New Release", priceCode: Movie.NEW_RELEASE);
      var customer = Customer(name: "Test Customer");
      customer.addRental(Rental(movie: newReleaseMovie, dayRented: 2));

      var expectedStatement =
          "Rental Record for Test Customer\n\tNew Release\t6.0\n"
          "Amount owed is 6.0\n"
          "You earned 2 frequent renter points";

      expect(customer.statement(), equals(expectedStatement));
    });

    test('Children Movie Rental - More Than 3 Days', () {
      var childrenMovie =
          const Movie(title: "Children Movie", priceCode: Movie.CHILDREN);
      var customer = Customer(name: "Test Customer");
      customer.addRental(Rental(movie: childrenMovie, dayRented: 4));

      var expectedStatement =
          "Rental Record for Test Customer\n\tChildren Movie\t3.0\n"
          "Amount owed is 3.0\n"
          "You earned 1 frequent renter points";

      expect(customer.statement(), equals(expectedStatement));
    });

    test('Popular and Expensive Movie Rental', () {
      var popularExpensiveMovie = const Movie(
          title: "Blockbuster",
          priceCode: Movie.NEW_RELEASE,
          isPopular: true,
          isExpensive: true);
      var customer = Customer(name: "Test Customer");
      customer.addRental(Rental(movie: popularExpensiveMovie, dayRented: 2));

      var expectedStatement =
          "Rental Record for Test Customer\n\tBlockbuster\t12.0\n"
          "Amount owed is 12.0\n"
          "You earned 2 frequent renter points";

      expect(customer.statement(), equals(expectedStatement));
    });

    test('Multiple Rentals', () {
      var customer = Customer(name: "Test Customer");
      var movies = const [
        Movie(title: "Regular Movie", priceCode: Movie.REGULAR),
        Movie(title: "New Release", priceCode: Movie.NEW_RELEASE),
        Movie(title: "Children Movie", priceCode: Movie.CHILDREN),
      ];
      var daysRented = [1, 2, 4];

      for (int i = 0; i < movies.length; i++) {
        customer.addRental(Rental(movie: movies[i], dayRented: daysRented[i]));
      }

      var expectedStatement = "Rental Record for Test Customer\n"
          "\tRegular Movie\t2.0\n"
          "\tNew Release\t6.0\n"
          "\tChildren Movie\t3.0\n"
          "Amount owed is 11.0\n"
          "You earned 4 frequent renter points";

      expect(customer.statement(), equals(expectedStatement));
    });
  });
}
