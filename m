Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D06BC4332F
	for <rcu@archiver.kernel.org>; Fri, 25 Nov 2022 18:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKYSdw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Nov 2022 13:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKYSdv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Nov 2022 13:33:51 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1CC4EC33
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 10:33:50 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt23so12057952ejc.7
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 10:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGeFtC2tsUrvqCL/IYB9IQCUSRTZiqMrscDMvBALSIo=;
        b=demwEfueEuE2BEZwhzF9EmkakdMf3NOUXXTsJMal18s+BBKMDuNfsiriVzS+WXkZIa
         jjRaUNSv7pXHxzSH9DlinOZrELZ84eB3FHLVbXXMKUnqr+jvY8MXKwAtY8hgeKFcN0FP
         37QcSYr2fAZIZGnGF8OVBLFkRFfiwoCth5zv19IKnlr2gpuwHbIrRtTwVIJwlQMvexFc
         a5cjJ99BwNIJ9VwB3GjSEsDG80JCe/h/yYSD0xJV7r0ZXXGWtmpad3VIRM6wBZK38r/Y
         IlN5q9MQuxNJwt/tctjOWEW4h6+v63b4AwXsa3OEQQP1dY8YrR7y9viPE/dSS5r1foia
         Sy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGeFtC2tsUrvqCL/IYB9IQCUSRTZiqMrscDMvBALSIo=;
        b=YSoJjgRCokFF8o67MeZNPhKbm/kA6ubO9+VlWCdGARDqwZCYihC4R4Vca8jeM9ZlCS
         DWQuRg5scllpWnRv4An3EhY+qqfwoIDfePVny5UIlTdX+th41F15nPYKfdovecVcFM22
         R+R2LJ2AK9mhBnZ4Vn/u6qMDupmOWsk5X9nqWAa8s50BH0Tml36mrGFQB15XzwdF5UAy
         OuhL+sRCrrQ0P1d37lbhlAthtkKpyLX2kVPWTxCwbJIzF7PapTyWZCj/jUs+hqNJiwMp
         pcSEkxa463zwQkSsMzgvI6vbB7euJVkCYirQpYITZl7swSEY/R1DI6J815b1iFCyht1O
         pmdw==
X-Gm-Message-State: ANoB5pntNKmRm+yaTKVcv8aZoR+IigofyzFc+t6W4f3Xgcrsnxd9+crK
        QaxrV9FWwfxyOyMQtGsScKY=
X-Google-Smtp-Source: AA0mqf5vsazR/nPRx8JoYUrSkw18dk5WzmvwXCC2BXevy6ButTfFTye9q1bU1TxA+Ytnp0B9b6yobw==
X-Received: by 2002:a17:906:597:b0:7a8:fd1a:c073 with SMTP id 23-20020a170906059700b007a8fd1ac073mr25276773ejn.4.1669401228383;
        Fri, 25 Nov 2022 10:33:48 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id n3-20020a056402514300b0045d59e49acbsm2074785edd.7.2022.11.25.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 10:33:47 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 25 Nov 2022 19:33:46 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     urezki@gmail.com, rcu@vger.kernel.org
Subject: Re: get_state_synchronize_rcu() at boot time
Message-ID: <Y4EKihpFpRWysNvZ@pc638.lan>
References: <20221125160516.GA303456@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125160516.GA303456@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> Hello, Uladzislau,
> 
> Here is where I placed that probe code and the corresponding output.
> Where should I be placing it instead?
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 219b4b516f387..308cbc5e68a64 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4546,8 +4546,17 @@ void rcu_scheduler_starting(void)
>  	local_irq_restore(flags);
>  
>  	// Switch out of early boot mode.
> +	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> +	synchronize_rcu();
> +	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
>  	rcu_scheduler_active = RCU_SCHEDULER_INIT;
> +	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> +	synchronize_rcu();
> +	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
>  	rcu_test_sync_prims();
> +	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> +	synchronize_rcu();
> +	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
>  }
>  
>  /*
> @@ -4817,6 +4826,9 @@ void __init rcu_init(void)
>  
>  	kfree_rcu_batch_init();
>  	rcu_bootup_announce();
> +	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> +	synchronize_rcu();
> +	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
>  	sanitize_kthread_prio();
>  	rcu_init_geometry();
>  	rcu_init_one();
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 7b1e183b0eb23..2993be46f81d5 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -557,9 +557,12 @@ struct early_boot_kfree_rcu {
>  static void early_boot_test_call_rcu(void)
>  {
>  	static struct rcu_head head;
> +	int idx;
>  	static struct rcu_head shead;
>  	struct early_boot_kfree_rcu *rhp;
>  
> +	idx = srcu_down_read(&early_srcu);
> +	srcu_up_read(&early_srcu, idx);
>  	call_rcu(&head, test_callback);
>  	early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
>  	call_srcu(&early_srcu, &shead, test_callback);
> 
> ------------------------------------------------------------------------
> 
> [    0.016333] rcu: -> [0] Invoke synchronize_rcu(): seq number: 12
> [    0.016334] rcu: -> [0] Done. A seq number: 16
> [    0.114209] rcu: -> [0] Invoke synchronize_rcu(): seq number: 32
> [    0.114662] rcu: -> [0] Done. A seq number: 36
> [    0.115191] rcu: -> [0] Invoke synchronize_rcu(): seq number: 36
> [    0.115684] rcu: -> [0] Done. A seq number: 40
> [    0.116046] rcu: -> [0] Invoke synchronize_rcu(): seq number: 48
> [    0.116202] rcu: -> [0] Done. A seq number: 52

Just for a backup:

urezki@pc638:~/data/raid0/coding/linux-rcu.git$ git diff
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 76973d716921..dea7dcc6973b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3107,6 +3107,18 @@ static void kfree_rcu_work(struct work_struct *work)
                        }
                        rcu_lock_release(&rcu_callback_map);
 
+                       {
+                               unsigned long seq_a;
+                               unsigned long seq_b;
+
+                               seq_a = get_state_synchronize_rcu();
+                               synchronize_rcu();
+                               seq_b = get_state_synchronize_rcu();
+
+                               if (seq_a == seq_b)
+                                       BUG();
+                       }
+
                        raw_spin_lock_irqsave(&krcp->lock, flags);
                        if (put_cached_bnode(krcp, bkvhead[i]))
                                bkvhead[i] = NULL;
urezki@pc638:~/data/raid0/coding/linux-rcu.git$ head -10 Makefile 
# SPDX-License-Identifier: GPL-2.0
VERSION = 6
PATCHLEVEL = 1
SUBLEVEL = 0
EXTRAVERSION = -rc1
NAME = Hurr durr I'ma ninja sloth

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
urezki@pc638:~/data/raid0/coding/linux-rcu.git

urezki@pc638:~/data/raid0/coding/linux-rcu.git$ ../scripts/rcuscale.sh
tools/testing/selftests/rcutorture/initrd/init already exists, no need to create it
Results directory: /home/urezki/data/raid0/coding/linux-rcu.git/tools/testing/selftests/rcutorture/res/2022.11.25-17.50.32
tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 --kconfig CONFIG_NR_CPUS=64 --kconfig CONFIG_RCU_NOCB_CPU=y --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y --kconfig CONFIG_RCU_LAZY=n --bootargs rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot --trust-make
----Start batch 1: Fri 25 Nov 2022 05:50:32 PM CET
TREE 64: Starting build. Fri 25 Nov 2022 05:50:32 PM CET
TREE 64: Waiting for build to complete. Fri 25 Nov 2022 05:50:32 PM CET
TREE 64: Build complete. Fri 25 Nov 2022 05:50:37 PM CET
---- TREE 64: Kernel present. Fri 25 Nov 2022 05:50:37 PM CET
---- Starting kernels. Fri 25 Nov 2022 05:50:37 PM CET



---- All kernel runs complete. Fri 25 Nov 2022 05:54:37 PM CET
---- TREE 64: Build/run results:
 --- Fri 25 Nov 2022 05:50:32 PM CET: Starting build, PID 1284995
 --- Fri 25 Nov 2022 05:50:37 PM CET: Starting kernel
 --- Fri 25 Nov 2022 05:50:37 PM CET: Starting kernel, PID 1291757
QEMU 5.2.0 monitor - type 'help' for more information
(qemu) Monitoring qemu job at pid 1291776 Fri 25 Nov 2022 05:50:47 PM CET
Grace period for qemu job at pid 1291776 Fri 25 Nov 2022 05:51:37 PM CET
WARNING: Assertion failure in /home/urezki/data/raid0/coding/linux-rcu.git/tools/testing/selftests/rcutorture/res/2022.11.25-17.50.32/TREE/console.log TREE
WARNING: Summary: Bugs: 4 Call Traces: 6

urezki@pc638:~/data/raid0/coding/linux-rcu.git$ cat ../scripts/rcuscale.sh
#! /usr/bin/env bash

LOOPS=10

for (( i=0; i<$LOOPS; i++ )); do
        tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
        --kconfig CONFIG_NR_CPUS=64 \
        --kconfig CONFIG_RCU_NOCB_CPU=y \
        --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
        --kconfig CONFIG_RCU_LAZY=n \
        --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
        echo "Done $i"
done
urezki@pc638:~/data/raid0/coding/linux-rcu.git$

[    0.911180] ------------[ cut here ]------------
[    0.911747] kernel BUG at kernel/rcu/tree.c:3119!
[    0.912332] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[    0.912984] CPU: 0 PID: 408 Comm: kworker/0:2 Not tainted 6.1.0-rc1-00098-gcda6ad040ade-dirty #1509
[    0.913325] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[    0.913325] Workqueue: events kfree_rcu_work
[    0.913325] RIP: 0010:kfree_rcu_work+0x348/0x350
[    0.913325] Code: 85 48 ff ff ff 48 89 df e8 65 61 ff ff e9 3b ff ff ff c7 44 24 08 01 00 00 00 49 8b 6d 00 e9 49 fd ff ff 0f 0b e9 e5 fe ff ff <0f> 0b e8 91 5d af 00 90 48 83 ec 40 65 48 8b 04 25 28 00 00 00 48
[    0.913325] RSP: 0018:ffff9fc680fc3e08 EFLAGS: 00010246
[    0.913325] RAX: 0000000000000068 RBX: 0000000000000068 RCX: 0000000000000000
[    0.913325] RDX: 0000000000000000 RSI: 0000000000000287 RDI: ffffffffab32f9f8
[    0.913325] RBP: ffff8b2a45525000 R08: ffffffffab32ee30 R09: ffffffffab32ee30
[    0.913325] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8b2a410d5580
[    0.913325] R13: ffff9fc680fc3e28 R14: ffff8b2a45524000 R15: ffff8b2c34e1bb28
[    0.913325] FS:  0000000000000000(0000) GS:ffff8b2c34e00000(0000) knlGS:0000000000000000
[    0.913325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.913325] CR2: ffff8b2c3ffff000 CR3: 000000029aa0c000 CR4: 00000000000006f0
[    0.913325] Call Trace:
[    0.913325]  <TASK>
[    0.913325]  ? finish_task_switch.isra.0+0x89/0x260
[    0.913325]  process_one_work+0x1b4/0x310
[    0.913325]  worker_thread+0x48/0x3c0
[    0.913325]  ? process_one_work+0x310/0x310
[    0.913325]  kthread+0xe2/0x110
[    0.913325]  ? kthread_complete_and_exit+0x20/0x20
[    0.913325]  ret_from_fork+0x22/0x30
[    0.913325]  </TASK>
[    0.913325] Modules linked in:
[    0.930724] calling  init_posix_timers+0x0/0x29 @ 1
[    0.931651] initcall init_posix_timers+0x0/0x29 returned 0 after 2 usecs
[    0.933036] calling  clockevents_init_sysfs+0x0/0xc7 @ 1
[    0.933179] ------------[ cut here ]------------
[    0.934353] initcall clockevents_init_sysfs+0x0/0xc7 returned 0 after 406 usecs
[    0.934812] kernel BUG at kernel/rcu/tree.c:3119!

--
Uladzislau Rezki
