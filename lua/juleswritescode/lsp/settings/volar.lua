local M = {}

M.settings = {
  filetypes = { 'vue' },
  documentFeatures = {
    documentColor = true,
    documentFormatting = {
      defaultPrintWidth = 100
    },
    documentSymbol = true,
    foldingRange = true,
    linkedEditingRange = true,
    selectionRange = true
  },
  languageFeatures = {
    callHierarchy = true,
    codeAction = true,
    codeLens = true,
    completion = {
      defaultAttrNameCase = "kebabCase",
      defaultTagNameCase = "both"
    },
    definition = true,
    diagnostics = true,
    documentHighlight = true,
    documentLink = true,
    hover = true,
    implementation = true,
    references = true,
    rename = true,
    renameFileRefactoring = true,
    schemaRequestService = true,
    semanticTokens = false,
    signatureHelp = true,
    typeDefinition = true
  },
  typescript = {
    serverPath = ""
  }
}

return M
