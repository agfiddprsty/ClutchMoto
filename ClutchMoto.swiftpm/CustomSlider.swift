import SwiftUI

struct CustomSlider: View {
    @State private var location: CGPoint = CGPoint(x: 50, y: 70)
    @Binding var value: Double
    var range: (Double, Double)
    var type: String
    
    init(value: Binding<Double>, range: (Double, Double), type: String) {
        _value = value
        self.range = range
        self.type = type
    }
    
    private func onDragChange(_ drag: DragGesture.Value,_ frame: CGRect) {
        if drag.location.y < 0 {
            location.y = 70
            value = 0
        } else if drag.location.y > 300 {
            location.y = 350
            value = 350
        } else {
            location.y = drag.location.y + 50
            value = drag.location.y + 50
        }
    }
    
    private func view(geometry: GeometryProxy) -> some View {
        let frame = geometry.frame(in: .global)
        let drag = DragGesture(minimumDistance: 0).onChanged { drag in
            onDragChange(drag, frame)
        }.onEnded { _ in
            location.y = 70
            value = 0
        }
        
        return VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            HStack(alignment: .center) {
                if type == "throttle" {
                    Spacer()
                }
                ZStack {
                    ZStack() {
                        ZStack(alignment: .center) {
                            Group {
                                Rectangle()
                                    .frame(width: 60.0, height: 330)
                                    .cornerRadius(10.0)
                                    .foregroundColor(Color("road_color"))
                                Group {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 45, height: 300)
                                            .cornerRadius(10.0)
                                            .foregroundColor(Color("value_color"))
                                        if type == "clutch" {
                                            Rectangle()
                                                .frame(width: 45, height: 150)
                                                .cornerRadius(10.0)
                                                .padding(.top, 150)
                                                .foregroundColor(Color.green)
                                        }
                                    }
                                }.gesture(drag)
                            }
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                    }
                    VStack {
                        Spacer()
                        Spacer()
                        Image("knob_slider")
                            .offset(x: /*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/, y: location.y)
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }
                if type == "clutch" {
                    Spacer()
                }
            }
            .padding(.top, 150)
            Spacer()
        };
    }
    
    var body: some View {
        return GeometryReader { geometry in
            self.view(geometry: geometry)
        }
    }
}

struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(value: .constant(0.0), range: (0, 100), type: "clutch")
    }
}
