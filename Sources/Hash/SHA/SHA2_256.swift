//
//  SHA2_256.swift
//  Hash
//

import Math

// Reference: https://tools.ietf.org/html/rfc6234

public struct SHA2_256: SHA2 {
	internal typealias Data = UInt32
	
	internal static let lengthBytesPrefix = [UInt8]()
	internal static let hashByteCount = 256 / 8
	internal static let blockSize = 64
	internal static let blockBufferSize = 64
	internal static let constant = SHA2_224.constant
	
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
		0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
		0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
	]
	
	internal var finalized = false
	
	public init() {}
}
