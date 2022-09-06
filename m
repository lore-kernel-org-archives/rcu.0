Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88134ECAAA1
	for <rcu@archiver.kernel.org>; Tue,  6 Sep 2022 18:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiIFStM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 14:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIFStL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 14:49:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D986FC2
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 11:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DD43B819FF
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 18:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC0DC433D6;
        Tue,  6 Sep 2022 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662490148;
        bh=e7P0JrF6oT15iEjiYJBLZp6ZOEvO9f1XOQxM8Uivvcs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ho9jejDP2cKLY7mhG9b+zpfJakb/oR+3btgfV6XfgUrXRQh6txeT0CjZI0JIzHGmG
         Kk5p1ryq50vX9sFQKBSn+lH5g3ZN8iguMay9vM/ol2YCTBEM8xgTeqjawaJo4J7NII
         onK/HhjUGdpTq7tKoXRIB+1msjIvFuA07ZP5xXkX3x15TXl4LuB4XwhYZmd6z5SFky
         x6te/Xld93ma/0sKtCsiZyht33QybzFyFRM1QfH1NmYxwkt4SxxzBrIL90gJ1+uWlL
         a0r1+pDzvjKRniyUIO9d1HXRRC6ZZR358f+o49WV4pKlntXIwgh2CFJn2/Gs+I7OY/
         jpGPVe3bV4mRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 027275C09ED; Tue,  6 Sep 2022 11:42:58 -0700 (PDT)
Date:   Tue, 6 Sep 2022 11:42:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 3/3] rcu: Keep qsmaskinitnext fresh for
 rcu_boost_kthread_setaffinity()
Message-ID: <20220906184258.GE4315@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220905033852.18988-1-kernelfans@gmail.com>
 <20220905033852.18988-3-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905033852.18988-3-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 05, 2022 at 11:38:52AM +0800, Pingfan Liu wrote:
> rcutree_online_cpu() is concurrent, so there is the following race
> scene:
> 
>         CPU 1                               CPU2
> mask_old = rcu_rnp_online_cpus(rnp);
> ...
> 
>                                    mask_new = rcu_rnp_online_cpus(rnp);
>                                    ...
>                                    set_cpus_allowed_ptr(t, cm);
> 
> set_cpus_allowed_ptr(t, cm);
> 
> Consequently, the old mask will overwrite the new mask in the task's cpus_ptr.
> 
> Since there is a mutex ->boost_kthread_mutex, using it to build an
> order, then the latest ->qsmaskinitnext will be fetched for updating cpus_ptr.
> 
> Notes about the cpu teardown: The cpu hot-removing initiator executes
> rcutree_dead_cpu() for the teardown cpu. If in future, an initiator can
> hot-remove several cpus at a time, it executes rcutree_dead_cpu() in
> series for each cpu. So it is still race-free without the mutex.  But
> considering this is a cold path, applying that redundant mutex is
> harmless.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> To: rcu@vger.kernel.org

Good choice, thank you!

Because I did not take your patch #2, I had to hand-apply this one.
Please check the result below and let me know if I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit 7139c19d2ea117976aa892de4fb75682e989ba12
Author: Pingfan Liu <kernelfans@gmail.com>
Date:   Tue Sep 6 11:36:42 2022 -0700

    rcu: Synchronize ->qsmaskinitnext in rcu_boost_kthread_setaffinity()
    
    Once either rcutree_online_cpu() or rcutree_dead_cpu() is invoked
    concurrently, the following rcu_boost_kthread_setaffinity() race can
    occur:
    
            CPU 1                               CPU2
    mask = rcu_rnp_online_cpus(rnp);
    ...
    
                                       mask = rcu_rnp_online_cpus(rnp);
                                       ...
                                       set_cpus_allowed_ptr(t, cm);
    
    set_cpus_allowed_ptr(t, cm);
    
    This results in CPU2's update being overwritten by that of CPU1, and
    thus the possibility of ->boost_kthread_task continuing to run on a
    to-be-offlined CPU.
    
    This commit therefore eliminates this race by relying on the pre-existing
    acquisition of ->boost_kthread_mutex to serialize the full process of
    changing the affinity of ->boost_kthread_task.
    
    Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
    Cc: David Woodhouse <dwmw@amazon.co.uk>
    Cc: Frederic Weisbecker <frederic@kernel.org>
    Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
    Cc: Josh Triplett <josh@joshtriplett.org>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Lai Jiangshan <jiangshanlai@gmail.com>
    Cc: Joel Fernandes <joel@joelfernandes.org>
    Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e3142ee35fc6a..7b0fe741a0886 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1221,11 +1221,13 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
  * We don't include outgoingcpu in the affinity set, use -1 if there is
  * no outgoing CPU.  If there are no CPUs left in the affinity set,
  * this function allows the kthread to execute on any CPU.
+ *
+ * Any future concurrent calls are serialized via ->boost_kthread_mutex.
  */
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
 	struct task_struct *t = rnp->boost_kthread_task;
-	unsigned long mask = rcu_rnp_online_cpus(rnp);
+	unsigned long mask;
 	cpumask_var_t cm;
 	int cpu;
 
@@ -1234,6 +1236,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
 		return;
 	mutex_lock(&rnp->boost_kthread_mutex);
+	mask = rcu_rnp_online_cpus(rnp);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
 		    cpu != outgoingcpu)
