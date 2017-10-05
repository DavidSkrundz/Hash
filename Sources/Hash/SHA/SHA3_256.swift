//
//  SHA3_256.swift
//  Hash
//

// Reference: http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf

public struct SHA3_256: SHA3 {
	internal static let blockSize = 136
	internal static let hashByteCount = 256 / 8
	
	internal var data = ByteBuffer()
	internal var digest = [Long](repeating: 0, count: 25)
	
	internal var finalized = false
	
	public init() {}
}
