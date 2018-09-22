//
//  SHA256Tests.swift
//  Hash
//

import XCTest
import Hash

final class SHA3_256Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [UInt8]()
		let digest = SHA3<sha256>.hash(bytes)
		XCTAssertEqual(digest.description, "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha256>.hash(bytes)
		XCTAssertEqual(digest.description, "69070dda01975c8c120c3aada1b282394e7f032fa9cf32f4cb2259a0897dfc04")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha256>.hash(bytes)
		XCTAssertEqual(digest.description, "cc80b0b13ba89613d93f02ee7ccbe72ee26c6edfe577f22e63a1380221caedbc")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha256>.hash(bytes)
		XCTAssertEqual(digest.description, "80084bf2fba02475726feb2cab2d8215eab14bc6bdd8bfb2c8151257032ecd8b")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha256>.hash(bytes)
		XCTAssertEqual(digest.description, "3a985da74fe225b2045c172d6bd390bd855f086e3e9d525b46bfe24511431532")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha256>.hash(bytes)
		XCTAssertEqual(digest.description, "edcdb2069366e75243860c18c3a11465eca34bce6143d30c8665cefcfd32bffd")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha256>.hash(bytes)
		XCTAssertEqual(digest.description, "7cab2dc765e21b241dbc1c255ce620b29f527c6d5e7f5f843e56288f0d707521")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha256>.hash(bytes)
		XCTAssertEqual(digest.description, "a79d6a9da47f04a3b9a9323ec9991f2105d4c78a7bc7beeb103855a7a11dfb9f")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha256>.hash(bytes)
		XCTAssertEqual(digest.description, "293e5ce4ce54ee71990ab06e511b7ccd62722b1beb414f5ff65c8274e0f5be1d")
	}
}

extension SHA3_256Tests: TestCase {
	static var allTests = [
		("testEmptyBytes", testEmptyBytes),
		("testLazyDog", testLazyDog),
		("testLazyCog", testLazyCog),
		("testA", testA),
		("testABC", testABC),
		("testMessageDigest", testMessageDigest),
		("testAlphabet", testAlphabet),
		("testFullAlphabet", testFullAlphabet),
		("testLotsOfNumbers", testLotsOfNumbers),
	]
}
