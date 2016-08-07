//
//  SHA256Tests.swift
//  Hash
//

@testable import Hash
import XCTest

import Foundation

class SHA256Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [Byte]()
		let digest = SHA256.hash(bytes)
		XCTAssertEqual(digest.description, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA256.hash(bytes)
		XCTAssertEqual(digest.description, "d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA256.hash(bytes)
		XCTAssertEqual(digest.description, "e4c4d8f3bf76b692de791a173e05321150f7a345b46484fe427f6acc7ecc81be")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA256.hash(bytes)
		XCTAssertEqual(digest.description, "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA256.hash(bytes)
		XCTAssertEqual(digest.description, "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA256.hash(bytes)
		XCTAssertEqual(digest.description, "f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA256.hash(bytes)
		XCTAssertEqual(digest.description, "71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA256.hash(bytes)
		XCTAssertEqual(digest.description, "db4bfcbd4da0cd85a60c3c37d3fbd8805c77f15fc6b1fdfe614ee0a7c8fdb4c0")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA256.hash(bytes)
		XCTAssertEqual(digest.description, "f371bc4a311f2b009eef952dd83ca80e2b60026c8e935592d0f9c308453c813e")
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
		("testLotsOfNumbers", testLotsOfNumbers),
	]
}
