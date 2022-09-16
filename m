Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BB2ECAAD8
	for <rcu@archiver.kernel.org>; Fri, 16 Sep 2022 14:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiIPOwp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiIPOwp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Sep 2022 10:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752DFA8338
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 07:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1059D62C60
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 14:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33BCC433C1;
        Fri, 16 Sep 2022 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663339963;
        bh=IdNdO6WhTd00oQ36qRu4vrUwtNaSdOscEn3Jk2HXWpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifhzKRZ5RpY6Kv3Sca85ouyJ3rtVOOYXCaJjXNJvPHAPPkYUHwu/mEHpxd0hIac0n
         EQeZtA8vntap5EVF7LKyJTJegVhrtuyHgciXkbokZgsqUo9Ae2buBw+mUvfYXFR3U6
         dCbLDQe9A8NZvZev98KdhFdtFdtuO+duIaZNB/eUdSWwf8Wetvkoars5DXkiAMfgB2
         neCQqbmOXkQW8toOUkKBWjaY0yapY1tBJzeyHrU+ukxK5252803DG8FCRirtpitV/u
         ErpoiAD1HrQkypETAv5T4dhOV5SAhi5FKksaO32lswygwhh99q6UgnWaGBy+VSiuyt
         kFlrDs9s0Xgxw==
Date:   Fri, 16 Sep 2022 16:52:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 1/3] rcu: Keep qsmaskinitnext fresh when
 rcutree_online_cpu()
Message-ID: <20220916145240.GA27819@lothringen>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-2-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915055825.21525-2-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 15, 2022 at 01:58:23PM +0800, Pingfan Liu wrote:
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
> But for concurrent offlining, ->qsmaskinitnext is not reilable when
> rcutree_offline_cpu(). That is another story and comes in the following
> patch.
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
> ---
>  kernel/rcu/tree_plugin.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 438ecae6bd7e..ef6d3ae239b9 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  {
>  	struct task_struct *t = rnp->boost_kthread_task;
> -	unsigned long mask = rcu_rnp_online_cpus(rnp);
> +	unsigned long mask;
>  	cpumask_var_t cm;
>  	int cpu;
>  
> @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
>  		return;
>  	mutex_lock(&rnp->boost_kthread_mutex);
> +	/*
> +	 * Relying on the lock to serialize, so when onlining, the latest
> +	 * qsmaskinitnext is for cpus_ptr.
> +	 */
> +	mask = rcu_rnp_online_cpus(rnp);
>  	for_each_leaf_node_possible_cpu(rnp, cpu)
>  		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
>  		    cpu != outgoingcpu)

Right but you still race against concurrent rcu_report_dead() doing:

      WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask)

Thanks.

> -- 
> 2.31.1
> 
