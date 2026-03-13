---
name: add-dialog
description: 在现有页面上添加弹窗。当用户说"加个弹窗"、"添加对话框"、"添加确认弹窗"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, Write, AskUserQuestion
---

# 添加弹窗

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范和通用扫描逻辑。**

## 第一步：选择目标页面
按 _base 通用扫描逻辑执行。

## 第二步：确定弹窗类型（1 轮，3 个问题）

Q1（选项）: "弹窗类型？"
  - 确认弹窗（$confirm，最简单）(Recommended) / 表单弹窗（el-dialog + 表单）/ 信息展示弹窗（只读）
Q2（自由输入）: "弹窗标题？（如：确认删除、编辑备注）"
Q3（选项）: "如何触发弹窗？"
  - 动态选项：列出页面已有按钮 + "新增一个触发按钮"

## 第三步：收集详细内容

**确认弹窗**（1 轮，2 个问题）:
Q1（自由输入）: "确认提示文案？"
Q2（自由输入）: "确认后执行什么？（如：调用 ApiOrder.delete(row.id)）"

**表单弹窗**（1 轮，2 个问题）:
Q1（自由输入）: "表单字段（每行一个）：标签 | 字段名 | 类型 | 是否必填"
Q2（自由输入）: "提交后调用什么接口？"

**信息展示弹窗**（1 轮）:
Q1（自由输入）: "展示字段（每行一个）：标签 | 字段名"

## 第四步：生成代码

**确认弹窗** — 只修改/添加 methods：
```javascript
async handle{Action}(row) {
  await this.$confirm('{文案}', '提示', { type: 'warning' })
  await ApiXxx.method(row.id)
  this.$message.success('操作成功')
  this.getData()
},
```

**表单弹窗** — 三处修改：
1. data() 添加 `dialogVisible: false, dialogForm: {...}, dialogRules: {...}, currentRow: null`
2. template 末尾添加 `<el-dialog>` + 内部表单 + footer 按钮
3. methods 添加 `openDialog / handleDialogClose / handleDialogSubmit`

**信息展示弹窗** — 两处修改：
1. data() 添加 `infoDialogVisible: false, currentRow: null`
2. template 添加 `<el-dialog>` + `<el-descriptions>` 展示字段
