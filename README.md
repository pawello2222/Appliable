<p align="center">
  <a href="https://github.com/pawello2222/Appliable/actions?query=branch%3Amain">
    <img src="https://img.shields.io/github/actions/workflow/status/pawello2222/Appliable/swift.yml?logo=github" alt="Build">
  </a>
  <a href="https://app.codecov.io/gh/pawello2222/Appliable">
    <img src="https://img.shields.io/codecov/c/github/pawello2222/Appliable?logo=codecov" alt="Code coverage">
  </a>
  <a href="https://github.com/pawello2222/Appliable">
    <img src="https://img.shields.io/badge/language-swift-orange.svg" alt="Language">
  </a>
  <a href="https://github.com/pawello2222/Appliable#installation">
    <img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" alt="Swift Package Manager">
  </a>
  <a href="https://github.com/pawello2222/Appliable/releases">
    <img src="https://img.shields.io/github/v/release/pawello2222/Appliable" alt="Release version">
  </a>
  <a href="https://github.com/pawello2222/Appliable/blob/main/LICENSE.md">
    <img src="https://img.shields.io/github/license/pawello2222/Appliable" alt="License">
  </a>
</p>

# Appliable

Appliable makes configuring objects easier and more convenient using closures.

<details>
  <summary>
    <b>Table of Contents</b>
  </summary>

  1. [Highlights](#highlights)
  2. [Installation](#installation)
  2. [Examples](#examples)
  3. [Conformance](#conformance)
  4. [License](#license)

</details>

## Highlights <a name="highlights"></a>

```swift
let button = UIButton().apply {
    $0.isUserInteractionEnabled = false
}
```

```swift
UserDefaults.standard.apply {
    $0.set("Value 1", forKey: "Key 1")
    $0.set("Value 2", forKey: "Key 2")
    $0.set("Value 3", forKey: "Key 3")
}
```

## Installation <a name="installation"></a>

### Requirements
* Swift 5.5+
* Xcode 13+
* iOS 15.0+
* macOS 12.0+
* tvOS 15.0+
* watchOS 8.0+

### Swift Package Manager

Appliable is available as a Swift Package.

```swift
.package(url: "https://github.com/pawello2222/Appliable.git", .upToNextMajor(from: "1.0.0"))
```

## Examples <a name="examples"></a>

### Objects

```swift
let button = UIButton().apply {
    $0.isUserInteractionEnabled = false
}
```

```swift
let label = UILabel()

label.apply {
    $0.isUserInteractionEnabled = false
}
```

### Structs

```swift
let calendar = Calendar(identifier: .gregorian).applying {
    $0.timeZone = .init(identifier: "UTC")!
    $0.locale = .init(identifier: "en_US_POSIX")
}
```

```swift
var calendar = Calendar(identifier: .gregorian)

calendar.apply {
    $0.timeZone = .init(identifier: "UTC")!
    $0.locale = .init(identifier: "en_US_POSIX")
}
```

### Block operations

```swift
UserDefaults.standard.apply {
    $0.set("Value 1", forKey: "Key 1")
    $0.set("Value 2", forKey: "Key 2")
    $0.set("Value 3", forKey: "Key 3")
}
```

### Arrays

```swift
var array = Array(repeating: Date(), count: 3)

array.applyEach {
    $0.addTimeInterval(1000)
}
```

```swift
let array1 = Array(repeating: Date(), count: 3)

let array2 = array1.applyingEach {
    $0.addTimeInterval(1000)
}
```

```swift
let label = UILabel()
let button = UIButton()

[label, button].applyEach {
    $0.isUserInteractionEnabled = false
}

let components = [UILabel(), UIButton()].applyEach {
    $0.isUserInteractionEnabled = false
}
```

## Conformance <a name="conformance"></a>

### Built-in conformance

#### 1. Value types:

- `Array`
- `Calendar`
- `Date`
- `Dictionary`
- `Set`
- `URL`

#### 2. Reference types:

- `JSONDecoder`
- `JSONEncoder`
- `PropertyListDecoder`
- `PropertyListEncoder`

#### 3. All objects inheriting from `NSObject`.

### Custom conformance

```swift
extension Calendar: Appliable {}
```

```swift
struct Item: Appliable {
    var value: Int?
}

let item = Item().applying {
    $0.value = 1
}
```

## License <a name="license"></a>

Appliable is available under the MIT license. See the [LICENSE](https://github.com/pawello2222/Appliable/blob/main/LICENSE.md) file for more info.
