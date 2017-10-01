//
//  SHA224.swift
//  Hash
//

// Reference: https://tools.ietf.org/html/rfc6234

public struct SHA224: SHA2 {
	internal typealias Data = Word
	
	internal static var lengthBytesPrefix = [Byte]()
	internal static var dropLastAmount = 1
	internal static var blockSize = 64
	internal static var blockBufferSize = 64
	internal static var constant: [Data] = [
		0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
		0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
		0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
		0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
		0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
		0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
		0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
		0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
		0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
		0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
		0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
		0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
		0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
		0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
		0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
		0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
	]
	
	internal static func PaddingLength(_ length: Int) -> Int {
		return 64 - ((length &- 56 &+ 64) % 64)
	}
	
	internal static func SSIG0(_ x: Data) -> Data {
		return (x >>> 7) ^ (x >>> 18) ^ (x >> 3)
	}
	
	internal static func SSIG1(_ x: Data) -> Data {
		return (x >>> 17) ^ (x >>> 19) ^ (x >> 10)
	}
	
	internal static func BSIG0(_ x: Data) -> Data {
		return (x >>> 2) ^ (x >>> 13) ^ (x >>> 22)
	}
	
	internal static func BSIG1(_ x: Data) -> Data {
		return (x >>> 6) ^ (x >>> 11) ^ (x >>> 25)
	}
	
	internal static func CH(_ x: Data, _ y: Data, _ z: Data) -> Data {
		return (x & y) ^ (~x & z)
	}
	
	internal static func MAJ(_ x: Data, _ y: Data, _ z: Data) -> Data {
		return (x & y) ^ (x & z) ^ (y & z)
	}
	
	internal var data = ByteBuffer()
	internal var digest: [Data] = [
		0xc1059ed8, 0x367cd507, 0x3070dd17, 0xf70e5939,
		0xffc00b31, 0x68581511, 0x64f98fa7, 0xbefa4fa4
	]
	
	internal var finalized = false
	
	public init() {}
}
