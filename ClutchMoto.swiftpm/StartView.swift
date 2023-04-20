//
//  StartView.swift
//  ClutchMoto
//
//  Created by Agfid Prasetyo on 17/04/23.
//

import SwiftUI
import AVFoundation

struct StartView: View {
    @State private var hideTutorial = false
    @State private var currentStep = 0
    @State private var engineStarted = false
    @State private var valueClutch = 0.0
    @State private var valueThrottle = 0.0
    @State private var move = false
    @State private var gear = 0
    @State private var message: String = ""
    @State private var speed: Double = 4
    @State private var player = AVPlayer()
    
    struct Step: Identifiable {
        let id = UUID()
        var content: String
    }
    
    var tutorial = [
        Step(content: "I'll Tell You How to Operate a Motorcycle Clutch"),
        Step(content: "First, Get on your motorcycle and start it up"),
        Step(content: "Tap and hold start button"),
        Step(content: "Now, put your left hand at clutch lever"),
        Step(content: "and put your right hand at throttle"),
        Step(content: "pull and hold the clutch into the green zone and shift into first gear"),
        Step(content: "then release the clutch and pull the throttle slowly and simultaneously"),
        Step(content: "It's your turn to try it"),
    ]
    
    var body: some View {
        
        ZStack {
            Image("background_full")
                .resizable()
                .scaledToFill()
                .position(x: UIScreen.main.bounds.size.width * 0.5, y: UIScreen.main.bounds.size.height * 0.48)
            VStack {
                Image("roadline_full")
                    .padding(.leading)
                    .position(x: UIScreen.main.bounds.size.width * 0.5, y: UIScreen.main.bounds.size.height * 0.45)
                    .offset(y: move ? 230 : -135)
                    .animation(.linear(duration: move ? 14 : 0).speed(move ? Double(speed) : 0).repeatForever(autoreverses: false), value: move)
                    .onChange(of: valueThrottle) { newValue in
                        if valueThrottle > 0 {
                            print("value throttle: ", valueThrottle)
                            speed = Double(Int(valueThrottle) / 10)
                            print(speed)
                        }
                        if valueThrottle > 0 && currentStep == 4 {
                            currentStep += 1
                        }
                        if valueClutch < 220 && valueThrottle == 0 && engineStarted && gear > 0 {
                            engineStarted = false
                            move = false
                            stopSound(sound: "backsound", type: "mp3")
                            message = "Do not release the clutch while the engine is started and the throttle is not being pulled"
                        } else if valueThrottle == 0 && engineStarted && valueClutch < 220 && gear > 0 {
                            move = false
                            engineStarted = false
                            stopSound(sound: "backsound", type: "mp3")
                            message = "Do not release the throttle while the engine is started and the clutch is not being pulled"
                        } else if gear > 0 && valueClutch < 220 && valueThrottle > 0 && engineStarted {
                            move = true
                        }
                    }
                    .onChange(of: valueClutch) { newValue in
                        if valueClutch > 0 && currentStep == 3 {
                            currentStep += 1
                        }
                        if valueClutch < 220 && valueThrottle == 0 && engineStarted && gear > 0 {
                            engineStarted = false
                            move = false
                            stopSound(sound: "backsound", type: "mp3")
                            message = "Do not release the clutch while the engine is started and the throttle is not being pulled"
                        } else if valueThrottle == 0 && engineStarted && valueClutch < 220 && gear > 0 {
                            move = false
                            engineStarted = false
                            stopSound(sound: "backsound", type: "mp3")
                            message = "Do not release the throttle while the engine is started and the clutch is not being pulled"
                        } else if gear > 0 && valueClutch < 220 && valueThrottle > 0 && engineStarted {
                            move = true
                            if currentStep == 6 {
                                currentStep += 1
                            }
                        }
                    }
                    .onChange(of: gear) { newValue in
                        if gear > 0 && currentStep == 5 {
                            currentStep += 1
                        }
                        if valueClutch < 220 && valueThrottle == 0 && engineStarted && gear > 0 {
                            engineStarted = false
                            move = false
                            stopSound(sound: "backsound", type: "mp3")
                            message = "Do not release the clutch while the engine is started and the throttle is not being pulled"
                        } else if valueThrottle == 0 && engineStarted && valueClutch < 220 && gear > 0 {
                            move = false
                            engineStarted = false
                            stopSound(sound: "backsound", type: "mp3")
                            message = "Do not release the throttle while the engine is started and the clutch is not being pulled"
                        } else if gear > 0 && valueClutch < 220 && valueThrottle > 0 && engineStarted {
                            move = true
                            if currentStep == 6 {
                                currentStep += 1
                            }
                        }
                    }
                    .onChange(of: engineStarted) { newValue in
                        if valueClutch < 220 && valueThrottle == 0 && engineStarted && gear > 0 {
                            engineStarted = false
                            move = false
                            stopSound(sound: "backsound", type: "mp3")
                            message = "Do not release the clutch while the engine is started and the throttle is not being pulled"
                        } else if valueThrottle == 0 && engineStarted && valueClutch < 220 && gear > 0 {
                            move = false
                            engineStarted = false
                            stopSound(sound: "backsound", type: "mp3")
                            message = "Do not release the throttle while the engine is started and the clutch is not being pulled"
                        } else if gear > 0 && valueClutch < 220 && valueThrottle > 0 && engineStarted {
                            move = true
                        }
                    }
            }.mask {
                VStack {
                    Spacer()
                    Image("bottom_background").position(x: UIScreen.main.bounds.size.width * 0.5, y: UIScreen.main.bounds.size.height * 0.65)
                }
            }
            Image("motorbike")
                .position(x: UIScreen.main.bounds.size.width * 0.5, y: UIScreen.main.bounds.size.height * 0.86)
            if !hideTutorial {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(height: /*@START_MENU_TOKEN@*/120.0/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.white)
                        Text(tutorial[currentStep].content)
                            .font(.title)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .transition(.opacity)
                        HStack(alignment: .bottom) {
                            Spacer()
                            if (currentStep != 2) {
                                Text("Tap to next")
                                    .padding([.top, .trailing], 90.0)
                            }
                        }
                        .frame(height: /*@START_MENU_TOKEN@*/120.0/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                    
                }.padding(.top, 50).onTapGesture {
                    if currentStep < 2 && currentStep < tutorial.count - 1 {
                        currentStep += 1
                        print(currentStep)
                    } else if (currentStep == tutorial.count - 1){
                        hideTutorial = true
                    }
                }
            }
            if (currentStep >= 2 && engineStarted == false) {
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    HStack {
                        Spacer()
                        Image("start_engine")
                            .padding([.trailing], 130)
                            .onLongPressGesture(minimumDuration: 1) {
                                if currentStep == 2 {
                                    currentStep += 1
                                }
                                engineStarted = true
                                playSound(sound: "backsound", type: "mp3")
                            }
                    }
                    Spacer()
                }
            }
            ZStack {
                if message != "" {
                    VStack {
                        ZStack {
                            Rectangle()
                                .frame(height: /*@START_MENU_TOKEN@*/120.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.white)
                            Text(message)
                                .font(.title)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .transition(.opacity)
                                .padding([.trailing, .leading])
                            HStack(alignment: .bottom) {
                                Spacer()
                                Text("Tap to next")
                                    .padding([.top, .trailing], 90.0)
                            }
                            .frame(height: /*@START_MENU_TOKEN@*/120.0/*@END_MENU_TOKEN@*/)
                        }
                        Spacer()
                        
                    }.padding(.top, 50).onTapGesture {
                        message = ""
                    }
                }
                if currentStep >= 3 {
                    VStack {
                        CustomSlider(value: $valueClutch, range: (0, 100), type: "clutch")
                    }
                }
                if currentStep >= 4 {
                    VStack {
                        CustomSlider(value: $valueThrottle, range: (0, 100), type: "throttle")
                    }
                }
                if currentStep >= 5 {
                    VStack {
                        ZStack {
                            Circle().foregroundColor(Color.gray).frame(height: 100)
                            Circle().foregroundColor(Color.white).frame(height: 80)
                            Text(gear == 0 ? "N" : "\(gear)").font(.largeTitle)
                                .fontWeight(.bold)
                        }.padding(.top, 200)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Button(action: {
                                if gear == 0 && engineStarted && valueClutch > 220 {
                                    gear = 2
                                } else if gear == 0 && engineStarted && valueClutch < 220 {
                                    engineStarted = false
                                    stopSound(sound: "backsound", type: "mp3")
                                    message = "Do not change gears without pulling the clutch"
                                } else if gear < 6 && valueClutch < 220 && engineStarted {
                                    move = false
                                    engineStarted = false
                                    stopSound(sound: "backsound", type: "mp3")
                                    message = "Do not change gears without pulling the clutch"
                                } else if gear < 6 && valueClutch > 220 && engineStarted {
                                    gear += 1
                                }
                            }) {
                                Image("up_shift")
                            }.disabled(gear == 6)
                            Button(action: {
                                if valueClutch < 220 {
                                    move = false
                                    engineStarted = false
                                    stopSound(sound: "backsound", type: "mp3")
                                    message = "Do not change gears without pulling the clutch"
                                } else if valueClutch > 220 {
                                    gear = 0
                                    move = false
                                }
                            }) {
                                Image("netral_gear")
                            }.disabled(gear > 2 || gear == 0)
                            Button(action: {
                                print(valueClutch)
                                // ACTION DOWNSHIFT
                                if gear == 0 && engineStarted && valueClutch < 220 {
                                    engineStarted = false
                                    stopSound(sound: "backsound", type: "mp3")
                                    message = "Do not change gears without pulling the clutch"
                                } else if gear > 1 && engineStarted && valueClutch < 220 {
                                    engineStarted = false
                                    stopSound(sound: "backsound", type: "mp3")
                                    move = false
                                    message = "Do not change gears without pulling the clutch"
                                } else if gear == 0 && engineStarted && valueClutch > 220{
                                    gear = 1
                                } else if gear > 1 && engineStarted && valueClutch > 220 {
                                    gear -= 1
                                }
                            }) {
                                Image("down_shift")
                            }.disabled(gear == 1)
                            Spacer()
                            Spacer()
                            Spacer()
                        }.padding(.trailing, 130)
                    }
                }
            }
        }
        
    }
    
    struct StartView_Previews: PreviewProvider {
        static var previews: some View {
            StartView()
        }
    }
}
