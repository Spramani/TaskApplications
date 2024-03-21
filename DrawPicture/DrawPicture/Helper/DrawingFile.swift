//
//  DrawingFile.swift
//  DrawPicture
//
//  Created by Shubham Ramani on 11/03/24.
//

import Foundation
import UIKit


class DrawingView: UIView {
    private var lines: [[CGPoint]] = [[]]
    private var lineColors: [UIColor] = [.black]
    private var lineWidths: [CFloat] = [4]
    private var isErasing = false
    
    private var currentColor: UIColor = .black
    var currentLineWidth: CGFloat = 15.0
    private var isDrawing = false
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        backgroundColor?.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(.round)
        //  context?.setLineWidth(currentLineWidth)
        context?.fill(rect)
        
        for (i, line) in lines.enumerated() {
            guard !line.isEmpty else { continue }
            
            context?.setStrokeColor(lineColors[i].cgColor)
            context?.setLineWidth(CGFloat(lineWidths[i]))
            
            if isErasing {
                         context?.setBlendMode(.clear) // Set blend mode to clear for erasing
                     } else {
                         context?.setBlendMode(.normal) // Set blend mode back to normal for drawing
                }
            for (i, point) in line.enumerated() {
                if i == 0 {
                    context?.move(to: point)
                } else {
                    context?.addLine(to: point)
                }
            }
            
            context?.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let point = touch.location(in: self)
        
        if isErasing {
            erase(at: point)
        } else {
            let point = touch.location(in: self)
            lines.append([point])
            lineColors.append(currentColor)
            lineWidths.append(CFloat(currentLineWidth))
            
                        isDrawing = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, isDrawing else { return }
        
        let point = touch.location(in: self)
        lines[lines.count - 1].append(point)
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        
        isDrawing = false
    }
    
    func undo() {
        if !lines.isEmpty {
            lines.removeLast()
            lineColors.removeLast()
            lineWidths.removeLast()
            setNeedsDisplay()
        }
    }
    
    func changeColor(_ color: UIColor) {
        currentColor = color
        setNeedsDisplay()
    }
    
    func changeLineWidth(_ width: CGFloat) {
        currentLineWidth = width
    }
    
    func clear() {
        lines.removeAll()
        lineColors.removeAll()
        lineWidths.removeAll()
        setNeedsDisplay()
    }
    
    func getImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func erase(at point: CGPoint) {
           // Find if the point is close to any existing point in the lines array
           for i in 0..<lines.count {
               for j in 0..<lines[i].count {
                   let existingPoint = lines[i][j]
                   let distance = sqrt(pow(point.x - existingPoint.x, 2) + pow(point.y - existingPoint.y, 2))
                   if distance < currentLineWidth { // Adjust the proximity as needed
                       lines[i].remove(at: j)
                       setNeedsDisplay()
                       return
                   }
               }
           }
       }
    
    func toggleEraseMode(bool:Bool) {
        isErasing = bool
    }
    func toggleEraseMode() {
         isErasing = !isErasing
     }
}
