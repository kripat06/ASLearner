//
//  LearnView.swift
//  ASLearner
//
//  Created by admin on 10/24/22.
//

import SwiftUI
import Foundation
import HalfASheet

struct LearnView: View {
    @State var size:CGFloat = 60
    @State var cornerRad:CGFloat = 15
    @State var buttonColor:String = "Button Color"
    @State var selectedLetter: String = ""
    @State var showPopUp: Bool = false
    @State var isPresented: Bool = false

    let buttons: [[Keys]] = [
        [.A, .B, .C, .D],
        [.E, .F, .G, .H],
        [.I, .J, .K, .L],
        [.M, .N, .O, .P],
        [.Q, .R, .S, .T],
        [.U, .V, .W, .X],
        [.Y, .Z]
    ]
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                ForEach(buttons, id: \.self){ row in
                    HStack(spacing: 10){
                        ForEach(row, id: \.self){ elem in
                            Button {
                                selectedLetter = popUpCall(buttons: elem)
                                showPopUp.toggle()
                            } label: {
                                Text(elem.rawValue)
                                    .font(.system(size: 30))
                                    .frame(width: self.getWidth(elem: elem), height: self.getWidth(elem: elem))
                                    .background(elem.buttonColor)
                                    .foregroundColor(.black)
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.6), radius: 20)
                                }
                            }
                    }
                }.padding(.bottom, 10)
            }
            HalfASheet(isPresented: $showPopUp){
                VStack{
                    Image(selectedLetter)
                        .resizable()
                        .frame(width: 300, height: 300, alignment: .center)
                    Spacer()
                        .frame(height: 30)

                }
                
            }
            .height(.proportional(0.4))
            .backgroundColor(.white)
        }
        
    }
    //Finds width of screen to auto space the buttons
    func getWidth(elem: Keys) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*10))/4
    }
}

//Maps Button press to String output
private func popUpCall(buttons: Keys) -> String{
    var selectedLetter: String = ""
    if buttons == .A {
        selectedLetter = "A"
    }
    else if buttons == .B {
        selectedLetter = "B"
    }
    else if buttons == .C {
        selectedLetter = "C"
    }
    else if buttons == .D {
        selectedLetter = "D"
    }
    else if buttons == .E {
        selectedLetter = "E"
    }
    else if buttons == .F {
        selectedLetter = "F"
    }
    else if buttons == .G {
        selectedLetter = "G"
    }
    else if buttons == .H {
        selectedLetter = "H"
    }
    else if buttons == .I {
        selectedLetter = "I"
    }
    else if buttons == .J {
        selectedLetter = "J"
    }
    else if buttons == .K {
        selectedLetter = "K"
    }
    else if buttons == .L {
        selectedLetter = "L"
    }
    else if buttons == .M {
        selectedLetter = "M"
    }
    else if buttons == .N {
        selectedLetter = "N"
    }
    else if buttons == .O {
        selectedLetter = "O"
    }
    else if buttons == .P {
        selectedLetter = "P"
    }
    else if buttons == .Q {
        selectedLetter = "Q"
    }
    else if buttons == .R {
        selectedLetter = "R"
    }
    else if buttons == .S {
        selectedLetter = "S"
    }
    else if buttons == .T {
        selectedLetter = "T"
    }
    else if buttons == .U {
        selectedLetter = "U"
    }
    else if buttons == .V {
        selectedLetter = "V"
    }
    else if buttons == .W {
        selectedLetter = "W"
    }
    else if buttons == .X {
        selectedLetter = "X"
    }
    else if buttons == .Y {
        selectedLetter = "Y"
    }
    else if buttons == .Z {
        selectedLetter = "Z"
    }
    return selectedLetter
}

struct Learn_View_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}

