#!/usr/bin/python3
import dbus
import dbus.service
import dbus.mainloop.glib
from gi.repository import GLib

DBUS_NAME = 'xyz.openbmc_project.State.Host'
DBUS_PATH = '/xyz/openbmc_project/state/host0'

class Host0(dbus.service.Object):
    def __init__(self, bus):
        super().__init__(bus, DBUS_PATH)
        self.current_state = "xyz.openbmc_project.State.Host.HostState.Running"

    @dbus.service.method(dbus.PROPERTIES_IFACE, in_signature='ss', out_signature='v')
    def Get(self, interface_name, property_name):
        if interface_name != "xyz.openbmc_project.State.Host":
            raise dbus.exceptions.DBusException("Unknown interface")
        if property_name == "CurrentHostState":
            return self.current_state
        raise dbus.exceptions.DBusException("Unknown property")

    @dbus.service.method(dbus.PROPERTIES_IFACE, in_signature='s', out_signature='a{sv}')
    def GetAll(self, interface_name):
        if interface_name == "xyz.openbmc_project.State.Host":
            return {"CurrentHostState": self.current_state}
        return {}

    @dbus.service.method("xyz.openbmc_project.State.Host", in_signature='s')
    def RequestHostTransition(self, transition):
        # 这里可以随便打印一下，实际开发时再实现真正的开机关机逻辑
        print(f"Requested transition: {transition}")

dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
bus = dbus.SystemBus()

# 抢占名字（如果已经有同名的会失败，但开发环境一般没有）
name = dbus.service.BusName(DBUS_NAME, bus)

Host0(bus)
print(f"Mock {DBUS_PATH} 已成功挂上 D-Bus，CurrentHostState = Running")
GLib.MainLoop().run()

# busctl tree xyz.openbmc_project.State.Host