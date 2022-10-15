//
//  ContentView.swift
//  ARVideoMaterials
//
//  Created by Zaid Neurothrone on 2022-10-15.
//

import AVFoundation
import SwiftUI
import RealityKit

struct ContentView : View {
  var body: some View {
    ARViewContainer().edgesIgnoringSafeArea(.all)
  }
}

struct ARViewContainer: UIViewRepresentable {
  
  func makeUIView(context: Context) -> ARView {
    let arView = ARView(frame: .zero)
    let anchor = AnchorEntity(plane: .horizontal)
    
    guard let url = Bundle.main.url(forResource: "video", withExtension: "mp4") else {
      fatalError("❌ -> Video file not found.")
    }
    
    let avPlayer = AVPlayer(url: url)
    let videoMaterial = VideoMaterial(avPlayer: avPlayer)
    videoMaterial.controller.audioInputMode = .spatial // if video has sound
  
    let modelEntity = ModelEntity(mesh: .generatePlane(width: 0.5, depth: 0.5), materials: [videoMaterial])
    
    anchor.addChild(modelEntity)
    arView.scene.addAnchor(anchor)
    
    avPlayer.play()
    
    return arView
  }
  
  func updateUIView(_ uiView: ARView, context: Context) {}
  
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
