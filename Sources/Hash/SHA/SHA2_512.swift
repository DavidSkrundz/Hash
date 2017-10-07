//
//  SHA2_512.swift
//  Hash
//

// Reference: https://tools.ietf.org/html/rfc6234

public struct SHA2_512: SHA2 {
	internal typealias Data = Long
	
	internal static let lengthBytesPrefix = [Byte](repeating: 0, count: 8)
	internal static let hashByteCount = 512 / 8
	internal static let blockSize = 128
	internal static let blockBufferSize = 80
	internal static let constant = SHA2_384.constant
	
	internal static func PaddingLength(_ length: Int) -> Int {
		return 128 - ((length &- 112 &+ 128) % 128)
	}
	
	internal static func SSIG0(_ x: Data) -> Data {
		return (x >>> 1) ^ (x >>> 8) ^ (x >> 7)
	}
	
	internal static func SSIG1(_ x: Data) -> Data {
		return (x >>> 19) ^ (x >>> 61) ^ (x >> 6)
	}
	
	internal static func BSIG0(_ x: Data) -> Data {
		return (x >>> 28) ^ (x >>> 34) ^ (x >>> 39)
	}
	
	internal static func BSIG1(_ x: Data) -> Data {
		return (x >>> 14) ^ (x >>> 18) ^ (x >>> 41)
	}
	
	internal static func CH(_ x: Data, _ y: Data, _ z: Data) -> Data {
		return (x & y) ^ (~x & z)
	}
	internal static func MAJ(_ x: Data, _ y: Data, _ z: Data) -> Data {
		return (x & y) ^ (x & z) ^ (y & z)
	}
	
	internal var data = ByteBuffer()
	internal var digest: [Data] = [
		0x6a09e667f3bcc908, 0xbb67ae8584caa73b, 0x3c6ef372fe94f82b,
		0xa54ff53a5f1d36f1, 0x510e527fade682d1, 0x9b05688c2b3e6c1f,
		0x1f83d9abfb41bd6b, 0x5be0cd19137e2179
	]
	
	internal var finalized = false
	
	public init() {}
}
