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
public protocol ObjectAppliable {}

extension ObjectAppliable {
    /// Applies configuration using the given closure.
    ///
    /// - Parameter block: The configuration block to apply.
    @discardableResult
    public func apply(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

// MARK: - Collection

extension Collection where Element: ObjectAppliable {
    /// Applies configuration to each element using the given closure.
    ///
    /// - Parameter block: The configuration block to apply.
    @discardableResult
    public func applyEach(_ block: (Element) throws -> Void) rethrows -> Self {
        try forEach {
            try $0.apply(block)
        }
        return self
    }
}

// MARK: - Conformance

extension NSObject: ObjectAppliable {}

extension JSONDecoder: ObjectAppliable {}
extension JSONEncoder: ObjectAppliable {}
extension PropertyListDecoder: ObjectAppliable {}
extension PropertyListEncoder: ObjectAppliable {}
