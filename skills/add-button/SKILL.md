---
name: add-button
description: 在现有页面上添加一个按钮。当用户说"加个按钮"、"添加操作"、"增加按钮"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, Write, AskUserQuestion
---

# 添加按钮

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范和通用扫描逻辑。**

## 第一步：选择目标页面

按 _base 中的"通用页面扫描逻辑"执行：扫描 routes-old.js → AskUserQuestion 选模块 → 选文件 → 读取代码。

## 第二步：收集按钮信息（1 轮 AskUserQuestion，4 个问题）

Q1（自由输入）: "按钮文字？（如：导出、审核、上架）"
Q2（选项）: "按钮放在哪？"
  - 工具栏（搜索表单旁） / 表格操作列 / 表单底部 / 页面顶部
Q3（选项）: "按钮样式？"
  - 主要蓝色 primary (Recommended) / 成功绿色 success / 危险红色 danger / 文字链接 text
Q4（选项）: "点击后做什么？"
  - 跳转到其他页面 / 调用接口（弹确认框） / 打开弹窗 / 自定义（Other）

## 第三步：收集行为细节（1 轮）

根据 Q4 选择追问：
- **跳转**：Q1 "目标路由名或路径？"
- **调用接口**：Q1 "确认文案？" Q2 "API 调用代码？（如 ApiOrder.approve(row.id)）"
- **打开弹窗**：Q1 "弹窗标题？" Q2 "弹窗类型？" 选项：确认框 / 表单 / 信息展示

## 第四步：生成代码

确认后，用 Edit 插入：

**工具栏按钮** — 在 `<el-form>` 最后一个 `<el-form-item>` 后：
```html
<el-form-item>
  <el-button type="{type}" size="medium" @click="handle{Action}">{文字}</el-button>
</el-form-item>
```

**操作列按钮** — 在操作列 `<template slot-scope>` 中追加：
```html
<el-divider direction="vertical" />
<el-link type="{type}" @click="handle{Action}(row)">{文字}</el-link>
```

**methods 处理方法**:
- 跳转：`this.$router.push({ name: '{route}', params: { id: row.id } })`
- 确认+API：`await this.$confirm('{文案}') → await ApiXxx.method(row.id) → this.$message.success → this.getData()`
- 弹窗：设置 dialogVisible = true

如需 import 新 API 模块，在 script 顶部添加。
