## Installation (Linux)

The code is fully able to run on linux, however windows is still the recommended platform. The libraries we use for external functions (RUSTG and MILLA) require some extra dependencies.

For debian, please download the latest RUSTG release from [https://github.com/ParadiseSS13/rust-g](https://github.com/ParadiseSS13/rust-g), run the following: `apt-get install libssl-dev:i386 pkg-config:i386 zlib1g-dev:i386`.

After installing these packages, RUSTG should be able to build and function as intended. Build instructions are on the RUSTG page. We assume that if you are hosting on linux, you know what you are doing.

Once you've built RUSTG, you can build MILLA similarly, just go into the `milla/` directory and run `cargo build --release --target=i686-unknown-linux-gnu`.
