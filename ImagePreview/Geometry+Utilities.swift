//
//  Geometry+Utilities.swift
//  ImagePreview
//
//  Created by evan on 2023/5/17.
//

import Foundation
import UIKit

public enum ScaleMode {
    case fill, aspectFit, aspectFill

    public init?(_ contentMode: UIView.ContentMode) {
        switch contentMode {
        case .scaleToFill: self = .fill
        case .scaleAspectFit: self = .aspectFit
        case .scaleAspectFill: self = .aspectFill
        default: return nil
        }
    }
}

// MARK: Size
public extension CGSize {
    init(uniform value: CGFloat) {
        self.init(width: value, height: value)
    }

    // MARK: Scaling
    func scaling(to targetSize: CGSize, scaleMode: ScaleMode = .fill) -> CGSize {
        var scaling = targetSize / self
        // Adjust scale for aspect fit/fill
        switch scaleMode {
        case .aspectFit: scaling = CGSize(uniform: min(scaling.width, scaling.height))
        case .aspectFill: scaling = CGSize(uniform: max(scaling.width, scaling.height))
        case .fill: break
        }
        // New size
        return self * scaling
    }

    // Vector magnitude (length)
    var magnitude: CGFloat {
        return sqrt(width * width + height * height)
    }
    
    static func maxx(_ x: CGSize, _ y: CGSize) -> CGSize {
        x.magnitude > y.magnitude ? x : y
    }
    
    // Vector normalization
    var normalized: CGSize {
        return CGSize(width: width / magnitude, height: height / magnitude)
    }
}

public func + (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height) }
public func - (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height) }
public func * (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height) }
public func * (lhs: CGSize, rhs: CGFloat) -> CGSize { return CGSize(width: lhs.width * rhs, height: lhs.height * rhs) }
public func / (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width / rhs.width, height: lhs.height / rhs.height) }
public func / (lhs: CGSize, rhs: CGFloat) -> CGSize { return CGSize(width: lhs.width / rhs, height: lhs.height / rhs) }
public func += (lhs: inout CGSize, rhs: CGSize) { return lhs = lhs + rhs }
public func -= (lhs: inout CGSize, rhs: CGSize) { return lhs = lhs - rhs }
public func *= (lhs: inout CGSize, rhs: CGSize) { return lhs = lhs * rhs }
public func *= (lhs: inout CGSize, rhs: CGFloat) { return lhs = lhs * rhs }
public func /= (lhs: inout CGSize, rhs: CGSize) { return lhs = lhs / rhs }
public func /= (lhs: inout CGSize, rhs: CGFloat) { return lhs = lhs / rhs }
