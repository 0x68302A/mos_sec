## `mos_sec` is a Family for `merOS-virt`


Based on **Debian**, **2 Targets** ( VMs ) comprised of a *whonix-like* <br> network configuration, provide a ***safe framework for research.***
___

### `mos_sec-firewall` :: Acts as a firewall VM- <br>

In NAT connection with the host network, <br> 
 **accepts all** all `TCP 80, 443` connections. <br>

Running only a `tor-daemon` with a **single open port,** <br> 
it serves the isolated network `mos_sec_priv`.

___

### `mos_sec-guest` :: Acts as a guest VM- <br>

Bridged with `mos_sec-firewall`, <br> 
with a single SSH port exposed to the host,<br> 
it allows for an configurable, accessible and disposable Target.<br>

___

Networking is provided by `libvirt` (@ `libvirt/net_*`) <br>
and routing and firewall options by `nftables` (@ `hooks/*`)

---

Connection to the `guest` can be achieved with `-c|--connect` and/ or `--run` `mos_sec-guest`<br>

Internet access from within- <br>
can be gained with `torsocks` via `proxychains.` <br>

These packages come **preinstalled** and **preconfigured** with the right `HOST:PORT` options. <br>

___

Configuration files exploration is **encouraged**,
since by design- <br> 
The **Configuration-Tree is optimized for Customization.**

---

## For more information check [merOS-virt](https://github.com/AranAilbhe/merOS-virt) on Github
