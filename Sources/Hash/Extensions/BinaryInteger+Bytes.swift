//
//  BinaryInteger+Bytes.swift
//  Hash
//

extension FixedWidthInteger {
	internal var littleEndianBytes: [Byte] {
		var copy = self.littleEndian
		return withUnsafeBytes(of: &copy, Array.init)
	}
	
	internal var bigEndianBytes: [Byte] {
		var copy = self.bigEndian
		return withUnsafeBytes(of: &copy, Array.init)
	}
}
