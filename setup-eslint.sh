#!/bin/zsh

# Exit on error
set -e

echo "🔧 Setting up ESLint for Nuxt project with Vue 3, TypeScript, accessibility, and formatting best practices..."

# Install Nuxt ESLint integration
echo "📦 Installing @nuxt/eslint..."
npx nuxi@latest module add eslint

# Install all required ESLint dependencies
echo "📦 Installing ESLint plugins and configs..."
npm install -D \
  @antfu/eslint-config \
  eslint-plugin-format \
  eslint-plugin-vuejs-accessibility \
  @typescript-eslint/eslint-plugin \
  @typescript-eslint/parser \
  eslint-plugin-vue@latest \
  eslint-plugin-perfectionist \
  eslint-plugin-unicorn

# Setup VSCode settings
echo "📝 Creating .vscode/settings.json..."
mkdir -p .vscode
cat > .vscode/settings.json <<'EOF'
{
  "prettier.enable": false,
  "editor.formatOnSave": false,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "always",
    "source.organizeImports": false
  },
  "eslint.rules.customizations": [
    { "rule": "style/*", "severity": "off", "fixable": true },
    { "rule": "format/*", "severity": "off", "fixable": true }
  ],
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "html",
    "markdown",
    "json",
    "jsonc",
    "yaml",
    "toml",
    "xml",
    "gql",
    "graphql",
    "astro",
    "svelte",
    "css",
    "less",
    "scss",
    "pcss",
    "postcss"
  ]
}
EOF

# Overwrite eslint.config.mjs
echo "📝 Updating eslint.config.mjs..."
cat > eslint.config.mjs <<'EOF'
import antfu from "@antfu/eslint-config";
import withNuxt from "./.nuxt/eslint.config.mjs";
import vueAccessibility from "eslint-plugin-vuejs-accessibility";

export default withNuxt(
  antfu(
    {
      type: "app",
      vue: true,
      typescript: true,
      formatters: true,
      stylistic: {
        indent: 2,
        semi: true,
        quotes: "double",
      },
    },
    {
      plugins: {
        "vuejs-accessibility": vueAccessibility,
      },
      rules: {
        // Vue rules
        "vue/max-attributes-per-line": ["error", { singleline: 2, multiline: 1 }],
        "vue/component-name-in-template-casing": ["error", "PascalCase"],
        "vue/html-indent": ["error", 2],

        // TypeScript
        "@typescript-eslint/no-redeclare": "off",
        "@typescript-eslint/consistent-type-definitions": ["error", "type"],

        // Node / Nuxt
        "no-console": ["warn"],
        "node/no-process-env": ["error"],

        // Code quality
        "perfectionist/sort-imports": ["error", { tsconfigRootDir: "." }],
        "unicorn/filename-case": ["error", { case: "pascalCase", ignore: ["README.md"] }]
      }
    }
  )
);
EOF

echo "✅ ESLint setup complete with full Vue/Nuxt best practices and no plugin conflicts!"

# Ask before deleting script
SCRIPT_NAME="setup.sh"
if [[ -f "$SCRIPT_NAME" ]]; then
  echo -n "🗑️  Do you want to remove $SCRIPT_NAME? [y/N]: "
  read -r confirm
  if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    rm -- "$SCRIPT_NAME"
    echo "✅ $SCRIPT_NAME has been removed."
  else
    echo "ℹ️  Keeping $SCRIPT_NAME."
  fi
fi

# WebStorm instructions
echo "ℹ️  For WebStorm users:
1. Preferences → Languages & Frameworks → Code Quality Tools → ESLint → 'Automatic ESLint configuration'.
2. Preferences → Tools → Actions on Save → Run eslint --fix.
3. Disable Prettier if enabled.
"
