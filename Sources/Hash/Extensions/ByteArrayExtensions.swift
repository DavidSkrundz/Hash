//
//  ByteArrayExtensions.swift
//  Hash
//

import ProtocolNumbers

private let IndexToHexCharacterMap: [Character] = [
	"0", "1", "2", "3", "4",
	"5", "6", "7", "8", "9",
	"a", "b", "c", "d", "e",
	"f"
]

internal enum Endianness {
	case Big
	case Little
}

extension Collection where Iterator.Element == Byte,
                           IndexDistance == Int,
                           Index == Int {
	public var hexString: String {
		return self
			.flatMap { [$0 ≫ 4, $0 & 0x0F] }
			.map { IndexToHexCharacterMap[Int($0)] }
			.reduce("") { $0 + "\($1)" }
	}
	
	/// - Returns: A list of `Word`s built from 4 `Byte`s in network byte order
	public var asWords: [Word] {
		return self.toArray(endianness: .Big)
	}
	
	/// - Returns: A list of `Word`s built from 4 `Byte`s in little endian
	public var asLittleEndianWords: [Word] {
		return self.toArray(endianness: .Little)
	}
	
	/// - Returns: A list of `Long`s built from 8 `Byte`s in network byte order
	public var asLongs: [Long] {
		return self.toArray(endianness: .Big)
	}
	
	/// - Returns: A list of `Long`s built from 8 `Byte`s in little endian
	public var asLittleEndianLongs: [Long] {
		return self.toArray(endianness: .Little)
	}
	
	internal func toArray<T: SwiftInteger>(endianness: Endianness) -> [T]  {
		let byteCount = MemoryLayout<T>.size
		var array = [T]()
		
		let shiftFunction: (Int) -> T
		switch endianness {
			case .Big: shiftFunction = { i in T(8 * (byteCount - i - 1)) }
			case .Little: shiftFunction = { i in T(8 * i) }
		}
		
		for i in 0..<(self.count / byteCount) {
			var number = T(0)
			for j in 0..<byteCount {
				number |= T(self[i * byteCount + j]) ≪ shiftFunction(j)
			}
			array.append(number)
		}
		
		return array
	}
}
