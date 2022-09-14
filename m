Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55F5ECAAD8
	for <rcu@archiver.kernel.org>; Wed, 14 Sep 2022 12:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiINM1I (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiINM1G (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Sep 2022 08:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DA580525
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 05:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F7961CF3
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 12:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317C6C433D7;
        Wed, 14 Sep 2022 12:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663158425;
        bh=5yKawKKpylWjZKfecCB1mhJvOMSxBpkAOyvuELkZnk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gq0uN0qi42A53zPI2qsah84X9sTebEUTQs4FeuoYzFBEghqOw963BEPwkiXdw8Hs1
         DdlSWpoWHjuEosmjWJcoyMH4BCfz4lhwthAJXIfxiUM4YxPtqBhVAK+Awa6ZqnZk5p
         f0nc9E9DtHZ4bFEIYFaJ0INYOEjpsF1az+UNNvE+JBeCn3Fsh/80GTSPjX7cLA2xw2
         CPc+pdM4A+qu4DBU9hnQgEiXXof9RXb0uzqHecX73GIb4XApPUNvZPz4DwH0tLxoH9
         /kizG3idgTFqhEfFtkwoPGOPiBvL1jRHzfo1TntDz/wftJwef/hMwhHlgDLtySRoEF
         iJ5ogeZHujAMw==
Date:   Wed, 14 Sep 2022 14:27:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/3] rcu: remove redundant cpu affinity setting during
 teardown
Message-ID: <20220914122701.GB1879@lothringen>
References: <20220905033852.18988-1-kernelfans@gmail.com>
 <20220906172441.GY4315@paulmck-ThinkPad-P17-Gen-1>
 <Yxf2jRB9LXr4q6ri@piliu.users.ipa.redhat.com>
 <20220910203622.GI4315@paulmck-ThinkPad-P17-Gen-1>
 <YyGpC03H0c9EXTv9@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyGpC03H0c9EXTv9@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 14, 2022 at 06:12:27PM +0800, Pingfan Liu wrote:
> On Sat, Sep 10, 2022 at 01:36:22PM -0700, Paul E. McKenney wrote:
> Actually, the scheduler will pick up one online cpu for the boost
> thread.
> 
> On the last cpu, boost is subject to migration, and is pushed away by
> __balance_push_cpu_stop()
> {
>         if (task_rq(p) == rq && task_on_rq_queued(p)) {
>                 cpu = select_fallback_rq(rq->cpu, p);
>                 rq = __migrate_task(rq, &rf, p, cpu);
>         }
> }
> 
> Now, turning to select_fallback_rq(), inside that function, if
> p->cpus_ptr has no suitable cpus, then case cpuset or possible will make it
> point to cpuset or cpu_possible_mask.  So finally, there is a valid cpu
> is picked up. (I have not found the online cpu there. The trick should hide
> elsewhere. But that rendered the same result as in v5.16, where
> rcu_boost_kthread_setaffinity()->cpumask_setall(cm))
> 
> But now, in 6.0, it changes into housekeeping_cpumask(HK_TYPE_RCU),
> which appeals for a more careful thinking.
> If there is a cpuset for housekeeping so that select_fallback_rq() can
> pick up one from that cpuset?
> 
> To Frederic, could you show some light here and is it worth introducing
> such a cpuset so that select_fallback_rq() can pick up a cpu in
> housekeeping set in this case?
> 
> 
> Anyway, as the last resort, TICK_DEP_BIT_RCU has already appealed for
> the awareness of the concurrent rcutree_offline_cpu(), the affinity
> setting could be done there if select_fallback_rq() can not work.

Here is the way I understand it: suppose the outgoing CPU was the last online
one in this rcu node, in this case the migration performed in
sched_cpu_deactivate() will find only one CPU in p->cpus_mask, but that CPU is
now out of cpu_active_mask, so the task is affined by default to cpu_possible_mask.

So there is a short window between sched_cpu_deactivate() and
rcutree_offline_cpu() where the task may run on all cpu_possible_mask. Does it
matter? Maybe, I don't know...

After that we reach rcutree_offline_cpu() -> rcu_boost_kthread_setaffinity()
that fails to fill the cpumask since the node is now empty. As the resulting
cpumask is empty, it fills it as a last resort to the HK_TYPE_RCU housekeeping
set which has to have at least 1 online CPU (nohz_full constraint). So the task
is finally affine to that housekeeping set.

Like Paul said, I'd rather indeed remove the rcu_boost_kthread_setaffinity()
call from rcutree_dead_cpu() as this one looks useless.

Thanks.




> 
> Thanks,
> 
> 	Pingfan
