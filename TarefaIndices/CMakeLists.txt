cmake_minimum_required(VERSION 3.21)
project(gerador_nomes)

# Configurar o vcpkg como toolchain
set(CMAKE_TOOLCHAIN_FILE "C:/Users/eduar/Desktop/Estudos/GitHub/vcpkg/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")

# Definir o triplet se necessário (ajuste conforme seu sistema)
set(VCPKG_TARGET_TRIPLET "x64-windows-static-md" CACHE STRING "")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Adicionar diretório do vcpkg ao CMAKE_PREFIX_PATH
list(APPEND CMAKE_PREFIX_PATH "C:/Users/eduar/Desktop/Estudos/GitHub/vcpkg/installed/x64-windows-static-md/share")

# Encontrar o faker-cxx
find_package(faker-cxx CONFIG REQUIRED)

# Criar executável
add_executable(gerador_nomes gerador_de_nomes.cpp)

# Linkar contra faker-cxx
target_link_libraries(gerador_nomes PRIVATE faker-cxx::faker-cxx)
