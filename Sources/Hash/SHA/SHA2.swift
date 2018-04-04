//
//  SHA2.swift
//  Hash
//

import Math

// Reference: https://tools.ietf.org/html/rfc6234

public protocol _SHA2Type {
	associatedtype Data: FixedWidthInteger
	
	static var sha2_lengthBytesPrefix: [UInt8] { get }
	static var sha2_hashByteCount: Int { get }
	static var sha2_blockSize: Int { get }
	static var sha2_blockBufferSize: Int { get }
	static var sha2_constant: [Data] { get }
	static var sha2_initialDigest: [Data] { get }
	
	static func sha2_PaddingLength(_ length: Int) -> Int
	static func sha2_SSIG0(_ x: Data) -> Data
	static func sha2_SSIG1(_ x: Data) -> Data
	static func sha2_BSIG0(_ x: Data) -> Data
	static func sha2_BSIG1(_ x: Data) -> Data
}
extension _SHA2Type {
	public static func sha2_CH(_ x: Data, _ y: Data, _ z: Data) -> Data {
		return (x & y) ^ (~x & z)
	}
	public static func sha2_MAJ(_ x: Data, _ y: Data, _ z: Data) -> Data {
		return (x & y) ^ (x & z) ^ (y & z)
	}
}

public protocol SHA2Type: _SHA2Type {}

public struct SHA2<T: SHA2Type>: Hashing {
	typealias Data = T.Data
	
	var data = ByteBuffer()
	var digest = T.sha2_initialDigest

	var finalized = false
	
	public init() {}
	
	public mutating func hashData(_ data: [UInt8]) {
		precondition(self.finalized == false)
		self.data.append(data)
		self.digestBlocks()
	}

	public mutating func finalize() -> Hash {
		precondition(self.finalized == false)
		self.padData()
		var lengthBytes = T.sha2_lengthBytesPrefix
		lengthBytes += (self.data.length &* 8).bigEndianBytes
		self.hashData(lengthBytes)
		self.finalized = true
		let bytes = self.digest.flatMap { $0.bigEndianBytes }
		return Hash(bytes: Array(bytes[0..<T.sha2_hashByteCount]))
	}

	private mutating func padData() {
		let length = T.sha2_PaddingLength(self.data.count)
		self.data.append([0x80] + [UInt8](repeating: 0, count: length - 1),
		                 shouldCount: false)
	}

	private mutating func digestBlocks() {
		while self.data.count >= T.sha2_blockSize {
			self.digest(block: self.createBlock())
		}
	}

	private mutating func createBlock() -> [Data] {
		return self.data.processBytes(T.sha2_blockSize).asBigEndian()
	}

	private mutating func digest(block: [Data]) {
		self.computeDigest(self.createBlockBuffer(from: block))
	}

	private mutating func createBlockBuffer(from block: [Data]) -> [Data] {
		let count = T.sha2_blockBufferSize - 16
		let blockPadding = [Data](repeating: 0, count: count)
		var blockBuffer = block + blockPadding
		for i in 16..<T.sha2_blockBufferSize {
			blockBuffer[i] = T.sha2_SSIG1(blockBuffer[i - 2]) &+
				blockBuffer[i - 7] &+
				T.sha2_SSIG0(blockBuffer[i - 15]) &+
				blockBuffer[i - 16]
		}
		return blockBuffer
	}

	private mutating func computeDigest(_ blockBuffer: [Data]) {
		let abcde = self.digest
		for t in 0..<T.sha2_blockBufferSize {
			self.digestLoop(t, blockBuffer)
		}
		self.digest = zip(self.digest, abcde).map(&+)
	}

	private mutating func digestLoop(_ t: Int, _ blockBuffer: [Data]) {
		let T1 = self.digest[7] &+ T.sha2_BSIG1(self.digest[4]) &+
			T.sha2_CH(self.digest[4], self.digest[5], self.digest[6]) &+
			T.sha2_constant[t] &+
			blockBuffer[t]
		let T2 = T.sha2_BSIG0(self.digest[0]) &+
			T.sha2_MAJ(self.digest[0], self.digest[1], self.digest[2])

		self.digest.insert(self.digest.removeLast(), at: 0)
		self.digest[4] = self.digest[4] &+ T1
		self.digest[0] = T1 &+ T2
	}
}

internal protocol SHA256Type {
	associatedtype Data: FixedWidthInteger
}
extension SHA256Type {
	public static func sha2_PaddingLength(_ length: Int) -> Int {
		return 64 - ((length &- 56 &+ 64) % 64)
	}
	
	public static func sha2_SSIG0(_ x: Data) -> Data {
		return (x >>> 7) ^ (x >>> 18) ^ (x >> 3)
	}
	
	public static func sha2_SSIG1(_ x: Data) -> Data {
		return (x >>> 17) ^ (x >>> 19) ^ (x >> 10)
	}
	
	public static func sha2_BSIG0(_ x: Data) -> Data {
		return (x >>> 2) ^ (x >>> 13) ^ (x >>> 22)
	}
	
	public static func sha2_BSIG1(_ x: Data) -> Data {
		return (x >>> 6) ^ (x >>> 11) ^ (x >>> 25)
	}
}

internal protocol SHA512Type {
	associatedtype Data: FixedWidthInteger
}
extension SHA512Type {
	public static func sha2_PaddingLength(_ length: Int) -> Int {
		return 128 - ((length &- 112 &+ 128) % 128)
	}
	
	public static func sha2_SSIG0(_ x: Data) -> Data {
		return (x >>> 1) ^ (x >>> 8) ^ (x >> 7)
	}
	
	public static func sha2_SSIG1(_ x: Data) -> Data {
		return (x >>> 19) ^ (x >>> 61) ^ (x >> 6)
	}
	
	public static func sha2_BSIG0(_ x: Data) -> Data {
		return (x >>> 28) ^ (x >>> 34) ^ (x >>> 39)
	}
	
	public static func sha2_BSIG1(_ x: Data) -> Data {
		return (x >>> 14) ^ (x >>> 18) ^ (x >>> 41)
	}
}
