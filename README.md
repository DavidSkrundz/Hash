# Hash

[![](https://img.shields.io/badge/Swift-4.2-orange.svg)][1]
[![](https://img.shields.io/badge/os-macOS%20|%20Linux-lightgray.svg)][1]
[![](https://travis-ci.com/DavidSkrundz/Hash.svg?branch=master)][2]
[![](https://codebeat.co/badges/135a24b1-e0a1-43eb-8f26-a913ec651f51)]()
[![](https://codecov.io/gh/DavidSkrundz/Hash/branch/master/graph/badge.svg)]()

[1]: https://swift.org/download/#releases
[2]: https://travis-ci.com/DavidSkrundz/Hash
[3]: https://codebeat.co/projects/github-com-davidskrundz-hash
[4]: https://codecov.io/gh/DavidSkrundz/Hash

Hashing algorithms

## Importing

```Swift
.package(url: "https://github.com/DavidSkrundz/Hash.git", .upToNextMinor(from: "1.4.0"))
```

## `Hash: Equatable, CustomStringConvertible`

```Swift
let bytes: [UInt8]
var description: String // hexadecimal representation
```

## `Hashing`

```Swift
init()
mutating func hashData(_ data: [UInt8])
func finalize() -> Hash
static func hash(_ data: [UInt8]) -> Hash
```

## Implemented Functions

- MD2
- MD4
- MD5
- SHA0
- SHA1
- SHA2\<T>
	- sha224
	- sha256
	- sha384
	- sha512
- SHA3\<T>
	- sha224
	- sha256
	- sha384
	- sha512