//
//  GameRenderer.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class GameRenderer {
    var scale: CGFloat
    var unitSize: CGFloat
    var boardAreaFrame: CGRect

    init(scale: CGFloat, unitSize: CGFloat, boardAreaFrame: CGRect) {
        self.scale = scale
        self.unitSize = unitSize
        self.boardAreaFrame = boardAreaFrame
    }

    func getPositionWithOffsets(for originalPosition: CGPoint, playerPosition: CGPoint?) -> CGPoint {
        let verticalCameraOffset = 1_300.0
        var xPosition = originalPosition.x + boardAreaFrame.width / scale / 2
        var yPosition = originalPosition.y + boardAreaFrame.height / scale / 2 + verticalCameraOffset / scale
        if let playerPosition = playerPosition {
            xPosition -= playerPosition.x
            yPosition -= playerPosition.y
        }
        return toBoardPosition(position: CGPoint(x: xPosition, y: yPosition))
    }

    private func toBoardPosition(position: CGPoint) -> CGPoint {
        CGPoint(x: position.x * unitSize, y: position.y * unitSize)
    }
}
