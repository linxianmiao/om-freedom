---
name: remove-table-column
description: 从列表页表格中删除一列。当用户说"删掉这列"、"移除表格列"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, AskUserQuestion
---

# 删除表格列

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范和通用扫描逻辑。**

## 第一步：选择目标列表页
按 _base 通用扫描逻辑执行。

## 第二步：解析并展示列列表
分析 `<el-table>` 中所有 `<el-table-column>`，提取 label/prop/width。

用 AskUserQuestion（multiSelect: true）展示：
"选择要删除的列："
- 选项格式：`"{标题}" (prop: {字段名}, width: {宽度})`
- 操作列单独标注，选中时二次确认

## 第三步：执行删除
1. Edit 删除完整的 `<el-table-column>` 元素（含内部 template）
2. 如果列引用了 data() 中的映射数据且无其他引用，一并删除
