[# netbox-plugin-development-env


When developing NetBox plugins having an easily reproducible dev enviroment can be difficult. This project will provide a Docker container pre configured with NetBox and will automatically reload when changes are detected with the plugin you are working on.

## Install

### Quickstart
```
git clone git@github.com:dkraklan/netbox-plugin-development-env.git
make build
make run
```
You will now have a local instance of netbox runinng on http://127.0.0.1:8000 , username and password are defiend in the `netbox.env`file.

To customize the installation edit the env file for some common options, you can also expand the `configuration.py` file. It comes pre-loaded with a test-plugin to demonstrate how it works. To get it working with your plugin you can make a new directory in the root of the project. Clone your plugin into this, edit `configuration.py` and add your plugin. Then simply `make build` and `make run`.

## Notes

This was developed primarily around my workflow which is in neovim. With the venv being built inside the docker container your IDE won't have access to the modules and won't have auto completion for them. To get around this I created an option in the make file `make venv` this will build the venv and install all required modules. To get this working with PyRight create a `pyrightconfig.json` file in the root of the project.
```
{
    "extraPaths": [
        "netbox/venv/lib/python3.10/site-packages",
        "netbox/netbox/netbox",
        "netbox_dev/netbox/netbox"
    ]
}
```


## Credits
I combined a few different development setups I saw from other plugins as well as some of the scripts from the official docker image.

[Netbox Docker](https://github.com/netbox-community/netbox-docker)

[netbox-config-diff](https://github.com/miaow2/netbox-config-diff/tree/develop)

[netbox-acls](https://github.com/netbox-community/netbox-acls/)
