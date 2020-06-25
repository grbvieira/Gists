import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(NS_ChallgendTests.allTests),
    ]
}
#endif
