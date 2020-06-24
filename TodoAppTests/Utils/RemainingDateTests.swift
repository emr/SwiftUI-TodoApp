import XCTest

class RemainingDateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBuildString() throws {
        let now = Date()
        let calendar = Calendar.current
        let remainingDate = RemainingDate(calendar: calendar, from: now)
        XCTAssertEqual(
            remainingDate.buildString(to: calendar.date(byAdding: DateComponents(second: 60), to: now)!),
            "1 minute"
        )
        XCTAssertEqual(
            remainingDate.buildString(to: calendar.date(byAdding: DateComponents(second: 90), to: now)!),
            "1 minute"
        )
        XCTAssertEqual(
            remainingDate.buildString(to: calendar.date(byAdding: DateComponents(hour: 2, minute: 30), to: now)!),
            "2 hours, 30 minutes"
        )
        XCTAssertEqual(
            remainingDate.buildString(to: calendar.date(byAdding: DateComponents(day: 1), to: now)!),
            "1 day"
        )
        XCTAssertEqual(
            remainingDate.buildString(to: calendar.date(byAdding: DateComponents(day: 2), to: now)!),
            "2 days"
        )
        XCTAssertEqual(
            remainingDate.buildString(to: calendar.date(byAdding: DateComponents(day: 2, hour: 4, minute: 33), to: now)!),
            "2 days, 4 hours"
        )
        XCTAssertEqual(
            remainingDate.buildString(to: calendar.date(byAdding: DateComponents(day: 2, minute: 33), to: now)!),
            "2 days"
        )
        XCTAssertEqual(
            remainingDate.buildString(to: calendar.date(byAdding: DateComponents(day: 7), to: now)!),
            "1 week"
        )
        XCTAssertEqual(
            remainingDate.buildString(to: calendar.date(byAdding: DateComponents(day: 1, weekOfMonth: 3), to: now)!),
            "3 weeks, 1 day"
        )
    }

}
