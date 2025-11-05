# Claude Code

## git worktree

```bash
$ git fetch --all
$ git switch develop
$ git pull origin develop
$ git switch -c feature/blabla # 새 브랜치 생성
$ git switch -c feature/blabla origin/develop
```

## MCP

```bash
# Add context7 MCP
$ claude mcp add context7 -- npx -y @upstash/context7-mcp@latest

# Add serena MCP
## 1. Install Serena MCP
$ brew install uv
$ cd ~/workspace # serene 설치를 원하는 디렉토리로 이동
$ git clone https://github.com/oraios/serena
$ cd serena
$ cp src/serena/resources/serena_config.template.yml ~/.serena/serena_config.yml
# 설정 파일에서 web_bashboard_open_on_lanuch를 false로 하면 mcp 실행시마다 브라우저 실행되는 것을 끌 수 있음
# $ vi ~/.serena/serena_config.yml
$ echo "export SERENA_PATH=\"\$HOME/workspace/serena\"" >> ~/.zshrc
$ source ~/.zshrc
$ echo "**/.serena" >> ~/.gitignore_global
## 2. Add the serena MCP
$ j claude-code # claude-code 로 생성한 worktree로 이동 (https://github.com/wting/autojump)
$ claude mcp remove serena # 잘못 설치되어 있었다면 제거
$ claude mcp add serena -- uv run --directory $SERENA_PATH serena-mcp-server --context ide-assistant --project "$(pwd)"
# git repository를 직접 사용하는 방법. 매번 오버헤드가 발생하므로 위와 같이 로컬 사용 권장
# $ claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$(pwd)"

# Add seqeutial-thinking MCP
$ claude mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking

# Add playwright MCP
$ claude mcp add playwright npx @playwright/mcp@latest

# Add browser-use MCP
$ claude mcp add browsermcp npx @browsermcp/mcp@latest

# Add notion MCP
claude mcp add notion https://mcp.notion.com/sse -t sse

# Add linear MCP
claude mcp add linear-server https://mcp.linear.app/sse -t sse
```

## ETC

```bash
# Install GitHub CLI (https://cli.github.com/)
$ brew isntall gh
$ gh auth login

# Run Claude Code
$ echo "**/CLAUDE.local.md" >> ~/.gitignore_global
$ claude mcp list
$ claude --dangerously-skip-permissions # YOLO mode
> /mcp

# 명령어 입력시 개행(opt+enter)을 추가할 수 있도록 설정
> /terminal-setup
```
