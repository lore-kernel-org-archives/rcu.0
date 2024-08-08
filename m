Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3D183098
	for <rcu@vger.kernel.org>; Thu,  8 Aug 2024 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096364; cv=none; b=Nr8zGOChTRaKXGwB2SkICP5tBhDOfGAkkJqs2kCChx4kyF3dA2yZaKnYdOWvnRXzWNrZcZbpYq+K0nLMYUDENY1EozVnQ51hq4zCdk78RkZK9Eu5PcyyJaF9/aZ7eUVe/DqbKwHjNXdn6n5PZxSxEXG1w28dybCitTpJJCMrFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096364; c=relaxed/simple;
	bh=96DSV1OZgIozfx4GFj0bXdJuiQnMgYPc5v8Ji7Hnp9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKHCJCnnpDYUjtAV87GYhTVDLRX1hAs1hXmuRficsm0PtFuwfPV87MV4x4kv1cqML+YY75w7KM/mVnd5490udgzG3hvSB1BxHpyTE/UJEu5CtdhCzrmw7kiXY5H1Lk8XfdGagpNFlUpX8fUcddaiHHoMErOvZ9EMxhz/iq5/GnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0o2wdos; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0o2wdos"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso564378a12.0
        for <rcu@vger.kernel.org>; Wed, 07 Aug 2024 22:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723096361; x=1723701161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVUDHLY2uO6WoouUgRVm6LFZczKBLH1EDA8/sFIUT/c=;
        b=k0o2wdosiPa+gQHGCke3FGLXdzrmmoKSBu5H/IKJs/q5mvAwodpD6fYYrQ/BMMLNga
         AnltRDDSNOtxYJI7wEwdki/H7IIJkmHewbCMS/rMwAZvQJmRomi/FQaMxPXGCEpiCGPA
         2Xe1roh5bkcE5Fg5Dqs6W03q0qK6NgkCIQXfsWzMnKke8wpZ2aI1wxW7XGlqYVmd4Ssz
         SUBqxt1ya2jVzb8vox9Va/8TOfqIHbJYOgblv57koeKQP8/x20P+/sbEFYpJVv57pGGx
         UMavrw+o8HpY/JBqWcw5h+lN6sufhoemd94KStLrDzmrP5uE+2xl4OTv3pwSrDYTXYkl
         B9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723096361; x=1723701161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVUDHLY2uO6WoouUgRVm6LFZczKBLH1EDA8/sFIUT/c=;
        b=AASNjsLFmYMT6EYjkugdWnMv3FC9oPlXV91Ivv4dbH5bt2z8dwz0Lhz49F+oBbEk9J
         FTtN3MRoRGWmlFkXN2imBPWss5Wo+geDPsqMAgQ5z678O6LBWFY1xCCUUAco2xlpie98
         PjFcIJs97Yq160FdJulcqZjDX3fzWhgdtQ+8fgnIHUD7kC8nZX3iRa7IZeIlGzzXGBuN
         FeKy7fjanByZ2YD/QW0IsCKXbf9+qeo1H19lVPav33fD1sBxlYpI5iJFMcVUrlUD4hd+
         dCI9X3KdUMjZpc72MN9fes0x1WuXBNx5n6sMvjA6Ol4gZtUP0by8XbhMnQ3H7w40jj5k
         VHvw==
X-Forwarded-Encrypted: i=1; AJvYcCXl2kUBdyFXuRwdqoubtUaQgSbGHaf6hQx9maqs4mIlRysppjHJIlF2QvWSDi/iuYq9AzIuITcWX3iq6AxBOSOk7qpj
X-Gm-Message-State: AOJu0YyA3qk+d9Fdn7wMIOWc1KQxY48/fJKFudmWT3iXud5QpZdTMsvW
	RWCl3JBTwfbYFANe6Jyyq0aUtZm82vNnScmO2q4VIO41dxQSfZxq/w+sGK33uFP+uQp4ajtLyO+
	93793YQ08z/qLLjGdYeDYUuoSPzY=
X-Google-Smtp-Source: AGHT+IHOmuUzIb/kzXWrlEkW1EFgsx8SPI7IrM47fi3WkJbLm/tGzpsSE8UVms2dClrFlRCblusMIuEmd0m9PmCFaHs=
X-Received: by 2002:a17:907:daa:b0:a7a:ab1a:2d65 with SMTP id
 a640c23a62f3a-a8090f0e742mr53758866b.67.1723096360448; Wed, 07 Aug 2024
 22:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408081016.9d43eb89-lkp@intel.com>
In-Reply-To: <202408081016.9d43eb89-lkp@intel.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Thu, 8 Aug 2024 11:22:28 +0530
Message-ID: <CAFwiDX9QSrn_ETfO0RsEV9zDoQge2mm0kNUZa_DJp=oUBa1kCQ@mail.gmail.com>
Subject: Re: [paulmckrcu:dev.2024.07.18b] [srcu] 8a4c716cfc: WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sync[rcutorture]
To: kernel test robot <oliver.sang@intel.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the report!

On Thu, Aug 8, 2024 at 10:49=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
> hi, JP Kobryn and Paul E. McKenney,
>
> we don't see commit with same title in later dev.2024.07*** or dev.2024.0=
8***
> branches in https://github.com/paulmckrcu/linux, so not sure if this repo=
rt is
> still useful.
>

Similar issue was identified in [1]. The newer version of the patch -
commit 316a003bd5a4
("srcu: faster gp seq wrap-around") in branch dev.2024.08.05a fixes
this problem.


[1] https://lore.kernel.org/rcu/191db3ea-f1aa-4e13-b919-0ca4a00dc89e@paulmc=
k-laptop/


- Neeraj

> another thing is the issue is random. just FYI.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
>   vm-snb/rcutorture/debian-12-x86_64-20240206.cgz/x86_64-randconfig-003-2=
0240730/clang-18/300s/cpuhotplug/srcu
>
> commit:
>   1815b92627178 ("workqueue: Add check for clocks going backwards to wq_w=
orker_tick()")
>   8a4c716cfcb96 ("srcu: Make SRCU GP sequence number wrap")
>
> 1815b926271780c9 8a4c716cfcb9602e0baedfced5f
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :100          9%           9:100   dmesg.RIP:do_rtws_sync[rcut=
orture]
>            :100          9%           9:100   dmesg.WARNING:at_kernel/rcu=
/rcutorture.c:#do_rtws_sync[rcutorture]
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#do_rtws_sy=
nc[rcutorture]" on:
>
> commit: 8a4c716cfcb9602e0baedfced5fa6d2c9169f421 ("srcu: Make SRCU GP seq=
uence number wrap")
> https://github.com/paulmckrcu/linux dev.2024.07.18b
>
> in testcase: rcutorture
> version:
> with following parameters:
>
>         runtime: 300s
>         test: cpuhotplug
>         torture_type: srcu
>
>
>
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408081016.9d43eb89-lkp@intel.=
com
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240808/202408081016.9d43eb89-lk=
p@intel.com
>
>
> [   27.636859][  T515] ------------[ cut here ]------------
> [   27.636869][  T515] do_rtws_sync: Cookie check 3 failed srcu_torture_s=
ynchronize_expedited+0x0/0x20 [rcutorture]() online 0-1.
> [   27.636964][  T515] WARNING: CPU: 0 PID: 515 at kernel/rcu/rcutorture.=
c:1348 do_rtws_sync+0x1fc/0x240 [rcutorture]
> [   27.636983][  T515] Modules linked in: rcutorture(+) torture ip_tables=
 x_tables
> [   27.636999][  T515] CPU: 0 PID: 515 Comm: rcu_torture_wri Tainted: G  =
              T  6.10.0-rc5-00120-g8a4c716cfcb9 #1
> [   27.637005][  T515] RIP: 0010:do_rtws_sync+0x1fc/0x240 [rcutorture]
> [   27.637021][  T515] Code: ae c0 00 00 01 90 8b 0d 5a a1 d3 e3 48 c7 c7=
 ab 48 04 a0 48 c7 c6 74 29 04 a0 48 89 da 49 c7 c0 68 80 d6 83 e8 35 a3 04=
 e1 90 <0f> 0b 90 90 45 84 e4 0f 85 7b ff ff ff eb ac c6 05 74 c0 00 00 01
> [   27.637026][  T515] RSP: 0000:ffffc9000170bde0 EFLAGS: 00010286
> [   27.637031][  T515] RAX: 000000000000006a RBX: ffffffffa002d860 RCX: 0=
000000000000027
> [   27.637035][  T515] RDX: 0000000000000007 RSI: ffff888143590680 RDI: f=
fff88842fbd6cc8
> [   27.637039][  T515] RBP: ffffc9000170be18 R08: ffff888143590680 R09: 0=
000000000000001
> [   27.637042][  T515] R10: 0000000000000009 R11: 0000000000000000 R12: 0=
000000000000000
> [   27.637046][  T515] R13: 0000000000000001 R14: 0000000000000004 R15: 0=
000000000000001
> [   27.637049][  T515] FS:  0000000000000000(0000) GS:ffff88842fa00000(00=
00) knlGS:0000000000000000
> [   27.637054][  T515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   27.637058][  T515] CR2: 00007f1846cf4000 CR3: 00000001440fc000 CR4: 0=
0000000000406b0
> [   27.637065][  T515] Call Trace:
> [   27.637068][  T515]  <TASK>
> [   27.637073][  T515]  ? show_regs+0x5e/0x70
> [   27.637108][  T515]  ? __warn+0xcb/0x220
> [   27.637116][  T515]  ? do_rtws_sync+0x1fc/0x240 [rcutorture]
> [   27.637135][  T515]  ? report_bug+0xc6/0x160
> [   27.637977][  T515]  ? handle_bug+0x42/0x80
> [   27.637985][  T515]  ? exc_invalid_op+0x1b/0x50
> [   27.637993][  T515]  ? asm_exc_invalid_op+0x1b/0x20
> [   27.638004][  T515]  ? __cfi_srcu_torture_synchronize_expedited+0x10/0=
x10 [rcutorture]
> [   27.638030][  T515]  ? do_rtws_sync+0x1fc/0x240 [rcutorture]
> [   27.638055][  T515]  rcu_torture_writer+0x8c3/0x1040 [rcutorture]
> [   27.638071][  T515]  ? local_clock+0x15/0x20
> [   27.638081][  T515]  ? lock_release+0x120/0x4b0
> [   27.638087][  T515]  ? kthread+0x128/0x190
> [   27.638102][  T515]  ? kthread+0xad/0x190
> [   27.638108][  T515]  kthread+0x179/0x190
> [   27.638112][  T515]  ? __cfi_rcu_torture_writer+0x10/0x10 [rcutorture]
> [   27.638131][  T515]  ? __cfi_kthread+0x10/0x10
> [   27.638137][  T515]  ret_from_fork+0x4a/0x60
> [   27.638143][  T515]  ? __cfi_kthread+0x10/0x10
> [   27.638150][  T515]  ret_from_fork_asm+0x11/0x20
> [   27.638174][  T515]  </TASK>
> [   27.638177][  T515] irq event stamp: 333
> [   27.638180][  T515] hardirqs last  enabled at (339): [<ffffffff8110c3b=
f>] vprintk_emit+0x21f/0x2c0
> [   27.638188][  T515] hardirqs last disabled at (344): [<ffffffff8110c2b=
3>] vprintk_emit+0x113/0x2c0
> [   27.638195][  T515] softirqs last  enabled at (40): [<ffffffffa002af04=
>] rcu_torture_writer+0x264/0x1040 [rcutorture]
> [   27.638212][  T515] softirqs last disabled at (38): [<ffffffffa002aeba=
>] rcu_torture_writer+0x21a/0x1040 [rcutorture]
> [   27.638228][  T515] ---[ end trace 0000000000000000 ]---
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
