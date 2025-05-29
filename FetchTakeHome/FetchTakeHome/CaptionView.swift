//
//  CaptionView.swift
//  FetchTakeHome
//
//  Created by Mariana Montoya on 5/26/25.
//

import SwiftUI

struct CaptionView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.custom("AmericanTypewriter", size: 50))
            .padding()
            .foregroundColor(.white)
            .padding()
    }
}

#Preview {
    CaptionView(text: "Recipe Caption Title").preferredColorScheme(.dark)
}
