//
//  LineChart.swift
//  
//
//  Created by Leopold Lemmermann on 04.03.22.
//

import SwiftUI
import MyCollections

public struct LineChart: View {
    
    public let data: [LineData]
    
    public let lines: Int

    public var body: some View {
        ZStack {
            ForEach(data, id: \.self) { lineData in
                if let color = lineData.line.color {
                    Line(lineData.dataPoints, pointSize: lineData.points.size, drawPoints: false)
                        .stroke(color, lineWidth: lineData.line.width)
                }

                if let color = lineData.points.color {
                    Line(lineData.dataPoints, pointSize: lineData.points.size, drawPoints: true)
                        .fill(color)
                }
            }
        }
        .background {
            VStack {
                ForEach(0..<lines) { _ in
                    Divider()
                    Spacer()
                }
            }
        }
    }
    
    public init(_ data: [LineData], lines: Int = 10) {
        self.data = data
        self.lines = lines
    }
    public init(_ data: LineData..., lines: Int = 10) {
        self.init(data, lines: lines)
    }
    
}

public extension LineChart {
    
    struct LineData {
        
        public var dataPoints: [DataPoint]
        
        public var line: (color: Color?, width: Double),
                   points: (color: Color?, size: Double)
        
        public init(
            _ dataPoints: [DataPoint],
            lineColor: Color? = .init(hue: .random(in: 0..<1), saturation: .random(in: 0..<1), brightness: .random(in: 0..<1)), lineWidth: Double = 2,
            pointColor: Color? = .init(hue: .random(in: 0..<1), saturation: .random(in: 0..<1), brightness: .random(in: 0..<1)), pointSize: Double = 5
        ) {
            self.dataPoints = dataPoints
            self.line = (lineColor, lineWidth)
            self.points = (pointColor, pointSize)
        }
        
    }
    
}

extension LineChart.LineData: Hashable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool { lhs.dataPoints == rhs.dataPoints }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(dataPoints)
    }
    
}

extension LineChart.LineData: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: DataPoint...) {
        self.init(elements)
    }
    
}

extension LineChart {
    
    struct Line: Shape {
        public let dataPoints: [DataPoint],
                   maxValue: Double
        
        public let points: (draw: Bool, size: Double)
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let drawRect = rect.insetBy(dx: points.size, dy: points.size)
            let factor: (x: Double, y: Double) = (drawRect.width / Double(dataPoints.count - 1), drawRect.height / Double(maxValue))
            
            for (index, dataPoint) in dataPoints.enumerated() {
                var point: CGPoint = .init(x: factor.x * Double(index), y: factor.y * dataPoint.value)
                point.y += drawRect.minX
                point.y = drawRect.minY + (drawRect.height - point.y)
                
                if !points.draw {
                    if index == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                } else {
                    point.x -= points.size / 2
                    point.y -= points.size / 2

                    path.addEllipse(in: CGRect(origin: point, size: CGSize(width: points.size, height: points.size)))
                }
                
                                
            }
            
            return path
        }
        
        init(
            _ dataPoints: [DataPoint],
            pointSize: Double,
            drawPoints: Bool
        ) {
            self.dataPoints = dataPoints
            self.points = (drawPoints, pointSize)
            
            self.maxValue = dataPoints.maxValue()
        }
    }
    
}

#if DEBUG
//MARK: - Previews
struct LineChart_Previews: PreviewProvider {
    private static let lineData: [LineChart.LineData] = Array(count: 5, { _ in LineChart.LineData(.lineExamples()) })
    
    static var previews: some View {
        LineChart(lineData)
            .frame(maxWidth: 300, maxHeight: 300)
    }
}
#endif
