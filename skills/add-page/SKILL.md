---
name: add-page
description: 新增一个完整的 CRUD 模块（列表页+详情页+API文件+路由注册）。当用户说"新增页面"、"创建模块"、"添加新功能页面"时触发。
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep, Glob, Edit, Write, AskUserQuestion
---

# 新增 CRUD 模块

你是 OM 后台的开发助手。通过多轮问答收集需求，然后生成完整的 CRUD 模块。

**执行前先读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解项目规范。**

## 执行流程

### 第一步：准备工作（静默执行）

1. 读取 `${CLAUDE_SKILL_DIR}/../_base/SKILL.md` 了解技术约束
2. 读取 `src/routes-old.js` 最后 100 行，确认路由插入位置
3. 读取 `${CLAUDE_SKILL_DIR}/templates/` 下的模板文件

### 第二步：收集基本信息（1 轮 AskUserQuestion，4 个问题）

Q1（自由输入）: "模块的中文名称？（如：优惠券管理）"
Q2（自由输入）: "模块的英文路径名？（用于URL和目录名，如：coupon）"
Q3（选项）: "放在哪个菜单分组？"
  - 资料库 / 交易基础 / B2C 交易 / 社区（Other 覆盖其余分组）
Q4（多选 multiSelect: true）: "需要哪些功能？"
  - 列表页（搜索+表格+分页）/ 详情编辑页（表单）/ 新建功能 / 删除功能

### 第三步：收集 API 信息（1 轮，3 个问题）

Q1（选项）: "使用哪个 HTTP 实例？"
  - goHttp（Go服务，最常用）(Recommended) / http（默认Node服务）/ adminHttp（管理后端）/ goInternalHttp（内部Go服务）
Q2（自由输入）: "后端 API 路径前缀？（如：/om-web/admin/coupon）"
Q3（自由输入）: "API 文件名？（创建 src/apis/xxx.js，如：coupon）"

### 第四步：收集表格列（1 轮，仅列表页需要）

AskUserQuestion 自由输入：
"请定义表格列（每行一列）：
格式：列标题 | 字段名 | 列宽(可选) | 类型(可选)
类型可选：text(默认) / time(时间) / status(状态映射) / image(图片)

示例：
ID | id | 100
名称 | name | 200
创建时间 | createdAt | 180 | time
状态 | status | 120 | status"

### 第五步：收集搜索+表单字段（1 轮，2 个问题合并）

Q1（自由输入）: "搜索字段（不需要则留空）：
格式：标签 | 字段名 | 类型(input/select/date/daterange)
示例：名称 | name | input"

Q2（自由输入，仅详情页需要）: "表单字段：
格式：标签 | 字段名 | 类型(input/textarea/number/select/switch) | 是否必填(是/否)
示例：名称 | name | input | 是"

### 第六步：确认并生成

展示完整需求摘要，确认后：

1. **创建 Index.vue**（`src/views/{module}/Index.vue`）
   - 读取 `${CLAUDE_SKILL_DIR}/templates/Index.vue.tpl` 直接复制

2. **创建 API 文件**（`src/apis/{name}.js`）
   - 读取 `${CLAUDE_SKILL_DIR}/templates/api.js.tpl`
   - 替换 `__HTTP_INSTANCE__`、`__PATH_PREFIX__` 占位符

3. **创建 List.vue**（`src/views/{module}/List.vue`）
   - 读取 `${CLAUDE_SKILL_DIR}/templates/List.vue.tpl`
   - 根据用户定义的列和搜索字段替换 `__SEARCH_FIELDS__`、`__TABLE_COLUMNS__`、`__QUERY_DEFAULTS__` 等占位符

4. **创建 Detail.vue**（`src/views/{module}/Detail.vue`）
   - 读取 `${CLAUDE_SKILL_DIR}/templates/Detail.vue.tpl`
   - 根据用户定义的表单字段替换占位符

5. **注册路由**
   - 在 `src/routes-old.js` 的 `]` 之前用 Edit 插入路由配置

### 第七步：总结

告诉用户创建了哪些文件，运行 `yarn dev` 后访问对应路径查看效果。
