//
//  TestCount.swift
//  HashTests
//

import XCTest

protocol TestCase {
	static var allTests: [(String, (Self) -> () -> ())] { get }
}

#if os(macOS)

final class TestCount: XCTestCase {
	func testTestCount() {
		AssertTestCount(MD2Tests.self)
		AssertTestCount(MD4Tests.self)
		AssertTestCount(MD5Tests.self)
		AssertTestCount(SHA0Tests.self)
		AssertTestCount(SHA1Tests.self)
		AssertTestCount(SHA2_224Tests.self)
		AssertTestCount(SHA2_256Tests.self)
		AssertTestCount(SHA2_384Tests.self)
		AssertTestCount(SHA2_512Tests.self)
		AssertTestCount(SHA3_224Tests.self)
		AssertTestCount(SHA3_256Tests.self)
		AssertTestCount(SHA3_384Tests.self)
		AssertTestCount(SHA3_512Tests.self)
	}
}

func AssertTestCount<T: XCTestCase & TestCase>(_ T: T.Type) {
	let allTestsCount = T.allTests.count
	let testCount = T.defaultTestSuite.testCaseCount
	let difference = testCount - allTestsCount
	XCTAssertEqual(allTestsCount, testCount,
				   "\(difference) tests are missing from \(String(describing: T)).allTests")
}

#endif
