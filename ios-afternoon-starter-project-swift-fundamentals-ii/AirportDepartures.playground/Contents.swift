import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus: String {
    case EnRoute = "En Route"
    case Scheduled = "Scheduled"
    case Canceled = "Canceled"
    case Delayed = "Delayed"
    case Boarding = "Boarding"
    
}

struct Airport {
    let city: String
}

struct Flight {
    var airline: String
    var destination: String
    var flightNumber: String
    var departureTime: Date?
    var terminal: String?
    var status: FlightStatus
    
}

class DepartureBoard {
    let airPort: Airport
    var departureFlights: [Flight]
    
    init(airPort: Airport, departureFlights: [Flight]) {
        self.airPort = airPort
        self.departureFlights = departureFlights
    }
    
    func alertPassengers() {
        for flight in departureFlights {
            switch flight.status {
                case .Canceled:
                    print("We're sorry your flight to \(flight.destination) was canceled, here is a $500 voucher")
                case .Delayed:
                    print("We're sorry your flight to \(flight.destination) is delayed, We'll let you know a new time")
                case .Boarding:
                    print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
                case .EnRoute:
                    print("Your flight to \(flight.destination) is En Route")
                case .Scheduled:
                    if let time = flight.departureTime {
                        let dateformatter = DateFormatter()
                        dateformatter.dateStyle = .none
                        dateformatter.timeStyle = .short
                        let formattedTime = dateformatter.string(from: time)
                        print("Your flight to \(flight.destination) is scheduled to depart at \(formattedTime) from terminal: \(flight.terminal ?? "TBD")")
                        
                    } else {
                        print("Your flight to \(flight.destination) is scheduled to depart at from terminal: \(flight.terminal ?? "TBD")")

                        
                }
                   
                    
            }
        }
    }
}




//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
let flight1 = Flight(airline: "Delta", destination: "New York", flightNumber: "D228", departureTime: Date(), terminal: "8", status: .EnRoute)
let flight2 = Flight(airline: "American Airlines", destination: "Chicago", flightNumber: "AA4456", departureTime: nil, terminal: nil, status: .Canceled)
let flight3 = Flight(airline: "Jet Blue", destination: "Orlando", flightNumber: "JB955", departureTime: Date(), terminal: "13", status: .Scheduled)
let flights = [flight1, flight2, flight3]

let airport = Airport(city: "Texas")
let departureBoard = DepartureBoard(airPort: airport, departureFlights: [])

for flight in flights {
    departureBoard.departureFlights.append(flight)
}



//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    for flight in flights {
        print("departure: \(flight.departureTime) terminal: \(flight.terminal)  status: \(flight.status)")
    }
}

printDepartures(departureBoard: departureBoard)



//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
func printDepartures2(departureBoard: DepartureBoard) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    for flight in flights {
        if let departTime = flight.departureTime {
            let formattedDate = dateFormatter.string(from: departTime)
            if let terminal = flight.terminal {
                print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flightNumber) Departure Time: \(formattedDate) Terminal: \(terminal)  Status: \(flight.status.rawValue)")
            } else {
                print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flightNumber) Departure Time: \(formattedDate) Terminal:  Status: \(flight.status.rawValue)")
            }
            
        } else {
            if let terminal = flight.terminal {
                print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flightNumber) Departure Time: Terminal: \(terminal)  Status: \(flight.status.rawValue)")
            } else {
                print("Destination: \(flight.destination) Airline: \(flight.airline) Flight: \(flight.flightNumber) Departure Time: Terminal: Status: \(flight.status.rawValue)")
            }
            

        }
    }
}

printDepartures2(departureBoard: departureBoard)


//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
departureBoard.alertPassengers()



//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    let bagCost = 25 * checkedBags
    let distanceCost = 0.10 * Double(distance)
    let travelerCost = (Double(bagCost) + distanceCost) * Double(travelers)
    return travelerCost
}


let airfare1 = calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
print(airfare1)

let airfare2 = calculateAirfare(checkedBags: 5, distance: 2000, travelers: 2)
print(airfare2)


