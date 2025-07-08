mkdir -p .gemini

# 0. 先建空 JSON
jq -n '{}' > .gemini/settings.json

########## 第一層 ##########

# 1. contextFileName（先建空陣列）
jq '.contextFileName = []' .gemini/settings.json | sponge .gemini/settings.json

# 2. 塞入 .github/copilot-instructions.md
jq '.contextFileName += [".github/copilot-instructions.md"]' .gemini/settings.json | sponge .gemini/settings.json

# 3. 再塞入 GEMINI.md
jq '.contextFileName += ["GEMINI.md"]' .gemini/settings.json | sponge .gemini/settings.json

# 4. preferredEditor
jq '.preferredEditor = "vscode"' .gemini/settings.json | sponge .gemini/settings.json

# 5. theme
jq '.theme = "GitHub"' .gemini/settings.json | sponge .gemini/settings.json

# 6. mcpServers（先建空物件）
jq '.mcpServers = {}' .gemini/settings.json | sponge .gemini/settings.json


########## mcpServers.github ##########
# 7. 建立 github 子物件
jq '.mcpServers.github = {}' .gemini/settings.json | sponge .gemini/settings.json

# 8. command
jq '.mcpServers.github.command = "docker"' .gemini/settings.json | sponge .gemini/settings.json

# 9. args（空陣列）
jq '.mcpServers.github.args = []' .gemini/settings.json | sponge .gemini/settings.json

# 10~15. 依序推入各個參數
jq '.mcpServers.github.args += ["run"]'                         .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["-i"]'                          .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["--rm"]'                        .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["-e"]'                          .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["GITHUB_PERSONAL_ACCESS_TOKEN"]' .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["ghcr.io/github/github-mcp-server"]' .gemini/settings.json | sponge .gemini/settings.json

# 16. env 子物件
jq '.mcpServers.github.env = {"GITHUB_PERSONAL_ACCESS_TOKEN":"$GITHUB_PERSONAL_ACCESS_TOKEN"}' .gemini/settings.json | sponge .gemini/settings.json

# 17. trust
jq '.mcpServers.github.trust = true' .gemini/settings.json | sponge .gemini/settings.json


########## mcpServers.context7 ##########
# 18. 建立 context7 子物件
jq '.mcpServers.context7 = {}' .gemini/settings.json | sponge .gemini/settings.json

# 19. type
jq '.mcpServers.context7.type = "stdio"' .gemini/settings.json | sponge .gemini/settings.json

# 20. command
jq '.mcpServers.context7.command = "npx"' .gemini/settings.json | sponge .gemini/settings.json

# 21. args（空陣列）
jq '.mcpServers.context7.args = []' .gemini/settings.json | sponge .gemini/settings.json

# 22~23. 依序推入兩個參數
jq '.mcpServers.context7.args += ["-y"]'                  .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.context7.args += ["@upstash/context7-mcp"]' .gemini/settings.json | sponge .gemini/settings.json

# 24. trust
jq '.mcpServers.context7.trust = true' .gemini/settings.json | sponge .gemini/settings.json
