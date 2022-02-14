## ``mos_mersec_deb` is a Family for `merOS-virt`


Based on **Debian**, **2 Targets** ( VMs ) comprised of a *whonix-like* <br> network configuration, provide a ***safe framework for research.***
___

### `mos_mersec-firewall`: Acts as a firewall VM- <br>

In nat NAT connection with the host network interface, <br> 
which accepts and forwards all ``TCP 80, 443` connections. <br>

Running only a `tor-daemon` with a single open port <br> 
it serves the isolated network `mos_mersec_priv`.

___

### `mos_mersec_deb-guest`: Acts as a guest VM- <br>

Bridged with ``mos_mersec_deb-firewall`, <br> 
and with a single SSH port exposed to the host,<br> 
it allows for an configurable and disposable Target.<br>

___

Networking is provided by ``libvirt` (@ `libvirt/net_*`) <br>
and routing and firewall options by `nftables` (@ `hooks/*`)

---

Connection to the ``guest` can be achieved with `-c|--connect` and/ or `--run` `mos_mersec_deb-guest`<br>

Internet access can be gained with `torsocks` via `proxychains.` <br>
These packages come **preinstalled** and **preconfigured** with the right `HOST:PORT` options. <br>

___

Target `rootfs` exploration is encouraged- <br>
since by design, the **configuration-tree is optimized for customization.**

---

## For more information check [merOS-virt](https://github.com/AranAilbhe/merOS-virt) on Github
