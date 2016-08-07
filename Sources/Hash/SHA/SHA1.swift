//
//  SHA1.swift
//  Hash
//

import ProtocolNumbers
import UnicodeOperators

// Reference: https://tools.ietf.org/html/rfc3174

public struct SHA1: Hashing {
	private var dataBuffer = [Byte]()
	private var digest: [Word] = [
		0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0,
	]
	private var dataLength: Long = 0
	
	private var finalized = false
	
	public init() {}
	
	public mutating func finalize() -> Hash {
		precondition(self.finalized == false)
		self.dataBuffer = MD4.padData(self.dataBuffer)
		self.hashData((self.dataLength * 8).bytes)
		self.finalized = true
		return Hash(bytes: self.digest.flatMap { $0.bytes })
	}
	
	public mutating func hashData(_ data: [Byte]) {
		precondition(self.finalized == false)
		self.dataBuffer += data
		self.dataLength = self.dataLength &+ Long(data.count)
		self.digestBlocks()
	}
	
	private mutating func digestBlocks() {
		while self.dataBuffer.count ≥ 64 {
			let block = self.createBlock()
			self.digestBlock(block)
		}
	}
	
	private mutating func createBlock() -> [Word] {
		defer { self.dataBuffer.removeFirst(64) }
		return self.dataBuffer.prefix(64).asWords
	}
	
	private mutating func digestBlock(_ block: [Word]) {
		let blockBuffer = SHA1.createBlockBuffer(from: block)
		self.computeDigest(blockBuffer)
	}
	
	private static func createBlockBuffer(from block: [Word]) -> [Word] {
		var blockBuffer = block + [Word](repeating: 0, count: 80 - 16)
		
		for t in 16..<80 {
			blockBuffer[t] = [3, 8, 14, 16]
				.map { blockBuffer[t - $0] }
				.reduce(0, ^) ⋘ 1
		}
		
		return blockBuffer
	}
	
	private mutating func computeDigest(_ blockBuffer: [Word]) {
		var abcde = self.digest
		
		for t in 0..<80 {
			let functionResult = SHA1.F(t, abcde[1], abcde[2], abcde[3])
			let sum = functionResult &+ abcde[4] &+ blockBuffer[t] &+ SHA1.K(t)
			let tmp = (abcde[0] ⋘ 5) &+ sum
			abcde.removeLast(1)
			abcde.insert(tmp, at: 0)
			abcde[2] = abcde[2] ⋘ 30
		}
		
		self.digest = zip(self.digest, abcde).map(&+)
	}
	
	private static func F(_ t: Int, _ b: Word, _ c: Word, _ d: Word) -> Word {
		switch t {
			case  0...19: return (b & c) | (~b & d)
			case 20...39: return b ^ c ^ d
			case 40...59: return (b & c) | (b & d) | (c & d)
			case 60...79: return b ^ c ^ d
			default: fatalError("Invalid t: \(t)")
		}
	}
	
	private static func K(_ t: Int) -> Word {
		switch t {
			case  0...19: return 0x5A827999
			case 20...39: return 0x6ED9EBA1
			case 40...59: return 0x8F1BBCDC
			case 60...79: return 0xCA62C1D6
			default: fatalError("Invalid t: \(t)")
		}
	}
}
