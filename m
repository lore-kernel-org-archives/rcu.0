Received: from mail.ams.netpunt.systems (mail.ams.netpunt.systems [178.62.236.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1391CEC2
	for <rcu@vger.kernel.org>; Tue,  5 Mar 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.236.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649171; cv=none; b=NjqAJ1koc9pZHxfhQVHKhm6pe021q1TlRgP7H1A8H/bQUa7LTRWG55ndTD9NlZjZf1zpR0OZFFg71ssLPGAWigv7/j6H2482eSyXFMfPgu/7X7w0KFbIlsiGYCK2kPp15XFmR0uT5n5ejVuR8q+dOYYcazLTCzzxTOEpo5xke8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649171; c=relaxed/simple;
	bh=7unoQV74f2vxm8Av9Ud1M0tmFtILxICJctdzZoUlNHI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dtExRcRx0+md97ok6c7rduI8oMid0TmATUQdgVZc4myJVn2aUkN721Ac/7JbKd9741748xipjEtUne5ITuI6mNYj/rkVTQRfYoQKhAq0OOWixUpz5yvzTR7zZKfg2dK8yXE5Ye/T5K8vkLxaOUKXzP7Ynqz0S7Igao94UvoqGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxboone.com; spf=pass smtp.mailfrom=maxboone.com; dkim=fail (2048-bit key) header.d=maxboone.com header.i=@maxboone.com header.b=D9m4oo77 reason="signature verification failed"; arc=none smtp.client-ip=178.62.236.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxboone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxboone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=maxboone.com header.i=@maxboone.com header.b="D9m4oo77"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91354AE80C;
	Tue,  5 Mar 2024 15:32:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxboone.com;
	s=dkim; t=1709649164;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KbKGtOw6mp1EVnPn93fawFRoXFdO8Cjp1XTweC7/xkw=;
	b=D9m4oo77WfbkW2KTBmbiDyqQG7HCwPt2MVaSIGDgbgFZIRNjEhFgygGYoJT3mH3lmj3iZq
	LxMjWH79vDigUr1w7mSxX/q3DBBbYm1Da4Xg7EL2YnOtzSzjVA3ECYYif4wUooxi2i4+ga
	2hV8ool/0nYGMGcmzUqiAjGrmn2QJvU30iPB745xO2so8MH9BXxg5tk+lhTwvD2w0CdOf0
	j5xyKaDqGKpXqOtZDABE/zVMx6TsphJpwJ0QuY91aKPhz3xDrIVKovaYP4XUnbr58BGozb
	AOkALUPNv9WakFv3j2BeNy4iWhnzU4U/+7sf+nT9NMizuLdwH4TgYqotvjCLGA==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 14:32:44 +0000
Message-Id: <CZLW1RFSY649.1B7IZKT83LY3W@maxboone.com>
Cc: <rcu@vger.kernel.org>
Subject: Re: Advice sought on RCU stalls on ARM64 WSL2
From: "Max Boone" <contact@maxboone.com>
To: "Max Boone" <contact@maxboone.com>, "Joel Fernandes"
 <joel@joelfernandes.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Paul E.
 McKenney" <paulmck@kernel.org>
References: <1a5d96d6-2057-44d9-a4b0-8771c46032fb@paulmck-laptop>
 <3718bb-65e38400-d-5cd53080@68830111>
 <99a0fb2c-c936-405f-85bf-847c61531bd5@paulmck-laptop>
 <ZeX327aMIrthOXbs@Boquns-Mac-mini.home>
 <CZLATSBV6XDH.2WUG4D8VJHEQ5@maxboone.com>
 <807b26d4-b55f-4b5e-932e-1252e1ff2446@joelfernandes.org>
 <CZLL3BA2G8O8.1M5NNUFKOJDY6@maxboone.com>
In-Reply-To: <CZLL3BA2G8O8.1M5NNUFKOJDY6@maxboone.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Mar 5, 2024 at 5:57 AM UTC, Max Boone wrote:
> On Tue Mar 5, 2024 at 12:32 AM UTC, Joel Fernandes wrote:
> > Have you tried to reproduce the issue with CONFIG_RSEQ=3Dn and see if i=
t happens?
>
> Will build a new kernel today with that flag, and report back.

With CONFIG_RSEQ=3Dn the stalls happen a lot less often, the system is
way more workable and when it does freeze up it recovered on its own
once, and I was able to get the full kernel messages for this:

```
[  675.812339] rcu: INFO: rcu_sched self-detected stall on CPU
[  675.814587] rcu:     3-....: (14893 ticks this GP) idle=3D762c/1/0x40000=
00000000000 softirq=3D6920/6920 fqs=3D6610
[  675.815606] rcu:     (t=3D15001 jiffies g=3D50497 q=3D1304 ncpus=3D8)
[  675.816520] CPU: 3 PID: 232 Comm: snapfuse Not tainted 6.7.7-WSL2-STABLE=
+ #2
[  675.816550] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  675.816553] pc : __arch_copy_to_user+0x1a0/0x240
[  675.817689] lr : _copy_to_iter+0xf0/0x560
[  675.818069] sp : ffff800082ceba80
[  675.818070] x29: ffff800082cebac0 x28: 0000000001b2c000 x27: 00000000000=
00005
[  675.818074] x26: 0000000000000000 x25: ffff00004c491000 x24: 00000000000=
00000
[  675.818076] x23: 0000000000001000 x22: 0000040000000000 x21: ffff800082c=
ebd30
[  675.818079] x20: ffff800082cebd30 x19: 0000000000001000 x18: 00000000000=
00000
[  675.818081] x17: 0000000000000000 x16: 0000000000000000 x15: ffff00004c4=
91000
[  675.818083] x14: 9887db4ae914c054 x13: 6bcd444ce14effe5 x12: 0b22b481c60=
01041
[  675.818086] x11: 7513c0250d7df247 x10: b85affa4063b12c7 x9 : 368beb85bc6=
48557
[  675.818088] x8 : 217c88df9795370e x7 : a16d77942052b4ab x6 : 0000aaf8445=
16fff
[  675.818090] x5 : 0000aaf844517e2f x4 : 0000000000000000 x3 : 00000000000=
03daf
[  675.818092] x2 : 0000000000000dc0 x1 : ffff00004c491210 x0 : 0000aaf8445=
16e2f
[  675.818096] Call trace:
[  675.818143]  __arch_copy_to_user+0x1a0/0x240
[  675.818147]  copy_page_to_iter+0xbc/0x140
[  675.818150]  filemap_read+0x1b0/0x398
[  675.818427]  generic_file_read_iter+0x48/0x168
[  675.818429]  ext4_file_read_iter+0x58/0x288
[  675.818681]  vfs_read+0x1e8/0x280
[  675.818804]  ksys_pread64+0x90/0xf0
[  675.818806]  __arm64_sys_pread64+0x24/0x48
[  675.818807]  invoke_syscall.constprop.0+0x54/0x128
[  675.818912]  do_el0_svc+0x44/0xf0
[  675.818914]  el0_svc+0x24/0xb0
[  675.819041]  el0t_64_sync_handler+0x138/0x148
[  675.819043]  el0t_64_sync+0x14c/0x150
[  681.501178] block sda: the capability attribute has been deprecated.
[  741.700330] rcu: INFO: rcu_sched self-detected stall on CPU
[  741.701707] rcu:     4-....: (14940 ticks this GP) idle=3D8074/1/0x40000=
00000000000 softirq=3D13021/13037 fqs=3D6400
[  741.703152] rcu:     (t=3D15001 jiffies g=3D50713 q=3D5093 ncpus=3D8)
[  741.704017] CPU: 4 PID: 194 Comm: systemd-journal Not tainted 6.7.7-WSL2=
-STABLE+ #2
[  741.704047] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  741.704050] pc : __arch_copy_to_user+0x190/0x240
[  741.704424] lr : _copy_to_iter+0xf0/0x560
[  741.704565] sp : ffff800082cfb870
[  741.704566] x29: ffff800082cfb8b0 x28: ffff00000fe96b18 x27: 00000000000=
00085
[  741.704569] x26: 0000000000000000 x25: ffff0000061e1c00 x24: 00000000000=
00000
[  741.704571] x23: 0000000000000085 x22: ffff000117d2a600 x21: ffff800082c=
fbd90
[  741.704574] x20: ffff0000061e1c00 x19: 0000000000000085 x18: 00000000000=
00000
[  741.704608] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0000061=
e1c00
[  741.704610] x14: 62616c6961766120 x13: 7365746164707520 x12: 6f6e2073616=
82070
[  741.704612] x11: 616e73203a687365 x10: 7266657220746f6e x9 : 6e6163203a3=
13937
[  741.704614] x8 : 3a6f672e73726570 x7 : 6c656865726f7473 x6 : 0000ab58c96=
fd6f0
[  741.704617] x5 : 0000ab58c96fd775 x4 : 0000000000000000 x3 : 00000000000=
00000
[  741.704619] x2 : 0000000000000005 x1 : ffff0000061e1c40 x0 : 0000ab58c96=
fd6f0
[  741.704621] Call trace:
[  741.704647]  __arch_copy_to_user+0x190/0x240
[  741.704651]  simple_copy_to_iter+0x48/0x98
[  741.704939]  __skb_datagram_iter+0x7c/0x280
[  741.704941]  skb_copy_datagram_iter+0x48/0xc8
[  741.704943]  unix_stream_read_actor+0x30/0x68
[  741.705137]  unix_stream_read_generic+0x304/0xb70
[  741.705139]  unix_stream_recvmsg+0xc0/0xd0
[  741.705140]  sock_recvmsg+0x88/0x108
[  741.705170]  ____sys_recvmsg+0x78/0x198
[  741.705171]  ___sys_recvmsg+0x80/0xf0
[  741.705173]  __sys_recvmsg+0x5c/0xd0
[  741.705175]  __arm64_sys_recvmsg+0x28/0x50
[  741.705177]  invoke_syscall.constprop.0+0x54/0x128
[  741.705316]  do_el0_svc+0xcc/0xf0
[  741.705317]  el0_svc+0x24/0xb0
[  741.705369]  el0t_64_sync_handler+0x138/0x148
[  741.705371]  el0t_64_sync+0x14c/0x150
[  743.232431] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks=
: { 4-.... } 15347 jiffies s: 721 root: 0x10/.
[  743.234297] rcu: blocking rcu_node structures (internal RCU debug):
[  743.235477] Sending NMI from CPU 1 to CPUs 4:
[  743.235491] NMI backtrace for cpu 4
[  743.235531] CPU: 4 PID: 194 Comm: systemd-journal Not tainted 6.7.7-WSL2=
-STABLE+ #2
[  743.235535] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  743.235537] pc : __arch_copy_to_user+0x190/0x240
[  743.235598] lr : _copy_to_iter+0xf0/0x560
[  743.235603] sp : ffff800082cfb870
[  743.235604] x29: ffff800082cfb8b0 x28: ffff00000fe96b18 x27: 00000000000=
00085
[  743.235607] x26: 0000000000000000 x25: ffff0000061e1c00 x24: 00000000000=
00000
[  743.235610] x23: 0000000000000085 x22: ffff000117d2a600 x21: ffff800082c=
fbd90
[  743.235612] x20: ffff0000061e1c00 x19: 0000000000000085 x18: 00000000000=
00000
[  743.235614] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0000061=
e1c00
[  743.235617] x14: 62616c6961766120 x13: 7365746164707520 x12: 6f6e2073616=
82070
[  743.235619] x11: 616e73203a687365 x10: 7266657220746f6e x9 : 6e6163203a3=
13937
[  743.235621] x8 : 3a6f672e73726570 x7 : 6c656865726f7473 x6 : 0000ab58c96=
fd6f0
[  743.235623] x5 : 0000ab58c96fd775 x4 : 0000000000000000 x3 : 00000000000=
00000
[  743.235626] x2 : 0000000000000005 x1 : ffff0000061e1c40 x0 : 0000ab58c96=
fd6f0
[  743.235628] Call trace:
[  743.235630]  __arch_copy_to_user+0x190/0x240
[  743.235632]  simple_copy_to_iter+0x48/0x98
[  743.235636]  __skb_datagram_iter+0x7c/0x280
[  743.235639]  skb_copy_datagram_iter+0x48/0xc8
[  743.235641]  unix_stream_read_actor+0x30/0x68
[  743.235644]  unix_stream_read_generic+0x304/0xb70
[  743.235646]  unix_stream_recvmsg+0xc0/0xd0
[  743.235647]  sock_recvmsg+0x88/0x108
[  743.235650]  ____sys_recvmsg+0x78/0x198
[  743.235651]  ___sys_recvmsg+0x80/0xf0
[  743.235653]  __sys_recvmsg+0x5c/0xd0
[  743.235655]  __arm64_sys_recvmsg+0x28/0x50
[  743.235657]  invoke_syscall.constprop.0+0x54/0x128
[  743.235661]  do_el0_svc+0xcc/0xf0
[  743.235663]  el0_svc+0x24/0xb0
[  743.235667]  el0t_64_sync_handler+0x138/0x148
[  743.235668]  el0t_64_sync+0x14c/0x150
```

Another time it didn't recover, and I was only able to get whatever was
printed to console:

```
[ 1559.425979] rcu:     7-....: (14977 ticks this GP) idle=3Dd4ec/1/0x40000=
00000000000 softirq=3D18636/18636 fqs=3D5263
[ 1559.431367] rcu:     (t=3D15002 jiffies g=3D67965 q=3D36939 ncpus=3D8)
[ 1559.432083] rcu: rcu_sched kthread starved for 2866 jiffies! g67965 f0x0=
 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[ 1559.433645] rcu:     Unless rcu_sched kthread gets sufficient CPU time, =
OOM is now expected behavior.
[ 1559.434604] rcu: RCU grace-period kthread stack dump:
[ 1559.435549] rcu: Stack dump where RCU GP kthread last ran:
[ 1739.451891] rcu: INFO: rcu_sched self-detected stall on CPU
[ 1739.452511] rcu:     7-....: (59616 ticks this GP) idle=3Dd4ec/1/0x40000=
00000000000 softirq=3D18636/18636 fqs=3D5263
[ 1739.453498] rcu:     (t=3D60008 jiffies g=3D67965 q=3D36939 ncpus=3D8)
[ 1739.454053] rcu: rcu_sched kthread starved for 47871 jiffies! g67965 f0x=
0 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[ 1739.455135] rcu:     Unless rcu_sched kthread gets sufficient CPU time, =
OOM is now expected behavior.
[ 1739.456110] rcu: RCU grace-period kthread stack dump:
[ 1739.456687] rcu: Stack dump where RCU GP kthread last ran:
[ 1919.467822] rcu: INFO: rcu_sched self-detected stall on CPU
[ 1919.468776] rcu:     7-....: (104010 ticks this GP) idle=3Dd4ec/1/0x4000=
000000000000 softirq=3D18636/18636 fqs=3D5263
[ 1919.470405] rcu:     (t=3D105012 jiffies g=3D67965 q=3D36941 ncpus=3D8)
[ 1919.472599] rcu: rcu_sched kthread starved for 92875 jiffies! g67965 f0x=
0 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[ 1919.474013] rcu:     Unless rcu_sched kthread gets sufficient CPU time, =
OOM is now expected behavior.
[ 1919.474977] rcu: RCU grace-period kthread stack dump:
[ 1919.475641] rcu: Stack dump where RCU GP kthread last ran:
```

Unfortunately the traces are not provided there.

