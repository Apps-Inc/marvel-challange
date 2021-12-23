import XCTest
@testable import MarvelChallenge

class MarvelChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        systemUnderTest = MarvelService()
    }
    override func tearDownWithError() throws {
        systemUnderTest = nil
        try super.tearDownWithError()
    }

    func testApiCall() throws {
        let promise = expectation(description: "Return succesful and not empty ")
        systemUnderTest.fetchEvents(page: 1) { result in
            switch result {
            case .success(let mainRequest):
                XCTAssertTrue((mainRequest.data?.total)! > 0, "Request total should be > 0")
                promise.fulfill()
            case .error(let error):
                XCTFail("Error in event get request: \(String(describing: error.localizedDescription))")
            case .noContent:
                XCTFail("No content from request")
            }
        }
        wait(for: [promise], timeout: 5)
    }

    func testItemDecode() throws {
        let promise = expectation(description: "Decode successfull and not empty")
        systemUnderTest.fetchEvents(page: 1) { result in
            switch result {
            case .success(let mainRequest):
                XCTAssert((mainRequest.data?.results?.first?.title!.count)! > 0,
                "Title should not be empty")
                promise.fulfill()
            case .error(let error):
                XCTFail("Error in repository get request: \(String(describing: error.localizedDescription))")
            case .noContent:
                XCTFail("No content from request")
            }
        }
        wait(for: [promise], timeout: 5)
    }

}
