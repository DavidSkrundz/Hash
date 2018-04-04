//
//  SHA3.swift
//  Hash
//

import Math

// Reference: http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf

public protocol _SHA3Type {
	static var sha3_blockSize: Int { get }
	static var sha3_hashByteCount: Int { get }
	static var sha3_initialDigest: [UInt64] { get }
}

public protocol SHA3Type: _SHA3Type {}

private let sha3_iota_constant: [UInt64] = [
	0x0000000000000001, 0x0000000000008082, 0x800000000000808a,
	0x8000000080008000, 0x000000000000808b, 0x0000000080000001,
	0x8000000080008081, 0x8000000000008009, 0x000000000000008a,
	0x0000000000000088, 0x0000000080008009, 0x000000008000000a,
	0x000000008000808b, 0x800000000000008b, 0x8000000000008089,
	0x8000000000008003, 0x8000000000008002, 0x8000000000000080,
	0x000000000000800a, 0x800000008000000a, 0x8000000080008081,
	0x8000000000008080, 0x0000000080000001, 0x8000000080008008
]

/// Taken from Table 2 modulo 64
private let sha3_rho_constant = [
	 0,  1, 62, 28, 27,
	36, 44,  6, 55, 20,
	 3, 10, 43, 25, 39,
	41, 45, 15, 21,  8,
	18,  2, 61, 56, 14
]

/// Derived from Figure 5
private let sha3_pi_indices = [
	0, 6, 12, 18, 24,
	3, 9, 10, 16, 22,
	1, 7, 13, 19, 20,
	4, 5, 11, 17, 23,
	2, 8, 14, 15, 21
]



public struct SHA3<T: SHA3Type>: Hashing {
	var data = ByteBuffer()
	var digest = T.sha3_initialDigest
	
	var finalized = false
	
	public init() {}
	
	public mutating func hashData(_ data: [UInt8]) {
		assert(self.finalized == false)
		self.data.append(data)
		self.digestBlocks()
	}
	
	public mutating func finalize() -> Hash {
		assert(self.finalized == false)
		self.padData()
		self.digestBlocks()
		let bytes = self.digest.flatMap { $0.littleEndianBytes }
		return Hash(bytes: Array(bytes[0..<T.sha3_hashByteCount]))
	}
	
	private mutating func padData() {
		let length = T.sha3_blockSize - (self.data.count % T.sha3_blockSize)
		var padding = [UInt8](repeating: 0, count: length)
		padding[0] = 0x06
		padding[padding.count-1] |= 0x80
		self.data.append(padding, shouldCount: false)
	}
	
	private mutating func digestBlocks() {
		while self.data.count >= T.sha3_blockSize {
			self.digest(block: self.createBlock())
		}
	}
	
	private mutating func createBlock() -> [UInt64] {
		return self.data.processBytes(T.sha3_blockSize).asLittleEndian()
	}
	
	private mutating func digest(block: [UInt64]) {
		block.enumerated().forEach { (index, element) in
			self.digest[index] ^= element
		}
		
		for t in 0..<24 {
			self.theta()
			self.rho()
			self.pi()
			self.chi()
			self.iota(t)
		}
	}
	
	private mutating func theta() {
		var c = [UInt64](repeating: 0, count: 5)
		for i in 0..<5 {
			for j in stride(from: 0, to: 25, by: 5) {
				c[i] ^= self.digest[i + j]
			}
		}
		
		var d = [UInt64](repeating: 0, count: 5)
		for i in 0..<5 {
			d[i] = (c[(i + 1) % 5] <<< 1) ^ c[(i + 4) % 5]
		}
		
		for i in 0..<5 {
			for j in stride(from: 0, to: 25, by: 5) {
				self.digest[i + j] ^= d[i]
			}
		}
	}
	
	private mutating func rho() {
		for i in 0..<25 {
			self.digest[i] = self.digest[i] <<< sha3_rho_constant[i]
		}
	}
	
	private mutating func pi() {
		self.digest = sha3_pi_indices.map { self.digest[$0] }
	}
	
	private mutating func chi() {
		for i in stride(from: 0, to: 25, by: 5) {
			let tmp0 = self.digest[0 + i]
			let tmp1 = self.digest[1 + i]
			self.digest[0 + i] ^= ~tmp1 & self.digest[2 + i]
			self.digest[1 + i] ^= ~self.digest[2 + i] & self.digest[3 + i]
			self.digest[2 + i] ^= ~self.digest[3 + i] & self.digest[4 + i]
			self.digest[3 + i] ^= ~self.digest[4 + i] & tmp0
			self.digest[4 + i] ^= ~tmp0 & tmp1
		}
	}
	
	private mutating func iota(_ t: Int) {
		self.digest[0] ^= sha3_iota_constant[t]
	}
}
