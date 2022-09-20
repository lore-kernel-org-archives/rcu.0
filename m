Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8DFC6FA8E
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 10:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiITKcV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 06:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiITKbw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 06:31:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C272683
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 03:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 891CF628BB
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 10:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEF5C433D6;
        Tue, 20 Sep 2022 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663669907;
        bh=qY6/Jbd+KKNh7pKIOzTb04G5z8/zzbJWChGINz2RUOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ct8/t4LjxPKkpnprYrGVDLFqRlocr780+ZjEQ9+9Iv+Cz6r5oLTpscOGYpNtvfWZh
         qkHaLB40V5BPuni3ZQ9E/HLlyf8ctPrzJmdI7fjXv55347zZG5SwtoEkfpbN0DWqbJ
         U4ucQmCAZ48sbC+G59uolt+0iRsLcoL2UcVMnl0nxvBgSoBxX6wMC/bq0lg+XGFrER
         cfscWAUpozHd/jAqQIthcC7oWCLnSIsKElmYvmjOKGiLmeG97HvvgUKaY73+fki8DV
         hzMKV4imunyPyhtmcERyqIKifik73A3vFWOMBP0Yn2C23NB58FVzS+9IaWxndM4nEl
         4VAt4EL5u+vCg==
Date:   Tue, 20 Sep 2022 12:31:43 +0200
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
Message-ID: <20220920103143.GB71722@lothringen>
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

Just for clarity, may I suggest:


          CPU 0                                    CPU 1
          -----                                    -----
       rcutree_online_cpu()
           rcu_boost_kthread_setaffinity()
               mask = rcu_rnp_online_cpus(rnp);
                                                rcu_cpu_starting()
                                                    WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
                                                rcutree_online_cpu()
                                                    rcu_boost_kthread_setaffinity()
                                                        mask = rcu_rnp_online_cpus(rnp);
                                                        set_cpus_allowed_ptr(t, cm);
               set_cpus_allowed_ptr(t, cm);


> @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
>  		return;
>  	mutex_lock(&rnp->boost_kthread_mutex);
> +	/*
> +	 * Relying on the lock to serialize, so when onlining, the latest
> +	 * qsmaskinitnext is for cpus_ptr.
> +	 */

Given how tricky the situation is, I suggest to also add more details to the
comment:

        /*
         * Rely on the boost mutex to serialize ->qsmaskinitnext and
         * set_cpus_allowed_ptr(), so when concurrently onlining, racing against
	 * rcu_cpu_starting() makes sure that the latest update eventually
	 * wins with the right affinity setting.
         */

Thanks!

> +	mask = rcu_rnp_online_cpus(rnp);
>  	for_each_leaf_node_possible_cpu(rnp, cpu)
>  		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
>  		    cpu != outgoingcpu)
> -- 
> 2.31.1
> 
