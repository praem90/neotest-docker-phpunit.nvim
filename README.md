# Neotest Docker PHPUnit nvim plugin
Run phpunit tests in the docker container. This plugin extends the (neotest-phpunit)[https://github.com/olimorris/neotest-phpunit] plugin and execute the test in the specified dokcer container.

## Installation
Install from source
```zsh
git clone https://github.com/praem90/phpunit-docker-test.git
cd phpunit-docker-test
cargo build
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

