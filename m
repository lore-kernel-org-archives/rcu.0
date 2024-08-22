Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F601B5EDA
	for <rcu@vger.kernel.org>; Thu, 22 Aug 2024 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325402; cv=none; b=twU7uztAXVupNyUjua3ZShTLrBkkJC+btlFUX8ybeV9MLS2bG/FuLQ3wCWCL1YWE4fy5MLwtiH/TgqiA5q7eQ5zlzDm9x/KbNNffRjClAmeUyJfiQ12exVkgqjUr/gNnD24sB74eUuYOeitlSym73H6u2qE/iSc1FbMn9rxqWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325402; c=relaxed/simple;
	bh=ZQM0jlM0i4BhaH2ycjENVN+O4L7lnffqa+y1DBRqTx8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dA+HDulO2xyhTGMeXlwPY7zeR8bzkTsSwUVkqp9A8tHT9gfDtRlB1ofTTN8cndx9X4mEX0CmvWAp9+pECNzX2WA7+V+REahLPg3o/THUHO/+HY8otI36QBmFlTdkoHT30VdmcRsUgjFnw7LwzQsiO3QKIqQogO+WT7YZyAAI1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZoClSd0Z; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoClSd0Z"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4fce9f16f83so260151e0c.1
        for <rcu@vger.kernel.org>; Thu, 22 Aug 2024 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724325399; x=1724930199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nQGhp/3TTwCIHX+uin7PrRsXOTUFzwYBGtPV6IPYgn0=;
        b=ZoClSd0ZQtpMkwCqWRvmpU4e128f3IU/XQ567jpdcqNg0BTmmj+0X9THDhZ+bQeRu1
         cGa+UBYS62UfVymAwQ0l1GltrPGLE9iifLGol2Ce/xGBRB6IjWXYuDzGIbfSD9mFTj7P
         tqRjV8mFZhrZiW50iskDaV5W3ZW+fblnTZZLhOmPDqewUpYK+1k+t7TeeIQMOMEgzGl/
         0eRcUDjkfcrM/Ev6PS3DTbKHaBNjysTKpLH4EtiQ5NP8HHMg19T6WOAgrHJJZzlMpLt7
         r+eEc9ZT1kWHRSL8tEzXL+MGwCRUrw4POZQSsugnrPpifIyxOkuACyDUk5ty8PbVF4yO
         v7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724325399; x=1724930199;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQGhp/3TTwCIHX+uin7PrRsXOTUFzwYBGtPV6IPYgn0=;
        b=uDwUBj49u4E9eFlJ8RieDODKhMzUun42iM6Y9ANqejpZWQUhkkEIoyaxYP6Fs/WNyk
         7cLv5CNX1m5k3c3ANUY5fMtQn8Plx1Ygs8vRjjuHCe14wfZuTH2arhwNBjdutk9lyjt3
         UBCdiAU45YS+DwZ8PLxI5Q8e9oa6BtuTpYgqXZ2J9ZlTpzgb2sQjDruLW5INQ42GNBoe
         oAKnQC6p0udAHeu+UsmTe4ip6/fl5IDzDwpGE5ctu2303TZy5hPNcy3lJrgikyoI9TAM
         TXDRX+UeovSLshARTzqBTRbT4NBD+5YHHNL38hi8uoF6XSQeAgfXI7J4U9y6kp4Ln5T4
         ec8A==
X-Gm-Message-State: AOJu0YzwIkhCwvLgElnQkT67E6tciXh9aKA16jCJXKhTgnj0aGOiBy3z
	k22AvFoVL2bFfgHfBLHpX6lRvs4lXl/DSiNOVcdxVnWprsWtpV/CvT6cuGY3e69SnNVL6UUGLQB
	M8WtfuzrPISullvvkqcmLnFiV8b/V15G4CXFphKwd3slDmB5dN5I=
X-Google-Smtp-Source: AGHT+IE/sfORkK+EpFxfIxWr2dv+G1BHkfaEQtCTObdoB+2cYQJlgUrzOdE/TYRmlB20bOqNUvTQ5IsnPD1twg0Eo14=
X-Received: by 2002:a05:6122:a08:b0:4ef:53ad:97bd with SMTP id
 71dfb90a1353d-4fcf1aec603mr6710881e0c.3.1724325399347; Thu, 22 Aug 2024
 04:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Aug 2024 16:46:27 +0530
Message-ID: <CA+G9fYvZAUOKhf+Yg6J=OUxnJ0ckv4jxyDLGyKsqwUpAak84hw@mail.gmail.com>
Subject: next-20240822: rcu: Unless rcu_preempt kthread gets sufficient CPU
 time, OOM is now expected behavior.
To: rcu <rcu@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Brown <broonie@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel crash was noticed on arm64 Rock-pi 4b,
Qcomm dragonboard 410c and 845c devices while booting / loading kernel modules
on today's Linux next-20240822.

First seen on next-20240822.
  Good: next-20240821
  BAD:  next-20240822

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

We are bisecting this problem.

Crash log:
--------
[    0.000000] Linux version 6.11.0-rc4-next-20240822
(tuxmake@tuxmake) (Debian clang version 18.1.8
(++20240731024919+3b5b5c1ec4a3-1~exp1~20240731145017.142), Debian LLD
18.1.8) #1 SMP PREEMPT @1724309008
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Radxa ROCK Pi 4B
...
[   16.923808] coresight-cpu-debug fe430000.debug: Coresight
debug-CPU0 initialized
[   16.933919] coresight-cpu-debug fe432000.debug: Coresight
debug-CPU1 initialized
[   16.935653] coresight-cpu-debug fe434000.debug: Coresight
debug-CPU2 initialized
[   16.937846] coresight-cpu-debug fe436000.debug: Coresight
debug-CPU3 initialized
[   16.939744] coresight-cpu-debug fe610000.debug: Coresight
debug-CPU4 initialized
[   16.942132] coresight-cpu-debug fe710000.debug: Coresight
debug-CPU5 initialized
[   37.987966] rcu: INFO: rcu_preempt self-detected stall on CPU
[   37.989037] rcu: 2-...!: (5248 ticks this GP)
idle=d1f4/1/0x4000000000000000 softirq=1552/1553 fqs=0
[   37.990715] rcu: (t=5250 jiffies g=1269 q=784 ncpus=6)
[   37.991667] rcu: rcu_preempt kthread timer wakeup didn't happen for
5249 jiffies! g1269 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[   37.993718] rcu: Possible timer handling issue on cpu=4 timer-softirq=296
[   37.994966] rcu: rcu_preempt kthread starved for 5250 jiffies!
g1269 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=4
[   37.996844] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
[   37.998499] rcu: RCU grace-period kthread stack dump:
[   37.999419] task:rcu_preempt     state:I stack:0     pid:18
tgid:18    ppid:2      flags:0x00000008
[   38.001117] Call trace:
[   38.001565]  __switch_to+0x15c/0x208
[   38.002229]  __schedule+0x54c/0x9d0
[   38.002870]  schedule+0x12c/0x1e0
[   38.003479]  schedule_timeout+0x9c/0x1b0
[   38.004202]  rcu_gp_fqs_loop+0x1e0/0x880
[   38.004926]  rcu_gp_kthread+0x70/0x230
[   38.005616]  kthread+0x104/0x198
[   38.006209]  ret_from_fork+0x10/0x20
[   38.006877] CPU: 2 UID: 0 PID: 237 Comm: (udev-worker) Not tainted
6.11.0-rc4-next-20240822 #1
[   38.008442] Hardware name: Radxa ROCK Pi 4B (DT)
[   38.009284] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   38.010551] pc : smp_call_function_many_cond+0x468/0x6b8
[   38.011521] lr : smp_call_function_many_cond+0x428/0x6b8
[   38.012490] sp : ffff800083d1bb50
[   38.013094] x29: ffff800083d1bb90 x28: 0000000000000006 x27: 0000000000000000
[   38.014399] x26: ffff80008269e000 x25: 0000000000000000 x24: 0000000000000001
[   38.015702] x23: ffff8000801bc470 x22: ffff800074e75000 x21: ffff0000f74d8c20
[   38.017005] x20: ffff0000f746cb80 x19: ffff8000826a3470 x18: ffff80007afc2000
[   38.018308] x17: 000000000909008e x16: 0000000000000000 x15: ffff8000816092a0
[   38.019611] x14: 060a090000000000 x13: 0000000000000003 x12: 000000000000003f
[   38.020914] x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000011
[   38.022218] x8 : ffff0000f74b6c28 x7 : 0000000000000000 x6 : 0000000000000080
[   38.023520] x5 : 000000000000003f x4 : 0000000000000000 x3 : 0000000000000006
[   38.024823] x2 : 0000000000000004 x1 : 0000000000000004 x0 : 0000000000000004
[   38.026126] Call trace:
[   38.026574]  smp_call_function_many_cond+0x468/0x6b8
[   38.027481]  kick_all_cpus_sync+0x44/0x78
[   38.028216]  flush_module_icache+0x38/0xe0
[   38.028965]  load_module+0x1374/0x1778
[   38.029654]  __arm64_sys_finit_module+0x238/0x348
[   38.030516]  invoke_syscall+0x4c/0x110
[   38.031207]  el0_svc_common+0x8c/0xf0
[   38.031880]  do_el0_svc+0x28/0x40
[   38.032490]  el0_svc+0x40/0x88
[   38.033054]  el0t_64_sync_handler+0x90/0x100
[   38.033837]  el0t_64_sync+0x190/0x198
[   38.034509] Sending NMI from CPU 2 to CPUs 4:
[   48.036555] Sending NMI from CPU 2 to CPUs 5:
[   78.247966] sched: DL replenish lagged too much
[  121.047963] rcu: INFO: rcu_preempt self-detected stall on CPU
[  121.049009] rcu: 2-...!: (21002 ticks this GP)
idle=d1f4/1/0x4000000000000000 softirq=1552/1553 fqs=0
[  121.050702] rcu: (t=26015 jiffies g=1269 q=784 ncpus=6)
[  121.051669] rcu: rcu_preempt kthread timer wakeup didn't happen for
26014 jiffies! g1269 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x200
[  121.053735] rcu: Possible timer handling issue on cpu=4 timer-softirq=296
[  121.054982] rcu: rcu_preempt kthread starved for 26015 jiffies!
g1269 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=4
[  121.056876] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
[  121.058530] rcu: RCU grace-period kthread stack dump:
[  121.059447] task:rcu_preempt     state:R stack:0     pid:18
tgid:18    ppid:2      flags:0x00000008
[  121.061140] Call trace:
[  121.061587]  __switch_to+0x15c/0x208
[  121.062245]  __schedule+0x54c/0x9d0
[  121.062885]  schedule+0x12c/0x1e0
[  121.063494]  schedule_timeout+0x9c/0x1b0
[  121.064214]  rcu_gp_fqs_loop+0x1e0/0x880
[  121.064936]  rcu_gp_kthread+0x70/0x230
[  121.065625]  kthread+0x104/0x198
[  121.066217]  ret_from_fork+0x10/0x20
[  121.066874] CPU: 2 UID: 0 PID: 237 Comm: (udev-worker) Not tainted
6.11.0-rc4-next-20240822 #1
...
[  785.590550] Sending NMI from CPU 2 to CPUs 4:
[  795.592594] Sending NMI from CPU 2 to CPUs 5:

boot Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240822/testrun/24939658/suite/boot/test/clang-18-lkftconfig/log
 - https://lkft.validation.linaro.org/scheduler/job/7816099#L523
 - https://lkft.validation.linaro.org/scheduler/job/7815910#L2448

Boot failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240822/testrun/24939658/suite/boot/test/clang-18-lkftconfig/history/

metadata:
----
  git describe: next-20240822
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: 6a7917c89f219f09b1d88d09f376000914a52763
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2l0EZh4ZCNgUovHichD9yUraMrY/config
  kernel version: 6.11.0-rc4
  artifact location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2l0EZh4ZCNgUovHichD9yUraMrY/
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2l0EZh4ZCNgUovHichD9yUraMrY/
  toolchain: clang-18 and gcc-13

Steps to reproduce:
---------
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2l0EbxmBUpGzF37iIJ51WvkJFt8/reproducer
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2l0EbxmBUpGzF37iIJ51WvkJFt8/tux_plan

--
Linaro LKFT
https://lkft.linaro.org
