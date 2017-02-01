//
//  Package.swift
//  Hash
//

import PackageDescription

let package = Package(
	name: "Hash",
	dependencies: [
		.Package(url: "https://github.com/DavidSkrundz/ProtocolNumbers.git", majorVersion: 1, minor: 0),
		.Package(url: "https://github.com/DavidSkrundz/UnicodeOperators.git", majorVersion: 1, minor: 0),
	]
)

let staticLibrary = Product(
	name: "Hash",
	type: .Library(.Static),
	modules: ["Hash"]
)
let dynamicLibrary = Product(
	name: "Hash",
	type: .Library(.Dynamic),
	modules: ["Hash"]
)

products.append(staticLibrary)
products.append(dynamicLibrary)
