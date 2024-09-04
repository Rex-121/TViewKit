//
//  File.swift
//  TViewKit
//
//  Created by Tyrant on 2024/9/4.
//

import Foundation
import CoreImage
import UIKit

extension CVPixelBuffer {
    
    
    /// 转换成`UIImage`
    public func toImage() -> UIImage? {
        let ciimage = CIImage(cvImageBuffer: self)
        let context = CIContext(options: nil)
        let value = context.createCGImage(ciimage, from: .init(origin: .zero, size: pixelSize()))
        return value?.toUIImage
    }
    
    /// 获取图像像素尺寸
    public func pixelSize() -> CGSize {
        return .init(width: CVPixelBufferGetWidth(self), height: CVPixelBufferGetHeight(self))
    }
}

extension CVPixelBuffer {
    
    
    public func distance(at points: [CGPoint]) -> [(CGPoint, Double?)] {
                
        CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
        
        defer {
            CVPixelBufferUnlockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
        }
        
        let baseAddress = CVPixelBufferGetBaseAddress(self)?
            .assumingMemoryBound(to: Float32.self)
        
        let bytesPerRow = CVPixelBufferGetBytesPerRow(self)
        
        let indexes: [(CGPoint, Double?)] = points.map { point in
            (point, Int(point.y) * bytesPerRow / MemoryLayout<Float32>.stride + Int(point.x))
        }.map { (point, index) in
            if let value = baseAddress?[index] {
                return (point, Double(value))
            }
            return (point, nil)
        }.map { (point, index) in
            return (point, index)
        }

        return indexes
    }
    
}


extension CGImage {
    
    /// 转换成`UIImage`
    var toUIImage: UIImage? { UIImage(cgImage: self) }
    
}
