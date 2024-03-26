local M = {}

M.setup = function (opts)
    opts = opts or {}

    local phpunit = require('neotest-phpunit')(opts)

    local existing = phpunit.build_spec

    ---@param args neotest.RunArgs
    ---@return neotest.RunSpec | nil
    phpunit.build_spec = function (args)
        local spec = existing(args)

        local build_options = M.get_build_options(args)
        if build_options.volume then
            table.insert(spec.command, "--volume=" .. build_options.volume)
        end

        if build_options.container then
            table.insert(spec.command, "--container=" .. build_options.container)
        end

        if build_options.standalone then
            table.insert(spec.command, "--standalone")
        end

        -- Allows you to extend and customize the table
        if build_options.callback and type(build_options.callback) == "function" then
            spec = build_options.callback(spec, args)
        end

        return spec
    end

    return phpunit
end

M.get_build_options = function (opts)
    local conf = opts.docker_phpunit or {}

    local options = conf[vim.fn.getcwd()] or conf.default or {}

    return options
end

return M
