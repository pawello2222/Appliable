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

final class ObjectAppliableTests: XCTestCase {
    func test_apply_init() throws {
        let object = Object().apply {
            $0.value = 1
        }

        XCTAssertEqual(object.value, 1)
    }

    func test_apply_assign() throws {
        let object = Object(1)

        object.apply {
            $0.value = 2
        }

        XCTAssertEqual(object.value, 2)
    }

    func test_apply_assign_first() throws {
        let object1 = Object(1)
        let object2 = object1

        object1.apply {
            $0.value = 2
        }

        XCTAssertEqual(object1.value, 2)
        XCTAssertEqual(object2.value, 2)
    }

    func test_apply_assign_second() throws {
        let object1 = Object(1)
        let object2 = object1

        object2.apply {
            $0.value = 2
        }

        XCTAssertEqual(object1.value, 2)
        XCTAssertEqual(object2.value, 2)
    }

    func test_applyEach_array() throws {
        let array = [Object(1), Object(2), Object(3)]

        array.applyEach {
            $0.value += 1
        }

        XCTAssertEqual(array.map(\.value), [2, 3, 4])
    }
}

// MARK: - Helpers

private class Object: ObjectAppliable {
    var value: Int

    init(_ value: Int = 0) {
        self.value = value
    }
}
