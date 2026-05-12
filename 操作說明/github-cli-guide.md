# GitHub CLI 使用教學（Ubuntu 環境）

> **GitHub CLI (`gh`)** 讓你直接在終端機操作 GitHub，不需要開瀏覽器就能管理 repo、PR、issue 等。

---

## 目錄

1. [安裝](#安裝)
2. [登入驗證](#登入驗證)
3. [Repository 操作](#repository-操作)
4. [Issues 操作](#issues-操作)
5. [Pull Request 操作](#pull-request-操作)
6. [Workflow / Actions](#workflow--actions)
7. [Gist 操作](#gist-操作)
8. [常用快捷技巧](#常用快捷技巧)

---

## 安裝

### 方法一：apt（推薦）

```bash
# 加入 GitHub CLI 官方套件庫
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg \
     | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
     | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# 安裝
sudo apt update && sudo apt install gh -y
```

### 方法二：Snap

```bash
sudo snap install gh
```

### 確認安裝成功

```bash
gh --version
# 輸出範例：gh version 2.x.x (...)
```

---

## 登入驗證

```bash
gh auth login
```

互動式選單會問你：

| 問題 | 建議選項 |
|------|----------|
| 使用哪個平台？ | `GitHub.com` |
| 偏好的協議？ | `HTTPS` 或 `SSH` |
| 驗證方式？ | `Login with a web browser`（最方便）|

登入後確認狀態：

```bash
gh auth status
```

登出：

```bash
gh auth logout
```

---

## Repository 操作

### 建立新 Repo

```bash
# 互動式建立
gh repo create

# 直接指定名稱與設定
gh repo create my-project --public --description "我的專案" --clone
```

| 參數 | 說明 |
|------|------|
| `--public` | 公開 repo |
| `--private` | 私人 repo |
| `--clone` | 建立後自動 clone 到本地 |
| `--description` | 設定描述 |

### Clone Repo

```bash
gh repo clone owner/repo-name
# 等同於 git clone，但不需要手動複製 URL
```

### Fork Repo

```bash
gh repo fork owner/repo-name
gh repo fork owner/repo-name --clone  # fork 後立即 clone
```

### 查看 Repo 資訊

```bash
gh repo view                     # 查看目前目錄的 repo
gh repo view owner/repo-name     # 查看指定 repo
gh repo view --web               # 在瀏覽器開啟
```

### 列出自己的 Repo

```bash
gh repo list
gh repo list --limit 20          # 顯示最多 20 筆
gh repo list --public            # 只顯示公開 repo
```

---

## Issues 操作

### 建立 Issue

```bash
# 互動式
gh issue create

# 直接指定
gh issue create --title "修復登入錯誤" --body "按下登入按鈕後出現 500 錯誤"

# 指派給自己並加標籤
gh issue create --title "新功能" --assignee @me --label "enhancement"
```

### 查看 Issues

```bash
gh issue list                    # 列出開啟中的 issues
gh issue list --state closed     # 列出已關閉
gh issue list --assignee @me     # 指派給自己的
gh issue list --label "bug"      # 指定標籤

gh issue view 42                 # 查看 #42
gh issue view 42 --web           # 在瀏覽器開啟
```

### 關閉 / 重新開啟

```bash
gh issue close 42
gh issue reopen 42
```

### 新增留言

```bash
gh issue comment 42 --body "已確認可以重現此問題"
```

---

## Pull Request 操作

### 建立 PR

```bash
# 互動式（推薦新手）
gh pr create

# 直接指定
gh pr create --title "新增登入功能" --body "實作 OAuth 登入流程" --base main

# 建立草稿 PR
gh pr create --draft
```

### 查看 PR

```bash
gh pr list                       # 列出開啟中的 PR
gh pr list --state merged        # 已合併
gh pr list --author @me          # 自己建立的

gh pr view 15                    # 查看 #15
gh pr view 15 --web              # 在瀏覽器開啟
```

### Review PR

```bash
gh pr review 15 --approve                          # 核准
gh pr review 15 --request-changes --body "請修正縮排"  # 要求修改
gh pr review 15 --comment --body "看起來不錯！"       # 留言
```

### Checkout PR（切換到 PR 分支）

```bash
gh pr checkout 15
```

### 合併 PR

```bash
gh pr merge 15                   # 互動式選擇合併方式
gh pr merge 15 --merge           # 一般合併
gh pr merge 15 --squash          # Squash 合併
gh pr merge 15 --rebase          # Rebase 合併
```

### 關閉 PR

```bash
gh pr close 15
```

---

## Workflow / Actions

### 查看執行狀態

```bash
gh run list                      # 最近的執行紀錄
gh run list --workflow "CI"      # 指定 workflow

gh run view                      # 查看最新一次
gh run view 1234567890           # 查看指定 run ID
gh run view --log                # 顯示完整 log
```

### 手動觸發 Workflow

```bash
gh workflow run deploy.yml
gh workflow run deploy.yml --ref feature/my-branch
```

### 查看所有 Workflows

```bash
gh workflow list
```

---

## Gist 操作

### 建立 Gist

```bash
gh gist create myfile.sh                             # 單一檔案
gh gist create file1.py file2.py                    # 多個檔案
gh gist create myfile.sh --public                   # 公開
gh gist create myfile.sh --desc "我的啟動腳本"       # 加描述
```

### 查看 Gist

```bash
gh gist list
gh gist view <gist-id>
gh gist view <gist-id> --raw    # 顯示原始內容
```

---

## 常用快捷技巧

### 設定預設 Editor

```bash
gh config set editor vim         # 或 nano、code 等
```

### 設定別名（Alias）

```bash
gh alias set prc 'pr create'
gh prc                           # 等同於 gh pr create
```

### 用 JSON 輸出（搭配 jq 處理）

```bash
gh pr list --json number,title,state
gh issue list --json title,number | jq '.[].title'
```

### 快速在瀏覽器開啟當前 Repo

```bash
gh browse
gh browse --issues               # 開啟 issues 頁面
gh browse --settings             # 開啟設定頁面
```

### 搜尋 Repo

```bash
gh search repos "machine learning" --language python --limit 10
```

---

## 常用指令速查表

| 操作 | 指令 |
|------|------|
| 登入 | `gh auth login` |
| 建立 repo | `gh repo create` |
| Clone repo | `gh repo clone owner/repo` |
| 建立 issue | `gh issue create` |
| 列出 issues | `gh issue list` |
| 建立 PR | `gh pr create` |
| 列出 PR | `gh pr list` |
| 合併 PR | `gh pr merge <編號>` |
| 查看 Actions | `gh run list` |
| 在瀏覽器開啟 | `gh repo view --web` |

---

## 參考資源

- 官方文件：<https://cli.github.com/manual/>
- 指令說明：`gh help` 或 `gh <指令> --help`
