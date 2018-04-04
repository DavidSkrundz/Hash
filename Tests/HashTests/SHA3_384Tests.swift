//
//  SHA384Tests.swift
//  Hash
//

import XCTest
import Hash

class SHA3_384Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [UInt8]()
		let digest = SHA3<sha384>.hash(bytes)
		XCTAssertEqual(digest.description, "0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha384>.hash(bytes)
		XCTAssertEqual(digest.description, "7063465e08a93bce31cd89d2e3ca8f602498696e253592ed26f07bf7e703cf328581e1471a7ba7ab119b1a9ebdf8be41")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha384>.hash(bytes)
		XCTAssertEqual(digest.description, "e414797403c7d01ab64b41e90df4165d59b7f147e4292ba2da336acba242fd651949eb1cfff7e9012e134b40981842e1")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha384>.hash(bytes)
		XCTAssertEqual(digest.description, "1815f774f320491b48569efec794d249eeb59aae46d22bf77dafe25c5edc28d7ea44f93ee1234aa88f61c91912a4ccd9")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha384>.hash(bytes)
		XCTAssertEqual(digest.description, "ec01498288516fc926459f58e2c6ad8df9b473cb0fc08c2596da7cf0e49be4b298d88cea927ac7f539f1edf228376d25")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha384>.hash(bytes)
		XCTAssertEqual(digest.description, "d9519709f44af73e2c8e291109a979de3d61dc02bf69def7fbffdfffe662751513f19ad57e17d4b93ba1e484fc1980d5")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha384>.hash(bytes)
		XCTAssertEqual(digest.description, "fed399d2217aaf4c717ad0c5102c15589e1c990cc2b9a5029056a7f7485888d6ab65db2370077a5cadb53fc9280d278f")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha384>.hash(bytes)
		XCTAssertEqual(digest.description, "d5b972302f5080d0830e0de7b6b2cf383665a008f4c4f386a61112652c742d20cb45aa51bd4f542fc733e2719e999291")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha384>.hash(bytes)
		XCTAssertEqual(digest.description, "3c213a17f514638acb3bf17f109f3e24c16f9f14f085b52a2f2b81adc0db83df1a58db2ce013191b8ba72d8fae7e2a5e")
	}
	
	static var allTests = [
		("testEmptyBytes", testEmptyBytes),
		("testLazyDog", testLazyDog),
		("testLazyCog", testLazyCog),
		("testA", testA),
		("testABC", testABC),
		("testMessageDigest", testMessageDigest),
		("testAlphabet", testAlphabet),
		("testFullAlphabet", testFullAlphabet),
		("testLotsOfNumbers", testLotsOfNumbers)
	]
}
