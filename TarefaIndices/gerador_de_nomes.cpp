#include <fstream>
#include <faker-cxx/Person.h>

int main() {
    std::ofstream file("nomes.csv");

    for (int i = 1; i <= 250000000; i++) {
        file << i << "," << faker::person::fullName() << "\n";
    }

    file.close();
    return 0;
}