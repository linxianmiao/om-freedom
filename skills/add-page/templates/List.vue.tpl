<template>
  <div>
    <el-form inline>
      __SEARCH_FIELDS__
      <el-form-item>
        <el-button type="primary" size="medium" :disabled="loading" @click.stop="handleSearch">
          查询
        </el-button>
      </el-form-item>
      __CREATE_BUTTON__
    </el-form>

    <el-table :data="items" stripe v-loading="loading">
      __TABLE_COLUMNS__
      __OPERATION_COLUMN__
    </el-table>

    <el-pagination
      class="mt-4 float-right"
      background
      layout="total, sizes, prev, pager, next, jumper"
      :total="count"
      :page-size="query.limit"
      :page-sizes="[20, 50, 100, 200]"
      :current-page="currentPage"
      @size-change="handleSizeChange"
      @current-change="handlePageChange"
    />
  </div>
</template>

<script>
import __API_IMPORT_NAME__ from '@/apis/__API_FILE_NAME__'

export default {
  data() {
    return {
      query: {
        __QUERY_DEFAULTS__
        offset: 0,
        limit: 20,
      },
      items: [],
      count: 0,
      loading: false,
      currentPage: 1,
      __EXTRA_DATA__
    }
  },

  created() {
    this.getData()
  },

  methods: {
    async getData() {
      try {
        this.loading = true
        const { data } = await __API_IMPORT_NAME__.getList(this.query)
        this.items = data.rows || data.list || []
        this.count = +(data.count || data.total || 0)
      } catch (error) {
        this.$message.error(error.message || '获取数据失败')
      } finally {
        this.loading = false
      }
    },

    handleSearch() {
      this.query.offset = 0
      this.currentPage = 1
      this.getData()
    },

    handlePageChange(page) {
      this.currentPage = page
      this.query.offset = (page - 1) * this.query.limit
      this.getData()
    },

    handleSizeChange(size) {
      this.query.limit = size
      this.query.offset = 0
      this.currentPage = 1
      this.getData()
    },

    __CREATE_METHOD__

    handleEdit(row) {
      this.$router.push({ name: '__ROUTE_PREFIX__-detail', params: { id: row.id } })
    },

    __DELETE_METHOD__
  },
}
</script>
