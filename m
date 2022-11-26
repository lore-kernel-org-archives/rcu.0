Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14FAC43217
	for <rcu@archiver.kernel.org>; Sat, 26 Nov 2022 01:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKZBiM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Nov 2022 20:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKZBiK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Nov 2022 20:38:10 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461CB1A044
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 17:38:09 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id jr19so3449297qtb.7
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 17:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cUS9Ou+wuuPIYQWeUU2uqQWaao2sRSSxYAjwiFGBA8=;
        b=QW94d2fJyRnP29eEPlM9k4KXu5vUE1dbaqmhUoCwoKsMN8J4blw41ue5UNIO69Bl2N
         gETmsyWludrHy5E2bAhuMoysPgZU9RJ+4yxA7WH42jQDH57ZhX2p+Ke51VtkiTX3HRxM
         ckvaNRiDCm+RNIMRWAmvmv/GQVpHZJmhwSurg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cUS9Ou+wuuPIYQWeUU2uqQWaao2sRSSxYAjwiFGBA8=;
        b=kB0uEXxbfb4XhA9NlvsSAAFEhTv7IG9dfDSAnzOMpIyLXwREcNThUn/ztSadZEW8Tj
         qka/TJMm6xHIZgqOKGRnKwrbC+Ry7FuvhTXKj9GIC4RH3GlOIkJGaQjgPRtccaYICDUB
         vKous9VpTd1JR+igAp+A3ua4gTskqpcLnXhs54qVdckwlrkJOsLIKMvbB031e8iaAayo
         OHTVScOGYE7zvqKz5Wqc6VyXwYw/sHIbVjvFlpAHrFKClQMbis9wb71xmuBVMLS9io0G
         jz9kVqr8lo78RIZhDhx+q5ZpNS2l4PfBPYMpciMGYe6vVlXsUuNrevhtp2VVc0ZcuhZy
         hqIA==
X-Gm-Message-State: ANoB5plAxAjm+w//jKyz/VPEoLNL/tPCH6Uu+0LnqTrNRbiRdc2cAJIA
        nvLnJWezm1W54qQbLoW9fMWv0VYbuCu+Tg==
X-Google-Smtp-Source: AA0mqf6veNlHj40O3PxEC4NpMANrlVA2BMF4NfA/BNYJHroUYeP/iy8hHzgfsaCS2BlfgY735BgEjQ==
X-Received: by 2002:ac8:6a1a:0:b0:35c:f2e5:a673 with SMTP id t26-20020ac86a1a000000b0035cf2e5a673mr39105444qtr.232.1669426688265;
        Fri, 25 Nov 2022 17:38:08 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id c14-20020ac8518e000000b003a611cb2a95sm2074925qtn.9.2022.11.25.17.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 17:38:07 -0800 (PST)
Date:   Sat, 26 Nov 2022 01:38:07 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: get_state_synchronize_rcu() at boot time
Message-ID: <Y4Ft/wthSRd0RJrA@google.com>
References: <20221125160516.GA303456@paulmck-ThinkPad-P17-Gen-1>
 <Y4EKihpFpRWysNvZ@pc638.lan>
 <20221125184509.GX4001@paulmck-ThinkPad-P17-Gen-1>
 <20221125201709.GA3203732@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125201709.GA3203732@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 25, 2022 at 12:17:09PM -0800, Paul E. McKenney wrote:
> On Fri, Nov 25, 2022 at 10:45:09AM -0800, Paul E. McKenney wrote:
> > On Fri, Nov 25, 2022 at 07:33:46PM +0100, Uladzislau Rezki wrote:
> > > > Hello, Uladzislau,
> > > > 
> > > > Here is where I placed that probe code and the corresponding output.
> > > > Where should I be placing it instead?
> > > > 
> > > > 						Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 219b4b516f387..308cbc5e68a64 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -4546,8 +4546,17 @@ void rcu_scheduler_starting(void)
> > > >  	local_irq_restore(flags);
> > > >  
> > > >  	// Switch out of early boot mode.
> > > > +	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> > > > +	synchronize_rcu();
> > > > +	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> > > >  	rcu_scheduler_active = RCU_SCHEDULER_INIT;
> > > > +	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> > > > +	synchronize_rcu();
> > > > +	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> > > >  	rcu_test_sync_prims();
> > > > +	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> > > > +	synchronize_rcu();
> > > > +	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> > > >  }
> > > >  
> > > >  /*
> > > > @@ -4817,6 +4826,9 @@ void __init rcu_init(void)
> > > >  
> > > >  	kfree_rcu_batch_init();
> > > >  	rcu_bootup_announce();
> > > > +	pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> > > > +	synchronize_rcu();
> > > > +	pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, get_state_synchronize_rcu());
> > > >  	sanitize_kthread_prio();
> > > >  	rcu_init_geometry();
> > > >  	rcu_init_one();
> > > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > > index 7b1e183b0eb23..2993be46f81d5 100644
> > > > --- a/kernel/rcu/update.c
> > > > +++ b/kernel/rcu/update.c
> > > > @@ -557,9 +557,12 @@ struct early_boot_kfree_rcu {
> > > >  static void early_boot_test_call_rcu(void)
> > > >  {
> > > >  	static struct rcu_head head;
> > > > +	int idx;
> > > >  	static struct rcu_head shead;
> > > >  	struct early_boot_kfree_rcu *rhp;
> > > >  
> > > > +	idx = srcu_down_read(&early_srcu);
> > > > +	srcu_up_read(&early_srcu, idx);
> > > >  	call_rcu(&head, test_callback);
> > > >  	early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
> > > >  	call_srcu(&early_srcu, &shead, test_callback);
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > [    0.016333] rcu: -> [0] Invoke synchronize_rcu(): seq number: 12
> > > > [    0.016334] rcu: -> [0] Done. A seq number: 16
> > > > [    0.114209] rcu: -> [0] Invoke synchronize_rcu(): seq number: 32
> > > > [    0.114662] rcu: -> [0] Done. A seq number: 36
> > > > [    0.115191] rcu: -> [0] Invoke synchronize_rcu(): seq number: 36
> > > > [    0.115684] rcu: -> [0] Done. A seq number: 40
> > > > [    0.116046] rcu: -> [0] Invoke synchronize_rcu(): seq number: 48
> > > > [    0.116202] rcu: -> [0] Done. A seq number: 52
> > > 
> > > Just for a backup:
> > > 
> > > urezki@pc638:~/data/raid0/coding/linux-rcu.git$ git diff
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 76973d716921..dea7dcc6973b 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3107,6 +3107,18 @@ static void kfree_rcu_work(struct work_struct *work)
> > >                         }
> > >                         rcu_lock_release(&rcu_callback_map);
> > >  
> > > +                       {
> > > +                               unsigned long seq_a;
> > > +                               unsigned long seq_b;
> > > +
> > > +                               seq_a = get_state_synchronize_rcu();
> > > +                               synchronize_rcu();
> > > +                               seq_b = get_state_synchronize_rcu();
> > > +
> > > +                               if (seq_a == seq_b)
> > > +                                       BUG();
> > > +                       }
> > > +
> > >                         raw_spin_lock_irqsave(&krcp->lock, flags);
> > >                         if (put_cached_bnode(krcp, bkvhead[i]))
> > >                                 bkvhead[i] = NULL;
> > > urezki@pc638:~/data/raid0/coding/linux-rcu.git$ head -10 Makefile 
> > > # SPDX-License-Identifier: GPL-2.0
> > > VERSION = 6
> > > PATCHLEVEL = 1
> > > SUBLEVEL = 0
> > > EXTRAVERSION = -rc1
> > > NAME = Hurr durr I'ma ninja sloth
> > > 
> > > # *DOCUMENTATION*
> > > # To see a list of typical targets execute "make help"
> > > # More info can be located in ./README
> > > urezki@pc638:~/data/raid0/coding/linux-rcu.git
> > > 
> > > urezki@pc638:~/data/raid0/coding/linux-rcu.git$ ../scripts/rcuscale.sh
> > > tools/testing/selftests/rcutorture/initrd/init already exists, no need to create it
> > > Results directory: /home/urezki/data/raid0/coding/linux-rcu.git/tools/testing/selftests/rcutorture/res/2022.11.25-17.50.32
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 --kconfig CONFIG_NR_CPUS=64 --kconfig CONFIG_RCU_NOCB_CPU=y --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y --kconfig CONFIG_RCU_LAZY=n --bootargs rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot --trust-make
> > > ----Start batch 1: Fri 25 Nov 2022 05:50:32 PM CET
> > > TREE 64: Starting build. Fri 25 Nov 2022 05:50:32 PM CET
> > > TREE 64: Waiting for build to complete. Fri 25 Nov 2022 05:50:32 PM CET
> > > TREE 64: Build complete. Fri 25 Nov 2022 05:50:37 PM CET
> > > ---- TREE 64: Kernel present. Fri 25 Nov 2022 05:50:37 PM CET
> > > ---- Starting kernels. Fri 25 Nov 2022 05:50:37 PM CET
> > > 
> > > 
> > > 
> > > ---- All kernel runs complete. Fri 25 Nov 2022 05:54:37 PM CET
> > > ---- TREE 64: Build/run results:
> > >  --- Fri 25 Nov 2022 05:50:32 PM CET: Starting build, PID 1284995
> > >  --- Fri 25 Nov 2022 05:50:37 PM CET: Starting kernel
> > >  --- Fri 25 Nov 2022 05:50:37 PM CET: Starting kernel, PID 1291757
> > > QEMU 5.2.0 monitor - type 'help' for more information
> > > (qemu) Monitoring qemu job at pid 1291776 Fri 25 Nov 2022 05:50:47 PM CET
> > > Grace period for qemu job at pid 1291776 Fri 25 Nov 2022 05:51:37 PM CET
> > > WARNING: Assertion failure in /home/urezki/data/raid0/coding/linux-rcu.git/tools/testing/selftests/rcutorture/res/2022.11.25-17.50.32/TREE/console.log TREE
> > > WARNING: Summary: Bugs: 4 Call Traces: 6
> > > 
> > > urezki@pc638:~/data/raid0/coding/linux-rcu.git$ cat ../scripts/rcuscale.sh
> > > #! /usr/bin/env bash
> > > 
> > > LOOPS=10
> > > 
> > > for (( i=0; i<$LOOPS; i++ )); do
> > >         tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
> > >         --kconfig CONFIG_NR_CPUS=64 \
> > >         --kconfig CONFIG_RCU_NOCB_CPU=y \
> > >         --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
> > >         --kconfig CONFIG_RCU_LAZY=n \
> > >         --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
> > >         echo "Done $i"
> > > done
> > > urezki@pc638:~/data/raid0/coding/linux-rcu.git$
> > > 
> > > [    0.911180] ------------[ cut here ]------------
> > > [    0.911747] kernel BUG at kernel/rcu/tree.c:3119!
> > > [    0.912332] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > [    0.912984] CPU: 0 PID: 408 Comm: kworker/0:2 Not tainted 6.1.0-rc1-00098-gcda6ad040ade-dirty #1509
> > > [    0.913325] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> > > [    0.913325] Workqueue: events kfree_rcu_work
> > > [    0.913325] RIP: 0010:kfree_rcu_work+0x348/0x350
> > > [    0.913325] Code: 85 48 ff ff ff 48 89 df e8 65 61 ff ff e9 3b ff ff ff c7 44 24 08 01 00 00 00 49 8b 6d 00 e9 49 fd ff ff 0f 0b e9 e5 fe ff ff <0f> 0b e8 91 5d af 00 90 48 83 ec 40 65 48 8b 04 25 28 00 00 00 48
> > > [    0.913325] RSP: 0018:ffff9fc680fc3e08 EFLAGS: 00010246
> > > [    0.913325] RAX: 0000000000000068 RBX: 0000000000000068 RCX: 0000000000000000
> > > [    0.913325] RDX: 0000000000000000 RSI: 0000000000000287 RDI: ffffffffab32f9f8
> > > [    0.913325] RBP: ffff8b2a45525000 R08: ffffffffab32ee30 R09: ffffffffab32ee30
> > > [    0.913325] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8b2a410d5580
> > > [    0.913325] R13: ffff9fc680fc3e28 R14: ffff8b2a45524000 R15: ffff8b2c34e1bb28
> > > [    0.913325] FS:  0000000000000000(0000) GS:ffff8b2c34e00000(0000) knlGS:0000000000000000
> > > [    0.913325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    0.913325] CR2: ffff8b2c3ffff000 CR3: 000000029aa0c000 CR4: 00000000000006f0
> > > [    0.913325] Call Trace:
> > > [    0.913325]  <TASK>
> > > [    0.913325]  ? finish_task_switch.isra.0+0x89/0x260
> > > [    0.913325]  process_one_work+0x1b4/0x310
> > > [    0.913325]  worker_thread+0x48/0x3c0
> > > [    0.913325]  ? process_one_work+0x310/0x310
> > > [    0.913325]  kthread+0xe2/0x110
> > > [    0.913325]  ? kthread_complete_and_exit+0x20/0x20
> > > [    0.913325]  ret_from_fork+0x22/0x30
> > > [    0.913325]  </TASK>
> > > [    0.913325] Modules linked in:
> > > [    0.930724] calling  init_posix_timers+0x0/0x29 @ 1
> > > [    0.931651] initcall init_posix_timers+0x0/0x29 returned 0 after 2 usecs
> > > [    0.933036] calling  clockevents_init_sysfs+0x0/0xc7 @ 1
> > > [    0.933179] ------------[ cut here ]------------
> > > [    0.934353] initcall clockevents_init_sysfs+0x0/0xc7 returned 0 after 406 usecs
> > > [    0.934812] kernel BUG at kernel/rcu/tree.c:3119!
> > 
> > And 110 runs had 46 cases where get_state_synchronize_rcu()
> > failed to notice a grace period's passage, and none for
> > get_state_synchronize_rcu_full().
> > 
> > So my advice is to either tolerate the occasional obliviousness of
> > get_state_synchronize_rcu() or switch to get_state_synchronize_rcu_full().
> 
> Here is the patch I used, just for posterity.

Hello,

I am wondering if it is worth changing it to _full().

If I'm understanding the thread correctly, the suggestion is to use _full()
variant of the polling API, as we do not know if an expedited GP also
elapsed when since sampling the regular rcu_state.gp_seq.

If get_state_synchronize_rcu() does not notice a GP passage, that's OK it
will just wait for another GP. 46 cases of 110 runs sounds very tiny to
justify increasing the size of the data structure for _full() so let us keep
it as get_state_synchronize_rcu(). Do we know how many cases in total each
run had, I am assuming millions?

Or did I miss something?

thanks!

 - Joel


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ae24f6f94f2b7..3de9e95715631 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2905,6 +2905,10 @@ static void kfree_rcu_work(struct work_struct *work)
>  	struct kfree_rcu_cpu *krcp;
>  	struct kfree_rcu_cpu_work *krwp;
>  	int i, j;
> +	unsigned long oldstate;
> +	struct rcu_gp_oldstate oldfullstate;
> +	unsigned long newstate;
> +	struct rcu_gp_oldstate newfullstate;
>  
>  	krwp = container_of(to_rcu_work(work),
>  			    struct kfree_rcu_cpu_work, rcu_work);
> @@ -2957,6 +2961,15 @@ static void kfree_rcu_work(struct work_struct *work)
>  
>  			cond_resched_tasks_rcu_qs();
>  		}
> +		oldstate = get_state_synchronize_rcu();
> +		get_state_synchronize_rcu_full(&oldfullstate);
> +		pr_err("-> [%d] Invoke synchronize_rcu(): seq number: %lu\n", current->pid, oldstate);
> +		synchronize_rcu();
> +		get_state_synchronize_rcu_full(&newfullstate);
> +		newstate = get_state_synchronize_rcu();
> +		WARN_ON_ONCE(same_state_synchronize_rcu(oldstate, newstate));
> +		WARN_ON_ONCE(same_state_synchronize_rcu_full(&oldfullstate, &newfullstate));
> +		pr_err("-> [%d] Done. A seq number: %lu\n", current->pid, newstate);
>  	}
>  
>  	/*
