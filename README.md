# Solana Pumpfun Sniper Bot

This bot fetches new pumpfun pools and buys as soon as possible. If the RPC or node is good, it commonly buys tokens before the token is available on the Pumpfun UI -- letting you buy ahead of others. It's the free, basic version; an advanced version is also available. The codebase is written in Rust to boost speed and performance.

## Features

### Speed and Efficiency
- **Lightning-Quick Transactions**: Leveraging Rust's exceptional performance, the bot allows you to snipe new tokens almost instantly. Say goodbye to delays and seize opportunities as they arise!

### Safety First
- **Robust Security**: Rust's safety guarantees minimize bugs and vulnerabilities, ensuring your trading activities are secure. Trade with confidence and peace of mind.

### Multiple gRPC Connections
- **Stay Updated**: Effortlessly connect to top Solana data providers like **Helius** and **Yellowstone** through multiple gRPC connections. Get real-time updates and make informed trading decisions.

### User-Friendly Interface
- **Intuitive Design**: The sniper bot features a clean and accessible interface, making it easy for users of all experience levels to navigate. Start trading in no time!

## Advanced Features
- **jito-confirm**: Engage in low-latency transactions on platforms like Raydium and Pumpfun.
- **jito-bundle**: Bundle buy/sell actions with up to **20 wallets** in Raydium/Pumpfun, enhancing your trading strategy and flexibility.

---

## Directory Structure

```
src/
|-- core/
|   |-- token.rs        # Token definitions and handling
|   |-- tx.rs           # Transaction handling
|   `-- mod.rs          # mod file
|
|-- engine/
|   |-- swap.rs         # Token swap (buy/sell) functionalities in various DEXes
|   |-- monitor/        # New token monitoring (and tx parsing) via geyser / RPC
|   |   |-- helius.rs       # Helius gRPC for tx listen and parse
|   |   `-- yellowstone.rs  # Yellowstone gRPC for tx listen and parse
|   `-- mod.rs          # mod file
|
|-- dex/
|   |-- pumpfun.rs      # Pumpfun
|   `-- mod.rs          # mod file
|
|-- services/
|   |-- jito.rs         # Jito - ultra-fast transaction confirmation
|   |-- nozomi.rs       # Nozomi - ultra-fast transaction confirmation
|   |-- zeroslot.rs     # ZeroSlot - ultra-fast transaction confirmation
|   |-- nextblock.rs    # NextBlock - ultra-fast transaction confirmation
|   `-- mod.rs          # mod file
|
|-- common/
|   |-- logger.rs       # Clean, convenient logging
|   |-- utils.rs        # Shared utility functions
|   `-- mod.rs          # mod file
|
|-- lib.rs
`-- main.rs
```

---

## Setup

1. Install [Rust](https://rustup.rs/) (stable).
2. Copy `.env.example` to `.env` and fill in your values:
   ```plaintext
   PRIVATE_KEY= # your wallet priv_key (base58)
   RPC_HTTPS= # Helius / premium HTTPS RPC
   RPC_WSS= # matching WebSocket RPC
   SLIPPAGE=10
   JITO_BLOCK_ENGINE_URL=https://ny.mainnet.block-engine.jito.wtf
   JITO_TIP_VALUE=0.0001
   TOKEN_AMOUNT=0.01 # SOL amount to buy per new token
   UNIT_PRICE=20000
   UNIT_LIMIT=300000
   ```
3. Add wallet/mint addresses to block (one per line) in `trial/blacklist.txt`.
4. On Windows (source build only), install [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) with the **Desktop development with C++** workload (needed for `link.exe`).
5. Build and run from source (all platforms):
   ```bash
   cargo build --release
   cargo run --release
   ```

## Running the Prebuilt Trial Binaries

Prebuilt binaries for all supported platforms live in the `trial/` folder:

```
trial/
|-- pumpfun-sniper.exe              # Windows x86_64
|-- pumpfun-sniper-linux-x86_64     # Linux x86_64
|-- pumpfun-sniper-linux-aarch64    # Linux ARM64
`-- pumpfun-sniper-mac-darwin       # macOS (Intel / Apple Silicon)
```

Configure `.env` (or `trial/config.env`) first, then launch with the helper script for your OS.

### Windows

Double-click `start_trial_windows.bat`, or from Command Prompt / PowerShell:

```bat
start_trial_windows.bat
```

This runs `trial\pumpfun-sniper.exe`.

### Linux

```bash
chmod +x start_trial_mac_linux.sh
./start_trial_mac_linux.sh
```

The script picks `pumpfun-sniper-linux-x86_64` or `pumpfun-sniper-linux-aarch64` based on your CPU.

### macOS

```bash
chmod +x start_trial_mac_linux.sh
./start_trial_mac_linux.sh
```

The script runs `trial/pumpfun-sniper-mac-darwin` (Intel and Apple Silicon).

If macOS blocks the binary ("unidentified developer"), allow it once via **System Settings -> Privacy & Security**, or:

```bash
xattr -d com.apple.quarantine trial/pumpfun-sniper-mac-darwin
```

## Test Result (Same Block)
- Detect: https://solscan.io/tx/5o7ajnZ9CRf7FBYEvydu8vapJJDWtKCvRFiTUBmbeu2FmmDhAQQy3c9YFFhpTucrr2SZcrf2aUsDanEVjYgwN9kBc
- Bought: https://solscan.io/tx/3vgim3MwJsdtahXqfWmDrzTAWpVQ8EUTed2cjzHuqxSfUpfp72mgxZhiVosWaCUHdqJTDHpQaYh5xN7rkHGmzqWv
- Dexscreener: https://dexscreener.com/solana/A1zZXCq2DmqwVD4fLDzmgQ3ceY6LQnMBVokejqnHpump

## Pricing

| Package | Price | Includes |
| --- | --- | --- |
| **Pro version** | **1 SOL** | Prebuilt binary with advanced features (jito-confirm, jito-bundle, multi-wallet support) |
| **Full source code** | **5 SOL** | Complete Rust source, all modules, and the ability to customize and rebuild |

This repository is the free basic / trial version. For Pro or full source access, contact us on Telegram.

## Contact

Telegram: [https://t.me/SolTraderX](https://t.me/SolTraderX)
