//
//  PieChart.swift
//  
//
//  Created by Leopold Lemmermann on 25.02.22.
//

import SwiftUI
import MyCollections

/***/
public struct PieChart: View {
    ///
    let segments: [Segment]
    
    ///
    public let strokeWidth: Double?,
               ///
               legend: Bool
    
    public var body: some View {
        ZStack {
            ForEach(segments) { segment in
                segment
                    .fill(segment.data.color)
            }
        }
        .mask {
            Circle()
                .if(let: strokeWidth) { view, strokeWidth in
                    view.strokeBorder(.white, lineWidth: strokeWidth)
                }
        }
        .overlay(alignment: .bottomTrailing) {
            if legend {
                VStack(alignment: .leading) {
                    ForEach(segments) { segment in
                        Label(segment.data.title, systemImage: "circle")
                            .foregroundColor(segment.data.color)
                            .font(.caption2)
                            .minimumScaleFactor(0.3)
                    }
                }
                .padding(5)
                .background(.bar)
                .cornerRadius(10)
            }
        }
    }
    
    /***/
    public init(
        _ dataPoints: [DataPoint],
        stroke: Stroke = .all,
        legend: Bool = false
    ) {
        self.strokeWidth = stroke.width
        self.legend = legend
        
        let total = dataPoints.sum(\.value)
        self.segments = dataPoints.reduce([Segment]()) { segments, data in
            segments + Segment(data: data, start: segments.sum(\.amount) - 0.25, amount: data.value / total)
        }
    }
    
    
}

//MARK: - Segments
import MyNumbers
extension PieChart {
    /***/
    struct Segment: Shape, Identifiable {
        ///
        let data: DataPoint
        var id: Int { data.id }
        
        ///
        var start: Double,
            ///
            amount: Double
        
        /***/
        func path(in rect: CGRect) -> Path {
            let radius = min(rect.width, rect.height) * 0.5
            let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
            
            var path = Path()
            path.move(to: center)
            path.addRelativeArc(center: center, radius: radius, startAngle: Angle(radians: .twoPi * start), delta: Angle(radians: .twoPi * amount))
            return path
        }
        
        ///
        var animatableData: AnimatablePair<Double, Double> {
            get { AnimatablePair(start, amount) }
            set { (start, amount) = (newValue.first, newValue.second) }
        }
        
    }
}

//MARK: - Stroke for making a donut chart
public extension PieChart {
    
    /***/
    enum Stroke {
        case all, thin, regular, thick, custom(Double)
        
        ///
        var width: Double? {
            switch self {
            case .all: return nil
            case .thin: return 20
            case .regular: return 50
            case .thick: return 100
            case .custom(let double): return double
            }
        }
    }
    
}

extension PieChart.Stroke: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    
    public init(floatLiteral width: Double) {
        self = .custom(width)
    }
    
    public init(integerLiteral width: IntegerLiteralType) {
        self = .custom(Double(width))
    }
}

#if DEBUG
//MARK: - Previews
struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PieChart(.examples)
            PieChart(.examples, legend: true)
        }
        
        VStack {
            PieChart(.examples, stroke: .regular)
            PieChart(.examples, stroke: .thin)
            PieChart(.examples, stroke: .thick)
            PieChart(.examples, stroke: 10)
        }
    }
}
#endif
