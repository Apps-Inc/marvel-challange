import XCTest
@testable import MarvelChallenge
import Alamofire

var systemUnderTest: MarvelService!

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
    func testEventApiCallShouldBeValid() throws {
        let promise = expectation(description: "Return succesful and not empty ")
        systemUnderTest.fetchEvents(page: 1) { result in
            switch result {
            case .success(let mainRequest):
                XCTAssert((mainRequest.data?.results!.count)! > 0,
                          "result itens are empty")
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
