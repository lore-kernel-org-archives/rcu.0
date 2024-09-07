Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF3611E;
	Sat,  7 Sep 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725724237; cv=none; b=T0q4HswIiKe3fJTDML5/g0PdMe0TPhZm1iTM7r38W+jP7/ynAFoE5TRwSsXCKLhmyRVXKYXwP4Qsja8S5G7FBfCgrKHRg6Ui3YF5DIUa6LuqkuCmLzelByedFDKZUIZD/uyImKXKvBsezhdpDTsVA6WV28WbAI0yeT9npQeoSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725724237; c=relaxed/simple;
	bh=9j0jZudAi85KXJQrAp3wZodkOxCgmFaqX5ssAwXv6DM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVUIyw1RQEqF9apzivFeK6eXWDl241bHco+6i9igp6C07k9fwpEPZf9Ich1/D9xElZ1TiygbxM7B/PbfDJnIjKlLh/2F6g0zyErQthDowh6C+uXo+f4yyuofiIqRZIqwRKn87kGt3mTs2WmHj0ZttgbkVC44wbzpjJ4C9yipfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB53C4CEC2;
	Sat,  7 Sep 2024 15:50:35 +0000 (UTC)
Date: Sat, 7 Sep 2024 11:50:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hui Guo <guohui.study@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in lookup_object_or_alloc
Message-ID: <20240907115033.0b958acb@rorschach.local.home>
In-Reply-To: <CAHOo4gJf9ypMGwD74Qa1EPdf4US3uZHQNm7gptGtFzUFNP-LWw@mail.gmail.com>
References: <CAHOo4gJf9ypMGwD74Qa1EPdf4US3uZHQNm7gptGtFzUFNP-LWw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Sep 2024 15:15:06 +0800
Hui Guo <guohui.study@gmail.com> wrote:

> Hi Kernel Maintainers,
> we found a crash "general protection fault in lookup_object_or_alloc"
> in upstream, and reproduced it successfully, this bug is a KASAN.
>=20
> HEAD Commit: 88fac17500f4ea49c7bac136cf1b27e7b9980075(Merge tag
> 'fuse-fixes-6.11-rc7')
> kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBu=
gs/main/6.11.config
> console output:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/88fac17=
500f4ea49c7bac136cf1b27e7b9980075/1b5c18c216e3fa6127f8a798b4c2d1ca1a8ff56e/=
repro.log
>=20
> repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBug=
s/main/88fac17500f4ea49c7bac136cf1b27e7b9980075/1b5c18c216e3fa6127f8a798b4c=
2d1ca1a8ff56e/repro.report


> syz reproducer:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/88fac17=
500f4ea49c7bac136cf1b27e7b9980075/1b5c18c216e3fa6127f8a798b4c2d1ca1a8ff56e/=
repro.prog

This link looks like garbage to me.

>=20
>=20
> Please let me know if there is anything I can help.
> Best,
> Hui Guo
>=20
> This is the crash log I got by reproducing the bug based on the above
> environment=EF=BC=8C
> I have piped this log through decode_stacktrace.sh for better
> understand the cause of the bug.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [ 895.266222][ T84] Bluetooth: hci1: unexpected cc 0x0c03 length: 249 > 1
> [ 895.267926][ T84] Bluetooth: hci1: unexpected cc 0x1003 length: 249 > 9
> [ 895.269300][ T84] Bluetooth: hci1: unexpected cc 0x1001 length: 249 > 9
> [ 895.270998][ T84] Bluetooth: hci1: unexpected cc 0x0c23 length: 249 > 4
> [ 895.272912][ T84] Bluetooth: hci1: unexpected cc 0x0c25 length: 249 > 3
> [ 895.274413][ T84] Bluetooth: hci1: unexpected cc 0x0c38 length: 249 > 2
> [ 895.410150][T20127] chnl_net:caif_netlink_parms(): no params data found
> [ 895.494391][T20127] bridge0: port 1(bridge_slave_0) entered blocking st=
ate
> [ 895.495435][T20127] bridge0: port 1(bridge_slave_0) entered disabled st=
ate
> [ 895.496415][T20127] bridge_slave_0: entered allmulticast mode
> [ 895.498601][T20127] bridge_slave_0: entered promiscuous mode
> [ 895.501009][T20127] bridge0: port 2(bridge_slave_1) entered blocking st=
ate
> [ 895.501821][T20127] bridge0: port 2(bridge_slave_1) entered disabled st=
ate
> [ 895.502674][T20127] bridge_slave_1: entered allmulticast mode
> [ 895.503989][T20127] bridge_slave_1: entered promiscuous mode
> [ 895.551919][T20127] bond0: (slave bond_slave_0): Enslaving as an
> active interface with an up link
> [ 895.556437][T20127] bond0: (slave bond_slave_1): Enslaving as an
> active interface with an up link
> [ 895.607375][T20127] team0: Port device team_slave_0 added
> [ 895.609904][T20127] team0: Port device team_slave_1 added
> [ 895.646804][T20127] batman_adv: batadv0: Adding interface: batadv_slave=
_0
> [ 895.647620][T20127] batman_adv: batadv0: The MTU of interface
> batadv_slave_0 is too small (1500) to handle the transport of
> batman-adv packets. Packets going over this interface will be
> fragmented on layer2 which could impact the performance. Setting the
> MTU to 1560 would solve the problem.
> [ 895.650389][T20127] batman_adv: batadv0: Not using interface
> batadv_slave_0 (retrying later): interface not active
> [ 895.653411][T20127] batman_adv: batadv0: Adding interface: batadv_slave=
_1
> [ 895.654150][T20127] batman_adv: batadv0: The MTU of interface
> batadv_slave_1 is too small (1500) to handle the transport of
> batman-adv packets. Packets going over this interface will be
> fragmented on layer2 which could impact the performance. Setting the
> MTU to 1560 would solve the problem.
> [ 895.654516][ T84] Bluetooth: hci0: command tx timeout
> [ 895.659120][T20127] batman_adv: batadv0: Not using interface
> batadv_slave_1 (retrying later): interface not active
> [ 895.716645][T20127] hsr_slave_0: entered promiscuous mode
> [ 895.718562][T20127] hsr_slave_1: entered promiscuous mode
> [ 895.719871][T20127] debugfs: Directory 'hsr0' with parent 'hsr'
> already present!
> [ 895.720876][T20127] Cannot create hsr debugfs directory
> [ 896.281656][T20127] netdevsim netdevsim0 netdevsim0: renamed from eth0
> [ 896.286970][T20127] netdevsim netdevsim0 netdevsim1: renamed from eth1
> [ 896.291120][T20127] netdevsim netdevsim0 netdevsim2: renamed from eth2
> [ 896.295245][T20127] netdevsim netdevsim0 netdevsim3: renamed from eth3
> [ 896.346467][T20127] 8021q: adding VLAN 0 to HW filter on device bond0
> [ 896.356632][T20127] 8021q: adding VLAN 0 to HW filter on device team0
> [ 896.362049][T13908] bridge0: port 1(bridge_slave_0) entered blocking st=
ate
> [ 896.364148][T13908] bridge0: port 1(bridge_slave_0) entered forwarding =
state
> [ 896.378645][ T94] bridge0: port 2(bridge_slave_1) entered blocking state
> [ 896.379672][ T94] bridge0: port 2(bridge_slave_1) entered forwarding st=
ate
> [ 896.529186][T20127] 8021q: adding VLAN 0 to HW filter on device batadv0
> [ 896.562218][T20127] veth0_vlan: entered promiscuous mode
> [ 896.568608][T20127] veth1_vlan: entered promiscuous mode
> [ 896.590615][T20127] veth0_macvtap: entered promiscuous mode
> [ 896.594647][T20127] veth1_macvtap: entered promiscuous mode
> [ 896.605996][T20127] batman_adv: The newly added mac address
> (aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_0
> [ 896.607433][T20127] batman_adv: It is strongly recommended to keep
> mac addresses unique to avoid problems!
> [ 896.610055][T20127] batman_adv: batadv0: Interface activated: batadv_sl=
ave_0
> [ 896.619254][T20127] batman_adv: The newly added mac address
> (aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
> [ 896.620612][T20127] batman_adv: It is strongly recommended to keep
> mac addresses unique to avoid problems!
> [ 896.623110][T20127] batman_adv: batadv0: Interface activated: batadv_sl=
ave_1
> [ 896.628806][T20127] netdevsim netdevsim0 netdevsim0: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 896.629976][T20127] netdevsim netdevsim0 netdevsim1: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 896.631117][T20127] netdevsim netdevsim0 netdevsim2: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 896.632261][T20127] netdevsim netdevsim0 netdevsim3: set [1, 0] type
> 2 family 0 port 6081 - 0
> [ 896.664957][T13908] wlan0: Created IBSS using preconfigured BSSID
> 50:50:50:50:50:50
> [ 896.666031][T13908] wlan0: Creating new IBSS network, BSSID 50:50:50:50=
:50:50
> [ 896.681078][ T94] wlan1: Created IBSS using preconfigured BSSID
> 50:50:50:50:50:50
> [ 896.682143][ T94] wlan1: Creating new IBSS network, BSSID 50:50:50:50:5=
0:50
> [ 896.757800][T21163] loop0: detected capacity change from 0 to 8192
> [ 896.761428][T21163] REISERFS warning: read_super_block: reiserfs
> filesystem is deprecated and scheduled to be removed from the kernel
> in 2025
> [ 896.762881][T21163] REISERFS (device loop0): found reiserfs format

Not related to this, but isn't REISERFS deprecated?=20

> "3.6" with non-standard journal
> [ 896.763940][T21163] REISERFS (device loop0): using ordered data mode
> [ 896.765414][T21163] reiserfs: using flush barriers
> [ 896.767165][T21163] REISERFS (device loop0): journal params: device
> loop0, size 512, journal first block 18, max trans len 256, max batch
> 225, max commit age 30, max trans age 30
> [ 896.769284][T21163] REISERFS (device loop0): checking transaction log (=
loop0)
> [ 896.797612][T21163] REISERFS (device loop0): Using rupasov hash to sort=
 names
> [ 896.804299][ C4] Oops: general protection fault, probably for
> non-canonical address 0xe0923c44e0000428: 0000 [#1] PREEMPT SMP KASAN
> NOPTI
> [ 896.804311][ C7]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 896.804329][ C7] BUG: KASAN: stack-out-of-bounds in rb_insert_color
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/rbtree.c:110
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/rbtree.c:436)
> [ 896.805996][ C4] KASAN: maybe wild-memory-access in range
> [0x0492022700002140-0x0492022700002147]
> [ 896.806014][ C4] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G W
> 6.11.0-rc6-00026-g88fac17500f4-dirty #1
> [ 896.807075][ C7] Read of size 8 at addr ffffc9001272f5a8 by task swappe=
r/7/0
> [ 896.808070][ C4] Tainted: [W]=3DWARN
> [ 896.808076][ C4] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [ 896.809288][ C7]
> [ 896.810710][ C4] RIP: 0010:debug_object_deactivate
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobject=
s.c:196
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobjects=
.c:766)
> [ 896.811681][ C7] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G W
> 6.11.0-rc6-00026-g88fac17500f4-dirty #1
> [ 896.812076][ C4] Code: 00 00 48 8b 9b 60 05 73 94 45 31 e4 48 85 db
> 74 44 49 be 00 00 00 00 00 fc ff df 48 8d 7b 18 41 83 c4 01 48 89 f8
> 48 c1 e8 03 <42> 80 3c 30 00 0f 85 58 01 00 00 4c 3b 6b 18 74 4b 48 89
> d8 48 c1
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
> 0: 00 00 add %al,(%rax)
> 2: 48 8b 9b 60 05 73 94 mov -0x6b8cfaa0(%rbx),%rbx
> 9: 45 31 e4 xor %r12d,%r12d
> c: 48 85 db test %rbx,%rbx
> f: 74 44 je 0x55
> 11: 49 be 00 00 00 00 00 movabs $0xdffffc0000000000,%r14
> 18: fc ff df
> 1b: 48 8d 7b 18 lea 0x18(%rbx),%rdi
> 1f: 41 83 c4 01 add $0x1,%r12d
> 23: 48 89 f8 mov %rdi,%rax
> 26: 48 c1 e8 03 shr $0x3,%rax
> 2a:* 42 80 3c 30 00 cmpb $0x0,(%rax,%r14,1) <-- trapping instruction
> 2f: 0f 85 58 01 00 00 jne 0x18d
> 35: 4c 3b 6b 18 cmp 0x18(%rbx),%r13
> 39: 74 4b je 0x86
> 3b: 48 89 d8 mov %rbx,%rax
> 3e: 48 rex.W
> 3f: c1 .byte 0xc1
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 0: 42 80 3c 30 00 cmpb $0x0,(%rax,%r14,1)
> 5: 0f 85 58 01 00 00 jne 0x163
> b: 4c 3b 6b 18 cmp 0x18(%rbx),%r13
> f: 74 4b je 0x5c
> 11: 48 89 d8 mov %rbx,%rax
> 14: 48 rex.W
> 15: c1 .byte 0xc1
> [ 896.813251][ C7] Tainted: [W]=3DWARN
> [ 896.813563][ C4] RSP: 0018:ffffc90000b80d40 EFLAGS: 00010016
> [ 896.814326][ C3] ------------[ cut here ]------------
> [ 896.814342][ C3] ODEBUG: active_state not available (active state 0)
> object: ffff88801fbb42d0 object type: rcu_head hint: 0x0

I'm guessing that the above is something that registered its object to
RCU but then freed it before waiting for RCU to synchronize. In other
words, we don't know what caused the bug.

You may need to enable RCU and kmem trace events and
ftrace_dump_on_oops to see the events that lead up to this crash. If I
had my persistent ring buffer upstream (next merge window), we could
get the trace from that and not wait for ftrace_dump_on_oops to finish.
You will likely want to make a smaller buffer before the crash:

 echo 500 > /sys/kernel/tracing/buffer_size_kb

-- Steve

> [ 896.814371][ C7] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [ 896.814869][ C3] WARNING: CPU: 3 PID: 0 at lib/debugobjects.c:515
> debug_print_object
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobject=
s.c:515)
> [ 896.814891][ C3] Modules linked in:
> [ 896.814903][ C3] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Tainted: G W
> 6.11.0-rc6-00026-g88fac17500f4-dirty #1
> [ 896.814919][ C3] Tainted: [W]=3DWARN
> [ 896.814923][ C3] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [ 896.814930][ C3] RIP: 0010:debug_print_object
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobject=
s.c:515)
> [ 896.814944][ C3] Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00
> 75 51 48 8b 14 dd 40 78 4a 8b 41 56 4c 89 e6 48 c7 c7 a0 6b 4a 8b e8
> ef 26 0c fd <0f> 0b 58 83 05 59 a5 5e 0b 01 48 83 c4 18 5b 5d 41 5c 41
> 5d 41 5e
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
> 0: 00 fc add %bh,%ah
> 2: ff (bad)
> 3: df 48 89 fisttps -0x77(%rax)
> 6: fa cli
> 7: 48 c1 ea 03 shr $0x3,%rdx
> b: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1)
> f: 75 51 jne 0x62
> 11: 48 8b 14 dd 40 78 4a mov -0x74b587c0(,%rbx,8),%rdx
> 18: 8b
> 19: 41 56 push %r14
> 1b: 4c 89 e6 mov %r12,%rsi
> 1e: 48 c7 c7 a0 6b 4a 8b mov $0xffffffff8b4a6ba0,%rdi
> 25: e8 ef 26 0c fd call 0xfffffffffd0c2719
> 2a:* 0f 0b ud2 <-- trapping instruction
> 2c: 58 pop %rax
> 2d: 83 05 59 a5 5e 0b 01 addl $0x1,0xb5ea559(%rip) # 0xb5ea58d
> 34: 48 83 c4 18 add $0x18,%rsp
> 38: 5b pop %rbx
> 39: 5d pop %rbp
> 3a: 41 5c pop %r12
> 3c: 41 5d pop %r13
> 3e: 41 5e pop %r14
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 0: 0f 0b ud2
> 2: 58 pop %rax
> 3: 83 05 59 a5 5e 0b 01 addl $0x1,0xb5ea559(%rip) # 0xb5ea563
> a: 48 83 c4 18 add $0x18,%rsp
> e: 5b pop %rbx
> f: 5d pop %rbp
> 10: 41 5c pop %r12
> 12: 41 5d pop %r13
> 14: 41 5e pop %r14
> [ 896.814957][ C3] RSP: 0018:ffffc90000b28d18 EFLAGS: 00010282
> [ 896.814966][ C3] RAX: 0000000000000000 RBX: 0000000000000005 RCX:
> ffffffff814d11f6
> [ 896.814973][ C3] RDX: ffff8881406e9cc0 RSI: ffffffff814d1203 RDI:
> 0000000000000001
> [ 896.814981][ C3] RBP: 0000000000000001 R08: 0000000000000001 R09:
> ffffed1047795179
> [ 896.814988][ C3] R10: 0000000000000000 R11: 3a746e6968206461 R12:
> ffffffff8b4a7100
> [ 896.814996][ C3] R13: ffffffff8aee4940 R14: 0000000000000000 R15:
> ffffc90000b28dd8
> [ 896.815006][ C3] FS: 0000000000000000(0000)
> GS:ffff88823bc80000(0000) knlGS:0000000000000000
> [ 896.815019][ C3] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 896.815027][ C3] CR2: 00007fc4bf0756f4 CR3: 000000002fb5a000 CR4:
> 00000000000006f0
> [ 896.815035][ C3] Call Trace:
> [ 896.815040][ C3] <IRQ>
> [ 896.815045][ C3] ? show_regs
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel=
/dumpstack.c:479)
> [ 896.815062][ C3] ? __warn
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/panic.c:=
741)
> [ 896.815074][ C3] ? debug_print_object
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobject=
s.c:515)
> [ 896.815086][ C3] ? report_bug
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/bug.c:201
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/bug.c:219)
> [ 896.815106][ C3] ? debug_print_object
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobject=
s.c:515)
> [ 896.815118][ C3] ? handle_bug
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel=
/traps.c:239)
> [ 896.815135][ C3] ? exc_invalid_op
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel=
/traps.c:260
> (discriminator 1))
> [ 896.815150][ C3] ? asm_exc_invalid_op
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/incl=
ude/asm/idtentry.h:621)
> [ 896.815167][ C3] ? __warn_printk
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux=
/context_tracking.h:155
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/panic.c:7=
90)
> [ 896.815178][ C3] ? __warn_printk
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/panic.c:=
781)
> [ 896.815189][ C3] ? debug_print_object
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobject=
s.c:515)
> [ 896.815201][ C3] ? debug_print_object
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobject=
s.c:515)
> [ 896.815226][ C3] ? trace_irq_enable.constprop.0
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/trace=
/events/preemptirq.h:40)
> [ 896.815241][ C3] debug_object_active_state
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobject=
s.c:955)
> [ 896.815255][ C3] ? __pfx_debug_object_active_state
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/lib/debugobject=
s.c:926)
> [ 896.815269][ C3] ? trace_irq_enable.constprop.0
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/trace=
/events/preemptirq.h:40)
> [ 896.815281][ C3] ? rcu_is_watching
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux=
/context_tracking.h:122
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/rcu/tree.=
c:726)
> [ 896.815296][ C3] rcu_core
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/rcu/rcu.=
h:239
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/rcu/tree.=
c:2561
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/rcu/tree.=
c:2843)
> [ 896.815310][ C3] ? __pfx_rcu_core
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/rcu/tree=
.c:2790)
> [ 896.815324][ C3] handle_softirqs
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/incl=
ude/asm/jump_label.h:27
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/=
jump_label.h:207
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/trace/=
events/irq.h:142
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/softirq.c=
:555)
> [ 896.815342][ C3] irq_exit_rcu
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/softirq.=
c:589
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/softirq.c=
:428
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/softirq.c=
:637
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/softirq.c=
:649)
> [ 896.815357][ C3] sysvec_apic_timer_interrupt
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel=
/apic/apic.c:1043
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/=
apic/apic.c:1043)
> [ 896.815371][ C3] </IRQ>
> [ 896.815374][ C3] <TASK>
> [ 896.815378][ C3] asm_sysvec_apic_timer_interrupt
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/incl=
ude/asm/idtentry.h:702)
> [ 896.815392][ C3] RIP: 0010:default_idle
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/incl=
ude/asm/irqflags.h:37
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/inclu=
de/asm/irqflags.h:92
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/=
process.c:743)
> [ 896.815408][ C3] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 0f 1f 44 00 00 eb 0c 0f 1f 44 00 00 0f 00 2d 9d aa 49 00 0f 1f 44
> 00 00 fb f4 <fa> c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 90
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
> 0: 90 nop
> 1: 90 nop
> 2: 90 nop
> 3: 90 nop
> 4: 90 nop
> 5: 90 nop
> 6: 90 nop
> 7: 90 nop
> 8: 90 nop
> 9: 90 nop
> a: 90 nop
> b: 90 nop
> c: 90 nop
> d: 90 nop
> e: 90 nop
> f: 90 nop
> 10: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
> 15: eb 0c jmp 0x23
> 17: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
> 1c: 0f 00 2d 9d aa 49 00 verw 0x49aa9d(%rip) # 0x49aac0
> 23: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
> 28: fb sti
> 29: f4 hlt
> 2a:* fa cli <-- trapping instruction
> 2b: c3 ret
> 2c: cc int3
> 2d: cc int3
> 2e: cc int3
> 2f: cc int3
> 30: 90 nop
> 31: 90 nop
> 32: 90 nop
> 33: 90 nop
> 34: 90 nop
> 35: 90 nop
> 36: 90 nop
> 37: 90 nop
> 38: 90 nop
> 39: 90 nop
> 3a: 90 nop
> 3b: 90 nop
> 3c: 90 nop
> 3d: 90 nop
> 3e: 90 nop
> 3f: 90 nop
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 0: fa cli
> 1: c3 ret
> 2: cc int3
> 3: cc int3
> 4: cc int3
> 5: cc int3
> 6: 90 nop
> 7: 90 nop
> 8: 90 nop
> 9: 90 nop
> a: 90 nop
> b: 90 nop
> c: 90 nop
> d: 90 nop
> e: 90 nop
> f: 90 nop
> 10: 90 nop
> 11: 90 nop
> 12: 90 nop
> 13: 90 nop
> 14: 90 nop
> 15: 90 nop
> [ 896.815418][ C3] RSP: 0018:ffffc900001c7e00 EFLAGS: 00000246
> [ 896.815427][ C3] RAX: 0000000000097df4 RBX: 0000000000000003 RCX:
> ffffffff8a9cc644
> [ 896.815435][ C3] RDX: ffffed1047796fe2 RSI: 0000000000000000 RDI:
> ffffffff81623441
> [ 896.815442][ C3] RBP: dffffc0000000000 R08: 0000000000000000 R09:
> ffffed1047796fe1
> [ 896.815449][ C3] R10: ffff88823bcb7f0b R11: 0000000000000000 R12:
> 0000000000000003
> [ 896.815456][ C3] R13: ffffffff8f9f5e18 R14: 0000000000000000 R15:
> 0000000000000000
> [ 896.815466][ C3] ? ct_kernel_exit
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/context_=
tracking.c:148
> (discriminator 9))
> [ 896.815480][ C3] ? do_idle
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/sched/id=
le.c:186
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/sched/idl=
e.c:326)
> [ 896.815493][ C3] default_idle_call
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux=
/cpuidle.h:143
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/sched/idl=
e.c:118)
> [ 896.815508][ C3] do_idle
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/sched/id=
le.c:186
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/sched/idl=
e.c:326)
> [ 896.815519][ C3] ? __pfx_do_idle
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/sched/id=
le.c:253)
> [ 896.815530][ C3] ? do_idle
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/sched/id=
le.c:253)
> [ 896.815541][ C3] cpu_startup_entry
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/sched/id=
le.c:423
> (discriminator 1))
> [ 896.815552][ C3] start_secondary
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel=
/smpboot.c:201
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/=
smpboot.c:281)
> [ 896.815566][ C3] ? __pfx_start_secondary
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel=
/smpboot.c:231)
> [ 896.815580][ C3] common_startup_64
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel=
/head_64.S:421)
> [ 896.815594][ C3] </TASK>
> [ 896.815600][ C3] Kernel panic - not syncing: kernel: panic_on_warn set =
...
> [ 897.894182][ C3] Shutting down cpus with NMI
> [ 897.943852][ C3] Kernel Offset: disabled
> [ 897.944349][ C3] Rebooting in 86400 seconds..

