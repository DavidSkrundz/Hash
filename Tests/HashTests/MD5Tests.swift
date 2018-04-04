//
//  MD5Tests.swift
//  Hash
//

import XCTest
import Hash

class MD5Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [UInt8]()
		let digest = MD5.hash(bytes)
		XCTAssertEqual(digest.description, "d41d8cd98f00b204e9800998ecf8427e")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD5.hash(bytes)
		XCTAssertEqual(digest.description, "9e107d9d372bb6826bd81d3542a419d6")
	}
	
	func testLazyDogDot() {
		let string = "The quick brown fox jumps over the lazy dog."
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD5.hash(bytes)
		XCTAssertEqual(digest.description, "e4d909c290d0fb1ca068ffaddf22cbd0")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD5.hash(bytes)
		XCTAssertEqual(digest.description, "0cc175b9c0f1b6a831c399e269772661")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD5.hash(bytes)
		XCTAssertEqual(digest.description, "900150983cd24fb0d6963f7d28e17f72")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD5.hash(bytes)
		XCTAssertEqual(digest.description, "f96b697d7cb7938d525a2f31aaf161d0")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD5.hash(bytes)
		XCTAssertEqual(digest.description, "c3fcd3d76192e4007dfb496cca67e13b")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD5.hash(bytes)
		XCTAssertEqual(digest.description, "d174ab98d277d9f5a5611c2c9f419d9f")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD5.hash(bytes)
		XCTAssertEqual(digest.description, "57edf4a22be3c955ac49da2e2107b67a")
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
