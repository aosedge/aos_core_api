from conan import ConanFile


class AosCoreAPI(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeToolchain", "CMakeDeps"

    def requirements(self):
        self.requires("grpc/1.54.3")

    def build_requirements(self):
        self.tool_requires("grpc/1.54.3")
        self.tool_requires("protobuf/3.21.12")
