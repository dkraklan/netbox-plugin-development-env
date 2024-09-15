from netbox.plugins import PluginConfig

print('test')
class NetBoxAccessListsConfig(PluginConfig):
    name = 'test_plugin'
    verbose_name = 'A test plugin'
    description = 'We be testing'
    version = '0.1'
    base_url = 'test-plugin'
    min_version = '3.4.0'


config = NetBoxAccessListsConfig


