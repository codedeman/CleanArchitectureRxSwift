//
//  FlexiBorrow.swift
//  CleanArchitectureRxSwiftTests
//
//  Created by Kevin on 12/16/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

@testable import CleanArchitectureRxSwift
import Domain
import XCTest
import RxSwift
import RxCocoa
import RxBlocking

final class FlexiBorrow: XCTestCase {

    var viewModel: FlexBorrowViewModel!
    let disposeBag = DisposeBag()
    
    override  func setUp() {
        super.setUp()
        viewModel = FlexBorrowViewModel()
    }
    override  func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_min_max_input() {
        let enterAmount = Observable.just("150")
        var isValid: Bool = false
        let input = createInput(amount: enterAmount, min: 30, max: 100)
        let output = viewModel.transform(input: input)
        output.valid.asObservable().subscribe { valid in
            isValid = valid
        }.disposed(by: disposeBag)
        XCTAssertTrue(isValid)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func createInput(amount: Observable<String> = Observable.just("")
                     ,min: Double
                     ,max: Double) -> FlexBorrowViewModel.Input {
        
        FlexBorrowViewModel.Input(amount: amount.asDriverOnErrorJustComplete(), min: min, max: max)
    }

}
