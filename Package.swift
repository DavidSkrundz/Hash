// swift-tools-version:4.2
//
//  Package.swift
//  Hash
//

import PackageDescription

let package = Package(
	name: "Hash",
	products: [
		.library(
			name: "Hash",
			targets: ["Hash"]),
		.library(
			name: "sHash",
			type: .static,
			targets: ["Hash"]),
		.library(
			name: "dHash",
			type: .dynamic,
			targets: ["Hash"])
	],
	dependencies: [
		.package(url: "https://github.com/DavidSkrundz/Math.git",
				 .upToNextMinor(from: "1.3.0"))
	],
	targets: [
		.target(
			name: "Hash",
			dependencies: ["Math"]),
		.testTarget(
			name: "HashTests",
			dependencies: ["Hash"])
	]
)
