---
name: add-form-field
description: 在详情/编辑页的表单中添加新字段。当用户说"加个表单字段"、"添加输入项"、"表单加个字段"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, AskUserQuestion
---

# 添加表单字段

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范和通用扫描逻辑。**

## 第一步：选择目标表单页
按 _base 通用扫描逻辑执行，优先定位 Detail.vue / Edit.vue。
读取代码后，确认表单数据对象名称（formData/formValue/value，以代码中实际使用的为准）。

## 第二步：收集字段信息（1 轮，4 个问题）

Q1（自由输入）: "字段标签？（如：商品名称）"
Q2（自由输入）: "字段名？（如：productName）"
Q3（选项）: "字段类型？"
  - 输入框 (Recommended) / 多行文本框 / 数字输入 / 下拉选择（Other 可输入 switch/radio/date/upload）
Q4（选项）: "是否必填？"
  - 是 / 否

## 第三步：选择插入位置（1 轮）
分析已有 `<el-form-item>` 标签列表。
AskUserQuestion（选项）: "新字段插入到哪个字段后面？"
- 动态选项：从已有字段标签生成 + "末尾"

## 第四步：生成代码

1. Edit 在表单数据对象中添加字段默认值
2. 如必填，Edit 在 rules 中添加：`{field}: [{ required: true, message: '请输入{label}', trigger: 'blur' }]`
3. Edit 在指定位置插入 `<el-form-item label="{label}" prop="{field}">`

注意：v-model 绑定使用代码中实际的数据对象名（formData/formValue/value）。

**输入框**: `<el-input v-model="{obj}.{field}" placeholder="请输入{label}" clearable />`
**多行文本**: `<el-input v-model="{obj}.{field}" type="textarea" :rows="4" />`
**数字**: `<el-input-number v-model="{obj}.{field}" :min="0" />`
**下拉**: `<el-select>` + data() 中添加 options
**开关**: `<el-switch v-model="{obj}.{field}" />`
