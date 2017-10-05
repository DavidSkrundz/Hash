//
//  SHA3_512.swift
//  Hash
//

// Reference: http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf

public struct SHA3_512: SHA3 {
	internal static let blockSize = 72
	internal static let hashByteCount = 512 / 8
	
	internal var data = ByteBuffer()
	internal var digest = [Long](repeating: 0, count: 25)
	
	internal var finalized = false
	
	public init() {}
}
