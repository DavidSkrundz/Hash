//
//  sha512.swift
//  Hash
//

// Reference: https://tools.ietf.org/html/rfc6234

public struct sha512 {
	private init() {}
}

extension sha512: SHA2Type, SHA512Type {
	public typealias Data = UInt64
	
	public static let sha2_lengthBytesPrefix = sha384.sha2_lengthBytesPrefix
	public static let sha2_hashByteCount = 512 / 8
	public static let sha2_blockSize = sha384.sha2_blockSize
	public static let sha2_blockBufferSize = sha384.sha2_blockBufferSize
	public static let sha2_constant = sha384.sha2_constant
	
	public static var sha2_initialDigest: [Data] = [
		0x6a09e667f3bcc908, 0xbb67ae8584caa73b, 0x3c6ef372fe94f82b,
		0xa54ff53a5f1d36f1, 0x510e527fade682d1, 0x9b05688c2b3e6c1f,
		0x1f83d9abfb41bd6b, 0x5be0cd19137e2179
	]
}

extension sha512: SHA3Type {
	public static let sha3_blockSize = 72
	public static let sha3_hashByteCount = 512 / 8
	public static var sha3_initialDigest = [UInt64](repeating: 0, count: 25)
}
