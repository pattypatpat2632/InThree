//
//  NotificationExension.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/16/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let closeLoginVC = Notification.Name("close-login-view-controller")
    static let closeDashboardVC = Notification.Name("close-dashboard-view-controller")
    static let availablePeersUpdated = Notification.Name("available-peers-updated")
    static let playbackStarted = Notification.Name("playback-started")
    static let playbackStopped = Notification.Name("playback-stopped")
}
