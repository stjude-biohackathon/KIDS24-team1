<template>
  <v-footer height="40" app>
    <a
      key="github-link"
      href="https://github.com/stjude-biohackathon/KIDS24-team1"
      title="Github Repo"
      class="d-inline-block mx-2 social-link"
      rel="noopener noreferrer"
      target="_blank"
    >
      <v-icon
        icon="$github"
        :size="24"
      />
    </a>

    <div
      class="text-caption text-disabled"
      style="position: absolute; right: 16px;"
    >
      <span class="d-none d-sm-inline-block">2024 St. Jude Biohackathon (Team 1)</span>
    </div>
  </v-footer>
</template>

<script setup>
</script>

<style scoped lang="sass">
  .social-link :deep(.v-icon)
    color: rgba(var(--v-theme-on-background), var(--v-disabled-opacity))
    text-decoration: none
    transition: .2s ease-in-out

    &:hover
      color: rgba(25, 118, 210, 1)
</style>
