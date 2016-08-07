//
//  SHA384.swift
//  Hash
//

import ProtocolNumbers

// Reference: https://tools.ietf.org/html/rfc6234

public struct SHA384: Hashing, SHA2 {
	internal typealias DataType = Long
	
	internal var sha2Type = SHA2Type<DataType>.SHA384
	
	internal var dataBuffer = ByteBuffer()
	internal var digest: [DataType] = [
		0xcbbb9d5dc1059ed8, 0x629a292a367cd507, 0x9159015a3070dd17,
		0x152fecd8f70e5939, 0x67332667ffc00b31, 0x8eb44a8768581511,
		0xdb0c2e0d64f98fa7, 0x47b5481dbefa4fa4,
	]
	
	internal var finalized = false
	
	public init() {}
}
