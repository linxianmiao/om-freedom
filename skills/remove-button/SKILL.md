---
name: remove-button
description: 从现有页面中删除一个按钮。当用户说"删掉按钮"、"移除操作按钮"、"去掉这个按钮"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, AskUserQuestion
---

# 删除按钮

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范和通用扫描逻辑。**

## 第一步：选择目标页面
按 _base 通用扫描逻辑执行。

## 第二步：解析并展示按钮列表
读取代码，找出所有 `<el-button>` 和 `<el-link>`，提取：文字、位置（工具栏/操作列/表单底部）、@click 方法名。

用 AskUserQuestion（multiSelect: true）展示：
"以下是页面中的按钮，选择要删除的："
- 选项格式：`[位置] "按钮文字" → 方法名()`

## 第三步：执行删除
1. Edit 删除 template 中按钮元素（含包裹的 el-form-item 或 el-divider）
2. 检查 @click 绑定的方法是否还有其他引用，无则一并删除
3. 清理多余空行
