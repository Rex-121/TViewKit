//
//  File.swift
//  TViewKit
//
//  Created by Tyrant on 2024/9/4.
//

import Foundation
import ARKit

extension ARFrame {

    /// 从 `sceneDepth?.depthMap` 深度图中获取像素点z轴数据，单位 `米` 。
    /// - depthMap:
    ///  A pixel buffer that contains per-pixel depth data (in meters).
    public func distanceFromSceneDepth(at points: [CGPoint]) -> [(CGPoint, Double?)] {

        if #available(iOS 14.0, *) {
            return sceneDepth?.depthMap.distance(at: points) ?? []
        } else {
            return []
        }
        
    }
    
}
