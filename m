Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CB15665E
	for <rcu@vger.kernel.org>; Thu, 31 Oct 2024 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364030; cv=none; b=BlX5cIDAtzNrFJfDAkoTfuCZHS8kuevad3mlVGmLHp7zYPfOTczhRbcGyy7pjUZyEv7z5l7q4BEw+MpaVBPb3fQrE9uYurLLzP479EaQuUI9ry0jWJpdyz7AXYtSgRIOtoT6YR5iZ790IhmMGAb2OXoSwAXugZEUMB2wVvrDBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364030; c=relaxed/simple;
	bh=LeyMk9avMeu7kqwcGwwL69alsnubIEkZVPHGvteIeZY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uH8jWXdEliS9Lr0d5urT/oNzjnBv5xuzilXyY0Q3vAVrw64oZ+RBjgZ7OnAvCEiA3VlOrdub66niT7dwk3/crBUzO+kBfLpYtethFsFzvd2kyU++QU4QTpOh0FQgZuvWjF2GSPFqzpBd/FDeLsyEYWcz3+3FXI00kHbaMWb7DTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAeR9ADs; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAeR9ADs"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50c9f4efd09so212934e0c.2
        for <rcu@vger.kernel.org>; Thu, 31 Oct 2024 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730364026; x=1730968826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yRVDQpV+hUXvvZ+d81+vLy4HFzH/pZtNnyV5rKLdBNk=;
        b=YAeR9ADsGq5fZFeMvyZi2C4yRMnG7MKHO14eu/7/wpV95yX63jAQGHhET+BNuyqKS6
         N/P7TauhdBKX0aC8uwUXAv4FXpjnWphcGGQbgoS3RF4UDE8AvyJ4QyvuMsETbJtJo3St
         QEtuGSLGCuvZ/cdS0UEDrw0dmX/MwOK43NPVP2pJ/nxot/upeLjiclE0cUAfI3EucGG3
         IPk0WMC4/Wpe2O5p5tNWXXthtg/vFHi4v5PZunO5NqoAz6V/TqdDje07YAV45IUOJDjO
         pabe256+yc8FO5r2sNmVMKSfSeH3niwHG2VwDjGislEDJXDLSfXFMBk9vzIsmHmiaJsy
         p45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364026; x=1730968826;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRVDQpV+hUXvvZ+d81+vLy4HFzH/pZtNnyV5rKLdBNk=;
        b=pPt6+1pjhGd4FogTLZ/xAxZUtRhZpLjcdXz939Z5QD17F3Sx2V9QafSNDRJbQMd7r7
         fFBHflET9lC04jqlQp5crb1JawN+ZSPi0A6RVxBZzrziIWMrPntWBwBw/j6vVqmGASZo
         cZ1WxlR8nhgoaKCNM7xBvLziYXawjPwISF8w0L4PlXFuHmx+pIzflL1Xgb0HCVxf7uTK
         Tq9gxx4gjfkermegnGF3FfjFaxkqgTS9dCtgnZqPrSgrOWk/h2kbyo/9LqSGaads6au8
         zTT5gyjGkEtwurYondYFkgLyhW/+ACHQsMkeo0cCbcxWn6x1j6KK+rqRcorRpYpofgmY
         TQPw==
X-Forwarded-Encrypted: i=1; AJvYcCWI9Y+GJbAaFHvJbYD1YJ2wAzlFsIXeYbXW3QohBw1s2/GF3PF8/0uRzS2C/YeAqryxgHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9nJwchWLkU5fIQWVuWWFyP93fpwVE52Uza6ejc5l3xVMWXZU
	TX+/EJiF/snhuCh0eqI1ruzVyb2iMlWEkRJZ0UpOKOJZkl05aFRTlWtozCnjgpYOGA09f+rEJrs
	lZAzzxclJfH1Gg83bjaWAXgqhyJBXcBt+o5dOAw==
X-Google-Smtp-Source: AGHT+IGR/MPyH3IolNU4N1H3KPOJfa7bE8GqUDT765g/usV3v7bfC6kWkOhjTjRmP547kzqlXxsbmIBpPjVVnaUU3uw=
X-Received: by 2002:a05:6122:891:b0:50a:caec:70a2 with SMTP id
 71dfb90a1353d-5101501c00bmr17269880e0c.4.1730364025759; Thu, 31 Oct 2024
 01:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Oct 2024 14:10:14 +0530
Message-ID: <CA+G9fYtb5vAnEiHupwsnaeZ7uzdko_WAcjw9ZAFkHNXBVhi1EA@mail.gmail.com>
Subject: next-20241031: kernel/time/clockevents.c:455 clockevents_register_device
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, rcu <rcu@vger.kernel.org>, 
	linux-clk <linux-clk@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Peter Maydell <peter.maydell@linaro.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset="UTF-8"

The QEMU-ARM64 boot has failed with the Linux next-20241031 tag.
The boot log shows warnings at clockevents_register_device and followed
by rcu_preempt detected stalls.

However, the system did not proceed far enough to reach the login prompt.
The fvp-aemva, Qemu-arm64, Qemu-armv7 and Qemu-riscv64 boot failed.

Please find the incomplete boot log links below for your reference.
The Qemu version is 9.0.2.

This is always reproducible.
First seen on Linux next-20241031 tag.
  Good: next-20241030
  Good: next-20241031

qemu-arm64:
  boot:
    * clang-19-lkftconfig
    * gcc-13-lkftconfig
    * clang-nightly-lkftconfig

qemu-armv7:
  boot:
    * clang-19-lkftconfig
    * gcc-13-lkftconfig
    * clang-nightly-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
-------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
    0.000000] Linux version 6.12.0-rc5-next-20241031 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils
for Debian) 2.43.1) #1 SMP PREEMPT @1730356841
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
<trim>
<6>[    0.216503] GICv3: CPU1: found redistributor 1 region 0:0x00000000080c0000
<6>[    0.218511] GICv3: CPU1: using allocated LPI pending table
@0x0000000100250000
<4>[    0.220528] ------------[ cut here ]------------
<4>[ 0.220657] WARNING: CPU: 1 PID: 0 at kernel/time/clockevents.c:455
clockevents_register_device (kernel/time/clockevents.c:455
(discriminator 1))
<4>[    0.221897] Modules linked in:
<4>[    0.222659] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted
6.12.0-rc5-next-20241031 #1
<4>[    0.223100] Hardware name: linux,dummy-virt (DT)
<4>[    0.223480] pstate: 200003c9 (nzCv DAIF -PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
<4>[ 0.223815] pc : clockevents_register_device
(kernel/time/clockevents.c:455 (discriminator 1))
<4>[ 0.223899] lr : clockevents_config_and_register
(kernel/time/clockevents.c:523)
<4>[    0.223951] sp : ffff800080103cd0
<4>[    0.223985] x29: ffff800080103cd0 x28: 0000000000000091 x27:
0000000000000000
<4>[    0.224143] x26: fff06d7e11c1b000 x25: fff00000ff4d7108 x24:
00000000000000ee
<4>[    0.224221] x23: 01ffffffffffffff x22: ffff9282ed4e66c8 x21:
ffff9282ed8ce940
<4>[    0.224296] x20: fff00000ff4ef000 x19: fff00000ff4ef000 x18:
0000000000000010
<4>[    0.224376] x17: 3030353230303130 x16: 3030303030307830 x15:
4020656c62617420
<4>[    0.224450] x14: 676e69646e657020 x13: 3030303035323030 x12:
3130303030303030
<4>[    0.224522] x11: 78304020656c6261 x10: ffff9282eda4de88 x9 :
ffff9282eb3b161c
<4>[    0.224621] x8 : 000000001dcd6500 x7 : 000000003b9aca00 x6 :
00000000007fffff
<4>[    0.224693] x5 : 000000000000001b x4 : 0000000000800000 x3 :
000001ffffffffff
<4>[    0.224771] x2 : 0000000000000001 x1 : ffff9282ed9ced40 x0 :
0000000000000000
<4>[    0.225007] Call trace:
<4>[ 0.225218] clockevents_register_device+0x170/0x188 P
<4>[ 0.225367] clockevents_config_and_register+0x34/0x50 L
<4>[ 0.225487] clockevents_config_and_register (kernel/time/clockevents.c:523)
<4>[ 0.225553] arch_timer_starting_cpu
(drivers/clocksource/arm_arch_timer.c:1034)
<4>[ 0.225602] cpuhp_invoke_callback (kernel/cpu.c:194)
<4>[ 0.225649] __cpuhp_invoke_callback_range (kernel/cpu.c:965)
<4>[ 0.225691] notify_cpu_starting (kernel/cpu.c:1604)
<4>[ 0.225733] secondary_start_kernel (arch/arm64/kernel/smp.c:251)
<4>[ 0.225809] __secondary_switched (arch/arm64/kernel/head.S:421)
<4>[    0.226244] ---[ end trace 0000000000000000 ]---
<6>[    0.228186] CPU1: Booted secondary processor 0x0000000001 [0x000f0510]
<6>[    0.237749] smp: Brought up 1 node, 2 CPUs
<6>[    0.253976] SMP: Total of 2 processors activated.
<6>[    0.254658] CPU: All CPU(s) started at EL2
<trim>
<3>[   21.732871] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
<3>[   21.734120] rcu: 1-...!: (0 ticks this GP) idle=0ca0/0/0x0
softirq=0/0 fqs=0 (false positive?)
<3>[   21.735202] rcu: (detected by 0, t=5252 jiffies, g=-1179, q=28 ncpus=2)
<6>[   21.736404] Sending NMI from CPU 0 to CPUs 1:
<4>[ 21.737195] NMI backtrace for cpu 1 skipped: idling at
default_idle_call (kernel/sched/idle.c:126)
<3>[   21.741361] rcu: rcu_preempt kthread timer wakeup didn't happen
for 5251 jiffies! g-1179 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
<3>[   21.742143] rcu: Possible timer handling issue on cpu=1 timer-softirq=0
<3>[   21.742724] rcu: rcu_preempt kthread starved for 5252 jiffies!
g-1179 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
<3>[   21.743583] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
<3>[   21.744154] rcu: RCU grace-period kthread stack dump:
<6>[   21.744678] task:rcu_preempt     state:I stack:0     pid:18
tgid:18    ppid:2      flags:0x00000008
<6>[   21.746801] Call trace:
<6>[ 21.747336] __switch_to+0x104/0x180 T
<6>[ 21.747990] __schedule (kernel/sched/core.c:5330 kernel/sched/core.c:6707)
<6>[ 21.748380] schedule (kernel/sched/core.c:6785 kernel/sched/core.c:6799)
<6>[ 21.748717] schedule_timeout (include/linux/timer.h:185
kernel/time/sleep_timeout.c:100)
<6>[ 21.749159] rcu_gp_fqs_loop (kernel/rcu/tree.c:2045 (discriminator 15))
<6>[ 21.749600] rcu_gp_kthread (kernel/rcu/tree.c:2250 (discriminator 2))
<6>[ 21.749966] kthread (kernel/kthread.c:389)
<6>[ 21.750256] ret_from_fork (arch/arm64/kernel/entry.S:863)
<3>[   84.752681] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
<3>[   84.753221] rcu: 1-...!: (0 ticks this GP) idle=0cd8/0/0x0
softirq=0/0 fqs=1 (false positive?)
<3>[   84.753702] rcu: (detected by 0, t=21007 jiffies, g=-1179, q=28 ncpus=2)
<6>[   84.754154] Sending NMI from CPU 0 to CPUs 1:
<4>[ 84.754746] NMI backtrace for cpu 1 skipped: idling at
default_idle_call (kernel/sched/idle.c:126)
<3>[   84.756511] rcu: rcu_preempt kthread timer wakeup didn't happen
for 15749 jiffies! g-1179 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
<3>[   84.757462] rcu: Possible timer handling issue on cpu=1 timer-softirq=0
<3>[   84.757880] rcu: rcu_preempt kthread starved for 15750 jiffies!
g-1179 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
<3>[   84.758538] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
<3>[   84.759136] rcu: RCU grace-period kthread stack dump:
<6>[   84.759609] task:rcu_preempt     state:I stack:0     pid:18
tgid:18    ppid:2      flags:0x00000008
<6>[   84.760175] Call trace:
<6>[ 84.760454] __switch_to+0x104/0x180 T
<6>[ 84.760810] __schedule (kernel/sched/core.c:5330 kernel/sched/core.c:6707)
<6>[ 84.761218] schedule (kernel/sched/core.c:6785 kernel/sched/core.c:6799)
<6>[ 84.761528] schedule_timeout (include/linux/timer.h:185
kernel/time/sleep_timeout.c:100)
<6>[ 84.761846] rcu_gp_fqs_loop (kernel/rcu/tree.c:2045 (discriminator 15))
<6>[ 84.762304] rcu_gp_kthread (kernel/rcu/tree.c:2250 (discriminator 2))
<6>[ 84.762751] kthread (kernel/kthread.c:389)
<6>[ 84.763168] ret_from_fork (arch/arm64/kernel/entry.S:863)
<3>[  105.768683] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
<3>[  105.769169] rcu: 1-...!: (0 ticks this GP) idle=0ce8/0/0x0
softirq=0/0 fqs=0 (false positive?)
<3>[  105.769749] rcu: (detected by 0, t=5252 jiffies, g=-1175, q=27 ncpus=2)
<6>[  105.770219] Sending NMI from CPU 0 to CPUs 1:
<4>[ 105.770939] NMI backtrace for cpu 1 skipped: idling at
default_idle_call (kernel/sched/idle.c:126)
<3>[  105.771924] rcu: rcu_preempt kthread timer wakeup didn't happen
for 5250 jiffies! g-1175 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
<3>[  105.772727] rcu: Possible timer handling issue on cpu=1 timer-softirq=0
<3>[  105.773193] rcu: rcu_preempt kthread starved for 5251 jiffies!
g-1175 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
<3>[  105.773892] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
<3>[  105.774494] rcu: RCU grace-period kthread stack dump:
<6>[  105.775006] task:rcu_preempt     state:I stack:0     pid:18
tgid:18    ppid:2      flags:0x00000008
<6>[  105.775929] Call trace:
<6>[ 105.776238] __switch_to+0x104/0x180 T
<6>[ 105.776702] __schedule (kernel/sched/core.c:5330 kernel/sched/core.c:6707)
<6>[ 105.777169] schedule (kernel/sched/core.c:6785 kernel/sched/core.c:6799)
<6>[ 105.777571] schedule_timeout (include/linux/timer.h:185
kernel/time/sleep_timeout.c:100)
<6>[ 105.778041] rcu_gp_fqs_loop (kernel/rcu/tree.c:2045 (discriminator 15))
<6>[ 105.778507] rcu_gp_kthread (kernel/rcu/tree.c:2250 (discriminator 2))
<6>[ 105.778968] kthread (kernel/kthread.c:389)
<6>[ 105.779365] ret_from_fork (arch/arm64/kernel/entry.S:863)
<3>[  168.788676] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
<3>[  168.789211] rcu: 1-...!: (0 ticks this GP) idle=0cf8/0/0x0
softirq=0/0 fqs=1 (false positive?)
<3>[  168.789696] rcu: (detected by 0, t=21007 jiffies, g=-1175, q=27 ncpus=2)
<6>[  168.790176] Sending NMI from CPU 0 to CPUs 1:
<4>[ 168.790347] NMI backtrace for cpu 1 skipped: idling at
default_idle_call (kernel/sched/idle.c:126)
<3>[  168.791281] rcu: rcu_preempt kthread timer wakeup didn't happen
for 15752 jiffies! g-1175 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
<3>[  168.791959] rcu: Possible timer handling issue on cpu=1 timer-softirq=0
<3>[  168.792586] rcu: rcu_preempt kthread starved for 15753 jiffies!
g-1175 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
<3>[  168.793343] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
<3>[  168.793928] rcu: RCU grace-period kthread stack dump:
<6>[  168.794213] task:rcu_preempt     state:I stack:0     pid:18
tgid:18    ppid:2      flags:0x00000008
<6>[  168.794719] Call trace:
<6>[ 168.794925] __switch_to+0x104/0x180 T
<6>[ 168.795202] __schedule (kernel/sched/core.c:5330 kernel/sched/core.c:6707)
<6>[ 168.795454] schedule (kernel/sched/core.c:6785 kernel/sched/core.c:6799)
<6>[ 168.795690] schedule_timeout (include/linux/timer.h:185
kernel/time/sleep_timeout.c:100)
<6>[ 168.795977] rcu_gp_fqs_loop (kernel/rcu/tree.c:2045 (discriminator 15))
<6>[ 168.796250] rcu_gp_kthread (kernel/rcu/tree.c:2250 (discriminator 2))
<6>[ 168.796606] kthread (kernel/kthread.c:389)
<6>[ 168.797039] ret_from_fork (arch/arm64/kernel/entry.S:863)
<3>[  189.804686] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
<3>[  189.805214] rcu: 1-...!: (0 ticks this GP) idle=0d08/0/0x0
softirq=0/0 fqs=0 (false positive?)
<3>[  189.805791] rcu: (detected by 0, t=5252 jiffies, g=-1171, q=27 ncpus=2)
<6>[  189.806325] Sending NMI from CPU 0 to CPUs 1:
<4>[ 189.807068] NMI backtrace for cpu 1 skipped: idling at
default_idle_call (kernel/sched/idle.c:126)
<3>[  189.808147] rcu: rcu_preempt kthread timer wakeup didn't happen
for 5251 jiffies! g-1171 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
<3>[  189.808872] rcu: Possible timer handling issue on cpu=1 timer-softirq=0
<3>[  189.809344] rcu: rcu_preempt kthread starved for 5252 jiffies!
g-1171 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
<3>[  189.809965] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
<3>[  189.810600] rcu: RCU grace-period kthread stack dump:
<6>[  189.811112] task:rcu_preempt     state:I stack:0     pid:18
tgid:18    ppid:2      flags:0x00000008
<6>[  189.811623] Call trace:
<6>[ 189.811852] __switch_to+0x104/0x180 T
<6>[ 189.812287] __schedule (kernel/sched/core.c:5330 kernel/sched/core.c:6707)
<6>[ 189.812584] schedule (kernel/sched/core.c:6785 kernel/sched/core.c:6799)
<6>[ 189.812932] schedule_timeout (include/linux/timer.h:185
kernel/time/sleep_timeout.c:100)
<6>[ 189.813394] rcu_gp_fqs_loop (kernel/rcu/tree.c:2045 (discriminator 15))
<6>[ 189.813685] rcu_gp_kthread (kernel/rcu/tree.c:2250 (discriminator 2))
<6>[ 189.813993] kthread (kernel/kthread.c:389)
<6>[ 189.814240] ret_from_fork (arch/arm64/kernel/entry.S:863)
<3>[  252.824675] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
<3>[  252.825201] rcu: 1-...!: (0 ticks this GP) idle=0d18/0/0x0
softirq=0/0 fqs=1 (false positive?)
<3>[  252.825675] rcu: (detected by 0, t=21007 jiffies, g=-1171, q=27 ncpus=2)
<6>[  252.826077] Sending NMI from CPU 0 to CPUs 1:
<4>[ 252.826332] NMI backtrace for cpu 1 skipped: idling at
default_idle_call (kernel/sched/idle.c:126)
<3>[  252.827295] rcu: rcu_preempt kthread timer wakeup didn't happen
for 15752 jiffies! g-1171 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
<3>[  252.828099] rcu: Possible timer handling issue on cpu=1 timer-softirq=0
<3>[  252.828632] rcu: rcu_preempt kthread starved for 15753 jiffies!
g-1171 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
<3>[  252.829561] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
<3>[  252.830012] rcu: RCU grace-period kthread stack dump:
<6>[  252.830503] task:rcu_preempt     state:I stack:0     pid:18
tgid:18    ppid:2      flags:0x00000008
<6>[  252.831137] Call trace:
<6>[ 252.831328] __switch_to+0x104/0x180 T
<6>[ 252.831619] __schedule (kernel/sched/core.c:5330 kernel/sched/core.c:6707)
<6>[ 252.832041] schedule (kernel/sched/core.c:6785 kernel/sched/core.c:6799)
<6>[ 252.832413] schedule_timeout (include/linux/timer.h:185
kernel/time/sleep_timeout.c:100)
<6>[ 252.832689] rcu_gp_fqs_loop (kernel/rcu/tree.c:2045 (discriminator 15))
<6>[ 252.832991] rcu_gp_kthread (kernel/rcu/tree.c:2250 (discriminator 2))
<6>[ 252.833264] kthread (kernel/kthread.c:389)
<6>[ 252.833511] ret_from_fork (arch/arm64/kernel/entry.S:863)
<struck>

Boot log link,
-----
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241031/testrun/25617342/suite/boot/test/gcc-13-lkftconfig-debug/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241031/testrun/25617342/suite/boot/test/gcc-13-lkftconfig-debug/details/

Build images:
------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oBwuVtvQdiUyZ16JGOe1JsS6KY/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2oBwvKQrvbVwqhTKdkXN0BXivv2

Steps to reproduce via qemu:
----------------
/usr/bin/qemu-system-aarch64 -cpu max,pauth-impdef=on \
   -machine virt,virtualization=on,gic-version=3,mte=on \
   -nographic -nic none -m 4G -monitor none -no-reboot \
   -smp 2 -kernel kernel/Image -append \"console=ttyAMA0,115200
rootwait root=/dev/vda debug verbose console_msg_format=syslog
systemd.log_level=warning rw earlycon\" \
   -drive file=rootfs.ext4,if=none,format=raw,id=hd0 \
   -device virtio-blk-device,drive=hd0


Steps to reproduce with tuxrun reproducer:
---------------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2oBwvKQrvbVwqhTKdkXN0BXivv2/reproducer

Boot history compare link:
------------------------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241031/testrun/25617515/suite/boot/test/gcc-13-lkftconfig-kselftest/history/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241031/testrun/25616350/suite/boot/test/clang-19-lkftconfig/history/

metadata:
---------
  git describe: next-20241031
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: f9f24ca362a4d84dd8aeb4b8f3ec28cb6c43dd06
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2oBwuVtvQdiUyZ16JGOe1JsS6KY/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2oBwuVtvQdiUyZ16JGOe1JsS6KY/
  toolchain: gcc-13, gcc-8 and clang-19
  config: defconfig+lkftconfig
  arch: arm64

Please let me know if you need more information.

--
Linaro LKFT
https://lkft.linaro.org
