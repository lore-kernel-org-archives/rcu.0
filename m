Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9994C433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 19:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB3361B5E
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 19:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhKQTtF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232079AbhKQTtE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 14:49:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D78C161B64;
        Wed, 17 Nov 2021 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637178365;
        bh=SsGpHWziCAOlxblm+hFfC95JeEWb1eNc65Gi+r9yp1w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GlQ1Im/Gibekc2FJpwNTFYhY1e5FI5UlnrNBrbgo104QMmHNo2WxkuUooBSRi/7en
         CST0T7Z/DRwkNlMCCVccTsDiP4aaDwDUSC3TMZRSHl0xSEde/SwKktYGuQ7tYT9Gg3
         Oy16x6S1QHeaJ0iMbedGGy3iAoi8ESGioP4fe+ERXAfMLEgCLLl9Ohfu6P0l9WH7k1
         b1W7iwNK7RWATB19zswLxeizlsp2DAInjZgLQ463j2xIjp6nSZRhZLxsu/t4fK7G57
         FjVdTBVqnhqW7gnBoNqHjg2onExfHEtbq7Z8eOq/jhNtvdTHq4d9Rh8lzCv60c5TRu
         2h+AY67vNKVaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A156E5C06BA; Wed, 17 Nov 2021 11:46:05 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:46:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Message-ID: <20211117194605.GL641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211117155637.363706-1-frederic@kernel.org>
 <20211117155637.363706-6-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117155637.363706-6-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 17, 2021 at 04:56:36PM +0100, Frederic Weisbecker wrote:
> If a user wants to boot without any CPU in offloaded mode initially but
> with the possibility to offload them later using cpusets, provide a way
> to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
> the creation of dormant nocb kthreads.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 10 ++++++----

Could you please also update kernel-parameters.txt?

>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 1871f15b8472..3845f1885ffc 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -66,14 +66,16 @@ static bool rcu_nocb_is_setup;
>  static int __init rcu_nocb_setup(char *str)
>  {
>  	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
> -	if (cpulist_parse(str, rcu_nocb_mask)) {
> -		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
> -		cpumask_setall(rcu_nocb_mask);
> +	if (*str == '=') {
> +		if (cpulist_parse(++str, rcu_nocb_mask)) {
> +			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
> +			cpumask_setall(rcu_nocb_mask);
> +		}

Wouldn't "*str == '='" indicate that the parameter passed in was of
the form "rcu_nocbs==8"?

Or am I misreading the next_arg() function in lib/cmdline.c?

If I am reading it correctly, doesn't the test instead want to be
something of the form "if (str && *str)"?

							Thanx, Paul

>  	}
>  	rcu_nocb_is_setup = true;
>  	return 1;
>  }
> -__setup("rcu_nocbs=", rcu_nocb_setup);
> +__setup("rcu_nocbs", rcu_nocb_setup);
>  
>  static int __init parse_rcu_nocb_poll(char *arg)
>  {
> -- 
> 2.25.1
> 
