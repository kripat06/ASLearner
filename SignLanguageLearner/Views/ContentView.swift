//
//  ContentView.swift
//  ASLearner
//
//  Created by Krish Patel on 10/15/22.
//

import SwiftUI
import AVFoundation

//Contains function to round specific corners
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//View for initial home page with Learn, Practice, and Transalate View
struct HomeView: View {
    @State var showLearnView = false
    @State var showPracticeView = false
    @State var showTransalateView = false
    @State private var hideStartScreen = true
    @ObservedObject var detectedWord = DetectedWord.shared

    var body: some View {

        NavigationView {
        ZStack{
            VStack {
                Text("ASLearner")
                    .font(.system(size: 48))
                    .fontWeight(.medium)
                    .offset(y: -310)
                Text("Sight for the world")
                    .font(.system(size: 27))
                    .fontWeight(.medium)
                    .offset(y: -310)

            }
            Spacer()
            VStack{
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        showLearnView = true
                    }
                }){
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("Button Color"))
                    .overlay(Text("Learn")
                        .font(.system(size: 27))
                        .fontWeight(.light)
                        .foregroundColor(.black)
                    )
                    .cornerRadius(8)
                    .shadow(color: .black, radius: 4, y: 4)
                    .frame(width: 238, height: 50, alignment: .center)
                
                    
                }
                .offset(y: -15)
                NavigationLink(destination: LearnView(), isActive: $showLearnView) {
                    EmptyView()
                }
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        showPracticeView = true
                        detectedWord.detectionMode = true
                    }
                }){
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("Button Color"))
                    .overlay(Text("Practice")
                        .font(.system(size: 27))
                        .fontWeight(.light)
                        .foregroundColor(.black)
                    )
                    .cornerRadius(8)
                    .shadow(color: .black, radius: 4, y: 4)
                    .frame(width: 238, height: 50, alignment: .center)
                
                    
                }
                NavigationLink(destination: PracticeView(), isActive: $showPracticeView) {
                    EmptyView()
                }
            }
            .offset(y: 190)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")

 
            Spacer()
            VStack{
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        showTransalateView = true
                    }
                }){
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("Button Color"))
                    .overlay(Text("Transalate")
                        .font(.system(size: 27))
                        .fontWeight(.light)
                        .foregroundColor(.black)
                    )
                    .cornerRadius(8)
                    .shadow(color: .black, radius: 4, y: 4)
                    .frame(width: 238, height: 50, alignment: .center)
                    
                }
                NavigationLink(destination: TransalateView(), isActive: $showTransalateView) {
                    EmptyView()
                }
                .navigationTitle("")
            }
            .offset(y: 280)

        }
    }
    }
}

//The learn view from the LearnView file is pulled here
struct LearningView: View{
    var body: some View {
        LearnView()
    }
}

//Overlays the Practice UI on the live camera view (HostedViewController)
struct PracticeView: View {
    init() {
            UINavigationBar.appearance().tintColor = .black
    }
    var body: some View {
        ZStack{

            HostedViewController()
                .ignoresSafeArea()
                .overlay(PracticeOverlay())
        }
    }

}

//The main Practice view without the live camera view
struct PracticeOverlay: View{
    @State var generatedWord =  randomText()
    @State var result:Bool = false
    @ObservedObject var detectedWord = DetectedWord.shared

    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color.green)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .opacity(0.6)
                .ignoresSafeArea()
                .overlay(Image(systemName: "checkmark").imageScale(.large)
                    .font(.system(size:56.0, weight: .black))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(Color.white)
                    .offset(y: -60)
                )
                .opacity(detectedWord.isDetected() ? 1 : 0)
                .animation(.easeInOut.speed(1), value: detectedWord.isDetected())
        }
        ZStack{
            VStack{
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("Dark Grey"))
                    .frame(width: 246, height: 54, alignment: .center)
                Spacer()
                    .frame(height: 650)
                Rectangle()
                    .fill(Color("Dark Grey"))
                    .frame(width: 414, height: 180, alignment: .center)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
            }
            VStack{
                HStack{
                    Text("Spell:")
                        .font(.system(size: 30))
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                    Text(detectedWord.getGeneratedWord())
                        .font(.system(size: 30))
                        .fontWeight(.light)
                        .tracking(8)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                            
                }
                .frame(alignment: .center)
                .offset(x: 2, y: 9)

                Spacer()
                    .frame(height:700)
                HStack{
                    Spacer()
                    Text("Detected:")
                        .font(.system(size: 30))
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .offset(x: 20)
                        .padding([.bottom], 110)
                    Text(detectedWord.getDetectedWord())
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .tracking(8)
                        .offset(x: 20)
                        .padding([.bottom], 110)
                    Spacer()
                    Button(action: {
                        generatedWord = randomText()
                    }) {
                        Text("Skip")
                            .offset(x: 8)
                            .foregroundColor(Color(.white))
                        Image(systemName: "chevron.compact.right")
                            .foregroundColor(Color(.white))
                            .font(Font.system(size: 30, weight: .heavy))
                    }
                    .frame(alignment: .bottom)
                    .offset(x: -20)
                    .padding([.bottom], 105)
                }
            }
        }
    }
}

//makes the RoundedCorner function a view modifier
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

//Overlays the Transalate UI on the live camera view (HostedViewController)
struct TransalateView: View {
    let synthesizer = AVSpeechSynthesizer()

    var body: some View{
        ZStack{
            HostedViewController()
                .ignoresSafeArea()
                .overlay(TransalateOverlay())
        }
        
    }
}

//The main Transalate view without the live camera view
struct TransalateOverlay: View {
    let synthesizer = AVSpeechSynthesizer()
    @ObservedObject var detectedLetter = DetectedLetter.shared
    @State var transalateStart = false

    var body: some View {
        Spacer()
            .frame(height: 560)
        ZStack {
            if transalateStart == false {
                RoundedRectangle(cornerRadius: 5)
                    .overlay(Text("Start Translating").font(.system(size:20))
                    .fontWeight(.light)
                                .foregroundColor(.white)
                    )
                    .foregroundColor(Color.black)
                    .frame(width: 220, height: 29, alignment: .center)
                    .offset(y: 250)
                    .opacity(0.8)
                    .animation(.easeIn.speed(0.6), value: transalateStart)
            }
            
        }

        ZStack{
            Text(detectedLetter.updateWord())
                .font(.system(size: 25))
                .fontWeight(.light)
                .foregroundColor(.white)
                .padding([.bottom], 230)
                .frame(minWidth: 0, maxWidth: 400, alignment: .center)
                .zIndex(1)
                .opacity(transalateStart ? 0.8 : 0)
                .animation(.easeInOut.speed(0.6), value: transalateStart)
            Rectangle()
                .fill(Color("Dark Grey"))
                .frame(width: 420, height: 300, alignment: .center)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .opacity(transalateStart ? 0.8 : 0)
                .animation(.easeInOut.speed(0.6), value: transalateStart)
            Button ( action: {textToSpeech(speech: detectedLetter.getDetectedWord()) })
              {
                Circle()
                  .fill(.black)
                  .frame(width: 50, height: 50)
                  .overlay(Image(systemName: "waveform").imageScale(.large)
                      .font(.system(size:25, weight: .black))
                      .foregroundColor(Color.white)
                  )
                  .opacity(transalateStart ? 0.8 : 0)
                  .animation(.easeInOut.speed(0.6), value: transalateStart)
                  
              }.offset(x: 150, y: -190)
        }
        .offset(y: 20)
        .overlay(
            Button(action: {
                transalateStart.toggle()
                detectedLetter.resetTranslation()
            })
            {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 54, height: 54, alignment: .bottom)
                    .cornerRadius(transalateStart ? 12 : 100/2)
                    .scaleEffect(transalateStart ? 0.65 : 1.0)
                    .animation(.easeIn(duration: 0.2))
                    .offset(x:39)
                Circle()
                    .stroke(lineWidth: 4)
                    .foregroundColor(Color.white)
                    .frame(width: 64, height: 64, alignment: .bottom)
                    .offset(x:-28)
                    .animation(.easeIn(duration: 0.2))

            }
        )
        .offset(y: 320)
    }
    private func textToSpeech(speech:String){
        let utterance = AVSpeechUtterance(string: speech)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        synthesizer.speak(utterance)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



//DetectedLetter class used mainly buy the Transalate View
class DetectedLetter: ObservableObject {
    @Published var detectedLetter: String = ""
    var oldWord:String = ""
    var occurences: Array<String> = []

    var word: String = "" {
        didSet{
            oldWord = oldValue
        }
    }
    func getDetectedLetter() -> String{
        return detectedLetter
    }
    static let shared = DetectedLetter()
}

//Allows for some extra functions for the transalate view detection logic
extension DetectedLetter {
    func updateWord() -> String{
        word = detectedLetter
        if oldWord == detectedLetter{  }
        else {
            occurences.append(word)
        }
        print(occurences)
        return occurences.joined(separator: "")
    }
    func getDetectedWord() -> String {
        return occurences.joined(separator: "")
    }
    func resetTranslation() {
        oldWord = ""
        occurences = []
    }
}

//Main class used for the Practice View
class DetectedWord: ObservableObject {
    @Published var detectedWord: String = ""
    @Published var detected: Bool = false
    @Published var detectionMode: Bool = false
    var detectedWordArr: Array<String> = []
    var generatedWord: Array<Character> = []
    static let shared = DetectedWord()
    
    func getDetectedWord() -> String{
        return detectedWord
    }
    
    func isDetected() -> Bool {
        return detected
    }
    func resetWord() {
        detectedWordArr = []
        detected = false
        detectedWord = ""
    }
    
    func setGeneratedWord(word:String){
        generatedWord = []
        detected = false
        for char in word {
            generatedWord.append(char)
        }
        print(generatedWord)
    }
    func getGeneratedWord() -> String {
        return generatedWord.map { String($0) }.joined(separator:"")
    }
    func getDisplayWord() -> String {
        var displayWord:Array<String> = detectedWordArr
        for i in 0...(generatedWord.count - detectedWord.count){
            displayWord.append(" ")
        }
        return displayWord.joined(separator:" ")
    }
    func appendToDetectedWord(letter: String) {
        print("detectedLetter - " + letter + " Mode: " + String(detectionMode))
        if detectionMode == true {
            if detectedWordArr.count < generatedWord.count {
                if generatedWord[detectedWordArr.count] == Character(letter)  {
                    detectedWordArr.append(letter)
                    detectedWord =  detectedWordArr.joined(separator:"")
                    print(detectedWord)
                }
                else { }
            }
            else {
                detected = true
                self.detectionMode = false
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(Int(1.5))) {
                    self.resetWord()
                    _ = randomText()
                    self.detectionMode = true

                }
            }
        }
    }
}
