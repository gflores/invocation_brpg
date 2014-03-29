Handlebars.registerHelper("TEMPLATE", (templateName, options) ->
        new Handlebars.SafeString(Template[templateName].render(options.hash))
)