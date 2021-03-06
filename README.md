### Compiling
Compiling of eplkup is essentially done through the CMake tool on Windows, OSX and Linux.

#### Windows
For Windows, the library files for eplkup are stored in libraries/.

#### OSX
For OSX you need to do a system install of libiconv and libeb.

To install libiconv, run `brew install libiconv`.
To install libeb, run the following

```sh
git clone git@github.com:FooSoft/eb.git
cd eb/
./configure
make install
```

#### Linux
On Linux, the libraries are assumed to be installed on your local computer. To do this, run the following

```sh
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install zlib1g-dev
sudo apt-get install libeb16-dev
```

If you are running a distribution other than Ubuntu, please install the relevant packages for your system
