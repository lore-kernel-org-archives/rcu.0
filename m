Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE238C433F5
	for <rcu@archiver.kernel.org>; Mon, 15 Nov 2021 13:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB1F61B2C
	for <rcu@archiver.kernel.org>; Mon, 15 Nov 2021 13:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKONPh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Nov 2021 08:15:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhKONOm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Nov 2021 08:14:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE1BC61B95;
        Mon, 15 Nov 2021 13:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636981905;
        bh=dtxG2ooLsjsAOKKUzdMgJNgihWOhmlB4tfTyKtkKoPk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vEalUbCnbaR4J3cqiLcHhTV19tb1+X2g3pYxtYmsEvMcnWYmwRg+L/QwyeyvRPqxE
         UdIYT+mpBVLKMogurf78pVeYrEH/cfA/QxwiSq3T/8Uq/KTRwzjDF9RxsutTGfw5WE
         oh2BFtjw+azCgc7mS53YXw7Cpd1XETz+rHutSHyOMOJ98m2cqEWUedhfWa2fvuW4lN
         SxHccM4+lYo7Mc/SDXYMfgcrCjlEQaHMKsRYOef16HYJ/b5PFjKqY0U63hCPHsyezR
         laomG4ry42iqU9p33LLx36Iii4kOyf4R5K1i5DUnw4U+uIVXuZY7x2IBHtL5ZTGJni
         ZcUvDbh9GXf2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 962CA5C065D; Mon, 15 Nov 2021 05:11:45 -0800 (PST)
Date:   Mon, 15 Nov 2021 05:11:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH] rcu: Avoid boost task running on isolated cpus
Message-ID: <20211115131145.GE641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211115051546.12476-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115051546.12476-1-qiang.zhang1211@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 15, 2021 at 01:15:46PM +0800, Zqiang wrote:
> If the nohz_full is enabled, when the boost task be created,
> the cpus_allowed_ptr be set housekeeping_cpumask(HK_FLAG_KTHREAD),
> however when the rcu_boost_kthread_setaffinity() be called, the
> original affinity will be changed, the isolated cpus should be
> considered again.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

I have queued this for testing and further review, thank you!

I am particularly interested in Frederic's thoughts on how this might
interact with any future ability to change the set of nohz_full CPUs
at runtime.

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 5199559fbbf0..87e7ebbdb12e 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1204,8 +1204,9 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
>  		    cpu != outgoingcpu)
>  			cpumask_set_cpu(cpu, cm);
> +	cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
>  	if (cpumask_weight(cm) == 0)
> -		cpumask_setall(cm);
> +		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
>  	set_cpus_allowed_ptr(t, cm);
>  	free_cpumask_var(cm);
>  }
> -- 
> 2.17.1
> 
