//
//  ByteConvertible.swift
//  Hash
//

public protocol ByteConvertible {
	/// - Returns: The value of `self` as a `[Byte]` in network byte order
	var bytes: [Byte] { get }
}
