# Neotest Docker PHPUnit nvim plugin
Run phpunit tests in the docker container. This plugin extends the [ neotest-phpunit ]( https://github.com/olimorris/neotest-phpunit ) plugin and execute the test in the specified dokcer container.

## Installation
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
Configure your neovim neotest-phpunit to use this binary instead of phpunit
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
 - [ ] Improve document
