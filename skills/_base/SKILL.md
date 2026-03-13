---
name: _base
description: OM 后台项目的技术约束和通用逻辑。其他技能在执行前应先读取此技能了解项目规范。不可由用户直接调用。
user-invocable: false
---

# OM 后台项目基础规范

## 技术栈约束（所有技能必须遵守）

- **框架**: Vue 2.7 Options API（非 Vue 3，非 Composition API `<script setup>` 语法）
- **UI 库**: Element UI（el-form, el-table, el-pagination, el-button, el-dialog 等）
- **模板语法**: `slot-scope="{ row }"`（非 Vue 3 的 `v-slot` 或 `#default`）
- **路径别名**: `@` 映射到 `src/`
- **CDN 外部依赖**: axios / dayjs / lodash 通过 CDN 引入，直接使用全局变量，不需要 import
- **HTTP 实例**: 定义在 `src/apis/http.js`，通过 `import { goHttp } from './http'` 引入
  - 可用实例: http, adminHttp, goHttp, goInternalHttp, internalGapiHttp
- **分页**: offset/limit 模式（非 page/pageSize）
- **消息提示**: `this.$message.success()` / `this.$message.error()`
- **确认弹窗**: `this.$confirm('文案', '提示', { type: 'warning' })`
- **路由跳转**: `this.$router.push({ name: 'xxx', params: {} })`

## 通用页面扫描逻辑

所有需要"选择目标页面"的技能，统一使用以下流程：

### 步骤 1：扫描模块列表
用 Grep 在 `src/routes-old.js` 中搜索 `inSideBar: true`，提取所有侧边栏模块的：
- title（中文标题）
- path（URL 路径）
- group（菜单分组）
- component（组件路径，用于定位 views 目录）

### 步骤 2：让用户选择模块
用 AskUserQuestion（options）展示模块列表。
- 如果 $ARGUMENTS 非空，尝试用参数模糊匹配模块标题/路径，直接定位，跳过选择
- 选项最多 4 个，按使用频率或字母排序
- 用户可通过 Other 输入模块名或文件路径

### 步骤 3：定位具体文件
确定模块后，用 Glob 在对应 views 子目录下找到所有 .vue 文件。
- 列表页技能：优先找 List.vue / index.vue
- 表单页技能：优先找 Detail.vue / Edit.vue / Form.vue
- 如果有多个候选，用 AskUserQuestion 让用户选
- 用 Read 读取目标文件完整代码

### 步骤 4：确认操作
每个技能在执行代码修改前，都必须展示变更摘要让用户确认。

## 路由注册位置

路由文件: `src/routes-old.js`
新路由插入位置: 在文件末尾的 `]` 之前（`export default routes` 之前的 `]`）

## 菜单分组列表

审核、社区、资料库、账号基础、交易基础、B2C 交易、C2C 交易、AI、其他、临界、PGS评级、Devtools
