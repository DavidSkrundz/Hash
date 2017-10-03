//
//  SHA224Tests.swift
//  Hash
//

import XCTest
import Hash

class SHA2_224Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [Byte]()
		let digest = SHA2_224.hash(bytes)
		XCTAssertEqual(digest.description, "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA2_224.hash(bytes)
		XCTAssertEqual(digest.description, "730e109bd7a8a32b1cb9d9a09aa2325d2430587ddbc0c38bad911525")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA2_224.hash(bytes)
		XCTAssertEqual(digest.description, "fee755f44a55f20fb3362cdc3c493615b3cb574ed95ce610ee5b1e9b")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA2_224.hash(bytes)
		XCTAssertEqual(digest.description, "abd37534c7d9a2efb9465de931cd7055ffdb8879563ae98078d6d6d5")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA2_224.hash(bytes)
		XCTAssertEqual(digest.description, "23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA2_224.hash(bytes)
		XCTAssertEqual(digest.description, "2cb21c83ae2f004de7e81c3c7019cbcb65b71ab656b22d6d0c39b8eb")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA2_224.hash(bytes)
		XCTAssertEqual(digest.description, "45a5f72c39c5cff2522eb3429799e49e5f44b356ef926bcf390dccc2")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA2_224.hash(bytes)
		XCTAssertEqual(digest.description, "bff72b4fcb7d75e5632900ac5f90d219e05e97a7bde72e740db393d9")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA2_224.hash(bytes)
		XCTAssertEqual(digest.description, "b50aecbe4e9bb0b57bc5f3ae760a8e01db24f203fb3cdcd13148046e")
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
