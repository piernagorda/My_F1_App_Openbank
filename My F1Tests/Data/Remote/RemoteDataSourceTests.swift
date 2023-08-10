//
//  RemoteDataSourceTests.swift
//  My F1Tests
//
//  Created by Piernagorda Olive Javier on 9/8/23.
//

import XCTest
@testable import My_F1

final class RemoteDataSourceTests: XCTestCase {
    
    var sut: RemoteDataSourceProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        //Configurando el mock de la URLSession
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        //Configuracion de inyecciones
        let mockURLSession = URLSession.init(configuration: configuration)
        sut = RemoteDataSourceImplementation(session: mockURLSession)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    func testRemoteDataSource_whenRetrievingCircuitsWithStatusCode200_returnsSuccess() async throws {
        //GIVEN
        //Request Handler con codigo y data que queramos
        URLProtocolMock.requestHandler = { request in
            //Respuesta favorable, devolvemos un status de 200
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            // Este es el struct mockeado, aqui estan los valores por defecto de cada cosa.
            
            //FAKE STRUCT
            let fakeStruct = Welcome(mrData: MRData(xmlns: " ",
                                                    series: " ",
                                                    url: " ",
                                                    limit: " ",
                                                    offset: " ",
                                                    total: " ",
                                                    circuitTable: CircuitTable(season: "2012", circuits: [Circuit(
                                                        circuitID: " ",
                                                        url: " ",
                                                        circuitName: " ",
                                                        location: Location(lat: " ",
                                                                           long: " ",
                                                                           locality: " ",
                                                                           country: " "))])))
            
            // Enconde con el structMock para tener la respuesta entera mockeada
            let data = try JSONEncoder().encode(fakeStruct)
            return (response, data)
        }
        // WHEN
        
        // Comprobamos que la llamada ha resultado exitosa  y evidentemente tiene datos
        guard let circuitos = try? await sut?.getCircuitsAPI(year: "2012")
        else {
            XCTFail("La llamada ha de contener circuitos!")
            return
        }
        XCTAssertNotNil(circuitos)
        print("Del test: "+circuitos.season)
        // Comprobando que el año recibido sea efectivamente el 2012
        XCTAssertEqual(circuitos.season, "2012")
        
        /*
         Otro ejemplo seria
         XCTAssertEqual(circuitos.url, "randomURL")
         Habria que añadir al mock  url: "randomURL"
         */
    }
}
