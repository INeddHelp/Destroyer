#include <iostream>
#include <cstdlib>
#include <string>

using namespace std;

int main()
{
    string ipAddress;
    string command;
    
    for (int i = 1; i <= 254; i++) {
        ipAddress = "192.168.1." + to_string(i);
        cout << "Scanning " << ipAddress << endl;
        command = "ping -c 1 " + ipAddress;
        
        if (system(command.c_str()) == 0) {
            cout << "Shutting down " << ipAddress << endl;
            command = "shutdown /s /t 0 /m \\\\" + ipAddress;
            system(command.c_str());
        }
    }
    
    return 0;
}

