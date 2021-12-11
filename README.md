### mos_mersec is a Family-Template for merOS-virt.

Based on **Debian**, **2 Targets** ( VMs ) comprised of a *whonix-like* <br> configuration, provide a **safe framework for research.**

**mos-fw: Acts as a firewall VM.** <br>
NATed with the host network interface, running only a tor-daemon,
with a single open port, it serves the isolated network, as described in

**mos-guest: Acts as a guest VM.** <br>
Bridged with *mos-fw*, and with a single SSH port exposed to the host, <br>
it allows for an easily-reproducible, configurable and disposable VM.
