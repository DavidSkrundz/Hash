//
//  Array+ByteArray.swift
//  Hash
//

private let indexToHexMap: [Character] = [
	"0", "1", "2", "3", "4", "5", "6", "7",
	"8", "9", "a", "b", "c", "d", "e", "f"
]

private enum Endianness {
	case big
	case little
}

extension Array where Element == Byte {
	internal var hexString: String {
		let halfbytes = self.flatMap { [$0 >> 4, $0 & 0x0F] }
		let characters = halfbytes.map { indexToHexMap[Int($0)] }
		return characters.reduce("") { $0 + "\($1)" }
	}
	
	internal func asBigEndian<T: BinaryInteger>() -> [T] {
		return self.toArray(endinanness: .big)
	}
	
	internal func asLittleEndian<T: BinaryInteger>() -> [T] {
		return self.toArray(endinanness: .little)
	}
	
	private func toArray<T: BinaryInteger>(endinanness: Endianness) -> [T] {
		let byteCount = MemoryLayout<T>.size
		var array = [T]()
		
		let shiftFunction: (Int) -> T
		switch endinanness {
			case .big: shiftFunction = { i in T(8 * (byteCount - i - 1)) }
			case .little: shiftFunction = { i in T(8 * i) }
		}
		
		for i in 0..<(self.count / byteCount) {
			var number = T(0)
			for j in 0..<byteCount {
				number |= T(self[i * byteCount + j]) << shiftFunction(j)
			}
			array.append(number)
		}
		
		return array
	}
}
