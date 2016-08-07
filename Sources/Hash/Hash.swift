//
//  Hash.swift
//  Hash
//

public struct Hash {
	public let bytes: [Byte]
	
	internal init(bytes: [Byte]) {
		self.bytes = bytes
	}
}

extension Hash: CustomStringConvertible {
	public var description: String {
		return self.bytes.hexString
	}
}
