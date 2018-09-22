//
//  SHA224Tests.swift
//  Hash
//

import XCTest
import Hash

final class SHA3_224Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [UInt8]()
		let digest = SHA3<sha224>.hash(bytes)
		XCTAssertEqual(digest.description, "6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha224>.hash(bytes)
		XCTAssertEqual(digest.description, "d15dadceaa4d5d7bb3b48f446421d542e08ad8887305e28d58335795")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha224>.hash(bytes)
		XCTAssertEqual(digest.description, "b770eb6ac3ac52bd2f9e8dc186d6b604e7c3b7ffc8bd9220b0078ced")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha224>.hash(bytes)
		XCTAssertEqual(digest.description, "9e86ff69557ca95f405f081269685b38e3a819b309ee942f482b6a8b")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha224>.hash(bytes)
		XCTAssertEqual(digest.description, "e642824c3f8cf24ad09234ee7d3c766fc9a3a5168d0c94ad73b46fdf")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha224>.hash(bytes)
		XCTAssertEqual(digest.description, "18768bb4c48eb7fc88e5ddb17efcf2964abd7798a39d86a4b4a1e4c8")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha224>.hash(bytes)
		XCTAssertEqual(digest.description, "5cdeca81e123f87cad96b9cba999f16f6d41549608d4e0f4681b8239")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha224>.hash(bytes)
		XCTAssertEqual(digest.description, "a67c289b8250a6f437a20137985d605589a8c163d45261b15419556e")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha224>.hash(bytes)
		XCTAssertEqual(digest.description, "0526898e185869f91b3e2a76dd72a15dc6940a67c8164a044cd25cc8")
	}
}

extension SHA3_224Tests: TestCase {
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
