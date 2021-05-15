Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E94C433ED
	for <rcu@archiver.kernel.org>; Sat, 15 May 2021 18:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A0561353
	for <rcu@archiver.kernel.org>; Sat, 15 May 2021 18:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhEOShZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 May 2021 14:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231558AbhEOShX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 May 2021 14:37:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BB1461264;
        Sat, 15 May 2021 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621103770;
        bh=c9kZz0fi7NPjOe1PJEFex+oAQGmlyG/CkSwJPzx/Lak=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=so8H/j09SHBBT1xMXwIZFRJeW8GzwTT8aG1+Zx3lFmoaKMzD2x35Z9fV6qPpcKvWw
         9J9ZTH4NTsb/Kqp9ufQeue0zxkgIyV5K5tZjYATwmGNX06PdkOU/bWX53hCqo8of/0
         BvCpCqAPc3ZTLGp/w/RLsVgneIMXJuKnpng9D/9991Z7n70zwWctFtdse7mEq94ISQ
         os0n6/3WbobLGUmzXNMxZ8JfEi9KzmsWdcqF560auhH58kgJ53WL7+MHfi+MxLcXmh
         CPAXiTWz7yyvlTnNZaGWU6k22FYMQvtocgUX62UoKHgZABiSuIhbNA1Altv8A6ehdU
         4tvSawMCiMcXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9EE45C0555; Sat, 15 May 2021 11:36:09 -0700 (PDT)
Date:   Sat, 15 May 2021 11:36:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     yanfei.xu@windriver.com
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: wrong stall log when only one task blocked within
 RCU read-side
Message-ID: <20210515183609.GA4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210515164511.3547618-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515164511.3547618-1-yanfei.xu@windriver.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 16, 2021 at 12:45:11AM +0800, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> The for loop in rcu_print_task_stall() always omits the first blocked
> task in RCU read-ride critical section. It will cause status of the
> blocked task can't be printed and lead a wrong ndetected variable.
> With the above, the wired stall log comes, All QSes seen, but qsmask
> still is not zero:
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    Tasks blocked on level-1 rcu_node (CPUs 12-23):
>         (detected by 15, t=6504 jiffies, g=164777, q=9011209)
> rcu: All QSes seen, last rcu_preempt kthread activity 1
> (4295252379-4295252378), jiffies_till_next_fqs=1, root ->qsmask 0x2
> BUG: sleeping function called from invalid context at
> include/linux/uaccess.h:156
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 70613, name:
> msgstress04
> INFO: lockdep is turned off.
> Preemption disabled at:
> [<ffff8000104031a4>] create_object.isra.0+0x204/0x4b0
> CPU: 15 PID: 70613 Comm: msgstress04 Kdump: loaded Not tainted
> 5.12.2-yoctodev-standard #1
> Hardware name: Marvell OcteonTX CN96XX board (DT)
> Call trace:
>  dump_backtrace+0x0/0x2cc
>  show_stack+0x24/0x30
>  dump_stack+0x110/0x188
>  ___might_sleep+0x214/0x2d0
>  __might_sleep+0x7c/0xe0
> 
> Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>

Apologies for that bug, and thank you for the fix!  Queued for testing
and review.  I wordsmithed as usual, so could you please check to make
sure that I did not mess anything up?

							Thanx, Paul

------------------------------------------------------------------------

commit 9855fdb508e2fa136551294861682d83b71daded
Author: Yanfei Xu <yanfei.xu@windriver.com>
Date:   Sun May 16 00:45:11 2021 +0800

    rcu: Fix to include first blocked task in stall warning
    
    The for loop in rcu_print_task_stall() always omits ts[0], which points
    to the first task blocking the stalled grace period.  This in turn fails
    to count this first task, which means that ndetected will be equal to
    zero when all CPUs have passed through their quiescent states and only
    one task is blocking the stalled grace period.  This zero value for
    ndetected will in turn result in an incorrect "All QSes seen" message:
    
    rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
    rcu:    Tasks blocked on level-1 rcu_node (CPUs 12-23):
            (detected by 15, t=6504 jiffies, g=164777, q=9011209)
    rcu: All QSes seen, last rcu_preempt kthread activity 1 (4295252379-4295252378), jiffies_till_next_fqs=1, root ->qsmask 0x2
    BUG: sleeping function called from invalid context at include/linux/uaccess.h:156
    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 70613, name: msgstress04
    INFO: lockdep is turned off.
    Preemption disabled at:
    [<ffff8000104031a4>] create_object.isra.0+0x204/0x4b0
    CPU: 15 PID: 70613 Comm: msgstress04 Kdump: loaded Not tainted
    5.12.2-yoctodev-standard #1
    Hardware name: Marvell OcteonTX CN96XX board (DT)
    Call trace:
     dump_backtrace+0x0/0x2cc
     show_stack+0x24/0x30
     dump_stack+0x110/0x188
     ___might_sleep+0x214/0x2d0
     __might_sleep+0x7c/0xe0
    
    This commit therefore fixes the loop to include ts[0].
    
    Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
    Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index f4152aa18f48..a10ea1f1f81f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -280,8 +280,8 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 			break;
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	for (i--; i; i--) {
-		t = ts[i];
+	while (i) {
+		t = ts[--i];
 		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
 			pr_cont(" P%d", t->pid);
 		else
