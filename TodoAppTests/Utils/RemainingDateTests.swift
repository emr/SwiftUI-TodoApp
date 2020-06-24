import XCTest

fileprivate struct Test {
    var diffComponents: DateComponents
    var expectedShortString: String
    var expectedMediumString: String
}

class RemainingDateTests: XCTestCase {

    fileprivate let tests = [
        Test(diffComponents: DateComponents(second: 60), expectedShortString: "1 minute", expectedMediumString: "1 minute"),
        Test(diffComponents: DateComponents(second: 90), expectedShortString: "1 minute", expectedMediumString: "1 minute"),
        Test(diffComponents: DateComponents(hour: 2, minute: 30), expectedShortString: "2 hours", expectedMediumString: "2 hours, 30 minutes"),
        Test(diffComponents: DateComponents(day: 1), expectedShortString: "1 day", expectedMediumString: "1 day"),
        Test(diffComponents: DateComponents(day: 2), expectedShortString: "2 days", expectedMediumString: "2 days"),
        Test(diffComponents: DateComponents(day: 2, hour: 4, minute: 33), expectedShortString: "2 days", expectedMediumString: "2 days, 4 hours"),
        Test(diffComponents: DateComponents(day: 2, minute: 33), expectedShortString: "2 days", expectedMediumString: "2 days"),
        Test(diffComponents: DateComponents(day: 7), expectedShortString: "1 week", expectedMediumString: "1 week"),
        Test(diffComponents: DateComponents(day: 1, weekOfMonth: 3), expectedShortString: "3 weeks", expectedMediumString: "3 weeks, 1 day"),
    ]

    func testBuildShortString() throws {
        let now = Date()
        let calendar = Calendar.current
        let remainingDate = RemainingDate(calendar: calendar, format: .short)
        for test in tests {
            XCTAssertEqual(
                remainingDate.buildString(
                    from: now,
                    to: calendar.date(byAdding: test.diffComponents, to: now)!
                ),
                test.expectedShortString
            )
        }
    }

    func testBuildMediumString() throws {
        let now = Date()
        let calendar = Calendar.current
        let remainingDate = RemainingDate(calendar: calendar, format: .medium)
        for test in tests {
            XCTAssertEqual(
                remainingDate.buildString(
                    from: now,
                    to: calendar.date(byAdding: test.diffComponents, to: now)!
                ),
                test.expectedMediumString
            )
        }
    }

}
