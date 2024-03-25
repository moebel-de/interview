import 'package:interview/models/movie.dart';
import 'package:interview/models/rental.dart';

class Customer {
  final String name;
  final List<Rental> _rentals = [];

  Customer({required this.name});

  void addRental(Rental rental) {
    _rentals.add(rental);
  }

  String statement() {
    double totalAmount = 0;
    int frequentRenterPoints = 0;
    String result = "Rental Record for $name\n";
    for (Rental each in _rentals) {
      double thisAmount = 0;
      //determine amounts for each line
      switch (each.movie.priceCode) {
        case Movie.REGULAR:
          thisAmount += 2;
          if (each.dayRented > 2) {
            thisAmount += (each.dayRented - 2) * 1.5;
          }
          break;
        case Movie.NEW_RELEASE:
          thisAmount += each.dayRented * 3;
          break;
        case Movie.CHILDREN:
          thisAmount += 1.5;
          if (each.dayRented > 3) thisAmount += (each.dayRented - 3) * 1.5;
          break;
      }
      // add frequent renter points
      frequentRenterPoints++;
      // add bonus for a two day new release rental
      if ((each.movie.priceCode == Movie.NEW_RELEASE) && each.dayRented > 1) {
        frequentRenterPoints++;
      }

      if(each.movie.isPopular && each.movie.isExpensive ) {
        thisAmount *= 2;
      }
      if(each.movie.isPopular && !each.movie.isExpensive ) {
        thisAmount *= 1.5;
      }
      //show figures for this rental
      result += "\t${each.movie.title}\t$thisAmount\n";
      totalAmount += thisAmount;
    }
    
    //add footer lines
    result += "Amount owed is $totalAmount\n";
    result += "You earned $frequentRenterPoints frequent renter points";
    return result;
  }
}


