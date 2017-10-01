//
//  MD5.swift
//  Hash
//

// Reference: https://tools.ietf.org/html/rfc1321

public struct MD5: MD {
	internal static let digestLoopCount = 4
	
	private static let _BlockIndex = [
		Array(0..<16),
		[1, 6, 11,  0,  5, 10, 15,  4,  9, 14, 3,  8, 13,  2,  7, 12],
		[5, 8, 11, 14,  1,  4,  7, 10, 13,  0, 3,  6,  9, 12, 15,  2],
		[0, 7, 14,  5, 12,  3, 10,  1,  8, 15, 6, 13,  4, 11,  2,  9]
	]
	private static let _Constant: [Word] = [
		0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee, 0xf57c0faf, 0x4787c62a,
		0xa8304613, 0xfd469501, 0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
		0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821, 0xf61e2562, 0xc040b340,
		0x265e5a51, 0xe9b6c7aa, 0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
		0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed, 0xa9e3e905, 0xfcefa3f8,
		0x676f02d9, 0x8d2a4c8a, 0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
		0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70, 0x289b7ec6, 0xeaa127fa,
		0xd4ef3085, 0x04881d05, 0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
		0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039, 0x655b59c3, 0x8f0ccc92,
		0xffeff47d, 0x85845dd1, 0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
		0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391
	]
	private static let _Rotations: [[Word]] = [
		[7, 12, 17, 22], [5, 9, 14, 20], [4, 11, 16, 23], [6, 10, 15, 21]
	]
	
	internal static func BlockIndex(_ i: Int) -> Int {
		return MD5._BlockIndex[i / 16][i % 16]
	}
	
	internal static func Constant(_ i: Int) -> Word {
		return MD5._Constant[i]
	}
	
	internal static func F(_ t: Int, _ x: Word, _ y: Word, _ z: Word) -> Word {
		switch t {
			case  0..<16: return (x & y) | (~x & z)
			case 16..<32: return (x & z) | (y & ~z)
			case 32..<48: return x ^ y ^ z
			case 48..<64: return y ^ (x | ~z)
			default: fatalError("Invalid t: \(t)")
		}
	}
	
	internal static func Rotations(_ i: Int) -> Word {
		return MD5._Rotations[i / 16][i % 4]
	}
	
	internal var data = ByteBuffer()
	internal var digest: [Word] = [
		0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476
	]
	
	internal var finalized = false
	
	public init() {}
	
	internal mutating func digestRoundAddToZeroth(_ value: Word) {
		self.digest[0] = self.digest[1] &+ value
	}
}
