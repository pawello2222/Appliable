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

@Suite("Appliable")
struct AppliableTests {
    private enum TestError: Error {
        case boom
    }

    @Test("applying on init")
    func applying_init() async throws {
        let item = Item().applying {
            $0.value = 1
        }

        #expect(item.value == 1)
    }

    @Test("applying returns modified copy")
    func applying_assign() async throws {
        let item1 = Item(1)

        let item2 = item1.applying {
            $0.value = 2
        }

        #expect(item1.value == 1)
        #expect(item2.value == 2)
    }

    @Test("apply assigns in place")
    func apply_assign() async throws {
        var item = Item(1)

        item.apply {
            $0.value = 2
        }

        #expect(item.value == 2)
    }

    @Test("apply on first copy mutates only first")
    func apply_assign_first() async throws {
        var item1 = Item(1)
        let item2 = item1

        item1.apply {
            $0.value = 2
        }

        #expect(item1.value == 2)
        #expect(item2.value == 1)
    }

    @Test("apply on second copy mutates only second")
    func apply_assign_second() async throws {
        let item1 = Item(1)
        var item2 = item1

        item2.apply {
            $0.value = 2
        }

        #expect(item1.value == 1)
        #expect(item2.value == 2)
    }

    @Test("applyingEach on array returns modified copy")
    func applyingEach_array() async throws {
        let array1 = [Item(1), Item(2), Item(3)]

        let array2 = array1.applyingEach {
            $0.value += 1
        }

        #expect(array1.map(\.value) == [1, 2, 3])
        #expect(array2.map(\.value) == [2, 3, 4])
    }

    @Test("applyEach on array mutates in place")
    func applyEach_array() async throws {
        var array = [Item(1), Item(2), Item(3)]

        array.applyEach {
            $0.value += 1
        }

        #expect(array.map(\.value) == [2, 3, 4])
    }

    @Test("apply propagates thrown errors")
    func apply_throws() async throws {
        var item = Item(1)

        #expect(throws: TestError.self) {
            try item.apply { _ in
                throw TestError.boom
            }
        }
        #expect(item.value == 1)
    }

    @Test("applying propagates thrown errors")
    func applying_throws() async throws {
        let item = Item(1)

        #expect(throws: TestError.self) {
            _ = try item.applying { _ in
                throw TestError.boom
            }
        }
        #expect(item.value == 1)
    }

    @Test("no-op applying leaves values unchanged")
    func applying_noop() async throws {
        let item = Item(5)

        let newItem = item.applying { _ in }

        #expect(item.value == 5)
        #expect(newItem.value == 5)
    }

    @Test("applyEach on empty array is no-op")
    func applyEach_array_empty() async throws {
        var array: [Item] = []

        array.applyEach {
            $0.value += 1
        }

        #expect(array.isEmpty)
    }

    @Test("chained applying accumulates changes without mutating original")
    func applying_chained() async throws {
        let item = Item(1)

        let result = item
            .applying { $0.value += 2 }
            .applying { $0.value *= 3 }

        #expect(item.value == 1)
        #expect(result.value == 9)
    }
}

// MARK: - Helpers

private struct Item: Appliable {
    var value: Int

    init(_ value: Int = 0) {
        self.value = value
    }
}
