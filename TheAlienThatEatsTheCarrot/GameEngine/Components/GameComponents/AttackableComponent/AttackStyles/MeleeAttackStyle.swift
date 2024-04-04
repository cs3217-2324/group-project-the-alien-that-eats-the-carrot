//
//  MeleeAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class MeleeAttackStyle: AttackStyle {
    static let DEFAULT_COOLDOWN_DURATION = 0.3
    let acceptableAttackDirections: [Direction]
    var knockbackForce: CGFloat
    var isCoolingDown: Bool = false
    var coolDownDuration: CGFloat
    private var meleeFinishCooldownObserver: NSObjectProtocol?

    init(acceptableAttackDirections: [Direction] = [.left, .right],
         knockbackForce: CGFloat = 1000.0,
         cooldownDuration: CGFloat = MeleeAttackStyle.DEFAULT_COOLDOWN_DURATION) {
        self.acceptableAttackDirections = acceptableAttackDirections
        self.knockbackForce = knockbackForce
        self.coolDownDuration = cooldownDuration
        subscribeToEvents()
    }

    deinit {
        if let observer = meleeFinishCooldownObserver {
            EventManager.shared.unsubscribe(from: observer)
        }
    }

    func attack(damage: CGFloat, attacker: Entity, attackee: Entity,
                targetables: [Component.Type], delegate: AttackableDelegate) {
        if attacker != attackee
            && canAttack(attackee, with: targetables, using: delegate)
            && !isCoolingDown {
            
            for direction in acceptableAttackDirections {
                if isAttacker(attacker, attacking: attackee, from: direction, delegate: delegate) {
                    dealDamage(damage, to: attackee, delegate: delegate)
                    applyKnockback(from: attacker, to: attackee, direction: direction, delegate: delegate)
                    setMeleeCooldown(for: attacker, delegate: delegate)
                    break
                }
            }
        }
    }

    private func isAttacker(_ attacker: Entity, attacking attackee: Entity,
                            from direction: Direction, delegate: AttackableDelegate) -> Bool {
        guard let attackerPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attacker),
              let attackeePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attackee) else {
            return false
        }
        if attackerPhysicsComponent.physicsBody.isCollidingWith(attackeePhysicsComponent.physicsBody,
                                                                on: direction) {
            return true
        }
        return false
    }

    private func applyKnockback(from attacker: Entity, to attackee: Entity,
                                direction: Direction, delegate: AttackableDelegate) {
        guard let attackeePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attackee) else {
            return
        }
        let forceDirection = CGVector(dx: cos(direction.vectorAngle), dy: sin(direction.vectorAngle))
        let force = forceDirection * knockbackForce
        attackeePhysicsComponent.physicsBody.applyForce(force)
    }

    private func setMeleeCooldown(for entity: Entity, delegate: AttackableDelegate) {
        self.isCoolingDown = true
        let meleeFinishCooldownEvent = MeleeFinishCooldownEvent(meleeAttackStyle: self)
        let timerComponent = TimerComponent(entity: entity, duration: coolDownDuration, event: meleeFinishCooldownEvent)
        delegate.addComponent(timerComponent, to: entity)
    }

    private func subscribeToEvents() {
        meleeFinishCooldownObserver = EventManager.shared.subscribe(to: MeleeFinishCooldownEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        guard let meleeFinishCooldownEvent = event as? MeleeFinishCooldownEvent else {
            return
        }
        meleeFinishCooldownEvent.meleeAttackStyle.isCoolingDown = false
    }

}

extension Direction {
    var vectorAngle: CGFloat {
        switch self {
        case .left: return 0
        case .right: return CGFloat.pi
        default: return 0
        }
    }
}
