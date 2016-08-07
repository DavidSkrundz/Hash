//
//  SHA224.swift
//  Hash
//

import ProtocolNumbers

// Reference: https://tools.ietf.org/html/rfc6234

public struct SHA224: Hashing, SHA2 {
	internal typealias DataType = Word
	
	internal var sha2Type = SHA2Type<DataType>.SHA224
	
	internal var dataBuffer = ByteBuffer()
	internal var digest: [DataType] = [
		0xc1059ed8, 0x367cd507, 0x3070dd17, 0xf70e5939,
		0xffc00b31, 0x68581511, 0x64f98fa7, 0xbefa4fa4,
	]
	
	internal var finalized = false
	
	public init() {}
}
