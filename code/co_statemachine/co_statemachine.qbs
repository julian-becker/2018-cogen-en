import qbs

Project {
    minimumQbsVersion: "1.7.1"

    Product {
        name: "cpp17"

        Export {
            Depends { name: "cpp" }
            cpp.cxxLanguageVersion: "c++17"

            Properties {
                condition: qbs.toolchain.contains('msvc')
                cpp.cxxFlags: ["/await", "/permissive-", "/Zc:__cplusplus", "/diagnostics:caret"]
            }
            Properties {
                condition: qbs.toolchain.contains('clang')
                cpp.cxxFlags: ["-fcoroutines-ts"]
                cpp.cxxStandardLibrary: "libc++"
                cpp.staticLibraries: ["c++", "c++abi"]
            }
        }
    }

    StaticLibrary {
        name: "statemachine"
        Depends { name: "cpp17" }
        files: [
            "StateMachine.cpp",
            "StateMachine.h",
        ]

        Export { Depends { name: "cpp17" } }
    }
    Application {
        name: "statemachine_test"
        consoleApplication: true
        Depends { name: "statemachine" }
        files: [
            "Elevator.cpp",
            "Elevator.h",
            "main.cpp",
        ]
    }
}
