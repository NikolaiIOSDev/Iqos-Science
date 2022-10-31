//
//  ViewController.swift
//  Iqos Science
//
//  Created by Николай Федоров on 29.10.2022.
//

import UIKit
import SceneKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        if let arImage = ARReferenceImage.referenceImages(inGroupNamed: "Iqos Science", bundle: Bundle.main) {
            configuration.detectionImages=arImage
            configuration.maximumNumberOfTrackedImages=2
            
        }


        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node=SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let videoNode = SKVideoNode(fileNamed: "part1.mp4")

           
                videoNode.play()

            
            let videoScene = SKScene(size: CGSize(width: 1080, height: 720))
            
            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
            
            videoNode.yScale = -1.0
                        
            videoScene.addChild(videoNode)
            
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = videoScene

            
            let nodeAnchor = SCNNode(geometry: plane)
            nodeAnchor.eulerAngles.x = -.pi / 2
            
            
            
            node.addChildNode(nodeAnchor)
            
            
        }
        return node

    }
    
    
}
