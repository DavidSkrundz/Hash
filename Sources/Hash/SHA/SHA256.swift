//
//  SHA256.swift
//  Hash
//

// Reference: https://tools.ietf.org/html/rfc6234

public struct SHA256: Hashing, SHA2 {
	internal typealias DataType = Word
	
	internal var sha2Type = SHA2Type<DataType>.SHA256
	
	internal var dataBuffer = ByteBuffer()
	internal var digest: [DataType] = [
		0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
		0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19,
	]
	
	internal var finalized = false
	
	public init() {}
}
