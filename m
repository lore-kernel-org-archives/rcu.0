Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A031DDA1E
	for <rcu@vger.kernel.org>; Fri, 11 Jul 2025 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216072; cv=none; b=ko5ax3pMGZxyzPNEAJl1sfP0NWsUNt5/cJ0deKY1RBTVyUwusE0K21mHNj0F9lQBj+tSUy+gMGbYdtl7otqNfJe9P2uEmV2/26Pj00BqbEDeQJxeh3c6+pRo09h5TLm3DL2G8nQ37hW1ag38HXDqgLm/9P4ninp/hIffwK37iTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216072; c=relaxed/simple;
	bh=mbg12yKXR3s+iNdgOpoNfasVa+8qpiZXy3G6e3D1HYg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aXS73Vv1VQbGUgxTfSo7YB9RyipSm40g28fNjXqM37F6Vi/C9J/CWX+IpNpl/2K1EPpBAdNq0iB92TZ1S8MhRclUM/N3CjHtUn6KgkODATCWtcBH6aKhBHK6eZNNnAl8rMzzJDUJYUvT4IeLc52M2Ag86A+JwOSiHiJP6+Z0evs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FyjQxWJy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyjQxWJy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso1708630a91.0
        for <rcu@vger.kernel.org>; Thu, 10 Jul 2025 23:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752216070; x=1752820870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mqQNmUQfn56mvxov71wQtdff180LenbJGhdViVlgjvQ=;
        b=FyjQxWJy4Ov8Dc8/X0VtA/5ajXp3+v22k/qYK+kOVHeBKBzfm+lFMQcI9qpJJ4y/t5
         4BBtzWpumdbkNU/YmCyjpT5mIvrQ4MmvB9HVviY7+7a79YzaYKR9Q+csc3KHT2f27JEs
         +9XokxU9i/YC1UrHpboVjimAzn32SPJOLslRIcQpyvq5DWXzgbBdETp+WXDfq1CnXU9a
         Ds461e7iWSvvx336T1yXkJGirBrxSK9vbBHNAuiKfQcvdIvChbH96XKp1DHpxsqF8Nr3
         qt3Aanfsm95Qhj6tCN1PXEzrdvbruBqopkWWI/I4XxserGnYs8VaY6gFvlzDQPX4E5+d
         Ovjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752216070; x=1752820870;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqQNmUQfn56mvxov71wQtdff180LenbJGhdViVlgjvQ=;
        b=O6sO1gOYndM0lnq9JOF3Z4zeu8XvjvDdBAL3un38wjjSfsESuMsF5y/wvG2E50QaRE
         trdCBnB6FtvQ47BS+Y9Dp5uYjIEzhLKkque8gVyXk1bdrNgy7N09Va/av/RrZgOA7xEa
         4TcfMtXoZ1E2m7XPaQhCG0xX1t13sL6d3sRc8a7+knPhh8FzkUCGNrw1RAS4TiuMTz2y
         lN4iLuXhX1IMcccxVaG8O1DSghRiynQXSDPibYJ2vE8mMNmIC72tGXmhuW3oaxKS+bYH
         zsp68ajnGhAl58eIennfwbtm1M7AVc89g5QglF/RIxbTyzuiJpzbfy4GxWpqj69UVU1z
         el6w==
X-Gm-Message-State: AOJu0YzacG+DmyTiBrMUPD0CcKhLB54aUQV5aQ2e+gpyUW9nWc76jU+b
	BIraXfGsuGqgDpxzUQDLOrz/37oVWbYRd3I+Q+u7TclKNbv/XIwNoOm0DuJEmWARswyeG/Uw7cL
	hbN2Nom3mLYzlsYKt9nlHBVyqrCFj04ycIjiZp/TVN2Y56zRjqK4t/aw=
X-Gm-Gg: ASbGncuWC5IvAf0aIsQ1H/Y2dzDYNQm5f5hUQShXMa5XTBzhl0lqw5L5pMukCcg0zWf
	f8CRR5zpIs4yluKvQwFFEiuvSyU3k6WeAiM2aIN0Y56Tm7r/t80jPB09Ubzv4Jc9uiCuUqHYr7k
	1hfIiayTeEtIK+y7ru1CSI0gz6YLTTwiXiwqpbhSZR7WMVydwymlgBMsFfFto6M7gimXqpY77Tz
	iVl4JVJe2ZDp7suhHsCnseBQvPyMUE/aUdfwJFn
X-Google-Smtp-Source: AGHT+IEKFZswwVLQAWHvjIhLdko+AnHsaWL90l3tdWBPIajeJUPhBeg+Kx39JnSXwjuhrRALb1kcVMkkypJenlZ34is=
X-Received: by 2002:a17:90b:5804:b0:311:b005:93d4 with SMTP id
 98e67ed59e1d1-31c50e2c50dmr1722297a91.25.1752216070024; Thu, 10 Jul 2025
 23:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 11 Jul 2025 12:10:57 +0530
X-Gm-Features: Ac12FXygO_zUkoGGWRK3NshxVmCFcyPjGdNuZIOJbPbgB0u-MP7JaQRj38GlGWM
Message-ID: <CA+G9fYvcb-BAreFW=QS=DnWnXX1gK1EAX09tBQzopwH1Jd1d=w@mail.gmail.com>
Subject: next-20250710: PREEMPT_RT: rcu_preempt self-detected stall on CPU rcu_preempt_deferred_qs_handler
To: rcu <rcu@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, neeraj.upadhyay@kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qi Xi <xiqi2@huawei.com>, 
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions on boot failure observed in builds with CONFIG_PREEMPT_RT=y
and CONFIG_LAZY_PREEMPT=y enabled on multiple platforms running the
Linux next-20250710.

Kernel stalls and RCU preempt self-detected stalls reported.
Boot log shows CPU stalls and failure as below.

Test environments:
- Ampere Altra
- rk3399-rock-pi-4b
- x86_64

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Boot regression: next-20250710 rcu_preempt self-detected stall on CPU
rcu_preempt_deferred_qs_handler

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this down to,
  first bad commit:
    [3284e4adca9b5b5a9f58dd071b848629e3bbecf8]
    rcu: Fix rcu_read_unlock() deadloop due to IRQ work

## Boot log
[ 12.001815] check access for rdinit=/init failed: -2, ignoring
[   22.252627] platform sdio-pwrseq: deferred probe pending:
pwrseq_simple: reset control not ready
[   22.252653] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to fe310000.mmc
[   22.252663] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff650000.video-codec
[   22.252672] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff660000.video-codec
[   22.252681] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff680000.rga
[   22.252696] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff880000.i2s
[   22.252704] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff8a0000.i2s
[   22.252712] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff8f0000.vop
[   22.252721] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff900000.vop
[   22.252735] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff940000.hdmi
[   22.252743] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff9a0000.gpu
[   22.257625] dwmmc_rockchip fe310000.mmc: IDMAC supports 32-bit address mode.
[   22.257666] dwmmc_rockchip fe310000.mmc: Using internal DMA controller.
[   22.257678] dwmmc_rockchip fe310000.mmc: Version ID is 270a
[   22.258153] dwmmc_rockchip fe310000.mmc: DW MMC controller at irq
49,32 bit host data width,256 deep fifo
[   23.142949] rcu: INFO: rcu_preempt self-detected stall on CPU
[   23.142962] rcu: t0-....: (5196 ticks this GP)
idle=195c/1/0x4000000000000000 softirq=0/0 fqs=2620 rcuc=5196
jiffies(starved)
[   23.142973] rcu: t(t=5250 jiffies g=-887 q=360 ncpus=6)
[   23.142984] CPU: 0 UID: 0 PID: 24 Comm: irq_work/0 Not tainted
6.16.0-rc5-next-20250710 #1 PREEMPT_RT
[   23.142991] Hardware name: Radxa ROCK Pi 4B (DT)
[   23.142995] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   23.143002] pc : rcu_preempt_deferred_qs_handler
(kernel/rcu/tree_plugin.h:647)
[   23.143020] lr : rcu_preempt_deferred_qs_handler
(arch/arm64/include/asm/irqflags.h:175
arch/arm64/include/asm/irqflags.h:195 kernel/rcu/tree_plugin.h:646)
[   23.143029] sp : ffff80008329bda0
[   23.143031] x29: ffff80008329bda0 x28: 0000000000000000 x27: 0000000000000000
[   23.143043] x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000061e320
[   23.143052] x23: ffff000000cd5f00 x22: ffff000000cd5f00 x21: 0000000000000020
[   23.143061] x20: 0000000000000000 x19: ffff0000f750f078 x18: 0000000000000000
[   23.143069] x17: 0000000000000000 x16: ffff800081cea140 x15: 0000000000000033
[   23.143078] x14: 0000000000000000 x13: e800521362c92235 x12: aa42a37f93df442b
[   23.143087] x11: ffff800083e2b730 x10: 0000000000000c40 x9 : ffff8000815d24dc
[   23.143096] x8 : ffff80008329bc88 x7 : 0000000000000000 x6 : ffff8000828ce000
[   23.143105] x5 : ffff000000cd5f00 x4 : ffff8000828ce3a0 x3 : 0000000000000000
[   23.143113] x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000100000000
[   23.143122] Call trace:
[   23.143126] rcu_preempt_deferred_qs_handler
(kernel/rcu/tree_plugin.h:647) (P)
[   23.143137] irq_work_single (kernel/irq_work.c:222 (discriminator 1))
[   23.143149] irq_work_run_list.part.0 (kernel/irq_work.c:251
(discriminator 1))
[   23.143159] run_irq_workd (kernel/irq_work.c:306)
[   23.143168] smpboot_thread_fn (kernel/smpboot.c:160)
[   23.143179] kthread (kernel/kthread.c:463)
[   23.143189] ret_from_fork (arch/arm64/kernel/entry.S:859)
[   28.908093] VFS: Mounted root (nfs filesystem) on device 0:23.
[   28.908665] devtmpfs: mounted
[   28.923586] Freeing unused kernel memory: 4160K
[   28.923786] Run /sbin/init as init process
[   49.938947] rcu: INFO: rcu_preempt self-detected stall on CPU
[   49.938955] rcu: t4-....: (1 GPs behind)
idle=0aec/1/0x4000000000000000 softirq=0/0 fqs=2617 rcuc=11947
jiffies(starved)
[   49.938963] rcu: t(t=5251 jiffies g=-883 q=3276 ncpus=6)
[   49.938971] CPU: 4 UID: 0 PID: 51 Comm: irq_work/4 Not tainted
6.16.0-rc5-next-20250710 #1 PREEMPT_RT
[   49.938976] Hardware name: Radxa ROCK Pi 4B (DT)
[   49.938978] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   49.938982] pc : rcu_preempt_deferred_qs_handler
(kernel/rcu/tree_plugin.h:647)
[   49.938998] lr : rcu_preempt_deferred_qs_handler
(arch/arm64/include/asm/irqflags.h:175
arch/arm64/include/asm/irqflags.h:195 kernel/rcu/tree_plugin.h:646)
[   49.939003] sp : ffff80008339bda0
[   49.939004] x29: ffff80008339bda0 x28: 0000000000000000 x27: 0000000000000000
[   49.939012] x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000061e5a0
[   49.939017] x23: ffff000000ed9300 x22: ffff000000ed9300 x21: 0000000000000020
[   49.939023] x20: 0000000000000000 x19: ffff0000f7597078 x18: ffff8000837fb388
[   49.939028] x17: ffff800082d35920 x16: 0000000000000000 x15: 000000007794abb1
[   49.939033] x14: 0000000000000001 x13: 6463682d69636878 x12: 0000000000000001
[   49.939038] x11: ffff0000f75961c0 x10: 0000000000000c40 x9 : ffff8000815d24dc
[   49.939043] x8 : ffff80008339bc88 x7 : 0000000000000000 x6 : ffff8000828ce000
[   49.939048] x5 : ffff000000ed9300 x4 : ffff8000828ce3a0 x3 : 0000000000000000
[   49.939053] x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000100000000
[   49.939059] Call trace:
[   49.939061] rcu_preempt_deferred_qs_handler
(kernel/rcu/tree_plugin.h:647) (P)
[   49.939068] irq_work_single (kernel/irq_work.c:222 (discriminator 1))
[   49.939076] irq_work_run_list.part.0 (kernel/irq_work.c:251
(discriminator 1))
[   49.939082] run_irq_workd (kernel/irq_work.c:306)
[   49.939087] smpboot_thread_fn (kernel/smpboot.c:160)
[   49.939094] kthread (kernel/kthread.c:463)
[   49.939101] ret_from_fork (arch/arm64/kernel/entry.S:859)
[   65.639064] random: crng init done

## Source
* Kernel version: 6.16.0-rc5-next-20250710
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: b551c4e2a98a177a06148cf16505643cd2108386
* Git describe: next-20250710
* Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250710
* Architectures: arm64
* Toolchains: gcc-13
* Kconfigs: gcc-13-defconfig-preempt_rt

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/29088924/log_file/
* Test LAVA log 1: https://lkft.validation.linaro.org/scheduler/job/8351708#L947
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250710/boot/gcc-13-defconfig-preempt_rt/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2zg2ZkIKDYPorIm1qfg2NEzlIkR
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zg2YGdS8dEcQIkEuzXik2IqIss/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2zg2YGdS8dEcQIkEuzXik2IqIss/config

--
Linaro LKFT
https://lkft.linaro.org
