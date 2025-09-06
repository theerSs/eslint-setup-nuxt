# 🛠️ ESLint Setup for Nuxt

This project includes a setup script to quickly configure **ESLint** with the [Antfu config](https://github.com/antfu/eslint-config), Nuxt integration, and editor settings for both **VS Code** and **WebStorm**.

---

## 🚀 How to Run the Script

### 1. Make the script executable

In your project root, run:

```sh
chmod +x setup-eslint.sh
```

### 2. Execute the script

Run the script with:

```sh
./setup-eslint.sh
```

Or, you can run it directly with zsh or bash:

```sh
zsh setup-eslint.sh
# or
bash setup-eslint.sh
```

---

## 📦 What the Script Does

* Installs **project dependencies** and ensures everything is up to date.
* Adds **ESLint with Nuxt integration** (`@nuxt/eslint`).
* Installs ESLint plugins and configs including:

  * `@antfu/eslint-config`
  * `eslint-plugin-format`
  * `eslint-plugin-vuejs-accessibility`
  * TypeScript support plugins
  * Code quality and stylistic plugins (`perfectionist`, `unicorn`, etc.)
* Creates a **VS Code settings file** (`.vscode/settings.json`) to:

  * Disable Prettier (ESLint handles formatting)
  * Auto-fix linting issues on save
  * Enable ESLint for multiple file types
* Generates or overwrites `eslint.config.mjs` with recommended rules and project-specific configurations.
* Injects the ESLint configuration into `nuxt.config.ts` properly with:

  ```ts
  eslint: {
    config: {
      standalone: false
    }
  }
  ```
* Prints **setup instructions for WebStorm** users.
* Optionally deletes the setup script after execution for a clean project.

---

## 📦 Packages Installed and What They Do

* **ESLint (`eslint`)**: Core linter for JavaScript/TypeScript projects. Checks code for errors, potential bugs, and style issues.
* **@nuxt/eslint**: Nuxt module to integrate ESLint seamlessly into a Nuxt project.
* **@antfu/eslint-config**: Opinionated ESLint configuration from Anthony Fu, preconfigured for modern projects, including Vue, TypeScript, and stylistic rules.
* **eslint-plugin-format**: Adds formatting-related ESLint rules, allowing ESLint to handle code style enforcement instead of Prettier.
* **eslint-plugin-vuejs-accessibility**: Ensures accessibility best practices in Vue templates.
* **@typescript-eslint/parser & @typescript-eslint/eslint-plugin**: Enable TypeScript linting support.
* **eslint-plugin-perfectionist**: Automatically sorts imports.
* **eslint-plugin-unicorn**: Enforces various code quality rules.
* **eslint-plugin-vue**: Vue-specific linting rules.

---

## 🖥️ Editor Setup

### VS Code

The script automatically generates `.vscode/settings.json` to:

* Disable Prettier and rely on ESLint for formatting.
* Auto-fix linting issues on save.
* Enable ESLint validation for multiple file types (JS, TS, Vue, Markdown, YAML, CSS, etc.).

### WebStorm

After running the script, configure ESLint manually:

1. Go to **Preferences → Languages & Frameworks → Code Quality Tools → ESLint**.
2. Select **Automatic ESLint configuration**.
3. Go to **Preferences → Tools → Actions on Save** and enable **Run eslint --fix**.
4. Disable Prettier if it is enabled.

---

## ℹ️ Additional Information

* To make the configuration fully effective, **start your Nuxt project once** so that Nuxt handles the ESLint module correctly.
* The script is idempotent: running it multiple times will not duplicate settings or ESLint blocks.

---

✅ After completing these steps, ESLint will be fully integrated into your Nuxt project with consistent formatting and linting across editors.
