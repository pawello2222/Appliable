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

import Appliable
import Testing

@Suite("ObjectAppliable")
struct ObjectAppliableTests {
    private enum TestError: Error {
        case boom
    }

    @Test("apply on init")
    func apply_init() async throws {
        let object = Object().apply {
            $0.value = 1
        }

        #expect(object.value == 1)
    }

    @Test("apply assigns value")
    func apply_assign() async throws {
        let object = Object(1)

        object.apply {
            $0.value = 2
        }

        #expect(object.value == 2)
    }

    @Test("apply on first reference updates both")
    func apply_assign_first() async throws {
        let object1 = Object(1)
        let object2 = object1

        object1.apply {
            $0.value = 2
        }

        #expect(object1.value == 2)
        #expect(object2.value == 2)
    }

    @Test("apply on second reference updates both")
    func apply_assign_second() async throws {
        let object1 = Object(1)
        let object2 = object1

        object2.apply {
            $0.value = 2
        }

        #expect(object1.value == 2)
        #expect(object2.value == 2)
    }

    @Test("applyEach on array")
    func applyEach_array() async throws {
        let array = [Object(1), Object(2), Object(3)]

        array.applyEach {
            $0.value += 1
        }

        #expect(array.map(\.value) == [2, 3, 4])
    }

    @Test("apply propagates thrown errors")
    func apply_throws() async throws {
        let object = Object(1)

        #expect(throws: TestError.self) {
            try object.apply { _ in
                throw TestError.boom
            }
        }

        #expect(object.value == 1)
    }

    @Test("no-op apply leaves value unchanged")
    func apply_noop() async throws {
        let object = Object(3)

        object.apply { _ in }

        #expect(object.value == 3)
    }

    @Test("applyEach on empty array is no-op")
    func applyEach_array_empty() async throws {
        let array: [Object] = []

        let result = array.applyEach {
            $0.value += 1
        }

        #expect(result.isEmpty)
        #expect(array.isEmpty)
    }

    @Test("chained apply mutates the same instance")
    func apply_chained_same_instance() async throws {
        let object = Object(1)

        let result = object
            .apply { $0.value += 2 }
            .apply { $0.value *= 3 }

        #expect(object === result)
        #expect(object.value == 9)
        #expect(result.value == 9)
    }
}

// MARK: - Helpers

private class Object: ObjectAppliable {
    var value: Int

    init(_ value: Int = 0) {
        self.value = value
    }
}
