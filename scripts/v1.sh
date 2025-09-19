mkdir -p .gemini

# 0. 先建空 JSON
jq -n '{}' > .gemini/settings.json

########## 第一層 ##########

# 1. contextFileName（先建空陣列）
jq '.contextFileName = []' .gemini/settings.json | sponge .gemini/settings.json

# 2. 塞入 GEMINI.md
jq '.contextFileName += ["GEMINI.md"]' .gemini/settings.json | sponge .gemini/settings.json

# 3. 再塞入 AGENTS.md
jq '.contextFileName += ["AGENTS.md"]' .gemini/settings.json | sponge .gemini/settings.json

# 4. 再塞入 CLAUDE.md
jq '.contextFileName += ["CLAUDE.md"]' .gemini/settings.json | sponge .gemini/settings.json

# 5. 再塞入 .github/copilot-instructions.md
jq '.contextFileName += [".github/copilot-instructions.md"]' .gemini/settings.json | sponge .gemini/settings.json

# 6. preferredEditor
jq '.preferredEditor = "vscode"' .gemini/settings.json | sponge .gemini/settings.json

# 6. theme
jq '.theme = "GitHub"' .gemini/settings.json | sponge .gemini/settings.json

# 7. mcpServers（先建空物件）
jq '.mcpServers = {}' .gemini/settings.json | sponge .gemini/settings.json


########## mcpServers.github ##########
# 8. 建立 github 子物件
jq '.mcpServers.github = {}' .gemini/settings.json | sponge .gemini/settings.json

# 9. command
jq '.mcpServers.github.command = "docker"' .gemini/settings.json | sponge .gemini/settings.json

# 10. args（空陣列）
jq '.mcpServers.github.args = []' .gemini/settings.json | sponge .gemini/settings.json

# 11~16. 依序推入各個參數
jq '.mcpServers.github.args += ["run"]'                         .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["-i"]'                          .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["--rm"]'                        .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["-e"]'                          .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["GITHUB_PERSONAL_ACCESS_TOKEN"]' .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.github.args += ["ghcr.io/github/github-mcp-server"]' .gemini/settings.json | sponge .gemini/settings.json

# 17. env 子物件
jq '.mcpServers.github.env = {"GITHUB_PERSONAL_ACCESS_TOKEN":"$GITHUB_PERSONAL_ACCESS_TOKEN"}' .gemini/settings.json | sponge .gemini/settings.json

# 18. trust
jq '.mcpServers.github.trust = true' .gemini/settings.json | sponge .gemini/settings.json


########## mcpServers.context7 ##########
# 19. 建立 context7 子物件
jq '.mcpServers.context7 = {}' .gemini/settings.json | sponge .gemini/settings.json

# 20. type
jq '.mcpServers.context7.type = "stdio"' .gemini/settings.json | sponge .gemini/settings.json

# 21. command
jq '.mcpServers.context7.command = "npx"' .gemini/settings.json | sponge .gemini/settings.json

# 22. args（空陣列）
jq '.mcpServers.context7.args = []' .gemini/settings.json | sponge .gemini/settings.json

# 23~24. 依序推入兩個參數
jq '.mcpServers.context7.args += ["-y"]'                  .gemini/settings.json | sponge .gemini/settings.json
jq '.mcpServers.context7.args += ["@upstash/context7-mcp"]' .gemini/settings.json | sponge .gemini/settings.json

# 25. trust
jq '.mcpServers.context7.trust = true' .gemini/settings.json | sponge .gemini/settings.json
