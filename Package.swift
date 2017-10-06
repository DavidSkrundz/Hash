// swift-tools-version:4.0
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
			type: .static,
			targets: ["Hash"]),
		.library(
			name: "Hash",
			type: .dynamic,
			targets: ["Hash"])
	],
	targets: [
		.target(
			name: "Hash",
			dependencies: []),
		.testTarget(
			name: "HashTests",
			dependencies: ["Hash"])
	]
)
