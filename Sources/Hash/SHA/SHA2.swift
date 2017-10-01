//
//  SHA2.swift
//  Hash
//

internal protocol SHA2: Hashing {
	associatedtype Data: FixedWidthInteger
	
	static var lengthBytesPrefix: [Byte] { get }
	static var dropLastAmount: Int { get }
	static var blockSize: Int { get }
	static var blockBufferSize: Int { get }
	static var constant: [Data] { get }
	
	static func PaddingLength(_ length: Int) -> Int
	static func SSIG0(_ x: Data) -> Data
	static func SSIG1(_ x: Data) -> Data
	static func BSIG0(_ x: Data) -> Data
	static func BSIG1(_ x: Data) -> Data
	static func CH(_ x: Data, _ y: Data, _ z: Data) -> Data
	static func MAJ(_ x: Data, _ y: Data, _ z: Data) -> Data
	
	var data: ByteBuffer { get set }
	var digest: [Data] { get set }
	
	var finalized: Bool { get set }
}

extension SHA2 {
	public mutating func hashData(_ data: [Byte]) {
		precondition(self.finalized == false)
		self.data.append(data)
		self.digestBlocks()
	}
	
	public mutating func finalize() -> Hash {
		precondition(self.finalized == false)
		self.padData()
		var lengthBytes = Self.lengthBytesPrefix
		lengthBytes += (self.data.length &* 8).bigEndianBytes
		self.hashData(lengthBytes)
		self.finalized = true
		let bytes = self.digest
			.dropLast(Self.dropLastAmount)
			.flatMap { $0.bigEndianBytes }
		return Hash(bytes: bytes)
	}
	
	private mutating func padData() {
		let length = Self.PaddingLength(self.data.count)
		self.data.append([0x80] + [Byte](repeating: 0, count: length - 1),
		                 shouldCount: false)
	}
	
	private mutating func digestBlocks() {
		while self.data.count >= Self.blockSize {
			self.digest(block: self.createBlock())
		}
	}
	
	private mutating func createBlock() -> [Data] {
		return self.data.processBytes(Self.blockSize).asBigEndian()
	}
	
	private mutating func digest(block: [Data]) {
		self.computeDigest(self.createBlockBuffer(from: block))
	}
	
	private mutating func createBlockBuffer(from block: [Data]) -> [Data] {
		let count = Self.blockBufferSize - 16
		let blockPadding = [Data](repeating: 0, count: count)
		var blockBuffer = block + blockPadding
		for i in 16..<Self.blockBufferSize {
			blockBuffer[i] = Self.SSIG1(blockBuffer[i - 2]) &+
				blockBuffer[i - 7] &+
				Self.SSIG0(blockBuffer[i - 15]) &+
				blockBuffer[i - 16]
		}
		return blockBuffer
	}
	
	private mutating func computeDigest(_ blockBuffer: [Data]) {
		let abcde = self.digest
		for t in 0..<Self.blockBufferSize {
			self.digestLoop(t, blockBuffer)
		}
		self.digest = zip(self.digest, abcde).map(&+)
	}
	
	private mutating func digestLoop(_ t: Int, _ blockBuffer: [Data]) {
		let T1 = self.digest[7] &+ Self.BSIG1(self.digest[4]) &+
			Self.CH(self.digest[4], self.digest[5], self.digest[6]) &+
			Self.constant[t] &+
			blockBuffer[t]
		let T2 = Self.BSIG0(self.digest[0]) &+
			Self.MAJ(self.digest[0], self.digest[1], self.digest[2])
		
		self.digest.insert(self.digest.removeLast(), at: 0)
		self.digest[4] = self.digest[4] &+ T1
		self.digest[0] = T1 &+ T2
	}
}
