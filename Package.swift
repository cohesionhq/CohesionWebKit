// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "CohesionWebUISwift",
    platforms: [.macOS("27.0"), .iOS("27.0")],
    products: [
        .library(name: "CohesionWebUISwift", targets: ["CohesionWebUISwift"]),
    ],
    targets: [
        .target(
            name: "CohesionWebUISwift",
            swiftSettings: [
                // As the apps build: main actor by default, approachable concurrency.
                .defaultIsolation(MainActor.self),
                .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
                .enableUpcomingFeature("InferIsolatedConformances"),
            ]
        ),
    ]
)
