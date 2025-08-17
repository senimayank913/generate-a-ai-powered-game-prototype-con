import GameplayKit
import UIKit

class AIController {
    let gameModel: GameModel
    let aiAgent: GKAgent

    init(gameModel: GameModel) {
        self.gameModel = gameModel
        self.aiAgent = GKAgent()
        self.aiAgent.delegate = self
        self.aiAgent.behavior = GKBehavior(goal: GKGoal(toReachTarget: gameModel.player.position), weight: 1.0)
    }

    func update(deltaTime: TimeInterval) {
        aiAgent.update(deltaTime: deltaTime)
    }
}

extension AIController: GKAgentDelegate {
    func agentWillUpdate(_ agent: GKAgent) {
        // Update AI decision-making here
    }

    func agentDidUpdate(_ agent: GKAgent) {
        // Update game state based on AI decisions
        gameModel.aiPosition = agent.position
    }
}

class GameModel {
    let player: Player
    var aiPosition: SIMD2<Float> = .zero

    init(player: Player) {
        self.player = player
    }
}

class Player {
    let position: SIMD2<Float> = SIMD2<Float>(x: 100, y: 100)
}

let gameModel = GameModel(player: Player())
let aiController = AIController(gameModel: gameModel)

aiController.update(deltaTime: 1.0)

print("AI Position: \(aiController.gameModel.aiPosition)")