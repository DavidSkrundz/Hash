//
//  SHA3_384.swift
//  Hash
//

// Reference: http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf

public struct SHA3_384: SHA3 {
	internal static let blockSize = 104
	internal static let hashByteCount = 384 / 8
	
	internal var data = ByteBuffer()
	internal var digest = [UInt64](repeating: 0, count: 25)
	
	internal var finalized = false
	
	public init() {}
}
