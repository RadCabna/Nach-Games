//
//  Training.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 14.05.2025.
//

import SwiftUI

struct Training: View {
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("bgNumber") var bgNumber = 6
    @AppStorage("selectedHorseIndex") var selectedHorseIndex = 0
    @State private var boostOn = false
    @State private var startRun = false
    @State private var horseJump = false
    @State private var showPause = false
    @State private var youLose = false
    @State private var youWin = false
    @State private var raceBegun = false
    @State private var runAlreadyStart = false
    @State private var startText = "3"
    @State private var horseOneArray: [String] = ["horse11", "horse13", "horse12", "horse14"]
    @State private var startTextOpacity: CGFloat = 0
    @State private var startTextScale: CGFloat = 1
    @State private var runProgress: CGFloat = 1
    @State private var stamina: CGFloat = 0
    @State private var horseBoostOffset: CGFloat = 0
    @State private var horseVerticalOffset: CGFloat = 0
    @State private var trackOffset: CGFloat = 0
    @State private var trackTimer: Timer?
    @State private var objectsTimer: Timer?
    @State private var progressTimer: Timer?
    @State private var objectsOffset: CGFloat = 0
    @State private var startFinishOffset: CGFloat = 0
    @State private var barierXOffset: CGFloat = 0
    @State private var bariersArray = Arrays.batiersArray
    @State private var yourHorsesAray = UserDefaults.standard.array(forKey: "yourHosesAray") as? [[String]] ?? Arrays.yourHorsesArray
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            
            HStack() {
                Image("pauseButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .onTapGesture {
                        showPause.toggle()
                    }
                Spacer()
                VStack(alignment: .leading) {
                    ZStack {
                        Image("runProgressLineBack")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.5)
                        
                        Image("runProgressLineFront")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.5)
                            .offset(x: -screenWidth*0.5*runProgress)
                            .mask(
                                Image("runProgressLineFront")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.5)
                            )
                    }
                    .padding(.top, screenHeight*0.02)
                    HStack(spacing: screenWidth*0.02) {
                        ZStack {
                            Image("staminaLineBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.15)
                            Image("staminaLineFront")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.15)
                                .offset(x: -screenWidth*0.15*stamina)
                                .mask(
                                    Image("staminaLineFront")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.15)
                                    
                                )
                        }
                        Text("STAMINA")
                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.02))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                        
                    }
                }
                Spacer()
                Image("coinCountFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth*0.06)
                    .overlay(
                        Text("\(coinCount)")
                            .font(Font.custom("SigmarOne-Regular", size: screenWidth*0.03))
                            .foregroundColor(Color("shadowColor"))
                            .offset(x: screenWidth*0.02)
                    )
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(screenHeight*0.07)
            Image("raceTrack")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth*1, height: screenHeight*0.8)
                .offset(x: trackOffset*screenWidth, y: screenHeight*0.13)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.height < 0 && horseVerticalOffset > -screenHeight*0.2 {
                                withAnimation {
                                    horseVerticalOffset -= screenHeight*0.2
                                }
                            } else  if value.translation.height > 0 && horseVerticalOffset < screenHeight*0.2{
                                withAnimation {
                                    horseVerticalOffset += screenHeight*0.2
                                }
                            }
                        }
                )
            Image("startLine")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.6)
                .offset(x:-screenWidth*0.37 + startFinishOffset ,y: screenHeight*0.24)
            Image("finishLine")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.6)
                .offset(x:screenWidth*4.6 + startFinishOffset,y: screenHeight*0.24)
            ZStack {
                ForEach(0..<bariersArray.count, id: \.self) { item in
                    if bariersArray[item].haveBarier {
                        Image(bariersArray[item].name)
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.1)
                            .offset(x: barierXOffset, y: bariersArray[item].yOffset)
                    }
                }
            }
            Horse(horseArray: $horseOneArray, startRun: $startRun, runAlreadyStart: $runAlreadyStart, boostSpeed: boostOn, jump: horseJump)
                .offset(x: -screenWidth*0.4 + horseBoostOffset, y: screenHeight*0.2+horseVerticalOffset)
            HStack {
                Image("jumpButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        if stamina <= 0.8 {
                            horseJump = true
                            stamina += 0.2
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                horseJump = false
                            }
                        }
                    }
                Image("boostButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        boostOn.toggle()
                        if stamina <= 0.8 {
                            withAnimation(Animation.easeIn(duration: 3)) {
                                horseBoostOffset += screenWidth*0.1
                            }
                            stamina += 0.2
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding()
            .padding(.trailing, screenWidth*0.05)
            
            Text(startText)
                .font(Font.custom("Chewy-Regular", size: screenWidth*0.2))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 4)
                .shadow(color: .black, radius: 4)
                .opacity(startTextOpacity)
                .scaleEffect(x: startTextScale, y: startTextScale)
            
            if showPause {
                PauseView(pauseTapped: $showPause)
            }
            if youLose {
                TrainingLose(trainingLose: $youLose)
            }
            if youWin {
                TrainingWin(trainingWin: $youWin)
            }
        }
        .onChange(of: showPause) { _ in
            if showPause {
                trackOffset = 0.52
                raceBegun = false
                startRun = false
                runAlreadyStart = false
                stopobjectsMoving()
                stopTrackAnimation()
                stopFinishLineAnimation()
            } else {
                trackAnimation()
                startFinishLineAnimation()
                objectsMoving()
                raceBegun = true
                startRun = true
                runAlreadyStart = true
            }
        }
        
        .onChange(of: youWin) { _ in
            if !youWin {
                restartLevel()
            }
        }
        
        .onChange(of: youLose) { _ in
            if !youLose {
                restartLevel()
            }
        }
        
        .onChange(of: raceBegun) { _ in
            if raceBegun {
                trackAnimation()
            } else {
                stopFinishLineAnimation()
            }
        }
        .onChange(of: startFinishOffset) { _ in
            if startFinishOffset <= -screenWidth*5 {
                stopTrackAnimation()
                stopFinishLineAnimation()
            }
        }
        
        .onChange(of: barierXOffset) { _ in
            for i in 0..<bariersArray.count {
                if barierXOffset - horseBoostOffset <= -screenWidth*0.4 + 50 && !horseJump && barierXOffset - horseBoostOffset >= -screenWidth*0.4 - 50 && horseVerticalOffset + screenHeight*0.2 == bariersArray[i].yOffset && bariersArray[i].haveBarier{
                    SoundManager.instance.playSound(sound: "horseStop")
                    startRun = false
                    raceBegun = false
                    youLose = true
                }
            }
        }
        
        .onAppear {
            updateHorseView()
            createBariers()
            startRaceAnimation()
        }
        
    }
    
    func updateHorseView() {
        switch selectedHorseIndex {
        case 1:
            horseOneArray = ["horse21", "horse22", "horse23", "horse24"]
        case 2:
            horseOneArray = ["horse31", "horse32", "horse33", "horse34"]
        case 3:
            horseOneArray = ["horse41", "horse42", "horse43", "horse44"]
        default:
            horseOneArray = ["horse11", "horse12", "horse13", "horse14"]
        }
    }
    
    func restartLevel() {
        startRun = false
        raceBegun = false
        barierXOffset = screenWidth*0.6
        horseBoostOffset = 0
        horseVerticalOffset = 0
        barierXOffset = 0
        stamina = 0
        runProgress = 1
        startText = "3"
        startTextOpacity = 0
        startTextScale = 1
        trackOffset = 0
        startFinishOffset = 0
        createBariers()
        stopTrackAnimation()
        stopFinishLineAnimation()
        startRaceAnimation()
    }
    
    func startRaceAnimation() {
        startTextOpacity = 1
        SoundManager.instance.playSound(sound: "321sound")
        withAnimation(Animation.easeInOut(duration: 1)) {
            startTextScale = 1.5
            startTextOpacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            startTextOpacity = 1
            startTextScale = 1
            startText = "2"
            withAnimation(Animation.easeInOut(duration: 1)) {
                startTextScale = 1.5
                startTextOpacity = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            startTextOpacity = 1
            startTextScale = 1
            startText = "1"
            withAnimation(Animation.easeInOut(duration: 1)) {
                startTextScale = 1.5
                startTextOpacity = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            startTextOpacity = 1
            startTextScale = 1
            startText = "GO!!!!"
            withAnimation(Animation.easeInOut(duration: 1)) {
                startTextScale = 1.5
                startTextOpacity = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            SoundManager.instance.playSound(sound: "startShoot")
            raceBegun = true
            startRun = true
            runAlreadyStart = true
            stopobjectsMoving()
            objectsMoving()
            startFinishLineAnimation()
        }
    }
    
    func objectsMoving() {
        createBariers()
        objectsTimer = Timer.scheduledTimer(withTimeInterval: 7, repeats: true) { _ in
            if startRun && raceBegun {
                createBariers()
            }
        }
    }
    
    func stopobjectsMoving() {
        objectsTimer?.invalidate()
        objectsTimer = nil
    }
    
    
    func createBariers() {
        if !youWin && !youLose {
            barierXOffset = screenWidth*0.6
            var offsetArray = [screenHeight*0.2, 0, screenHeight*0.4]
            var bariersNameArray = ["barier1", "barier2", "barier1"]
            offsetArray.shuffle()
            bariersNameArray.shuffle()
            for i in 0..<bariersArray.count {
                bariersArray[i].haveBarier = Bool.random()
                bariersArray[i].name = bariersNameArray[i]
                bariersArray[i].yOffset = offsetArray[i]
            }
        }
    }
    
    func finishedAnimation() {
        withAnimation(Animation.easeInOut(duration: 2)) {
            horseBoostOffset = screenWidth
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            youWin = true
        }
    }
    
    func startFinishLineAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            if runProgress > 0 {
                runProgress -= 0.0105
            }
            startFinishOffset -= screenWidth*0.05
            barierXOffset -= screenWidth*0.05
        }
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            if startFinishOffset - horseBoostOffset > -screenWidth*4.9 {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    if runProgress > 0 {
                        runProgress -= 0.0105
                    }
                    startFinishOffset -= screenWidth*0.05
                    barierXOffset -= screenWidth*0.05
                }
            } else {
                stopTrackAnimation()
                stopFinishLineAnimation()
                finishedAnimation()
                
            }
        }
    }
    
    func stopFinishLineAnimation() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    func trackAnimation() {
        withAnimation(Animation.linear(duration: 1.2)) {
            trackOffset -= 0.2
        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            trackOffset = 0
        //        }
        trackTimer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { _ in
            if raceBegun {
                withAnimation(Animation.linear(duration: 1.2)) {
                    trackOffset -= 0.2
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.9) {
            trackOffset = 0.52
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 21.8) {
            trackOffset = 0.46
        }
    }
    
    func stopTrackAnimation() {
        trackTimer?.invalidate()
        trackTimer = nil
    }
}

#Preview {
    Training()
}
