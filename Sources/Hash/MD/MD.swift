//
//  MD.swift
//  Hash
//

import Math

internal protocol MD: Hashing {
	static var digestLoopCount: Int { get }
	
	static func BlockIndex(_ index: Int) -> Int
	static func Constant(_ index: Int) -> UInt32
	static func F(_ index: Int, _ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32
	static func Rotations(_ index: Int) -> UInt32
	
	var data: ByteBuffer { get set }
	var digest: [UInt32] { get set }
	
	var finalized: Bool { get set }
	
	mutating func digestRoundAddToZeroth(_ value: UInt32)
}

extension MD {
	public mutating func hashData(_ data: [UInt8]) {
		precondition(self.finalized == false)
		self.data.append(data)
		self.digestBlocks()
	}
	
	public mutating func finalize() -> Hash {
		precondition(self.finalized == false)
		self.padData()
		self.hashData(self.lengthData())
		self.finalized = true
		return Hash(bytes: self.digest.flatMap { $0.littleEndianBytes })
	}
	
	private mutating func padData() {
		let length = 64 - ((self.data.count &- 56 &+ 64) % 64)
		self.data.append([0x80] + [UInt8](repeating: 0, count: length - 1),
		                 shouldCount: false)
	}
	
	private mutating func lengthData() -> [UInt8] {
		let length = self.data.length &* 8
		let bottomHalf = UInt32(truncatingIfNeeded: length)
		let topHalf = UInt32(truncatingIfNeeded: length >> 32)
		return bottomHalf.littleEndianBytes + topHalf.littleEndianBytes
	}
	
	private mutating func digestBlocks() {
		while self.data.count >= 64 {
			self.digest(block: self.data.processBytes(64).asLittleEndian())
		}
	}
	
	private mutating func digest(block: [UInt32]) {
		let savedDigest = self.digest
		self.digestRounds(block: block)
		self.digest = zip(self.digest, savedDigest).map(&+)
	}
	
	private mutating func digestRounds(block: [UInt32]) {
		for i in 0..<(16 * Self.digestLoopCount) {
			let oldValue = self.digest[0]
			let f = Self.F(i, self.digest[1], self.digest[2], self.digest[3])
			let value = block[Self.BlockIndex(i)] &+ Self.Constant(i)
			let sum = oldValue &+ f &+ value
			self.digestRoundAddToZeroth(sum <<< Self.Rotations(i))
			self.digest.insert(self.digest.removeLast(), at: 0)
		}
	}
}
