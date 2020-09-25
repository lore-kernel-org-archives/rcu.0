Return-Path: <SRS0=1ltc=DC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DA2C4363D
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 17:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532FD21D42
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601054013;
	bh=ti22SxcurzOVwjbQ0OSmV+nIlJOiyn0KdaZY90nJPlU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=0g/phjsXxCKwOOW0UN0DPevbI2CzAKRUeX/Wa6IVVDKx6Hz7PdRpvxgth4Jz62oim
	 45b/FZBB1s52aQ8N10jy48Ky59LH3sPTbvtdabBdqveOPeeQtTxJxCzP6DKX8jX6eS
	 C0yPmHnBwk+b0Vy6B3GJbZRaJnM46ScuhR4ymjsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgIYRNd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgIYRNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Sep 2020 13:13:32 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE36E20936;
        Fri, 25 Sep 2020 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601054011;
        bh=ti22SxcurzOVwjbQ0OSmV+nIlJOiyn0KdaZY90nJPlU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PNyjcsNPyihicpZ9GUOulMgzb6BJEnIW3Tu3F6s1CknkkVwbVCoYrGZ7UVh8kvjZq
         pHJaij6QK10Yq5ZkH2QsTw6Y/mvKcDzxD8JkDNDg7t+3oWNOz1r7L8bQibhqUXvR8M
         KYtvF7f2rohEMaxOmXwoFTqh49vkk3mDu+MLpFIg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 84A0435207C1; Fri, 25 Sep 2020 10:13:31 -0700 (PDT)
Date:   Fri, 25 Sep 2020 10:13:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2 2/2] locktorture: call percpu_free_rwsem() to do
 percpu-rwsem cleanup
Message-ID: <20200925171331.GF29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200923035137.GN29330@paulmck-ThinkPad-P72>
 <20200924141854.134835-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924141854.134835-1-houtao1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 24, 2020 at 10:18:54PM +0800, Hou Tao wrote:
> When do percpu-rwsem writer lock torture, the RCU callback
> rcu_sync_func() may still be pending after locktorture module
> is removed, and it will lead to the following Oops:
> 
>   BUG: unable to handle page fault for address: ffffffffc00eb920
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 6500a067 P4D 6500a067 PUD 6500c067 PMD 13a36c067 PTE 800000013691c163
>   Oops: 0000 [#1] PREEMPT SMP
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc5+ #4
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   RIP: 0010:rcu_cblist_dequeue+0x12/0x30
>   Call Trace:
>    <IRQ>
>    rcu_core+0x1b1/0x860
>    __do_softirq+0xfe/0x326
>    asm_call_on_stack+0x12/0x20
>    </IRQ>
>    do_softirq_own_stack+0x5f/0x80
>    irq_exit_rcu+0xaf/0xc0
>    sysvec_apic_timer_interrupt+0x2e/0xb0
>    asm_sysvec_apic_timer_interrupt+0x12/0x20
> 
> Fix it by adding an exit hook in lock_torture_ops and
> use it to call percpu_free_rwsem() for percpu rwsem torture
> before the module is removed, so we can ensure rcu_sync_func()
> completes before module exits.
> 
> Also needs to call exit hook if lock_torture_init() fails half-way,
> so add init_called field in lock_torture_cxt to indicate that
> init hook has been called.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Nice, thank you!  I have queued this for v5.11.

As always, I could not resist reworking the commit log as below, and
as always, please check to make sure that I didn't mess anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit f794b408207152995aefdf41ee9a3f5c974f622a
Author: Hou Tao <houtao1@huawei.com>
Date:   Thu Sep 24 22:18:54 2020 +0800

    locktorture: Invoke percpu_free_rwsem() to do percpu-rwsem cleanup
    
    When executing the LOCK06 locktorture scenario featuring percpu-rwsem,
    the RCU callback rcu_sync_func() may still be pending after locktorture
    module is removed.  This can in turn lead to the following Oops:
    
      BUG: unable to handle page fault for address: ffffffffc00eb920
      #PF: supervisor read access in kernel mode
      #PF: error_code(0x0000) - not-present page
      PGD 6500a067 P4D 6500a067 PUD 6500c067 PMD 13a36c067 PTE 800000013691c163
      Oops: 0000 [#1] PREEMPT SMP
      CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc5+ #4
      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
      RIP: 0010:rcu_cblist_dequeue+0x12/0x30
      Call Trace:
       <IRQ>
       rcu_core+0x1b1/0x860
       __do_softirq+0xfe/0x326
       asm_call_on_stack+0x12/0x20
       </IRQ>
       do_softirq_own_stack+0x5f/0x80
       irq_exit_rcu+0xaf/0xc0
       sysvec_apic_timer_interrupt+0x2e/0xb0
       asm_sysvec_apic_timer_interrupt+0x12/0x20
    
    This commit avoids tis problem by adding an exit hook in lock_torture_ops
    and using it to call percpu_free_rwsem() for percpu rwsem torture during
    the module-cleanup function, thus ensuring that rcu_sync_func() completes
    before module exits.
    
    It is also necessary to call the exit hook if lock_torture_init()
    fails half-way, so this commit also adds an ->init_called field in
    lock_torture_cxt to indicate that exit hook, if present, must be called.
    
    Signed-off-by: Hou Tao <houtao1@huawei.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 79fbd97..fd838ce 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -76,6 +76,7 @@ static void lock_torture_cleanup(void);
  */
 struct lock_torture_ops {
 	void (*init)(void);
+	void (*exit)(void);
 	int (*writelock)(void);
 	void (*write_delay)(struct torture_random_state *trsp);
 	void (*task_boost)(struct torture_random_state *trsp);
@@ -92,12 +93,13 @@ struct lock_torture_cxt {
 	int nrealwriters_stress;
 	int nrealreaders_stress;
 	bool debug_lock;
+	bool init_called;
 	atomic_t n_lock_torture_errors;
 	struct lock_torture_ops *cur_ops;
 	struct lock_stress_stats *lwsa; /* writer statistics */
 	struct lock_stress_stats *lrsa; /* reader statistics */
 };
-static struct lock_torture_cxt cxt = { 0, 0, false,
+static struct lock_torture_cxt cxt = { 0, 0, false, false,
 				       ATOMIC_INIT(0),
 				       NULL, NULL};
 /*
@@ -573,6 +575,11 @@ static void torture_percpu_rwsem_init(void)
 	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
 }
 
+static void torture_percpu_rwsem_exit(void)
+{
+	percpu_free_rwsem(&pcpu_rwsem);
+}
+
 static int torture_percpu_rwsem_down_write(void) __acquires(pcpu_rwsem)
 {
 	percpu_down_write(&pcpu_rwsem);
@@ -597,6 +604,7 @@ static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
 
 static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.init		= torture_percpu_rwsem_init,
+	.exit		= torture_percpu_rwsem_exit,
 	.writelock	= torture_percpu_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
 	.task_boost     = torture_boost_dummy,
@@ -789,9 +797,10 @@ static void lock_torture_cleanup(void)
 
 	/*
 	 * Indicates early cleanup, meaning that the test has not run,
-	 * such as when passing bogus args when loading the module. As
-	 * such, only perform the underlying torture-specific cleanups,
-	 * and avoid anything related to locktorture.
+	 * such as when passing bogus args when loading the module.
+	 * However cxt->cur_ops.init() may have been invoked, so beside
+	 * perform the underlying torture-specific cleanups, cur_ops.exit()
+	 * will be invoked if needed.
 	 */
 	if (!cxt.lwsa && !cxt.lrsa)
 		goto end;
@@ -831,6 +840,11 @@ static void lock_torture_cleanup(void)
 	cxt.lrsa = NULL;
 
 end:
+	if (cxt.init_called) {
+		if (cxt.cur_ops->exit)
+			cxt.cur_ops->exit();
+		cxt.init_called = false;
+	}
 	torture_cleanup_end();
 }
 
@@ -878,8 +892,10 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (cxt.cur_ops->init)
+	if (cxt.cur_ops->init) {
 		cxt.cur_ops->init();
+		cxt.init_called = true;
+	}
 
 	if (nwriters_stress >= 0)
 		cxt.nrealwriters_stress = nwriters_stress;
