## Neotest Docker PHPUnit
To execute phpunit tests within a docker container, utilize this plugin an extension of the [ neotest-phpunit ]( https://github.com/olimorris/neotest-phpunit ) plugin.
This facilitates the seamless execution of tests within the specified dokcer container environment.

## Why
Neotest provides a nice and fluent api and ux to run unit tests from neovim.
Using the neotest-phpunit adapter you can run unit tests which runs on your host machine. It does not support docker yet.
So I've decided to create an adapter to run PHPUnit tests in the docker container or add support for the docker.

## Challenges
When it comes to docker, most projects uses docker compose. We can run tests on standalone containers too.
PHPUnit test results were stored in a xml file and the neovim parses it to present the report in the UI.
But sometimes the docker work dir could be different.

## Solution
So I've decided to create a simple cli tool interact with the docker and phpunit.
Since the neotest-phpunit done most of the part except the docker support, I wanted to reuse it instead of
reinvent the whole adapter.
To run a test, neotest-phpunit adds the `log-junit` the report file tmp path and the `filter` options to the phpunit binary.

The `log-junit` wont be available on the host machine if the tests were executed in the docker.
So,once the tests were executed, the results must be exported to the host machine.
Along with these added below the the options to the binary

 1. `--container` The container name
 2. `--standalone` Whether the docker compose or standalone container
 3. `--volume` To map the work directory from host machine to the container as like as a docker volume option

 I've created the cli tool [ neotest-docker-phpunit ]( https://github.com/praem90/neotest-docker-phpunit ) to interact with the docker and export the result xml file into the host machine.

 So this plugin depends on both the neotest-phpunit adapter the [ neotest-docker-phpunit ]( https://github.com/praem90/neotest-docker-phpunit ) cli tool

## Neovim plugin
This plugin accepts all the options provided by the neotest-phpunit and neotest plugins.
I wanted to provide additional configuration to map working directory for each project since the working may differ on each project.
Also you can add a default config as a fallback

## Example
```lua
require('neotest').setup({
    adapters = {
        -- require('neotest-pest'),
        require('neotest-docker-phpunit').setup({
            phpunit_cmd = "neotest-docker-phpunit",
            "/path/to/other/project/" = {
                default = {
                    container = "phpunit",
                    volume = "/path/to/other/project/:/path/to/container/path",
                    standalone = true,
                }
            },
            docker_phpunit = {
                default = {
                    container = "php",
                    volume = "/path/to/your/project/:/path/to/container/path",
                    -- You can optionally map the parameters if you want to customize more
                    callback = function (spec, arg)
                        return spec
                    end
                }
            }
        }),
        require("neotest-go"),
    },
    diagnostic = {
        enabled = true
    }
})
```

