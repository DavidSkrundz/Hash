//
//  SHA512.swift
//  Hash
//

// Reference: https://tools.ietf.org/html/rfc6234

public struct SHA512: Hashing, SHA2 {
	internal typealias DataType = Long
	
	internal var sha2Type = SHA2Type<DataType>.SHA512
	
	internal var dataBuffer = ByteBuffer()
	internal var digest: [DataType] = [
		0x6a09e667f3bcc908, 0xbb67ae8584caa73b, 0x3c6ef372fe94f82b,
		0xa54ff53a5f1d36f1, 0x510e527fade682d1, 0x9b05688c2b3e6c1f,
		0x1f83d9abfb41bd6b, 0x5be0cd19137e2179,
	]
	
	internal var finalized = false
	
	public init() {}
}
