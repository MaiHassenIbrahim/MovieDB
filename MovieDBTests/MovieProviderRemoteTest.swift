//
//  MovieProviderRemoteTest.swift
//  MovieDBTests
//
//  Created by Mai Hassen on 20/04/2024.
//

import XCTest
@testable import MovieDB
import Combine

final class MovieProviderRemoteTest: XCTestCase {
    
    var movieRepository: MockMovieRespository!
    var mockApiService: MockApiService!

    private var cancellables: Set<AnyCancellable> = []
        override func setUp() {
            mockApiService = MockApiService()
            movieRepository = MockMovieRespository(apiClient: MovieAPIService())
        }

        func test_allMoviesReturnsResponse() {
            let expectation = XCTestExpectation(description: "allMovies")
            movieRepository.fetchMovies(page: 1).receive(on: DispatchQueue.main)
                .sink { completion in
                } receiveValue: { response in
                    XCTAssertFalse(response.isEmpty)
                    expectation.fulfill()
                }
                .store(in: &cancellables)
            
            wait(for: [expectation], timeout: 3)
            
            
        }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }



    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


}
