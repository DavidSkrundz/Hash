//
//  SHA1Tests.swift
//  Hash
//

import XCTest
import Hash

class SHA1Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [UInt8]()
		let digest = SHA1.hash(bytes)
		XCTAssertEqual(digest.description, "da39a3ee5e6b4b0d3255bfef95601890afd80709")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA1.hash(bytes)
		XCTAssertEqual(digest.description, "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12")
	}
	
	func testLazyDogDot() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA1.hash(bytes)
		XCTAssertEqual(digest.description, "de9f2c7fd25e1b3afad3e85a0bd17d9b100db4b3")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA1.hash(bytes)
		XCTAssertEqual(digest.description, "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA1.hash(bytes)
		XCTAssertEqual(digest.description, "a9993e364706816aba3e25717850c26c9cd0d89d")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA1.hash(bytes)
		XCTAssertEqual(digest.description, "c12252ceda8be8994d5fa0290a47231c1d16aae3")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA1.hash(bytes)
		XCTAssertEqual(digest.description, "32d10c7b8cf96570ca04ce37f2a19d84240d3a89")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA1.hash(bytes)
		XCTAssertEqual(digest.description, "761c457bf73b14d27e9e9265c46f4b4dda11f940")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA1.hash(bytes)
		XCTAssertEqual(digest.description, "50abf5706a150990a08b2c5ea40fa0e585554732")
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
