; extends
; https://phelipetls.github.io/posts/mdx-syntax-highlight-treesitter-nvim/
((inline) @injection.content
  (#lua-match? @injection.content "^%s*import")
  (#set! injection.language "typescript"))
((inline) @injection.content
  (#lua-match? @injection.content "^%s*export")
  (#set! injection.language "typescript"))
