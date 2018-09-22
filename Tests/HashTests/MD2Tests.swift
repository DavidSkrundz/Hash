//
//  MD2Tests.swift
//  Hash
//

import XCTest
import Hash

final class MD2Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [UInt8]()
		let digest = MD2.hash(bytes)
		XCTAssertEqual(digest.description, "8350e5a3e24c153df2275c9f80692773")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD2.hash(bytes)
		XCTAssertEqual(digest.description, "03d85a0d629d2c442e987525319fc471")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD2.hash(bytes)
		XCTAssertEqual(digest.description, "6b890c9292668cdbbfda00a4ebf31f05")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD2.hash(bytes)
		XCTAssertEqual(digest.description, "32ec01ec4a6dac72c0ab96fb34c0b5d1")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD2.hash(bytes)
		XCTAssertEqual(digest.description, "da853b0d3f88d99b30283a69e6ded6bb")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD2.hash(bytes)
		XCTAssertEqual(digest.description, "ab4f496bfb2a530b219ff33031fe06b0")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD2.hash(bytes)
		XCTAssertEqual(digest.description, "4e8ddff3650292ab5a4108c3aa47940b")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD2.hash(bytes)
		XCTAssertEqual(digest.description, "da33def2a42df13975352846c30338cd")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD2.hash(bytes)
		XCTAssertEqual(digest.description, "d5976f79d83d3a0dc9806c3c66f3efd8")
	}
}

extension MD2Tests: TestCase {
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
