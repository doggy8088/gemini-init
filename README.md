# Gemini CLI 設定精靈 🧙‍♂️✨

一個互動式的命令列工具，用於快速建立和設定 Google Gemini 的專案配置檔案。

## 📋 簡介

這個設定精靈可以協助您快速建立 `.gemini/settings.json` 配置檔案，包含以下功能：

- 🔧 **互動式設定**：透過友善的介面引導您完成設定
- 📝 **上下文管理**：設定要包含在 context 中的檔案
- 🖋️ **編輯器選擇**：支援多種主流程式碼編輯器
- 🎨 **主題配置**：提供豐富的顯示主題選項
- 🔌 **MCP 伺服器整合**：支援 GitHub 和 Context7 MCP 伺服器

## 🛠️ 系統需求

在執行此腳本之前，請確保系統已安裝以下相依套件：

- **bash**：執行腳本的 shell 環境
- **jq**：用於處理 JSON 資料的命令列工具
- **sponge**：來自 `moreutils` 套件，用於原地更新檔案
- **Docker**（可選）：如果要使用 GitHub MCP 伺服器
- **Node.js/npm**（可選）：如果要使用 Context7 MCP 伺服器

### 安裝相依套件

**Ubuntu/Debian:**

```bash
sudo apt update
sudo apt install -y jq moreutils
```

**macOS (使用 Homebrew):**

```bash
brew install jq moreutils
```

**Windows (使用 WSL):**

```bash
sudo apt update
sudo apt install -y jq moreutils
```

## 🚀 使用方法

1. **安裝腳本並賦予執行權限**：

    全域安裝

    ```bash
    sudo curl -sSL https://github.com/doggy8088/gemini-init/raw/main/gemini-init -o /usr/local/bin/gemini-init && sudo chmod +x /usr/local/bin/gemini-init
    ```

    本地安裝

    ```bash
    mkdir -p ~/.local/bin && curl -sSL https://github.com/doggy8088/gemini-init/raw/main/gemini-init -o ~/.local/bin/gemini-init && chmod +x ~/.local/bin/gemini-init
    ```

    💡 請確保 `~/.local/bin` 在您的 PATH 環境變數中

2. **執行設定精靈**：

    ```bash
    gemini-init
    ```

3. **依照提示進行設定**：腳本會引導您完成所有配置步驟。

## 📋 設定選項詳解

### 1. Context 檔案名稱

- **功能**：指定要包含在 Gemini context 中的檔案
- **預設值**：`GEMINI.md,AGENTS.md,CLAUDE.md,.github/copilot-instructions.md`
- **格式**：使用逗號分隔多個檔案名稱

### 2. 偏好編輯器

支援的編輯器選項：

1. Zed
2. **VS Code**（預設）
3. VSCodium
4. Windsurf
5. Cursor
6. Vim
7. Neovim

### 3. 顯示主題

可選擇的主題包括：

1. ANSI Light
2. ANSI
3. Atom One
4. Ayu Light
5. Ayu
6. Default Light
7. Default
8. Dracula
9. **GitHub**（預設）
10. GitHub Light
11. Google Code
12. No Color
13. Shades Of Purple

### 4. MCP 伺服器設定

#### GitHub MCP 伺服器

- **功能**：提供 GitHub 整合功能
- **需求**：Docker 和 `GITHUB_PERSONAL_ACCESS_TOKEN` 環境變數
- **設定內容**：

  ```json
  {
    "command": "docker",
    "args": ["run", "-i", "--rm", "-e", "GITHUB_PERSONAL_ACCESS_TOKEN", "ghcr.io/github/github-mcp-server"],
    "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": "$GITHUB_PERSONAL_ACCESS_TOKEN"},
    "trust": true
  }
  ```

#### Context7 MCP 伺服器

- **功能**：提供增強的 context 管理功能
- **需求**：Node.js 和 npm
- **設定內容**：

  ```json
  {
    "type": "stdio",
    "command": "npx",
    "args": ["-y", "@upstash/context7-mcp"],
    "trust": true
  }
  ```

## 📁 輸出結果

執行完成後，會在您的專案根目錄建立以下結構：

```text
.gemini/
└── settings.json
```

範例 `settings.json` 檔案內容：

```json
{
  "contextFileName": [
    ".github/copilot-instructions.md",
    "GEMINI.md"
  ],
  "preferredEditor": "vscode",
  "theme": "GitHub",
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "$GITHUB_PERSONAL_ACCESS_TOKEN"
      },
      "trust": true
    },
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@upstash/context7-mcp"
      ],
      "trust": true
    }
  }
}
```

## ❓ 常見問題

**Q: 出現 "jq: command not found" 錯誤**
A: 請先安裝 jq 套件：`sudo apt install jq`（Linux）或 `brew install jq`（macOS）

**Q: 出現 "sponge: command not found" 錯誤**
A: 請安裝 moreutils 套件：`sudo apt install moreutils`

**Q: GitHub MCP 伺服器無法啟動**
A: 請確認已安裝 Docker 並設定 `GITHUB_PERSONAL_ACCESS_TOKEN` 環境變數

**Q: 如何重新設定？**
A: 只需再次執行 `./gemini-init` 即可覆寫現有設定

## 📄 授權條款

此專案採用 MIT 授權條款 - 詳情請參閱 [LICENSE](LICENSE) 檔案

## 🤝 貢獻指南

歡迎提交 Issue 和 Pull Request！

1. Fork 此專案
2. 建立功能分支：`git checkout -b feature/amazing-feature`
3. 提交變更：`git commit -m 'Add some amazing feature'`
4. 推送到分支：`git push origin feature/amazing-feature`
5. 開啟 Pull Request

---

**享受您的 Gemini CLI 開發體驗！** 🚀🤖