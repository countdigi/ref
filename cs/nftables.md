# Nftables

<http://netfilter.org/projects/nftables/>

List the ruleset:
```bash
nft list ruleset
```

Persist the ruleset:
```bash
nft list ruleset > /etc/nftables.conf
```

Enable/Start the nftables service:
```bash
systemctl enable nftables.service
systemctl start nftables.service
```

Tables contain Chains, Chains contain Rules

```bash
nft add chain family table chain "{ type type hook hook priority priority; }"
```

```
nft add chain [<family>] <table-name> <chain-name> \
  "{ type <type> hook <hook> priority <value> ; [policy <policy>] }"
```

Tables can have one of five families specified:
- `ip` (iptables)
- `ip6` (ip6tables)
- `inet` (iptables and ip6tables)
- `arp` (arptables)
- `bridge` (ebtables)

Base chain types:
- `filter` - used to filter packets. This is supported by the arp, bridge, ip, ip6 and inet table families.
- `route` - used to reroute packets if any relevant IP header field or the packet mark is modified. If you are familiar with iptables, this chain type provides equivalent semantics to the mangle table but only for the output hook (for other hooks use type filter instead). This is supported by the ip and ip6 table families.
- `nat` - used to perform Networking Address Translation (NAT). The first packet that belongs to a flow always hits this chain, follow up packets not. Therefore, never use this chain for filtering. This is supported by the ip and ip6 table families.

Base chain hooks:
- `prerouting` - the routing decision for those packets didn't happen yet, so you don't know if they are addressed to the local or remote systems.
- `input` - It happens after the routing decision, you can see packets that are directed to the local system and processes running in system.
- `forward` - It also happens after the routing decision, you can see packet that are not directed to the local machine.
- `output` - to catch packets that are originated from processes in the local machine.
- `postrouting` - After the routing decision for packets leaving the local system.
- `ingress` - (only available at the netdev family): Since Linux kernel 4.2, you can filter traffic way before prerouting, after the packet is passed up from the NIC driver. So you have an alternative to tc.
