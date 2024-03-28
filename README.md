# Neotest Docker PHPUnit nvim plugin
To execute phpunit tests within a docker container, utilize this plugin an extension of the [ neotest-phpunit ]( https://github.com/olimorris/neotest-phpunit ) plugin. This facilitates the seamless execution of tests within the specified dokcer container environment.

## Installation
Based on your ideal preferances, install with any package manager as shown below

### Install the binary from cargo
```zsh
cargo install neotest-docker-phpunit
```

### Install from the source
```zsh
git clone https://github.com/praem90/neotest-docker-phpunit.git
cd neotest-docker-phpunit
cargo build
```

### Install nvim plugin using Plug
```zsh
Plug 'nvim-neotest/neotest'
Plug 'olimorris/neotest-phpunit'
Plug 'praem90/neotest-docker-phpunit.nvim'
```

## Configuration
Configure your neovim neotest-phpunit plugin to utilize an alternative binary, replacing the default phpunit executable.
```lua
require('neotest').setup({
    adapters = {
        require('neotest-docker-phpunit')({
            phpunit_cmd = "{PATH_TO}/neotest-docker-phpunit",
            docker_phpunit = {
                "/home/user/projects/another/project" = {
                    container   = "phpunit-debug",
                    volume      = "/home/user/projects/another/project:/docker/work/dir"
                    standalone  = true,
                }
                default = {
                    container   = "phpunit",
                    volume      = "/source/dir:/docker/work/dir"
                    standalone  = false,
                    callback    = function (spec, args)
                        return spec
                    end
                }
            }
        }),
    }
})
```

## TODO
 - [ ] Improve STDOUT
 - [ ] Improve document
