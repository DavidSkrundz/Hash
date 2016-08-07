//
//  MD4.swift
//  Hash
//

// Reference: https://tools.ietf.org/html/rfc1320

public struct MD4: Hashing, MD {
	internal static let digestLoopCount = 3
	
	internal static func BlockIndex(_ i: Int) -> Int {
		return [
			Array(0..<16),
			[0, 4, 8, 12, 1, 5, 9, 13, 2, 6, 10, 14, 3, 7, 11, 15],
			[0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15],
		][i / 16][i % 16]
	}
	
	internal static func Constant(_ i: Int) -> Word {
		return [0x00000000, 0x5A827999, 0x6ED9EBA1][i / 16]
	}
	
	internal static func F(_ i: Int, _ x: Word, _ y: Word, _ z: Word) -> Word {
		switch i {
			case  0..<16: return (x & y) | (~x & z)
			case 16..<32: return (x & y) | (x & z) | (y & z)
			case 32..<48: return x ^ y ^ z
			default: fatalError("Invalid t: \(i)")
		}
	}
	
	internal static func Rotations(_ i: Int) -> Word {
		return [[3, 7, 11, 19], [3, 5,  9, 13], [3, 9, 11, 15]][i / 16][i % 4]
	}
	
	internal var dataBuffer = ByteBuffer()
	internal var digest: [Word] = [
		0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476,
	]
	
	internal var finalized = false
	
	public init() {}
	
	internal mutating func digestRoundAddToZeroth(_ value: Word) {
		self.digest[0] = value
	}
}
