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

import Foundation

/// A protocol that enables configuring objects using closures.
public protocol Appliable {}

extension Appliable {
    /// Applies configuration using the given closure.
    ///
    /// - Parameter block: The configuration block to apply.
    @discardableResult
    public func applying(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }

    /// Applies configuration in-place using the given closure.
    ///
    /// - Parameter block: The configuration block to apply.
    public mutating func apply(_ block: (inout Self) throws -> Void) rethrows {
        try block(&self)
    }
}

// MARK: - MutableCollection

extension MutableCollection where Element: Appliable {
    /// Applies configuration to each element using the given closure.
    ///
    /// - Parameter block: The configuration block to apply.
    @discardableResult
    public func applyingEach(_ block: (inout Element) throws -> Void) rethrows -> Self {
        var copy = self
        try copy.applyEach(block)
        return copy
    }

    /// Applies configuration in-place to each element using the given closure.
    ///
    /// - Parameter block: The configuration block to apply.
    public mutating func applyEach(_ block: (inout Element) throws -> Void) rethrows {
        var index = startIndex
        while index != endIndex {
            try self[index].apply(block)
            formIndex(after: &index)
        }
    }
}

// MARK: - Conformance

extension Array: Appliable {}
extension Calendar: Appliable {}
extension Date: Appliable {}
extension Dictionary: Appliable {}
extension Set: Appliable {}
extension URL: Appliable {}
