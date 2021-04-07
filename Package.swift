// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftVulkan",
    products: [
        .library(name: "GLFW", targets: ["GLFW"]),
        .library(name: "Vulkan", targets: ["Vulkan"]),
        .executable(name: "SwiftVulkan", targets: ["SwiftVulkan"])
    ],
    targets: [
        .systemLibrary(name: "CGLFW", pkgConfig: "glfw3"),
        .systemLibrary(name: "CVulkan", pkgConfig: "vulkan"),
        .target(name: "GLFW", dependencies: ["CGLFW"]),
        .target(name: "Vulkan", dependencies: ["CVulkan"]),
        .target(name: "SwiftVulkan", dependencies: ["GLFW", "Vulkan"]),
    ]
)
