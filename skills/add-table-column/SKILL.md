---
name: add-table-column
description: 在列表页的表格中添加新列。当用户说"加个列"、"添加表格字段"、"表格加一列"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, AskUserQuestion
---

# 添加表格列

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范和通用扫描逻辑。**

## 第一步：选择目标列表页
按 _base 通用扫描逻辑执行，优先定位 List.vue。

## 第二步：解析已有列 + 收集新列信息（1 轮，4 个问题）

先分析 `<el-table>` 中已有 `<el-table-column>` 的 label 列表。

Q1（自由输入）: "列标题？（显示在表头）"
Q2（自由输入）: "数据字段名？（API 返回的字段名，如 status）"
Q3（选项）: "列类型？"
  - 纯文本（直接显示）(Recommended) / 时间格式化（YYYY-MM-DD HH:mm）/ 状态映射（值→中文）/ 图片预览（缩略图）
Q4（选项）: "插入到哪列后面？"
  - 动态选项：从已有列标题生成（如 "ID列之后" / "名称列之后" / "末尾（操作列之前）"）

## 第三步：补充（仅状态映射需要）
AskUserQuestion（自由输入）: "状态映射（每行一个）：值 | 显示文字"

## 第四步：生成代码

用 Edit 在指定位置插入 `<el-table-column>`：

**纯文本**: `<el-table-column prop="{field}" label="{title}" width="{width}" :show-overflow-tooltip="true" />`

**时间**:
```html
<el-table-column label="{title}" width="{width}">
  <template slot-scope="{ row }">
    {{ row.{field} ? dayjs(row.{field}).format('YYYY-MM-DD HH:mm') : '-' }}
  </template>
</el-table-column>
```

**状态映射**: 在 data() 添加 `{field}Map: {...}`，template 中用 `{{ {field}Map[row.{field}] || row.{field} }}`

**图片**:
```html
<el-table-column label="{title}" width="{width}">
  <template slot-scope="{ row }">
    <el-image v-if="row.{field}" style="width: 60px; height: 60px" :src="row.{field}" fit="cover" :preview-src-list="[row.{field}]" />
    <span v-else>-</span>
  </template>
</el-table-column>
```
