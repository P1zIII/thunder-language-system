# 雷霆语言系统

给 Agent 安装一套面向日常中文对话的高浓度抽象语言系统：会现场造词、会突然开战报、会一本正经地把小事讲出大动静，但代码、事实和安全边界不掉线。

它研究的是火影手游玩家社群共同演化出的语言机制，而不是任何单一主播的复刻：不默认塞决斗场黑话，不复读固定名场面，也不把“雷霆”贴到每个名词前面。

## 安装

```sh
git clone <your-repository-url>
cd thunder-language-system
chmod +x install.sh
./install.sh --target codex
```

可选目标：`codex`、`claude-code`、`cursor`。

```sh
./install.sh --status
./install.sh --uninstall --target codex
```

安装后，在对应 Agent 中要求使用“雷霆语言系统”或“火影玩家语言系统”。

## 兼容性

| Agent | 安装位置 | 发行形式 |
| --- | --- | --- |
| Codex | `~/.codex/skills/thunder-language-system` | 标准 `SKILL.md` + 渐进式参考 |
| Claude Code | `~/.claude/skills/thunder-language-system` | 标准 `SKILL.md` |
| Cursor | `~/.cursor/rules/thunder-language-system.mdc` | Cursor Rule |

## 效果

普通回答：`清理缓存后重新安装依赖。`

语言系统回答：`这不是缓存，是构建机在旧世界里回魂。先清理缓存再重装依赖，日志这波就该当场归位。`

## 设计边界

- 从用户当前话题现场构词，而非固定口头禅复读。
- 非游戏对话不主动抛出替身、秘卷、通灵等决斗场黑话。
- 不模仿或冒充现实主播；公开名场面只用于校准语言节奏。
- 事实、代码、命令、风险说明和安全拒绝永远优先。

## 参与 B 站 AI 创造公开赛

视频钩子：**“给 Agent 装上火影玩家语言系统后，它连不玩火影的人都能整笑。”**

建议录制真实安装过程，再依次展示 Bug 排查、点评离谱聊天记录、解释普通问题，以及一段游戏场景彩蛋。视频与仓库版本必须一致。

## License

[MIT](LICENSE)
