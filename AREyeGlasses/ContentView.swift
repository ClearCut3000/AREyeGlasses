//
//  ContentView.swift
//  AREyeGlasses
//
//  Created by Николай Никитин on 08.10.2021.
//

import ARKit
import SwiftUI
import RealityKit

var arView: ARView!
// Sets the interface created inside the glasses model structure
struct ContentView : View {
  @State var currentModel: Models = .glasses5
  var body: some View {
    ZStack(alignment: .bottom){
      ARViewContainer(currentModel: $currentModel).edgesIgnoringSafeArea(.all)
      ModelСhooser(currentModel: $currentModel)
    }
  }
}

struct ARViewContainer: UIViewRepresentable {
  @Binding var currentModel: Models

  func makeUIView(context: Context) -> ARView {
    arView = ARView(frame: .zero)
    return arView
    }

  func updateUIView(_ uiView: ARView, context: Context) {
    uiView.scene.anchors.removeAll()
    // Create Face Tracking Configuration
    let configuration = ARFaceTrackingConfiguration()
    configuration.isLightEstimationEnabled = true
    // Configuring session to remove previos tracking and anchoring data
    arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

    // Creating switch of anchors to change models in dependanse of users choiсe
    var anchor: RealityKit.HasAnchoring
    switch currentModel{
    case .glasses:
      anchor = try! ARGlasses.loadGlasses()
    case .glasses2:
      anchor = try! ARGlasses.loadGlasses2()
    case .glasses3:
      anchor = try! ARGlasses.loadGlasses3()
    case .glasses4:
      anchor = try! ARGlasses.loadGlasses4()
    case .glasses5:
      anchor = try! ARGlasses.loadGlasses5()
    }
    // Plase current anchor to scene
    uiView.scene.addAnchor(anchor)
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
