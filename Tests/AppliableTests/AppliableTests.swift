// The MIT License (MIT)
//
// Copyright (c) 2023-Present Paweł Wiszenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import XCTest
@testable import Appliable

final class AppliableTests: XCTestCase {
    func test_applying_init() throws {
        let item = Item().applying {
            $0.value = 1
        }

        XCTAssertEqual(item.value, 1)
    }

    func test_applying_assign() throws {
        let item1 = Item(1)

        let item2 = item1.applying {
            $0.value = 2
        }

        XCTAssertEqual(item1.value, 1)
        XCTAssertEqual(item2.value, 2)
    }

    func test_apply_assign() throws {
        var item = Item(1)

        item.apply {
            $0.value = 2
        }

        XCTAssertEqual(item.value, 2)
    }

    func test_apply_assign_first() throws {
        var item1 = Item(1)
        let item2 = item1

        item1.apply {
            $0.value = 2
        }

        XCTAssertEqual(item1.value, 2)
        XCTAssertEqual(item2.value, 1)
    }

    func test_apply_assign_second() throws {
        let item1 = Item(1)
        var item2 = item1

        item2.apply {
            $0.value = 2
        }

        XCTAssertEqual(item1.value, 1)
        XCTAssertEqual(item2.value, 2)
    }

    func test_applyingEach_array() throws {
        let array1 = [Item(1), Item(2), Item(3)]

        let array2 = array1.applyingEach {
            $0.value += 1
        }

        XCTAssertEqual(array1.map(\.value), [1, 2, 3])
        XCTAssertEqual(array2.map(\.value), [2, 3, 4])
    }

    func test_applyEach_array() throws {
        var array = [Item(1), Item(2), Item(3)]

        array.applyEach {
            $0.value += 1
        }

        XCTAssertEqual(array.map(\.value), [2, 3, 4])
    }
}

// MARK: - Helpers

private struct Item: Appliable {
    var value: Int

    init(_ value: Int = 0) {
        self.value = value
    }
}
