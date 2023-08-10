//
//  RemoteDataSourceImplementation.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 2/8/23.
//

import Foundation

enum NetworkError: Error, Equatable {
    case malformedURL
    case noData
    case noUser
    case errorCode(Int?)
    case tokenFormat
    case decoding
    case other
}

class RemoteDataSourceImplementation: RemoteDataSourceProtocol{
    
    private let session: NetworkFetchingProtocol
    private let server: String = "https://ergast.com/api/f1/"
  
    init(session: NetworkFetchingProtocol = URLSession.shared) {
        self.session = session
    }
    
    func getCircuits(year: String, completion: @escaping (CircuitTable) -> ())  {
        Task{
            do{
                guard let llamada = try await getCircuitsAPI(year: year) else{
                    print("HomeTableViewController: API Call Errored Out")
                    return
                }
                //Pasamos hacia arriba la clasificacion
                completion(llamada)
            } catch{
                print(error)
            }
        }
    }
    
    func getCircuitsAPI(year: String) async throws -> CircuitTable?{
        
        guard let urlRequest = getSessionCircuits(year: year) else{
            throw NetworkError.malformedURL
        }
        let (data, _) = try await self.session.data(url: urlRequest)
        let welcome = try? JSONDecoder().decode(Welcome.self, from: data)
        return welcome?.mrData.circuitTable
    }
    
    private func getSessionCircuits(year: String) -> URLRequest?{
        
        guard let url = URL(string: "\(server)"+year+"/circuits.json") else{
            print("URL Error")
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        return urlRequest
        
    }
    
    func getResults(year: String, completion: @escaping (RaceTable) -> ()) {
        Task{
            do{
                guard let llamada = try await getResultsAPI(year: year) else{
                    print("getResults for CardInfoView: API Call Errored Out")
                    return
                }
                //Pasamos hacia arriba la clasificacion
                completion(llamada)
            } catch{
                print(error)
            }
        }
    }
    
    //Esta funcion ha sido mockeada porque los json de la API tenian un formato incorrecto y solo cargaban los
    //resultados de las dos primeras carreras
    func getResultsAPI(year: String) async throws -> RaceTable?{
        //let url = URL(string: "https://ergast.com/api/f1/"+year+"/results.json")!
        let welcome = try? JSONDecoder().decode(Welcome2.self, from: mockedResultsRace.data(using: .utf8)!)
        return welcome?.mrData.raceTable
    }
    
    private var mockedResultsRace = """
 {
     "MRData": {
         "xmlns": "http:\\/\\/ergast.com\\/mrd\\/1.5",
         "series": "f1",
         "url": "http://ergast.com/api/f1/2020/results.json",
         "limit": "30",
         "offset": "0",
         "total": "340",
         "RaceTable": {
             "season": "2020",
             "Races": [{
                     "season": "2020",
                     "round": "1",
                     "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/2020_Austrian_Grand_Prix",
                     "raceName": "Austrian Grand Prix",
                     "Circuit": {
                         "circuitId": "red_bull_ring",
                         "url": "http://en.wikipedia.org/wiki/Red_Bull_Ring",
                         "circuitName": "Red Bull Ring",
                         "Location": {
                             "lat": "47.2197",
                             "long": "14.7647",
                             "locality": "Spielberg",
                             "country": "Austria"
                         }
                     },
                     "date": "2020-07-05",
                     "time": "13:10:00Z",
                     "Results": [{
                             "number": "77",
                             "position": "1",
                             "positionText": "1",
                             "points": "25",
                             "Driver": {
                                 "driverId": "bottas",
                                 "permanentNumber": "77",
                                 "code": "BOT",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Valtteri_Bottas",
                                 "givenName": "Valtteri",
                                 "familyName": "Bottas",
                                 "dateOfBirth": "1989-08-28",
                                 "nationality": "Finnish"
                             },
                             "Constructor": {
                                 "constructorId": "mercedes",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Mercedes-Benz_in_Formula_One",
                                 "name": "Mercedes",
                                 "nationality": "German"
                             },
                             "grid": "1",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5455739",
                                 "time": "1:30:55.739"
                             },
                             "FastestLap": {
                                 "rank": "2",
                                 "lap": "68",
                                 "Time": {
                                     "time": "1:07.657"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "229.758"
                                 }
                             }
                         },
                         {
                             "number": "16",
                             "position": "2",
                             "positionText": "2",
                             "points": "18",
                             "Driver": {
                                 "driverId": "leclerc",
                                 "permanentNumber": "16",
                                 "code": "LEC",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Charles_Leclerc",
                                 "givenName": "Charles",
                                 "familyName": "Leclerc",
                                 "dateOfBirth": "1997-10-16",
                                 "nationality": "Monegasque"
                             },
                             "Constructor": {
                                 "constructorId": "ferrari",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Scuderia_Ferrari",
                                 "name": "Ferrari",
                                 "nationality": "Italian"
                             },
                             "grid": "7",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5458439",
                                 "time": "+2.700"
                             },
                             "FastestLap": {
                                 "rank": "4",
                                 "lap": "64",
                                 "Time": {
                                     "time": "1:07.901"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "228.933"
                                 }
                             }
                         },
                         {
                             "number": "4",
                             "position": "3",
                             "positionText": "3",
                             "points": "16",
                             "Driver": {
                                 "driverId": "norris",
                                 "permanentNumber": "4",
                                 "code": "NOR",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Lando_Norris",
                                 "givenName": "Lando",
                                 "familyName": "Norris",
                                 "dateOfBirth": "1999-11-13",
                                 "nationality": "British"
                             },
                             "Constructor": {
                                 "constructorId": "mclaren",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/McLaren",
                                 "name": "McLaren",
                                 "nationality": "British"
                             },
                             "grid": "3",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5461230",
                                 "time": "+5.491"
                             },
                             "FastestLap": {
                                 "rank": "1",
                                 "lap": "71",
                                 "Time": {
                                     "time": "1:07.475"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "230.378"
                                 }
                             }
                         },
                         {
                             "number": "44",
                             "position": "4",
                             "positionText": "4",
                             "points": "12",
                             "Driver": {
                                 "driverId": "hamilton",
                                 "permanentNumber": "44",
                                 "code": "HAM",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Lewis_Hamilton",
                                 "givenName": "Lewis",
                                 "familyName": "Hamilton",
                                 "dateOfBirth": "1985-01-07",
                                 "nationality": "British"
                             },
                             "Constructor": {
                                 "constructorId": "mercedes",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Mercedes-Benz_in_Formula_One",
                                 "name": "Mercedes",
                                 "nationality": "German"
                             },
                             "grid": "5",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5461428",
                                 "time": "+5.689"
                             },
                             "FastestLap": {
                                 "rank": "3",
                                 "lap": "67",
                                 "Time": {
                                     "time": "1:07.712"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "229.572"
                                 }
                             }
                         },
                         {
                             "number": "55",
                             "position": "5",
                             "positionText": "5",
                             "points": "10",
                             "Driver": {
                                 "driverId": "sainz",
                                 "permanentNumber": "55",
                                 "code": "SAI",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Carlos_Sainz_Jr.",
                                 "givenName": "Carlos",
                                 "familyName": "Sainz",
                                 "dateOfBirth": "1994-09-01",
                                 "nationality": "Spanish"
                             },
                             "Constructor": {
                                 "constructorId": "mclaren",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/McLaren",
                                 "name": "McLaren",
                                 "nationality": "British"
                             },
                             "grid": "8",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5464642",
                                 "time": "+8.903"
                             },
                             "FastestLap": {
                                 "rank": "5",
                                 "lap": "63",
                                 "Time": {
                                     "time": "1:07.974"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "228.687"
                                 }
                             }
                         },
                         {
                             "number": "11",
                             "position": "6",
                             "positionText": "6",
                             "points": "8",
                             "Driver": {
                                 "driverId": "perez",
                                 "permanentNumber": "11",
                                 "code": "PER",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Sergio_P%C3%A9rez",
                                 "givenName": "Sergio",
                                 "familyName": "Pérez",
                                 "dateOfBirth": "1990-01-26",
                                 "nationality": "Mexican"
                             },
                             "Constructor": {
                                 "constructorId": "racing_point",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Racing_Point_F1_Team",
                                 "name": "Racing Point",
                                 "nationality": "British"
                             },
                             "grid": "6",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5470831",
                                 "time": "+15.092"
                             },
                             "FastestLap": {
                                 "rank": "6",
                                 "lap": "63",
                                 "Time": {
                                     "time": "1:08.305"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "227.579"
                                 }
                             }
                         },
                         {
                             "number": "10",
                             "position": "7",
                             "positionText": "7",
                             "points": "6",
                             "Driver": {
                                 "driverId": "gasly",
                                 "permanentNumber": "10",
                                 "code": "GAS",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Pierre_Gasly",
                                 "givenName": "Pierre",
                                 "familyName": "Gasly",
                                 "dateOfBirth": "1996-02-07",
                                 "nationality": "French"
                             },
                             "Constructor": {
                                 "constructorId": "alphatauri",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Scuderia_AlphaTauri",
                                 "name": "AlphaTauri",
                                 "nationality": "Italian"
                             },
                             "grid": "12",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5472421",
                                 "time": "+16.682"
                             },
                             "FastestLap": {
                                 "rank": "11",
                                 "lap": "64",
                                 "Time": {
                                     "time": "1:09.025"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "225.205"
                                 }
                             }
                         },
                         {
                             "number": "31",
                             "position": "8",
                             "positionText": "8",
                             "points": "4",
                             "Driver": {
                                 "driverId": "ocon",
                                 "permanentNumber": "31",
                                 "code": "OCO",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Esteban_Ocon",
                                 "givenName": "Esteban",
                                 "familyName": "Ocon",
                                 "dateOfBirth": "1996-09-17",
                                 "nationality": "French"
                             },
                             "Constructor": {
                                 "constructorId": "renault",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Renault_in_Formula_One",
                                 "name": "Renault",
                                 "nationality": "French"
                             },
                             "grid": "14",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5473195",
                                 "time": "+17.456"
                             },
                             "FastestLap": {
                                 "rank": "10",
                                 "lap": "64",
                                 "Time": {
                                     "time": "1:08.932"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "225.509"
                                 }
                             }
                         },
                         {
                             "number": "99",
                             "position": "9",
                             "positionText": "9",
                             "points": "2",
                             "Driver": {
                                 "driverId": "giovinazzi",
                                 "permanentNumber": "99",
                                 "code": "GIO",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Antonio_Giovinazzi",
                                 "givenName": "Antonio",
                                 "familyName": "Giovinazzi",
                                 "dateOfBirth": "1993-12-14",
                                 "nationality": "Italian"
                             },
                             "Constructor": {
                                 "constructorId": "alfa",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Alfa_Romeo_in_Formula_One",
                                 "name": "Alfa Romeo",
                                 "nationality": "Swiss"
                             },
                             "grid": "18",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5476885",
                                 "time": "+21.146"
                             },
                             "FastestLap": {
                                 "rank": "9",
                                 "lap": "70",
                                 "Time": {
                                     "time": "1:08.796"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "225.954"
                                 }
                             }
                         },
                         {
                             "number": "5",
                             "position": "10",
                             "positionText": "10",
                             "points": "1",
                             "Driver": {
                                 "driverId": "vettel",
                                 "permanentNumber": "5",
                                 "code": "VET",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Sebastian_Vettel",
                                 "givenName": "Sebastian",
                                 "familyName": "Vettel",
                                 "dateOfBirth": "1987-07-03",
                                 "nationality": "German"
                             },
                             "Constructor": {
                                 "constructorId": "ferrari",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Scuderia_Ferrari",
                                 "name": "Ferrari",
                                 "nationality": "Italian"
                             },
                             "grid": "11",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5480284",
                                 "time": "+24.545"
                             },
                             "FastestLap": {
                                 "rank": "8",
                                 "lap": "71",
                                 "Time": {
                                     "time": "1:08.623"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "226.524"
                                 }
                             }
                         },
                         {
                             "number": "6",
                             "position": "11",
                             "positionText": "11",
                             "points": "0",
                             "Driver": {
                                 "driverId": "latifi",
                                 "permanentNumber": "6",
                                 "code": "LAT",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Nicholas_Latifi",
                                 "givenName": "Nicholas",
                                 "familyName": "Latifi",
                                 "dateOfBirth": "1995-06-29",
                                 "nationality": "Canadian"
                             },
                             "Constructor": {
                                 "constructorId": "williams",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Williams_Grand_Prix_Engineering",
                                 "name": "Williams",
                                 "nationality": "British"
                             },
                             "grid": "20",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5487389",
                                 "time": "+31.650"
                             },
                             "FastestLap": {
                                 "rank": "16",
                                 "lap": "63",
                                 "Time": {
                                     "time": "1:09.662"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "223.146"
                                 }
                             }
                         },
                         {
                             "number": "26",
                             "position": "12",
                             "positionText": "12",
                             "points": "0",
                             "Driver": {
                                 "driverId": "kvyat",
                                 "permanentNumber": "26",
                                 "code": "KVY",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Daniil_Kvyat",
                                 "givenName": "Daniil",
                                 "familyName": "Kvyat",
                                 "dateOfBirth": "1994-04-26",
                                 "nationality": "Russian"
                             },
                             "Constructor": {
                                 "constructorId": "alphatauri",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Scuderia_AlphaTauri",
                                 "name": "AlphaTauri",
                                 "nationality": "Italian"
                             },
                             "grid": "13",
                             "laps": "69",
                             "status": "Suspension",
                             "FastestLap": {
                                 "rank": "13",
                                 "lap": "50",
                                 "Time": {
                                     "time": "1:09.135"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "224.847"
                                 }
                             }
                         },
                         {
                             "number": "23",
                             "position": "13",
                             "positionText": "13",
                             "points": "0",
                             "Driver": {
                                 "driverId": "albon",
                                 "permanentNumber": "23",
                                 "code": "ALB",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Alexander_Albon",
                                 "givenName": "Alexander",
                                 "familyName": "Albon",
                                 "dateOfBirth": "1996-03-23",
                                 "nationality": "Thai"
                             },
                             "Constructor": {
                                 "constructorId": "red_bull",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Red_Bull_Racing",
                                 "name": "Red Bull",
                                 "nationality": "Austrian"
                             },
                             "grid": "4",
                             "laps": "67",
                             "status": "Electronics",
                             "FastestLap": {
                                 "rank": "7",
                                 "lap": "50",
                                 "Time": {
                                     "time": "1:08.432"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "227.156"
                                 }
                             }
                         },
                         {
                             "number": "7",
                             "position": "14",
                             "positionText": "R",
                             "points": "0",
                             "Driver": {
                                 "driverId": "raikkonen",
                                 "permanentNumber": "7",
                                 "code": "RAI",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Kimi_R%C3%A4ikk%C3%B6nen",
                                 "givenName": "Kimi",
                                 "familyName": "Räikkönen",
                                 "dateOfBirth": "1979-10-17",
                                 "nationality": "Finnish"
                             },
                             "Constructor": {
                                 "constructorId": "alfa",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Alfa_Romeo_in_Formula_One",
                                 "name": "Alfa Romeo",
                                 "nationality": "Swiss"
                             },
                             "grid": "19",
                             "laps": "53",
                             "status": "Wheel",
                             "FastestLap": {
                                 "rank": "12",
                                 "lap": "48",
                                 "Time": {
                                     "time": "1:09.031"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "225.185"
                                 }
                             }
                         },
                         {
                             "number": "63",
                             "position": "15",
                             "positionText": "R",
                             "points": "0",
                             "Driver": {
                                 "driverId": "russell",
                                 "permanentNumber": "63",
                                 "code": "RUS",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/George_Russell_(racing_driver)",
                                 "givenName": "George",
                                 "familyName": "Russell",
                                 "dateOfBirth": "1998-02-15",
                                 "nationality": "British"
                             },
                             "Constructor": {
                                 "constructorId": "williams",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Williams_Grand_Prix_Engineering",
                                 "name": "Williams",
                                 "nationality": "British"
                             },
                             "grid": "17",
                             "laps": "49",
                             "status": "Fuel pressure",
                             "FastestLap": {
                                 "rank": "14",
                                 "lap": "49",
                                 "Time": {
                                     "time": "1:09.317"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "224.256"
                                 }
                             }
                         },
                         {
                             "number": "8",
                             "position": "16",
                             "positionText": "R",
                             "points": "0",
                             "Driver": {
                                 "driverId": "grosjean",
                                 "permanentNumber": "8",
                                 "code": "GRO",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Romain_Grosjean",
                                 "givenName": "Romain",
                                 "familyName": "Grosjean",
                                 "dateOfBirth": "1986-04-17",
                                 "nationality": "French"
                             },
                             "Constructor": {
                                 "constructorId": "haas",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Haas_F1_Team",
                                 "name": "Haas F1 Team",
                                 "nationality": "American"
                             },
                             "grid": "15",
                             "laps": "49",
                             "status": "Brakes",
                             "FastestLap": {
                                 "rank": "17",
                                 "lap": "46",
                                 "Time": {
                                     "time": "1:10.228"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "221.347"
                                 }
                             }
                         },
                         {
                             "number": "20",
                             "position": "17",
                             "positionText": "R",
                             "points": "0",
                             "Driver": {
                                 "driverId": "kevin_magnussen",
                                 "permanentNumber": "20",
                                 "code": "MAG",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Kevin_Magnussen",
                                 "givenName": "Kevin",
                                 "familyName": "Magnussen",
                                 "dateOfBirth": "1992-10-05",
                                 "nationality": "Danish"
                             },
                             "Constructor": {
                                 "constructorId": "haas",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Haas_F1_Team",
                                 "name": "Haas F1 Team",
                                 "nationality": "American"
                             },
                             "grid": "16",
                             "laps": "24",
                             "status": "Brakes",
                             "FastestLap": {
                                 "rank": "20",
                                 "lap": "23",
                                 "Time": {
                                     "time": "1:10.720"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "219.807"
                                 }
                             }
                         },
                         {
                             "number": "18",
                             "position": "18",
                             "positionText": "R",
                             "points": "0",
                             "Driver": {
                                 "driverId": "stroll",
                                 "permanentNumber": "18",
                                 "code": "STR",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Lance_Stroll",
                                 "givenName": "Lance",
                                 "familyName": "Stroll",
                                 "dateOfBirth": "1998-10-29",
                                 "nationality": "Canadian"
                             },
                             "Constructor": {
                                 "constructorId": "racing_point",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Racing_Point_F1_Team",
                                 "name": "Racing Point",
                                 "nationality": "British"
                             },
                             "grid": "9",
                             "laps": "20",
                             "status": "Engine",
                             "FastestLap": {
                                 "rank": "18",
                                 "lap": "4",
                                 "Time": {
                                     "time": "1:10.326"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "221.039"
                                 }
                             }
                         },
                         {
                             "number": "3",
                             "position": "19",
                             "positionText": "R",
                             "points": "0",
                             "Driver": {
                                 "driverId": "ricciardo",
                                 "permanentNumber": "3",
                                 "code": "RIC",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Daniel_Ricciardo",
                                 "givenName": "Daniel",
                                 "familyName": "Ricciardo",
                                 "dateOfBirth": "1989-07-01",
                                 "nationality": "Australian"
                             },
                             "Constructor": {
                                 "constructorId": "renault",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Renault_in_Formula_One",
                                 "name": "Renault",
                                 "nationality": "French"
                             },
                             "grid": "10",
                             "laps": "17",
                             "status": "Overheating",
                             "FastestLap": {
                                 "rank": "19",
                                 "lap": "8",
                                 "Time": {
                                     "time": "1:10.610"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "220.150"
                                 }
                             }
                         },
                         {
                             "number": "33",
                             "position": "20",
                             "positionText": "R",
                             "points": "0",
                             "Driver": {
                                 "driverId": "max_verstappen",
                                 "permanentNumber": "33",
                                 "code": "VER",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Max_Verstappen",
                                 "givenName": "Max",
                                 "familyName": "Verstappen",
                                 "dateOfBirth": "1997-09-30",
                                 "nationality": "Dutch"
                             },
                             "Constructor": {
                                 "constructorId": "red_bull",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Red_Bull_Racing",
                                 "name": "Red Bull",
                                 "nationality": "Austrian"
                             },
                             "grid": "2",
                             "laps": "11",
                             "status": "Electronics",
                             "FastestLap": {
                                 "rank": "15",
                                 "lap": "5",
                                 "Time": {
                                     "time": "1:09.351"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "224.146"
                                 }
                             }
                         }
                     ]
                 },
                 {
                     "season": "2020",
                     "round": "2",
                     "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/2020_Styrian_Grand_Prix",
                     "raceName": "Styrian Grand Prix",
                     "Circuit": {
                         "circuitId": "red_bull_ring",
                         "url": "http://en.wikipedia.org/wiki/Red_Bull_Ring",
                         "circuitName": "Red Bull Ring",
                         "Location": {
                             "lat": "47.2197",
                             "long": "14.7647",
                             "locality": "Spielberg",
                             "country": "Austria"
                         }
                     },
                     "date": "2020-07-12",
                     "time": "13:10:00Z",
                     "Results": [{
                             "number": "44",
                             "position": "1",
                             "positionText": "1",
                             "points": "25",
                             "Driver": {
                                 "driverId": "hamilton",
                                 "permanentNumber": "44",
                                 "code": "HAM",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Lewis_Hamilton",
                                 "givenName": "Lewis",
                                 "familyName": "Hamilton",
                                 "dateOfBirth": "1985-01-07",
                                 "nationality": "British"
                             },
                             "Constructor": {
                                 "constructorId": "mercedes",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Mercedes-Benz_in_Formula_One",
                                 "name": "Mercedes",
                                 "nationality": "German"
                             },
                             "grid": "1",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "4970683",
                                 "time": "1:22:50.683"
                             },
                             "FastestLap": {
                                 "rank": "3",
                                 "lap": "68",
                                 "Time": {
                                     "time": "1:06.719"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "232.989"
                                 }
                             }
                         },
                         {
                             "number": "77",
                             "position": "2",
                             "positionText": "2",
                             "points": "18",
                             "Driver": {
                                 "driverId": "bottas",
                                 "permanentNumber": "77",
                                 "code": "BOT",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Valtteri_Bottas",
                                 "givenName": "Valtteri",
                                 "familyName": "Bottas",
                                 "dateOfBirth": "1989-08-28",
                                 "nationality": "Finnish"
                             },
                             "Constructor": {
                                 "constructorId": "mercedes",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Mercedes-Benz_in_Formula_One",
                                 "name": "Mercedes",
                                 "nationality": "German"
                             },
                             "grid": "4",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "4984402",
                                 "time": "+13.719"
                             },
                             "FastestLap": {
                                 "rank": "7",
                                 "lap": "62",
                                 "Time": {
                                     "time": "1:07.534"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "230.177"
                                 }
                             }
                         },
                         {
                             "number": "33",
                             "position": "3",
                             "positionText": "3",
                             "points": "15",
                             "Driver": {
                                 "driverId": "max_verstappen",
                                 "permanentNumber": "33",
                                 "code": "VER",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Max_Verstappen",
                                 "givenName": "Max",
                                 "familyName": "Verstappen",
                                 "dateOfBirth": "1997-09-30",
                                 "nationality": "Dutch"
                             },
                             "Constructor": {
                                 "constructorId": "red_bull",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Red_Bull_Racing",
                                 "name": "Red Bull",
                                 "nationality": "Austrian"
                             },
                             "grid": "2",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5004381",
                                 "time": "+33.698"
                             },
                             "FastestLap": {
                                 "rank": "2",
                                 "lap": "70",
                                 "Time": {
                                     "time": "1:06.145"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "235.010"
                                 }
                             }
                         },
                         {
                             "number": "23",
                             "position": "4",
                             "positionText": "4",
                             "points": "12",
                             "Driver": {
                                 "driverId": "albon",
                                 "permanentNumber": "23",
                                 "code": "ALB",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Alexander_Albon",
                                 "givenName": "Alexander",
                                 "familyName": "Albon",
                                 "dateOfBirth": "1996-03-23",
                                 "nationality": "Thai"
                             },
                             "Constructor": {
                                 "constructorId": "red_bull",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Red_Bull_Racing",
                                 "name": "Red Bull",
                                 "nationality": "Austrian"
                             },
                             "grid": "6",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5015083",
                                 "time": "+44.400"
                             },
                             "FastestLap": {
                                 "rank": "6",
                                 "lap": "67",
                                 "Time": {
                                     "time": "1:07.299"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "230.981"
                                 }
                             }
                         },
                         {
                             "number": "4",
                             "position": "5",
                             "positionText": "5",
                             "points": "10",
                             "Driver": {
                                 "driverId": "norris",
                                 "permanentNumber": "4",
                                 "code": "NOR",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Lando_Norris",
                                 "givenName": "Lando",
                                 "familyName": "Norris",
                                 "dateOfBirth": "1999-11-13",
                                 "nationality": "British"
                             },
                             "Constructor": {
                                 "constructorId": "mclaren",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/McLaren",
                                 "name": "McLaren",
                                 "nationality": "British"
                             },
                             "grid": "9",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5032153",
                                 "time": "+1:01.470"
                             },
                             "FastestLap": {
                                 "rank": "5",
                                 "lap": "66",
                                 "Time": {
                                     "time": "1:07.193"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "231.345"
                                 }
                             }
                         },
                         {
                             "number": "11",
                             "position": "6",
                             "positionText": "6",
                             "points": "8",
                             "Driver": {
                                 "driverId": "perez",
                                 "permanentNumber": "11",
                                 "code": "PER",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Sergio_P%C3%A9rez",
                                 "givenName": "Sergio",
                                 "familyName": "Pérez",
                                 "dateOfBirth": "1990-01-26",
                                 "nationality": "Mexican"
                             },
                             "Constructor": {
                                 "constructorId": "racing_point",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Racing_Point_F1_Team",
                                 "name": "Racing Point",
                                 "nationality": "British"
                             },
                             "grid": "17",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5033070",
                                 "time": "+1:02.387"
                             },
                             "FastestLap": {
                                 "rank": "4",
                                 "lap": "68",
                                 "Time": {
                                     "time": "1:07.188"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "231.362"
                                 }
                             }
                         },
                         {
                             "number": "18",
                             "position": "7",
                             "positionText": "7",
                             "points": "6",
                             "Driver": {
                                 "driverId": "stroll",
                                 "permanentNumber": "18",
                                 "code": "STR",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Lance_Stroll",
                                 "givenName": "Lance",
                                 "familyName": "Stroll",
                                 "dateOfBirth": "1998-10-29",
                                 "nationality": "Canadian"
                             },
                             "Constructor": {
                                 "constructorId": "racing_point",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Racing_Point_F1_Team",
                                 "name": "Racing Point",
                                 "nationality": "British"
                             },
                             "grid": "12",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5033136",
                                 "time": "+1:02.453"
                             },
                             "FastestLap": {
                                 "rank": "10",
                                 "lap": "65",
                                 "Time": {
                                     "time": "1:07.833"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "229.162"
                                 }
                             }
                         },
                         {
                             "number": "3",
                             "position": "8",
                             "positionText": "8",
                             "points": "4",
                             "Driver": {
                                 "driverId": "ricciardo",
                                 "permanentNumber": "3",
                                 "code": "RIC",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Daniel_Ricciardo",
                                 "givenName": "Daniel",
                                 "familyName": "Ricciardo",
                                 "dateOfBirth": "1989-07-01",
                                 "nationality": "Australian"
                             },
                             "Constructor": {
                                 "constructorId": "renault",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Renault_in_Formula_One",
                                 "name": "Renault",
                                 "nationality": "French"
                             },
                             "grid": "8",
                             "laps": "71",
                             "status": "Finished",
                             "Time": {
                                 "millis": "5033274",
                                 "time": "+1:02.591"
                             },
                             "FastestLap": {
                                 "rank": "9",
                                 "lap": "65",
                                 "Time": {
                                     "time": "1:07.832"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "229.166"
                                 }
                             }
                         },
                         {
                             "number": "55",
                             "position": "9",
                             "positionText": "9",
                             "points": "3",
                             "Driver": {
                                 "driverId": "sainz",
                                 "permanentNumber": "55",
                                 "code": "SAI",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Carlos_Sainz_Jr.",
                                 "givenName": "Carlos",
                                 "familyName": "Sainz",
                                 "dateOfBirth": "1994-09-01",
                                 "nationality": "Spanish"
                             },
                             "Constructor": {
                                 "constructorId": "mclaren",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/McLaren",
                                 "name": "McLaren",
                                 "nationality": "British"
                             },
                             "grid": "3",
                             "laps": "70",
                             "status": "+1 Lap",
                             "FastestLap": {
                                 "rank": "1",
                                 "lap": "68",
                                 "Time": {
                                     "time": "1:05.619"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "236.894"
                                 }
                             }
                         },
                         {
                             "number": "26",
                             "position": "10",
                             "positionText": "10",
                             "points": "1",
                             "Driver": {
                                 "driverId": "kvyat",
                                 "permanentNumber": "26",
                                 "code": "KVY",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Daniil_Kvyat",
                                 "givenName": "Daniil",
                                 "familyName": "Kvyat",
                                 "dateOfBirth": "1994-04-26",
                                 "nationality": "Russian"
                             },
                             "Constructor": {
                                 "constructorId": "alphatauri",
                                 "url": "http:\\/\\/en.wikipedia.org\\/wiki\\/Scuderia_AlphaTauri",
                                 "name": "AlphaTauri",
                                 "nationality": "Italian"
                             },
                             "grid": "13",
                             "laps": "70",
                             "status": "+1 Lap",
                             "FastestLap": {
                                 "rank": "13",
                                 "lap": "60",
                                 "Time": {
                                     "time": "1:08.378"
                                 },
                                 "AverageSpeed": {
                                     "units": "kph",
                                     "speed": "227.336"
                                 }
                             }
                         }
                     ]
                 }
             ]
         }
     }
 }
 """

}

/*
var request = URLRequest(url: URL(string: self.server + year+"/circuits.json")!,timeoutInterval: Double.infinity)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let data = data else {
    print(String(describing: error))
    return
  }
    let welcome = try? JSONDecoder().decode(Welcome.self, from: data)
    print(welcome?.mrData.driverTable.drivers[0].familyName ?? "Vacio")
}

task.resume()
*/
