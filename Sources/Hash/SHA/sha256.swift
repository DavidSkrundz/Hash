//
//  sha256.swift
//  Hash
//

// Reference: https://tools.ietf.org/html/rfc6234

public struct sha256 {
	private init() {}
}

extension sha256: SHA2Type, SHA256Type {
	public typealias Data = UInt32
	
	public static let sha2_lengthBytesPrefix = sha224.sha2_lengthBytesPrefix
	public static let sha2_hashByteCount = 256 / 8
	public static let sha2_blockSize = sha224.sha2_blockSize
	public static let sha2_blockBufferSize = sha224.sha2_blockBufferSize
	public static let sha2_constant = sha224.sha2_constant
	
	public static func sha2_PaddingLength(_ length: Int) -> Int {
		return 64 - ((length &- 56 &+ 64) % 64)
	}
	
	public static var sha2_initialDigest: [Data] = [
		0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
		0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
	]
}

extension sha256: SHA3Type {
	public static let sha3_blockSize = 136
	public static let sha3_hashByteCount = 256 / 8
	public static var sha3_initialDigest = [UInt64](repeating: 0, count: 25)
}
