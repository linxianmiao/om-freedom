---
name: remove-form-field
description: 从详情/编辑页表单中删除字段。当用户说"删掉表单字段"、"移除输入项"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, AskUserQuestion
---

# 删除表单字段

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范和通用扫描逻辑。**

## 第一步：选择目标表单页
按 _base 通用扫描逻辑执行。

## 第二步：解析并展示表单字段
分析 `<el-form>` 中 `<el-form-item>`（排除提交按钮），提取 label、prop、组件类型、是否必填。

用 AskUserQuestion（multiSelect: true）展示：
"选择要删除的字段："
- 选项格式：`"{标签}" ({字段名}, {类型}, {必填/选填})`

## 第三步：执行删除
1. Edit 删除 template 中 `<el-form-item>` 元素
2. Edit 删除表单数据对象中对应属性
3. Edit 删除 rules 中对应验证规则（如有）
4. 检查关联的 watch/computed/options，有则提醒用户
