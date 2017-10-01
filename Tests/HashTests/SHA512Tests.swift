//
//  SHA512Tests.swift
//  Hash
//

import XCTest
import Hash

class SHA512Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [Byte]()
		let digest = SHA512.hash(bytes)
		XCTAssertEqual(digest.description, "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA512.hash(bytes)
		XCTAssertEqual(digest.description, "07e547d9586f6a73f73fbac0435ed76951218fb7d0c8d788a309d785436bbb642e93a252a954f23912547d1e8a3b5ed6e1bfd7097821233fa0538f3db854fee6")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA512.hash(bytes)
		XCTAssertEqual(digest.description, "3eeee1d0e11733ef152a6c29503b3ae20c4f1f3cda4cb26f1bc1a41f91c7fe4ab3bd86494049e201c4bd5155f31ecb7a3c8606843c4cc8dfcab7da11c8ae5045")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA512.hash(bytes)
		XCTAssertEqual(digest.description, "1f40fc92da241694750979ee6cf582f2d5d7d28e18335de05abc54d0560e0f5302860c652bf08d560252aa5e74210546f369fbbbce8c12cfc7957b2652fe9a75")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA512.hash(bytes)
		XCTAssertEqual(digest.description, "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA512.hash(bytes)
		XCTAssertEqual(digest.description, "107dbf389d9e9f71a3a95f6c055b9251bc5268c2be16d6c13492ea45b0199f3309e16455ab1e96118e8a905d5597b72038ddb372a89826046de66687bb420e7c")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA512.hash(bytes)
		XCTAssertEqual(digest.description, "4dbff86cc2ca1bae1e16468a05cb9881c97f1753bce3619034898faa1aabe429955a1bf8ec483d7421fe3c1646613a59ed5441fb0f321389f77f48a879c7b1f1")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA512.hash(bytes)
		XCTAssertEqual(digest.description, "1e07be23c26a86ea37ea810c8ec7809352515a970e9253c26f536cfc7a9996c45c8370583e0a78fa4a90041d71a4ceab7423f19c71b9d5a3e01249f0bebd5894")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { Byte($0) }
		let digest = SHA512.hash(bytes)
		XCTAssertEqual(digest.description, "72ec1ef1124a45b047e8b7c75a932195135bb61de24ec0d1914042246e0aec3a2354e093d76f3048b456764346900cb130d2a4fd5dd16abb5e30bcb850dee843")
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
