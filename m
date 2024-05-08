Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F3134B0
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 04:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715144140; cv=none; b=V7bxu2kNrRDttKC2Vld4x99x/zjr/L6cwBYwH6xOcB186N0xv84Md4zoz1NZHFjFzubdpAxQ5Ssks/JHYLBxIagAyH8RvRRD1dDGPfsPUPA0tsxMWVdElUBs+HVSi1clfJEKC5p4hyE3x49AiKkHhQ39FSdhkXz59nAg/dCoU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715144140; c=relaxed/simple;
	bh=U41MrgbYkPsrR6ThQO+8iR1bpZP3uqlDLJ8VV1Zd/6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEPWnXnQU3UAmxSXDmGNhhLOVEmSDfkTeYW61UkCz9PSDI03Xt1fQEFAoT4adrOLlHQqeZdmzQL8QaYLywMrppGaGWjKFKw1mV6uzJyYiHSH1bhrA6B64sPG73v4eprzfO3Hu4YXzkSh7P8Zr95xFJxQQTXatqMnByL29cge1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDQmjPkq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDQmjPkq"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-628a551d10cso1915771a12.1
        for <rcu@vger.kernel.org>; Tue, 07 May 2024 21:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715144137; x=1715748937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcNRCWZQuK2YXfFCpoV9ZB/QI8fhXRe4GDZiAfl5EvM=;
        b=aDQmjPkqOIvIjKn46YxRF6/fHQxhINm7B+wb4aqS3y2hmZcBHhK+DDfZJSihbRPz+V
         mZT+BV5JGR4XFuFawtiuTYljjeSmzYTqmnZkFvYSgUpqxnFhMn8C7a80ABGa9wRb2Wzt
         Dpy/hvjo3BowGlsmj6scCueZg8DbTGj7uRYaP+0a23epUHJL15aXbUHXaW6BP3jhtcrb
         Db4QRXbXIVny0r1HUHSk+BL9dlCdyQDkS4XDxoGq7VKIbgTtaxb/Zu+3ftUD1oYRj2Mh
         a53ROdkYnquZy5YVl3qaHmKsjA0CsL4VvW7DvEmbSaJLPh5/XhqObSxgsrqYu7v/UpGW
         x5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715144137; x=1715748937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcNRCWZQuK2YXfFCpoV9ZB/QI8fhXRe4GDZiAfl5EvM=;
        b=mJTDaxI45molq2DZxOs1vPpsBDVLuxun0pC7fravk1FUsHZ7pKpJ3A95rtQ2F05Cn6
         NZYb6M7v1tsGmNUMYzv2pSRGaLejOx85CkQzOStzpCfvWn0OUPFXOpXG9Z1fwd/nul6K
         GVnvONaxcfJQiB6Ey4qQ4ixafxD6GtH0Ow62xSFMIoBmOb/BrCChSxF2w1z1WyKRiGFu
         qJtC7EUllGRwk0EN6jEhmNo6J0dzmoZ47wpRyXrjylqgUwfB4jY++PwR13thSOGIpo/Y
         WVXYwZjVp6HZDnCgTaEakN1ZQSEHbve5NRFQsomC4tbnqJRcpArg8uvsccckw8W70ifB
         EOfw==
X-Forwarded-Encrypted: i=1; AJvYcCX6TDPbVCdU6qGdlBsHW3OL41e7wipcYRJ/5j5lPpIigXHrOP68/gkjuCZEIN7iqwANDpx7dKj5v3aVOgmynldGH4ew
X-Gm-Message-State: AOJu0Yz2NgSP7S6QJx/IJQo038ku+aWZ68BgPuH+xowI6xFLSsj+LRlm
	i8MJ72sXNufoc8yxNohs1TiX8bfVS+A+6wvRiKxIineM05cq35Zzsehjtxms2PwAZ6o6VlqsCUN
	DPTprWTUEQFV5K/KqcMqvL9bNarY=
X-Google-Smtp-Source: AGHT+IEgdaboXMD1SZjC+1ENkzJAKSXDfPlFJc3dWJ6Ku0Yief/WCdOwX0S0AqL9vzZfioFpDMgQpsky7WFY4jOaYrs=
X-Received: by 2002:a05:6a21:3985:b0:1af:9ede:58a4 with SMTP id
 adf61e73a8af0-1afc8dbe129mr1913419637.42.1715144136710; Tue, 07 May 2024
 21:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405072252.959dadc4-lkp@intel.com>
In-Reply-To: <202405072252.959dadc4-lkp@intel.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 8 May 2024 12:55:25 +0800
Message-ID: <CALm+0cViRh07e88uMrRp=5K0TgBVFwmwLiLnejc7puEMXrmFsA@mail.gmail.com>
Subject: Re: [linux-next:master] [rcu/nocb] 4c66bc7cac: BUG:using_smp_processor_id()in_preemptible
To: kernel test robot <oliver.sang@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
>
>
> Hello,
>
> kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:
>
> commit: 4c66bc7cacc08e8abcf5049d2b90bfd800904336 ("rcu/nocb: Use kthread parking instead of ad-hoc implementation")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 9221b2819b8a4196eecf5476d66201be60fbcf29]
>
> in testcase: boot
>
> compiler: gcc-13
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +--------------------------------------------------------------+------------+------------+
> |                                                              | 6deb20902f | 4c66bc7cac |
> +--------------------------------------------------------------+------------+------------+
> | BUG:using_smp_processor_id()in_preemptible                   | 0          | 12         |
> +--------------------------------------------------------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202405072252.959dadc4-lkp@intel.com
>
>
> [    4.099901][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.101313][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.102493][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.104098][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.104398][   T18] Call Trace:
> [    4.104398][   T18]  <TASK>
> [ 4.104398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.104398][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.104398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.104398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.104398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.104398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))


Please try the following modifications:

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 340bbefe5f65..b93e40206621 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -28,8 +28,8 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
                !(lockdep_is_held(&rcu_state.barrier_mutex) ||
                  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
                  rcu_lockdep_is_held_nocb(rdp) ||
-                 (rdp == this_cpu_ptr(&rcu_data) &&
-                  !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+                  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
+                   rdp == this_cpu_ptr(&rcu_data)) ||
                  rcu_current_is_nocb_kthread(rdp)),
                "Unsafe read of RCU_NOCB offloaded state"
        );

Thanks
Zqiang


> [ 4.104398][ T18] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
> [ 4.104398][ T18] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421 (discriminator 16))
> [ 4.104398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.104398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.104398][ T18] kthread (kernel/kthread.c:388)
> [ 4.104398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.104398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.104398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.104398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.104398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.104398][   T18]  </TASK>
> [    4.106221][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.107796][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.108547][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.109667][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.111064][   T18] Call Trace:
> [    4.111064][   T18]  <TASK>
> [ 4.111064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.111064][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.111064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.111064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.111064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.111064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.111064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.111064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.111064][ T18] kthread (kernel/kthread.c:388)
> [ 4.111064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.111064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.111064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.111064][   T18]  </TASK>
> [    4.132677][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
> [    4.135331][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.137454][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.137849][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.139414][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.141064][   T18] Call Trace:
> [    4.141064][   T18]  <TASK>
> [ 4.141064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.141064][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.141064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.141064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.141064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.141064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.141064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.141064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.141064][ T18] kthread (kernel/kthread.c:388)
> [ 4.141064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.141064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.141064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.141064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.141064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.141064][   T18]  </TASK>
> [    4.141391][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.143427][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.144497][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.146055][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.147731][   T18] Call Trace:
> [    4.147731][   T18]  <TASK>
> [ 4.147731][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.147731][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.147731][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.147731][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.147731][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.147731][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.147731][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.147731][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.147731][ T18] kthread (kernel/kthread.c:388)
> [ 4.147731][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.147731][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.147731][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.147731][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.147731][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.147731][   T18]  </TASK>
> [    4.148538][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.150537][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.151144][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.152635][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.154398][   T18] Call Trace:
> [    4.154398][   T18]  <TASK>
> [ 4.154398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.154398][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.154398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.154398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.154398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.154398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.154398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.154398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.154398][ T18] kthread (kernel/kthread.c:388)
> [ 4.154398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.154398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.154398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.154398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.154398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.154398][   T18]  </TASK>
> [    4.156100][    T1] smp: Bringing up secondary CPUs ...
> [    4.159421][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.161134][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.162569][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.164398][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.164398][   T18] Call Trace:
> [    4.164398][   T18]  <TASK>
> [ 4.164398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.164398][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.164398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.164398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.164398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.164398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.164398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.164398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.164398][ T18] kthread (kernel/kthread.c:388)
> [ 4.164398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.164398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.164398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.164398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.164398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.164398][   T18]  </TASK>
> [    4.168016][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.170139][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.171170][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.173242][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.174398][   T18] Call Trace:
> [    4.174398][   T18]  <TASK>
> [ 4.174398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.174398][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.174398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.174398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.174398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.174398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.174398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.174398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.174398][ T18] kthread (kernel/kthread.c:388)
> [ 4.174398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.174398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.174398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.174398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.174398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.174398][   T18]  </TASK>
> [    4.189949][    T1] smpboot: x86: Booting SMP configuration:
> [    4.191158][    T1] .... node  #0, CPUs:      #1
> [    1.668906][    T0] masked ExtINT on CPU#1
> [    4.202955][   T29] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/1/29
> [ 4.204471][ T29] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.205845][   T29] CPU: 0 PID: 29 Comm: rcuop/1 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.207731][   T29] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.207731][   T29] Call Trace:
> [    4.207731][   T29]  <TASK>
> [ 4.207731][ T29] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.207731][ T29] dump_stack (lib/dump_stack.c:124)
> [ 4.207731][ T29] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.207731][ T29] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.207731][ T29] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.207731][ T29] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.207731][ T29] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
> [ 4.207731][ T29] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421 (discriminator 16))
> [ 4.207731][ T29] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.207731][ T29] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.207731][ T29] kthread (kernel/kthread.c:388)
> [ 4.207731][ T29] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.207731][ T29] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.207731][ T29] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.207731][ T29] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.207731][ T29] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.207731][   T29]  </TASK>
> [    4.207989][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.209997][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.211188][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.212898][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.214398][   T18] Call Trace:
> [    4.214398][   T18]  <TASK>
> [ 4.214398][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.214398][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.214398][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.214398][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.214398][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.214398][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.214398][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.214398][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.214398][ T18] kthread (kernel/kthread.c:388)
> [ 4.214398][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.214398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.214398][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.214398][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.214398][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.214398][   T18]  </TASK>
> [    4.215399][   T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
> [ 4.217064][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [    4.217772][   T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
> [    4.219363][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    4.221064][   T18] Call Trace:
> [    4.221064][   T18]  <TASK>
> [ 4.221064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
> [ 4.221064][ T18] dump_stack (lib/dump_stack.c:124)
> [ 4.221064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
> [ 4.221064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 4.221064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
> [ 4.221064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
> [ 4.221064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
> [ 4.221064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
> [ 4.221064][ T18] kthread (kernel/kthread.c:388)
> [ 4.221064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
> [ 4.221064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.221064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 4.221064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 4.221064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [    4.221064][   T18]  </TASK>
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240507/202405072252.959dadc4-lkp@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
