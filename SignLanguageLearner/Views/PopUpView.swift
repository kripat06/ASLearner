//
//  PopUpView.swift
//  ASLearner
//
//  Created by admin on 10/25/22.
//

import SwiftUI

struct PopUpView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.red)
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView()
    }
}
