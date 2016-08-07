//
//  MD2.swift
//  Hash
//

import UnicodeOperators

// Reference: https://tools.ietf.org/html/rfc1319

public struct MD2: Hashing {
	private static let Substitutions: [Byte] = [
		 41,  46,  67, 201, 162, 216, 124,   1,  61,  54,  84, 161,
		236, 240,   6,  19,  98, 167,   5, 243, 192, 199, 115, 140,
		152, 147,  43, 217, 188,  76, 130, 202,  30, 155,  87,  60,
		253, 212, 224,  22, 103,  66, 111,  24, 138,  23, 229,  18,
		190,  78, 196, 214, 218, 158, 222,  73, 160, 251, 245, 142,
		187,  47, 238, 122, 169, 104, 121, 145,  21, 178,   7,  63,
		148, 194,  16, 137,  11,  34,  95,  33, 128, 127,  93, 154,
		 90, 144,  50,  39,  53,  62, 204, 231, 191, 247, 151,   3,
		255,  25,  48, 179,  72, 165, 181, 209, 215,  94, 146,  42,
		172,  86, 170, 198,  79, 184,  56, 210, 150, 164, 125, 182,
		118, 252, 107, 226, 156, 116,   4, 241,  69, 157, 112,  89,
		100, 113, 135,  32, 134,  91, 207, 101, 230,  45, 168,   2,
		 27,  96,  37, 173, 174, 176, 185, 246,  28,  70, 97,  105,
		 52,  64, 126,  15,  85,  71, 163,  35, 221,  81, 175,  58,
		195,  92, 249, 206, 186, 197, 234,  38,  44,  83,  13, 110,
		133,  40, 132,   9, 211, 223, 205, 244,  65, 129,  77,  82,
		106, 220,  55, 200, 108, 193, 171, 250,  36, 225, 123,   8,
		 12, 189, 177,  74, 120, 136, 149, 139, 227,  99, 232, 109,
		233, 203, 213, 254,  59,   0,  29,  57, 242, 239, 183,  14,
		102,  88, 208, 228, 166, 119, 114, 248, 235, 117,  75,  10,
		 49,  68,  80, 180, 143, 237,  31,  26, 219, 153, 141,  51,
		159,  17, 131,  20,
	]
	
	private var dataBuffer = [Byte]()
	private var digest = [Byte](repeating: 0, count: 48)
	
	private var checksum = [Byte](repeating: 0, count: 16)
	private var lastChecksumValue: Byte = 0
	
	private var finalized = false
	
	public init() {}
	
	public mutating func finalize() -> Hash {
		precondition(self.finalized == false)
		self.padData()
		self.hashData(self.checksum)
		self.finalized = true
		
		return Hash(bytes: Array(self.digest.prefix(16)))
	}
	
	private mutating func padData() {
		let length = 16 - (self.dataBuffer.count % 16)
		let padding = [Byte](repeating: Byte(length), count: length)
		self.hashData(padding)
	}
	
	public mutating func hashData(_ data: [Byte]) {
		precondition(self.finalized == false)
		self.dataBuffer += data
		self.digestBlocks()
	}
	
	private mutating func digestBlocks() {
		while self.dataBuffer.count ≥ 16 {
			self.digestBlock()
		}
	}
	
	private mutating func digestBlock() {
		for j in 0..<16 {
			let currentValue = self.dataBuffer.removeFirst()
			
			self.digest[16 + j] = currentValue
			self.digest[32 + j] = self.digest[16 + j] ^ self.digest[j]
			
			self.computeChecksum(j, currentValue: currentValue)
		}
		
		self.computeDigest()
	}
	
	private mutating func computeChecksum(_ j: Int, currentValue: Byte) {
		let substitutionIndex = Int(currentValue ^ self.lastChecksumValue)
		self.checksum[j] ^= MD2.Substitutions[substitutionIndex]
		self.lastChecksumValue = self.checksum[j]
	}
	
	private mutating func computeDigest() {
		var temp: Byte = 0
		for i in 0..<18 {
			for j in 0..<48 {
				temp = self.digest[j] ^ MD2.Substitutions[Int(temp)]
				self.digest[j] = temp
			}
			temp = temp &+ Byte(i)
		}
	}
}
