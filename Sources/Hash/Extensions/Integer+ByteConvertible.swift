//
//  Integer+ByteConvertible.swift
//  Hash
//

import ProtocolNumbers

extension ByteConvertible where Self: IntConvertible &
                                      BitshiftOperations &
                                      BitwiseOperations {
	public var bytes: [Byte] {
		var bytes = [Byte]()
		
		for i in (0..<MemoryLayout<Self>.size).reversed() {
			let shifted = self ≫ Self(i * 8)
			let trimmed = shifted & Self(0xFF)
			let bitPattern = trimmed.toIntMax()
			bytes.append(Byte(truncatingBitPattern: bitPattern))
		}
		
		return bytes
	}
}

extension Int: ByteConvertible {}
extension Int8: ByteConvertible {}
extension Int16: ByteConvertible {}
extension Int32: ByteConvertible {}
extension Int64: ByteConvertible {}

extension UInt: ByteConvertible {}
extension UInt8: ByteConvertible {}
extension UInt16: ByteConvertible {}
extension UInt32: ByteConvertible {}
extension UInt64: ByteConvertible {}
