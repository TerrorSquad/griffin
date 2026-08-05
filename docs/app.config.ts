export default defineAppConfig({
  seo: {
    title: "Griffin",
    description: "Automate your post-installation tasks with Ansible",
    titleTemplate: "%s · Griffin",
  },

  header: {
    title: "Griffin",
    logo: {
      alt: "Griffin",
      light: "",
      dark: "",
    },
  },

  github: {
    owner: "terrorsquad",
    name: "griffin",
    branch: "master",
    rootDir: "docs",
    url: "https://github.com/terrorsquad/griffin",
  },

  socials: {
    linkedin: "https://www.linkedin.com/in/goran-ninkovic/",
  },

  ui: {
    colors: {
      primary: "emerald",
      neutral: "gray",
    },
  },
});
