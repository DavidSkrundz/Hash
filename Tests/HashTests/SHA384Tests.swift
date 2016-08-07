//
//  SHA384Tests.swift
//  Hash
//
//  Created by David Skrundz on 2016-08-11.
//
//

@testable import Hash
import XCTest

import Foundation

class SHA384Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [Byte]()
		let digest = SHA384.hash(bytes)
		XCTAssertEqual(digest.description, "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA384.hash(bytes)
		XCTAssertEqual(digest.description, "ca737f1014a48f4c0b6dd43cb177b0afd9e5169367544c494011e3317dbf9a509cb1e5dc1e85a941bbee3d7f2afbc9b1")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA384.hash(bytes)
		XCTAssertEqual(digest.description, "098cea620b0978caa5f0befba6ddcf22764bea977e1c70b3483edfdf1de25f4b40d6cea3cadf00f809d422feb1f0161b")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA384.hash(bytes)
		XCTAssertEqual(digest.description, "54a59b9f22b0b80880d8427e548b7c23abd873486e1f035dce9cd697e85175033caa88e6d57bc35efae0b5afd3145f31")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA384.hash(bytes)
		XCTAssertEqual(digest.description, "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA384.hash(bytes)
		XCTAssertEqual(digest.description, "473ed35167ec1f5d8e550368a3db39be54639f828868e9454c239fc8b52e3c61dbd0d8b4de1390c256dcbb5d5fd99cd5")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA384.hash(bytes)
		XCTAssertEqual(digest.description, "feb67349df3db6f5924815d6c3dc133f091809213731fe5c7b5f4999e463479ff2877f5f2936fa63bb43784b12f3ebb4")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA384.hash(bytes)
		XCTAssertEqual(digest.description, "1761336e3f7cbfe51deb137f026f89e01a448e3b1fafa64039c1464ee8732f11a5341a6f41e0c202294736ed64db1a84")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA384.hash(bytes)
		XCTAssertEqual(digest.description, "b12932b0627d1c060942f5447764155655bd4da0c9afa6dd9b9ef53129af1b8fb0195996d2de9ca0df9d821ffee67026")
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
