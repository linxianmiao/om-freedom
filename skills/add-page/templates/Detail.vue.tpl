<template>
  <el-form ref="form" label-position="left" label-width="120px" :model="formData" :rules="rules">
    <header class="header">
      <div class="flex items-center mb-2">
        <el-page-header class="flex-1" @back="goBack" :content="pageTitle" />
      </div>
    </header>

    __FORM_FIELDS__

    <footer>
      <el-button type="primary" class="my-4" v-loading="loading" @click="handleSubmit">
        {{ action === 'create' ? '创建' : '保存' }}
      </el-button>
    </footer>
  </el-form>
</template>

<script>
import __API_IMPORT_NAME__ from '@/apis/__API_FILE_NAME__'

export default {
  props: {
    id: { type: [Number, String], default: '' },
    action: { type: String, default: 'edit' },
  },

  data() {
    return {
      loading: false,
      formData: {
        __FORM_DEFAULTS__
      },
      rules: {
        __FORM_RULES__
      },
      __EXTRA_DATA__
    }
  },

  computed: {
    pageTitle() {
      return this.action === 'create' ? '创建__MODULE_CN_NAME__' : '编辑__MODULE_CN_NAME__'
    },
  },

  created() {
    if (this.id) {
      this.fetchDetail()
    }
  },

  methods: {
    async fetchDetail() {
      try {
        this.loading = true
        const { data } = await __API_IMPORT_NAME__.getDetail(this.id)
        this.formData = data
      } catch (error) {
        this.$message.error(error.message || '获取详情失败')
      } finally {
        this.loading = false
      }
    },

    async handleSubmit() {
      const valid = await this.$refs.form.validate().catch(() => false)
      if (!valid) return
      try {
        this.loading = true
        if (this.action === 'create') {
          await __API_IMPORT_NAME__.create(this.formData)
          this.$message.success('创建成功')
        } else {
          await __API_IMPORT_NAME__.update({ ...this.formData, id: this.id })
          this.$message.success('保存成功')
        }
        this.goBack()
      } catch (error) {
        this.$message.error(error.message || '操作失败')
      } finally {
        this.loading = false
      }
    },

    goBack() {
      this.$router.go(-1)
    },
  },
}
</script>

<style lang="postcss" scoped>
.header {
  position: sticky;
  top: -20px;
  left: 0;
  z-index: 1;
  width: 100%;
  padding: 8px 0;
  background: #fff;
}
</style>
