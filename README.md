# 🎨 Color Guessing Game (Roblox + Fusion)

A simple color guessing game built with [Fusion](https://elttob.uk/Fusion/) for Roblox. Players are shown a color and must guess its RGB values within a margin of error. Includes UI interactions, hint/skip buttons, sound effects, and reactive state management.

## 🧠 Gameplay

* A random color is generated each round.
* Players input R, G, and B values to match the color.
* Guesses within ±5 of the correct value are accepted.
* Correct guesses lock the channel and play a sound.
* Use **Hint** to auto-reveal one correct channel.
* Use **Skip** to move on to a new color.

## 🧰 Tech Stack

* **Roblox Lua (Luau)**
* **Fusion** for reactive UI and state
* Modular UI components
* Sound feedback
* Scoping via `Fusion:scoped()`

## 📁 Folder Structure

```
ReplicatedStorage/
├── Packages/
│   ├── Interface/ (Fusion)
│   └── Utility/ErrorHandler.lua
├── Assets/
│   ├── Components/ (UI Components)
│   └── Sounds/
```

## 🚀 Setup

1. Install [Fusion](https://github.com/Elttob/Fusion) into `ReplicatedStorage.Packages.Interface`.
2. Place required components and sound assets in the respective folders.
3. Add the script to a **LocalScript** under `StarterPlayerScripts`.

## 🧪 How to Play

1. Run the game.
2. Input RGB values into the boxes.
3. Use **Hint** if stuck.
4. Use **Skip** to try a new color.
