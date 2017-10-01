//
//  BinaryInteger+Bytes.swift
//  Hash
//

extension BinaryInteger {
	internal var littleEndianBytes: [Byte] {
		return (0..<MemoryLayout<Self>.size)
			.map { self >> ($0 * 8) }
			.map { Byte($0 & 0xFF) }
	}
	
	internal var bigEndianBytes: [Byte] {
		return self.littleEndianBytes.reversed()
	}
}
