//
//  SHA0Tests.swift
//  HashTests
//

import XCTest
import Hash

class SHA0Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [Byte]()
		let digest = SHA0.hash(bytes)
		XCTAssertEqual(digest.description, "f96cea198ad1dd5617ac084a3d92c6107708c0ef")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA0.hash(bytes)
		XCTAssertEqual(digest.description, "b03b401ba92d77666221e843feebf8c561cea5f7")
	}
	
	func testLazyDogDot() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA0.hash(bytes)
		XCTAssertEqual(digest.description, "ff663342fe29cfb41198a86aed812f6fdac50ac7")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA0.hash(bytes)
		XCTAssertEqual(digest.description, "37f297772fae4cb1ba39b6cf9cf0381180bd62f2")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA0.hash(bytes)
		XCTAssertEqual(digest.description, "0164b8a914cd2a5e74c4f7ff082c4d97f1edf880")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA0.hash(bytes)
		XCTAssertEqual(digest.description, "c1b0f222d150ebb9aa36a40cafdc8bcbed830b14")
	}
	
	func testAlphabet() {
		let string = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA0.hash(bytes)
		XCTAssertEqual(digest.description, "d2516ee1acfa5baf33dfc1c471e438449ef134c8")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA0.hash(bytes)
		XCTAssertEqual(digest.description, "79e966f7a3a990df33e40e3d7f8f18d2caebadfa")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA0.hash(bytes)
		XCTAssertEqual(digest.description, "4aa29d14d171522ece47bee8957e35a41f3e9cff")
	}
	
	static var allTests = [
		("testEmptyBytes", testEmptyBytes),
		("testLazyDog", testLazyDog),
		("testLazyDogDot", testLazyDogDot),
		("testA", testA),
		("testABC", testABC),
		("testMessageDigest", testMessageDigest),
		("testAlphabet", testAlphabet),
		("testFullAlphabet", testFullAlphabet),
		("testLotsOfNumbers", testLotsOfNumbers)
	]
}
