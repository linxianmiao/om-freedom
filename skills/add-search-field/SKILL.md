---
name: add-search-field
description: 在列表页搜索区域添加新字段。当用户说"加个搜索条件"、"添加筛选字段"、"增加查询条件"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, AskUserQuestion
---

# 添加搜索字段

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范和通用扫描逻辑。**

## 第一步：选择目标列表页
按 _base 通用扫描逻辑执行。

## 第二步：收集字段信息（1 轮，4 个问题）

Q1（自由输入）: "搜索字段的标签？（如：用户名）"
Q2（自由输入）: "数据字段名？（query 属性名，如：userName）"
Q3（选项）: "字段类型？"
  - 输入框 (Recommended) / 下拉选择框 / 日期选择器 / 日期范围选择器
Q4（自由输入）: "提示文字？（不填使用默认）"

## 第三步：补充（仅下拉选择需要）
AskUserQuestion（自由输入）: "下拉选项（每行一个）：显示文字 | 值"

## 第四步：生成代码

1. Edit 在 data().query 中添加默认值（input/select: `''`，daterange: `[]`）
2. Edit 在 `<el-form>` 中"查询"按钮前插入 `<el-form-item>`

**输入框**: `<el-input v-model="query.{field}" placeholder="{提示}" clearable size="medium" />`
**下拉**: `<el-select>` + 在 data() 添加 options 数组
**日期**: `<el-date-picker type="date" value-format="yyyy-MM-dd" />`
**日期范围**: `<el-date-picker type="daterange" range-separator="至" value-format="yyyy-MM-dd" />`
