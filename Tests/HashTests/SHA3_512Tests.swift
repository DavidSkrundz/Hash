//
//  SHA384Tests.swift
//  Hash
//

import XCTest
import Hash

final class SHA3_512Tests: XCTestCase {
	func testEmptyBytes() {
		let bytes = [UInt8]()
		let digest = SHA3<sha512>.hash(bytes)
		XCTAssertEqual(digest.description, "a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26")
	}
	
	func testLazyDog() {
		let string = "The quick brown fox jumps over the lazy dog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha512>.hash(bytes)
		XCTAssertEqual(digest.description, "01dedd5de4ef14642445ba5f5b97c15e47b9ad931326e4b0727cd94cefc44fff23f07bf543139939b49128caf436dc1bdee54fcb24023a08d9403f9b4bf0d450")
	}
	
	func testLazyCog() {
		let string = "The quick brown fox jumps over the lazy cog"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha512>.hash(bytes)
		XCTAssertEqual(digest.description, "28e361fe8c56e617caa56c28c7c36e5c13be552b77081be82b642f08bb7ef085b9a81910fe98269386b9aacfd2349076c9506126e198f6f6ad44c12017ca77b1")
	}
	
	func testA() {
		let string = "a"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha512>.hash(bytes)
		XCTAssertEqual(digest.description, "697f2d856172cb8309d6b8b97dac4de344b549d4dee61edfb4962d8698b7fa803f4f93ff24393586e28b5b957ac3d1d369420ce53332712f997bd336d09ab02a")
	}
	
	func testABC() {
		let string = "abc"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha512>.hash(bytes)
		XCTAssertEqual(digest.description, "b751850b1a57168a5693cd924b6b096e08f621827444f70d884f5d0240d2712e10e116e9192af3c91a7ec57647e3934057340b4cf408d5a56592f8274eec53f0")
	}
	
	func testMessageDigest() {
		let string = "message digest"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha512>.hash(bytes)
		XCTAssertEqual(digest.description, "3444e155881fa15511f57726c7d7cfe80302a7433067b29d59a71415ca9dd141ac892d310bc4d78128c98fda839d18d7f0556f2fe7acb3c0cda4bff3a25f5f59")
	}
	
	func testAlphabet() {
		let string = "abcdefghijklmnopqrstuvwxyz"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha512>.hash(bytes)
		XCTAssertEqual(digest.description, "af328d17fa28753a3c9f5cb72e376b90440b96f0289e5703b729324a975ab384eda565fc92aaded143669900d761861687acdc0a5ffa358bd0571aaad80aca68")
	}
	
	func testFullAlphabet() {
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha512>.hash(bytes)
		XCTAssertEqual(digest.description, "d1db17b4745b255e5eb159f66593cc9c143850979fc7a3951796aba80165aab536b46174ce19e3f707f0e5c6487f5f03084bc0ec9461691ef20113e42ad28163")
	}
	
	func testLotsOfNumbers() {
		let string = "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
		let bytes = string.utf8.map { UInt8($0) }
		let digest = SHA3<sha512>.hash(bytes)
		XCTAssertEqual(digest.description, "9524b9a5536b91069526b4f6196b7e9475b4da69e01f0c855797f224cd7335ddb286fd99b9b32ffe33b59ad424cc1744f6eb59137f5fb8601932e8a8af0ae930")
	}
}

extension SHA3_512Tests: TestCase {
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
