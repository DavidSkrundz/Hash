//
//  SHA0.swift
//  Hash
//

import Math

// Reference: https://w2.eff.org/Privacy/Digital_signature/?f=fips_sha_shs.info.txt

public struct SHA0: Hashing {
	private var data = ByteBuffer()
	private var digest: [UInt32] = [
		0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0
	]
	
	private var finalized = false
	
	public init() {}
	
	public mutating func hashData(_ data: [UInt8]) {
		precondition(self.finalized == false)
		self.data.append(data)
		self.digestBlocks()
	}
	
	public mutating func finalize() -> Hash {
		precondition(self.finalized == false)
		self.padData()
		self.hashData((self.data.length &* 8).bigEndianBytes)
		self.digestBlocks()
		self.finalized = true
		return Hash(bytes: self.digest.flatMap { $0.bigEndianBytes })
	}
	
	private mutating func padData() {
		let length = 64 - ((self.data.count &- 56 &+ 64) % 64)
		self.data.append([0x80] + [UInt8](repeating: 0, count: length - 1),
		                 shouldCount: false)
	}
	
	private mutating func digestBlocks() {
		while self.data.count >= 64 {
			self.digest(block: self.data.processBytes(64).asBigEndian())
		}
	}
	
	private mutating func digest(block: [UInt32]) {
		let blockBuffer = SHA0.createBlockBuffer(from: block)
		self.computeDigest(of: blockBuffer)
	}
	
	private mutating func computeDigest(of blockBuffer: [UInt32]) {
		var abcde = self.digest
		for t in 0..<80 {
			let functionResult = SHA0.F(t, abcde[1], abcde[2], abcde[3])
			let sum = functionResult &+ abcde[4] &+ blockBuffer[t] &+ SHA0.K(t)
			let tmp = (abcde[0] <<< 5) &+ sum
			abcde.removeLast(1)
			abcde.insert(tmp, at: 0)
			abcde[2] = abcde[2] <<< 30
		}
		self.digest = zip(self.digest, abcde).map(&+)
	}
	
	private static func createBlockBuffer(from block: [UInt32]) -> [UInt32] {
		var blockBuffer = block + [UInt32](repeating: 0, count: 80 - 16)
		for t in 16..<80 {
			blockBuffer[t] = [3, 8, 14, 16]
				.map { blockBuffer[t - $0] }
				.reduce(0, ^)
		}
		return blockBuffer
	}
	
	private static func F(_ t: Int,
						  _ b: UInt32, _ c: UInt32, _ d: UInt32) -> UInt32 {
		switch t {
			case  0...19: return (b & c) | (~b & d)
			case 20...39: return b ^ c ^ d
			case 40...59: return (b & c) | (b & d) | (c & d)
			case 60...79: return b ^ c ^ d
			default: fatalError("Invalid t: \(t)")
		}
	}
	
	private static func K(_ t: Int) -> UInt32 {
		switch t {
			case  0...19: return 0x5A827999
			case 20...39: return 0x6ED9EBA1
			case 40...59: return 0x8F1BBCDC
			case 60...79: return 0xCA62C1D6
			default: fatalError("Invalid t: \(t)")
		}
	}
}
