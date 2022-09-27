Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77533C54EE9
	for <rcu@archiver.kernel.org>; Tue, 27 Sep 2022 18:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiI0SvY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Sep 2022 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI0SvX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Sep 2022 14:51:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B914AD4E
        for <rcu@vger.kernel.org>; Tue, 27 Sep 2022 11:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 920E161B33
        for <rcu@vger.kernel.org>; Tue, 27 Sep 2022 18:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5103C433D6;
        Tue, 27 Sep 2022 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664304682;
        bh=n33ey5ZgxV5n3qg7TAfLj9YMWFz9aiRkc41sZdN6zyY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KF0tj6WS9YjecHNikYoZoEb01zxscbnLOIJUqjvEOMCXVsR53TePi00+y5nYdKTMe
         1w5ltvDNnKfaQQQVEN6PXu6uwZkrILvwz+6AYgYGlQ5nfA0Xlz8yXg5/SoHCDZ9vv1
         yZqR11anwver1SBstm6qYmnb6dWgq2GewOpYd83RmUUQTf/LDwq2MJbGaSC2iUt2S/
         IrPaMARha2b+oTpdkIthag4NEHrdq+4ADKZCqkcqnTLqlCHKgHquFBVG3qxPWacUor
         RYpY1hYgOaKF5M2SVmRn2Y5HQphrxvfs8Q3zg6y/3QtJg6gIpi25SVRP7u2HQJHc96
         wXfwEhBepVNKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 896F65C066D; Tue, 27 Sep 2022 11:51:21 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:51:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Yipeng Zou <zouyipeng@huawei.com>, rcu@vger.kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rafael.j.wysocki@intel.com, peterz@infradead.org
Subject: Re: [PATCH] rcu: remove rcu_is_idle_cpu
Message-ID: <20220927185121.GU4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220926015827.227050-1-zouyipeng@huawei.com>
 <20220926203629.GA183228@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926203629.GA183228@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 26, 2022 at 10:36:29PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 26, 2022 at 09:58:27AM +0800, Yipeng Zou wrote:
> > The commit "x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs" introduce
> > this function to identify the current CPU idle state.
> > But after commit "x86/aperfmperf: Replace arch_freq_get_on_cpu()" we
> > just use MAX_SAMPLE_AGE to do that, So there is no use of this function.
> > 
> > Fixes: f3eca381bd49 ("x86/aperfmperf: Replace arch_freq_get_on_cpu()")
> > Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Good eyes, Yipeng!  Queued and pushed, thank you both!

As usual, I could not resist the urge to wordsmith, so please check the
patch below and let me know if I messed something up.

And please include both commit IDs in future patches with the
formatting shows below.  Makes it easier for me to accept your
patches, after all.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit f8b389c24cf9a523472e3e505815b26f0174856c
Author: Yipeng Zou <zouyipeng@huawei.com>
Date:   Mon Sep 26 09:58:27 2022 +0800

    rcu: Remove rcu_is_idle_cpu()
    
    The commit 3fcd6a230fa7 ("x86/cpu: Avoid cpuinfo-induced IPIing of
    idle CPUs") introduced rcu_is_idle_cpu() in order to identify the
    current CPU idle state.  But commit f3eca381bd49 ("x86/aperfmperf:
    Replace arch_freq_get_on_cpu()") switched to using MAX_SAMPLE_AGE,
    so rcu_is_idle_cpu() is no longer used.  This commit therefore removes it.
    
    Fixes: f3eca381bd49 ("x86/aperfmperf: Replace arch_freq_get_on_cpu()")
    Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 84e930c11065..93485b812712 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -146,8 +146,6 @@ static inline void rcu_virt_note_context_switch(void) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
 static inline void rcu_irq_exit_check_preempt(void) { }
-#define rcu_is_idle_cpu(cpu) \
-	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 3066e0975022..f41c4ab2a884 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -87,8 +87,6 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 void cond_synchronize_rcu(unsigned long oldstate);
 void cond_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 
-bool rcu_is_idle_cpu(int cpu);
-
 #ifdef CONFIG_PROVE_RCU
 void rcu_irq_exit_check_preempt(void);
 #else
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1930cee1ccdb..96d678c9cfb6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -301,12 +301,6 @@ static bool rcu_dynticks_in_eqs(int snap)
 	return !(snap & RCU_DYNTICKS_IDX);
 }
 
-/* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
-bool rcu_is_idle_cpu(int cpu)
-{
-	return rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
-}
-
 /*
  * Return true if the CPU corresponding to the specified rcu_data
  * structure has spent some time in an extended quiescent state since
