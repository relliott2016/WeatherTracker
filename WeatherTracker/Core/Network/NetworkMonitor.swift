//
//  NetworkMonitor.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Network

actor NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor
    private var isReady = false
    private let monitorQueue = DispatchQueue(label: "NetworkMonitor", qos: .utility)

    private init() {
        self.monitor = NWPathMonitor()
        // Configure monitor before starting it
        monitor.pathUpdateHandler = { [weak self] _ in
            Task {
                await self?.setReady()
            }
        }
        // Start monitor outside of initializer
        Task {
            self.monitor.start(queue: monitorQueue)
        }
    }

    private func setReady() {
        isReady = true
    }

    func checkConnection() -> Bool {
        // Only check connection if monitor is ready
        guard isReady else {
            return true // Assume connected until we know otherwise
        }
        return monitor.currentPath.status == .satisfied
    }

    deinit {
        monitor.cancel()
    }
}
