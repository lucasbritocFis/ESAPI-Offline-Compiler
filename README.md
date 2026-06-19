# ESAPI-Offline-Compiler
Compile Varian Eclipse scripts without Visual Studio. Just a .bat file and csc.exe.

<p align="center">
  <img src="https://img.shields.io/badge/C%23-5.0-green" alt="C# 5.0" />
  <img src="https://img.shields.io/badge/ESAPI-16.1+-blue" alt="ESAPI" />
  <img src="https://img.shields.io/badge/License-MIT-lightgrey" alt="License" />
</p>

<h1 align="center">⚡ ESAPI Offline Compiler</h1>
<p align="center"><b>Compile Varian Eclipse scripts without Visual Studio.</b><br/>Just a .bat file, csc.exe, and your brain.</p>

---

## 🤔 Why does this exist?

Most Medical Physicists assume they need a $10,000 Visual Studio license to script in Eclipse. **You don't.**

Windows ships with a built-in C# compiler (`csc.exe`). This repo is a ready-to-use, standalone template that compiles any `.cs` file into an ESAPI `.dll` in **under 2 seconds** – no IDE required.

---

## 🧠 The "Gotchas" this solves

The official Varian docs don't tell you these 3 traps:

| Trap | Solution |
| :--- | :--- |
| **Assembly Hash Cache** | Change 1 line? The hash changes. You MUST bump `[assembly: AssemblyVersion]` and re-register. The script handles it. |
| **x64 Architecture** | Eclipse is 64-bit. Compiling in `x86` kills the script silently. The build file forces `/platform:x64`. |
| **`AddSetupBeam` Reflection Block** | Trying to call it via reflection throws a compile-time error. This template keeps compile-time references explicit. |

---

## 📦 How to use it (1 minute setup)

```bash
# 1. Clone this repo
git clone https://github.com/SEU_USER/ESAPI-Offline-Compiler.git

# 2. Run the environment checker (finds your ESAPI path automatically)
scripts\check_env.bat

# 3. Update the ESAPI_DIR path in scripts\build.bat

# 4. Drop your .cs file in the root, and run:
scripts\build.bat
