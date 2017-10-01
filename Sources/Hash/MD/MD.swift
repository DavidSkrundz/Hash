//
//  MD.swift
//  Hash
//

internal protocol MD: Hashing {
	static var digestLoopCount: Int { get }
	
	static func BlockIndex(_ index: Int) -> Int
	static func Constant(_ index: Int) -> Word
	static func F(_ index: Int, _ x: Word, _ y: Word, _ z: Word) -> Word
	static func Rotations(_ index: Int) -> Word
	
	var data: ByteBuffer { get set }
	var digest: [Word] { get set }
	
	var finalized: Bool { get set }
	
	mutating func digestRoundAddToZeroth(_ value: Word)
}

extension MD {
	public mutating func hashData(_ data: [Byte]) {
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
		self.data.append([0x80] + [Byte](repeating: 0, count: length - 1),
		                 shouldCount: false)
	}
	
	private mutating func lengthData() -> [Byte] {
		let length = self.data.length &* 8
		let bottomHalf = UInt32(truncatingIfNeeded: length)
		let topHalf = UInt32(truncatingIfNeeded: length >> 32)
		return bottomHalf.littleEndianBytes + topHalf.littleEndianBytes
	}
	
	private mutating func digestBlocks() {
		while self.data.count >= 64 {
			self.digest(block: self.data.processBytes(64).asLittleEndianWords)
		}
	}
	
	private mutating func digest(block: [Word]) {
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
			self.digestRoundAddToZeroth(sum <<< Self.Rotations(i))
			self.digest.insert(self.digest.removeLast(), at: 0)
		}
	}
}
