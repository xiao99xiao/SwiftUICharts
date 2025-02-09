//
//  SwiftUIView.swift
//  
//
//  Created by Majid Jabrayilov on 24.09.20.
//
import SwiftUI

struct LineChartShape: Shape {
    let dataPoints: [DataPoint]
    var closePath: Bool = true

    func path(in rect: CGRect) -> Path {
        Path { path in
            let max = dataPoints.max()?.endValue ?? 1
            let min = dataPoints.min()?.endValue ?? 0
            let height = max - min
            let start = CGFloat(dataPoints.first?.endValue ?? 0 - min) / CGFloat(height)
            path.move(to: CGPoint(x: 0, y: rect.height - rect.height * start))
            let stepX = rect.width / CGFloat(dataPoints.count)
            var currentX: CGFloat = 0
            dataPoints.forEach {
                currentX += stepX
                let y = CGFloat(($0.endValue - min) / (height)) * rect.height
                path.addLine(to: CGPoint(x: currentX, y: rect.height - y))
            }

            if closePath {
                path.addLine(to: CGPoint(x: currentX, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
                path.closeSubpath()
            }
        }
    }
}

#if DEBUG
struct LineChartShape_Previews: PreviewProvider {
    static var previews: some View {
        LineChartShape(dataPoints: DataPoint.mock, closePath: true)
    }
}
#endif
