import Foundation

class MainScene: CCNode {

    
    func startGame() {
        let gameScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().presentScene(gameScene)
    }
}
