//
//  MD.swift
//  Hash
//

import ProtocolNumbers

internal protocol MD: Hashing {
	static var digestLoopCount: Int { get }
	
	static func BlockIndex(_ index: Int) -> Int
	static func Constant(_ index: Int) -> Word
	static func F(_ index: Int, _ x: Word, _ y: Word, _ z: Word) -> Word
	static func Rotations(_ index: Int) -> Word
	
	var dataBuffer: ByteBuffer { get set }
	var digest: [Word] { get set }
	
	var finalized: Bool { get set }
	
	mutating func digestRoundAddToZeroth(_ value: Word)
}

extension MD {
	public mutating func finalize() -> Hash {
		precondition(self.finalized == false)
		self.dataBuffer.bytes = Self.padData(self.dataBuffer.bytes)
		self.hashData(self.lengthData())
		self.finalized = true
		
		return Hash(bytes: self.digest.flatMap { $0.bytes.reversed() })
	}
	
	internal static func padData(_ data: [Byte]) -> [Byte] {
		let length = 64 - ((data.count &- 56 &+ 64) % 64)
		let padding = [Byte](repeating: 0, count: Int(length) - 1)
		return data + [0b1000_0000] + padding
	}
	
	private mutating func lengthData() -> [Byte] {
		let length = self.dataBuffer.totalLength * 8
		let bottomHalf = UInt32(truncatingBitPattern: length)
		let topHalf = UInt32(truncatingBitPattern: length ≫ 32)
		
		return bottomHalf.bytes.reversed() + topHalf.bytes.reversed()
	}
	
	public mutating func hashData(_ data: [Byte]) {
		precondition(self.finalized == false)
		self.dataBuffer.add(data)
		self.digestBlocks()
	}
	
	private mutating func digestBlocks() {
		while self.dataBuffer.count >= 64 {
			let block = self.createBlock()
			self.digestBlock(block)
		}
	}
	
	private mutating func createBlock() -> [Word] {
		defer { self.dataBuffer.bytes.removeFirst(64) }
		return self.dataBuffer.bytes.prefix(64).asLittleEndianWords
	}
	
	private mutating func digestBlock(_ block: [Word]) {
		let savedDigest = self.digest
		self.digestRounds(block: block)
		self.digest = zip(self.digest, savedDigest).map(&+)
	}
	
	private mutating func digestRounds(block: [Word]) {
		for i in 0..<(16 * Self.digestLoopCount) {
			let oldValue = self.digest[0]
			let f = Self.F(i, self.digest[1], self.digest[2], self.digest[3])
			let value = block[Self.BlockIndex(i)] &+ Self.Constant(i)
			let sum = oldValue &+ f &+ value
			self.digestRoundAddToZeroth(sum ⋘ Self.Rotations(i))
			self.digest.insert(self.digest.removeLast(), at: 0)
		}
	}
}
