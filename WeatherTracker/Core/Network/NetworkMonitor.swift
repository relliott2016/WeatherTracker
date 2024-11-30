//
//  NetworkMonitor.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Network

actor NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private var isReady = false

    private init() {
        monitor.pathUpdateHandler = { [weak self] _ in
            Task { @MainActor in
                await self?.setReady()
            }
        }
        monitor.start(queue: .main)
    }

    private func setReady() {
        isReady = true
    }

    func checkConnection() -> Bool {
        guard isReady else { return true }
        return monitor.currentPath.status == .satisfied
    }

    deinit {
        monitor.cancel()
    }
}
