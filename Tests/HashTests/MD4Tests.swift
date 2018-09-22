//
//  MD4Tests.swift
//  Hash
//

import XCTest
import Hash

final class MD4Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [UInt8]()
		let digest = MD4.hash(bytes)
		XCTAssertEqual(digest.description, "31d6cfe0d16ae931b73c59d7e0c089c0")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD4.hash(bytes)
		XCTAssertEqual(digest.description, "1bee69a46ba811185c194762abaeae90")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD4.hash(bytes)
		XCTAssertEqual(digest.description, "b86e130ce7028da59e672d56ad0113df")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD4.hash(bytes)
		XCTAssertEqual(digest.description, "bde52cb31de33e46245e05fbdbd6fb24")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD4.hash(bytes)
		XCTAssertEqual(digest.description, "a448017aaf21d8525fc10ae87aa6729d")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD4.hash(bytes)
		XCTAssertEqual(digest.description, "d9130a8164549fe818874806e1c7014b")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD4.hash(bytes)
		XCTAssertEqual(digest.description, "d79e1c308aa5bbcdeea8ed63df412da9")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD4.hash(bytes)
		XCTAssertEqual(digest.description, "043f8582f241db351ce627e153e7f0e4")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = MD4.hash(bytes)
		XCTAssertEqual(digest.description, "e33b4ddc9c38f2199c3e7b164fcc0536")
	}
	
	func testCollision() {
		let bytes1: [UInt8] = [
			0x83, 0x9C, 0x7A, 0x4D, 0x7A, 0x92, 0xCB, 0x56,
			0x78, 0xA5, 0xD5, 0xB9, 0xEE, 0xA5, 0xA7, 0x57,
			0x3C, 0x8A, 0x74, 0xDE, 0xB3, 0x66, 0xC3, 0xDC,
			0x20, 0xA0, 0x83, 0xB6, 0x9F, 0x5D, 0x2A, 0x3B,
			0xB3, 0x71, 0x9D, 0xC6, 0x98, 0x91, 0xE9, 0xF9,
			0x5E, 0x80, 0x9F, 0xD7, 0xE8, 0xB2, 0x3B, 0xA6,
			0x31, 0x8E, 0xDD, 0x45, 0xE5, 0x1F, 0xE3, 0x97,
			0x08, 0xBF, 0x94, 0x27, 0xE9, 0xC3, 0xE8, 0xB9
		]
		let bytes2: [UInt8] = [
			0x83, 0x9C, 0x7A, 0x4D, 0x7A, 0x92, 0xCB, 0xD6,
			0x78, 0xA5, 0xD5, 0x29, 0xEE, 0xA5, 0xA7, 0x57,
			0x3C, 0x8A, 0x74, 0xDE, 0xB3, 0x66, 0xC3, 0xDC,
			0x20, 0xA0, 0x83, 0xB6, 0x9F, 0x5D, 0x2A, 0x3B,
			0xB3, 0x71, 0x9D, 0xC6, 0x98, 0x91, 0xE9, 0xF9,
			0x5E, 0x80, 0x9F, 0xD7, 0xE8, 0xB2, 0x3B, 0xA6,
			0x31, 0x8E, 0xDC, 0x45, 0xE5, 0x1F, 0xE3, 0x97,
			0x08, 0xBF, 0x94, 0x27, 0xE9, 0xC3, 0xE8, 0xB9
		]
		
		let digest1 = MD4.hash(bytes1)
		let digest2 = MD4.hash(bytes2)
		
		XCTAssertNotEqual(bytes1, bytes2)
		XCTAssertEqual(digest1.description, "4d7e6a1defa93d2dde05b45d864c429b")
		XCTAssertEqual(digest1.bytes, digest2.bytes)
	}
}

extension MD4Tests: TestCase {
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
		("testCollision", testCollision),
	]
}
