---
name: remove-search-field
description: 从列表页搜索区域删除字段。当用户说"删掉搜索条件"、"移除筛选字段"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, AskUserQuestion
---

# 删除搜索字段

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范和通用扫描逻辑。**

## 第一步：选择目标列表页
按 _base 通用扫描逻辑执行。

## 第二步：解析并展示搜索字段
分析 `<el-form>` 中 `<el-form-item>`（排除只含按钮的项），提取 label、v-model 字段名、组件类型。

用 AskUserQuestion（multiSelect: true）展示：
"选择要删除的搜索字段："
- 选项格式：`"{标签}" (query.{字段名}, {类型})`

## 第三步：执行删除
1. Edit 删除 template 中 `<el-form-item>` 元素
2. Edit 删除 data().query 中对应属性
3. select 类型检查并清理无引用的 options 数组
