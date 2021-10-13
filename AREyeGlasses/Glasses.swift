//
//  Glasses.swift
//  AREyeGlasses
//
//  Created by Николай Никитин on 13.10.2021.
//

import SwiftUI
import RealityKit

// Create models enum to change glasses
enum Models: CaseIterable, Equatable {
  case glasses
  case glasses2
  case glasses3
  case glasses4
  case glasses5

// Create button next/prev functions to change glasses
  private func nextCase(_ cases: [Self]) -> Self? {
    if self == cases.last {
      return cases.first
    } else {
      return cases
        .drop(while: ){$0 != self}
        .dropFirst().first
    }
  }
  func next() -> Self{
    nextCase(Self.allCases) ?? .glasses4
  }

  func previos() -> Self{
    nextCase(Self.allCases.reversed()) ?? .glasses
  }
}
// Structure of interfase
  struct ModelСhooser: View {

    @Binding var currentModel: Models

    // Function to take salfie by tapping on circle button
    func selfie() {
      arView.snapshot(saveToHDR: false) { (image) in
          let compressedImage = UIImage(data: (image?.pngData())!)
          UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil) }
    }
// User interface with 3 buttons
    var body: some View {
      HStack{
        Button(action: {
          currentModel = currentModel.previos()
        }) {
          Image(systemName: "arrowtriangle.left.fill")
            .resizable()
            .frame(width: 44, height: 44)
        }
        Spacer()
        Button (action: {
        selfie()
        }) {
          Circle().stroke(lineWidth: 12.0)
        }
        Spacer()
        Button(action: {
          currentModel = currentModel.next()
        }) {
          Image(systemName: "arrowtriangle.right.fill")
            .resizable()
            .frame(width: 44, height: 44)
        }
      }
      .frame(height: 100)
      .foregroundColor(.primary)
      .padding(.horizontal)
        }

      }

