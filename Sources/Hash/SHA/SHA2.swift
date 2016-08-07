//
//  SHA2.swift
//  Hash
//

import ProtocolNumbers
import UnicodeOperators

internal protocol SHA2: Hashing {
	associatedtype DataType: ByteConvertible, SwiftInteger
	
	var sha2Type: SHA2Type<DataType> { get }
	
	var dataBuffer: ByteBuffer { get set }
	var digest: [DataType] { get set }
	
	var finalized: Bool { get set }
}

extension SHA2 {
	public mutating func finalize() -> Hash {
		let digest: [DataType] = self.finalize()
		let bytes = digest
			.dropLast(self.sha2Type.dropLastAmount)
			.flatMap { $0.bytes }
		return Hash(bytes: bytes)
	}
	
	internal mutating func finalize() -> [DataType] {
		precondition(self.finalized == false)
		self.padData()
		var lengthBytes = self.sha2Type.lengthBytesPrefix
		lengthBytes += (self.dataBuffer.totalLength &* 8).bytes
		self.hashData(lengthBytes)
		self.finalized = true
		return self.digest
	}
	
	private mutating func padData() {
		let length = self.sha2Type.paddingLength(self.dataBuffer.count)
		let padding = [Byte](repeating: 0, count: Int(length) - 1)
		self.dataBuffer += [0b1000_0000] + padding
	}
	
	public mutating func hashData(_ data: [Byte]) {
		precondition(self.finalized == false)
		self.dataBuffer.add(data)
		self.digestBlocks()
	}
	
	private mutating func digestBlocks() {
		while self.dataBuffer.count ≥ self.sha2Type.blockSize {
			let block = self.createBlock()
			self.digestBlock(block)
		}
	}
	
	private mutating func createBlock() -> [DataType] {
		defer { self.dataBuffer.bytes.removeFirst(self.sha2Type.blockSize) }
		return self.dataBuffer.bytes
			.prefix(self.sha2Type.blockSize)
			.toArray(endianness: .Big)
	}
	
	private mutating func digestBlock(_ block: [DataType]) {
		let blockBuffer = self.createBlockBuffer(block)
		self.computeDigest(blockBuffer)
	}
	
	private func createBlockBuffer(_ block: [DataType]) -> [DataType] {
		let count = Int(self.sha2Type.blockBufferSize - 16)
		let blockPadding = [DataType](repeating: DataType(0), count: count)
		var blockBuffer = block + blockPadding
		
		for i in 16..<self.sha2Type.blockBufferSize {
			blockBuffer[i] = self.sha2Type.SSIG1(blockBuffer[i - 2]) &+
				blockBuffer[i - 7] &+
				self.sha2Type.SSIG0(blockBuffer[i - 15]) &+
				blockBuffer[i - 16]
		}
		
		return blockBuffer
	}
	
	private mutating func computeDigest(_ blockBuffer: [DataType]) {
		let abcde = self.digest
		for t in 0..<self.sha2Type.blockBufferSize {
			self.digestLoop(t, blockBuffer)
		}
		self.digest = zip(self.digest, abcde).map(&+)
	}
	
	private mutating func digestLoop(_ t: Int, _ blockBuffer: [DataType]) {
		let T1 = self.digest[7] &+ self.sha2Type.BSIG1(self.digest[4]) &+
			self.sha2Type.CH(self.digest[4], self.digest[5], self.digest[6]) &+
			self.sha2Type.constant[t] &+
			blockBuffer[t]
		
		let T2 = self.sha2Type.BSIG0(self.digest[0]) &+
			self.sha2Type.MAJ(self.digest[0], self.digest[1], self.digest[2])
		
		self.digest.insert(self.digest.removeLast(), at: 0)
		self.digest[4] = self.digest[4] &+ T1
		self.digest[0] = T1 &+ T2
	}
}
