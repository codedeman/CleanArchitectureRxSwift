//
//  FlexiModelTesting.swift
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

final class FlexiModelTesting: XCTestCase {

    var flexiUseCase: PostsUseCaseMock!
    var flexiRouter: FlexiRouterMock!
    var viewModel: FlexiHomeViewModel!
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        flexiUseCase = PostsUseCaseMock()
        flexiRouter = FlexiRouterMock()
        viewModel = FlexiHomeViewModel(useCase: flexiUseCase, navigator: flexiRouter)
    }
    
    override  func tearDown() {
        super.tearDown()
        flexiUseCase = nil
        flexiRouter = nil
        viewModel = nil
    }
    
    func test_transform_triggerBorrow() {
        
        let trigger = PublishSubject<Void>()
        let input = createInput(trigger: trigger,borrowTrigger: trigger)
        let output = viewModel.transform(input: input)
        output.selectedBorrow.drive().disposed(by: disposeBag)
        let interestRate = createInterestRate()
        flexiUseCase.interest_rateValue = Observable.just(interestRate)
        trigger.onNext(())
        flexiRouter.toInputBorrow(flex: interestRate)

        // assert
        XCTAssertTrue(flexiRouter.toBorrow_Called)
        XCTAssertEqual(flexiRouter.toBorrow_ReceivedArguments?.availableLOC?.currencyCode ?? "", interestRate.availableLOC?.currencyCode)
//        output.sel
    }
    
    private func createInput(trigger: Observable<Void> = Observable.just(()),
                             borrowTrigger: Observable<Void> = Observable.never(),
                             selection: Observable<IndexPath> = Observable.never())
      -> FlexiHomeViewModel.Input {
          return FlexiHomeViewModel.Input(browerTrigger: borrowTrigger.asDriverOnErrorJustComplete(),trigger: trigger.asDriverOnErrorJustComplete())
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func createInterestRate() -> FlexiLoanModel {
        return FlexiLoanModel.init(availableLOC: GSXValue.init(currencyCode: "SG", val: 1000.0),offeredInterestRate: 100,offeredEIR: 10.0)
    }

}
