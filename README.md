<p align="center">
  <img src="https://img.shields.io/badge/C%23-5.0-green" alt="C# 5.0" />
  <img src="https://img.shields.io/badge/ESAPI-16.1+-blue" alt="ESAPI" />
  <img src="https://img.shields.io/badge/License-MIT-lightgrey" alt="License" />
  <img src="https://img.shields.io/badge/platform-Windows-0078D6" alt="Windows" />
</p>

<h1 align="center">⚡ ESAPI Offline Compiler</h1>
<p align="center"><b>Compile Varian Eclipse scripts without Visual Studio.</b><br/>Just a .bat file, csc.exe, and your brain.</p>

---

## 🤔 Why does this exist?

Most Medical Physicists assume they need a Visual Studio license to script in Eclipse. **You don't.**

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

## ✅ Requirements

- Windows 10/11, 64-bit (csc.exe ships with the OS)
- .NET Framework 4.x (64-bit) — already installed if Eclipse/ARIA run on the machine
- Varian Eclipse / ARIA with ESAPI 16.1+ installed locally

No admin rights needed beyond the normal Eclipse script registration step.

---

## 📦 How to use it (1 minute setup)

```bash
# 1. Clone this repo
git clone https://github.com/lucasbritocFis/ESAPI-Offline-Compiler.git
cd ESAPI-Offline-Compiler

# 2. Run the environment checker (finds your ESAPI path automatically)
scripts\check_env.bat

# 3. Paste the line it prints into ESAPI_DIR inside scripts\build.bat

# 4a. Try the bundled example first:
scripts\build.bat

# 4b. Then compile your own script:
scripts\build.bat YourScript.cs
```

`build.bat` with no arguments compiles the bundled `examples\HelloEsapi.cs`. Pass your own file as the first argument to compile that instead — the output `.dll` is named after your script.

---

## 📁 What's inside

```
ESAPI-Offline-Compiler/
├── examples/
│   └── HelloEsapi.cs       # working sample script, compiles out of the box
├── scripts/
│   ├── check_env.bat       # auto-detects your ESAPI install path
│   └── build.bat           # compiles a .cs file into an ESAPI .dll
└── LICENSE
```

---

## 🖥️ Example

The bundled `HelloEsapi.cs` opens the active patient's structure set and shows a message box listing every non-empty structure — a quick way to confirm your compile + registration pipeline works end-to-end before writing real scripts.

```
Compiling examples\HelloEsapi.cs to HelloEsapi.esapi.dll ...

SUCCESS: HelloEsapi.esapi.dll generated successfully.
You can now register it in Eclipse (Scripts > Administer Scripts).
```

---

## ⭐ Found this useful?

If this saved you from installing Visual Studio just to compile one script, consider starring the repo — it helps other Medical Physicists and ESAPI developers find it.

## License

MIT — see [LICENSE](LICENSE).

## Author

**Lucas Brito, PhD** — Clinical Medical Physicist and Software Developer. [GitHub](https://github.com/lucasbritocFis) · Rio de Janeiro, Brazil
