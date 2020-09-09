Return-Path: <SRS0=NFG3=CS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7F2C43461
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A54D22240
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599664592;
	bh=oAgyl5YCzOi2Oys2dADhKhmSZ1VDNwqV2xCYDMZdcWw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=y4e9EdEyZikcvInBuAk2Q3u/f/YZvmpIfDRUFpPoPcbxq3JwC/qdcv6x7suJ7wjz+
	 WgBQLkFkkj+kfmOFlQ5ysoznsfJpEQa4XllRHbSS0TbBannRcV8X9YQzHryyWmNMVm
	 3KnNdlTFjmvW9Qaet7p8CRlU886LUhRgTVT7mUEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIIPQ3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbgIILao (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Sep 2020 07:30:44 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F5820897;
        Wed,  9 Sep 2020 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599650561;
        bh=oAgyl5YCzOi2Oys2dADhKhmSZ1VDNwqV2xCYDMZdcWw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VGlHUA84CYJaxv0ABm+a7LxuNh29gVlf7PMfczNBCR98EuKwBIr0Bd91ClwrEdbao
         ZJmTM2fuC1vKlva5mCMB7bzzkTO9BoXDAgwzncyqAvGsXx1PyTsiLJdMRE2XiO4/rq
         m3UHhFdkjCrWGoIUrbT2sCHDNVlTZYQL/eUnmEZA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AB27F3523091; Wed,  9 Sep 2020 04:22:41 -0700 (PDT)
Date:   Wed, 9 Sep 2020 04:22:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RCU:  Question   rcu_preempt_blocked_readers_cgp  in
  rcu_gp_fqs_loop func
Message-ID: <20200909112241.GE29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200819135654.GB3875610@google.com>
 <20200819152159.GX27891@paulmck-ThinkPad-P72>
 <20200819155808.GA8817@pc636>
 <20200820223957.GB120898@google.com>
 <20200821153328.GH2855@paulmck-ThinkPad-P72>
 <BYAPR11MB263285B19261BE8096D87F65FF260@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632FD34F68A89CCE039018BFF260@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB2632FD34F68A89CCE039018BFF260@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 09, 2020 at 07:03:39AM +0000, Zhang, Qiang wrote:
> 
> When config preempt RCU,  and then  there are multiple levels  node,  the current task is preempted  in rcu  read critical region.
> the current task be add to "rnp->blkd_tasks" link list,  and the "rnp->gp_tasks"  may be assigned a value .  these rnp is leaf node in RCU tree.
> 
> But in "rcu_gp_fqs_loop" func, we check blocked readers in root node. 
> 
> static void rcu_gp_fqs_loop(void)
>  {
>             .....
>             struct rcu_node *rnp = rcu_get_root();
>             .....
>             if (!READ_ONCE(rnp->qsmask) &&
>                                !rcu_preempt_blocked_readers_cgp(rnp))    ------> rnp is root node
>                      break;
>             ....
> }
> 
> the root node's blkd_tasks never add task, the "rnp->gp_tasks" is never be assigned value,  this check is invailed.
>  Should we check leaf nodes like this 

There are two cases:

1.	There is only a single rcu_node structure, which is both root
	and leaf.  In this case, the current check is required:  Both
	->qsmask and the ->blkd_tasks list must be checked.  Your
	rcu_preempt_blocked_readers() would work in this case, but
	the current code is a bit faster because it does not need
	to acquire the ->lock nor does it need the loop overhead.

2.	There are multiple levels.  In this case, as you say, the root
	rcu_node structure's ->blkd_tasks list will always be empty.
	But also in this case, the root rcu_node structure's ->qsmask
	cannot be zero until all the leaf rcu_node structures' ->qsmask
	fields are zero and their ->blkd_tasks lists no longer have
	tasks blocking the current grace period.  This means that your
	rcu_preempt_blocked_readers() function would never return
	true in this case.

So the current code is fine.

Are you seeing failures on mainline kernels?  If so, what is the failure
mode?

							Thanx, Paul

> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1846,6 +1846,25 @@ static bool rcu_gp_init(void)
>  	return true;
>  }
>  
> +static bool rcu_preempt_blocked_readers(void)
> +{
> +	struct rcu_node *rnp;
> +	unsigned long flags;
> +	bool ret = false;
> +
> +	rcu_for_each_leaf_node(rnp) {
> +		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +		if (rcu_preempt_blocked_readers_cgp(rnp)) {
> +			ret = true;
> +			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +			break;
> +		}
> +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * Helper function for swait_event_idle_exclusive() wakeup at force-quiescent-state
>   * time.
> @@ -1864,7 +1883,7 @@ static bool rcu_gp_fqs_check_wake(int *gfp)
>  		return true;
>  
>  	// The current grace period has completed.
> -	if (!READ_ONCE(rnp->qsmask) && !rcu_preempt_blocked_readers_cgp(rnp))
> +	if (!READ_ONCE(rnp->qsmask) && !rcu_preempt_blocked_readers())
>  		return true;
>  
>  	return false;
> @@ -1927,7 +1946,7 @@ static void rcu_gp_fqs_loop(void)
>  		/* Locking provides needed memory barriers. */
>  		/* If grace period done, leave loop. */
>  		if (!READ_ONCE(rnp->qsmask) &&
> -		    !rcu_preempt_blocked_readers_cgp(rnp))
> +		    !rcu_preempt_blocked_readers())
>  			break;
>  		/* If time for quiescent-state forcing, do it. */
>  		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
> -- 
> 
> 
> thanks
> Qiang
