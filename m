Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB90C433EF
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 00:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbhKYAwb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 19:52:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244239AbhKYAua (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 19:50:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 829C8610CA;
        Thu, 25 Nov 2021 00:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637801240;
        bh=XXPkpWmUnd2wws2ZsDexjSBAAJrlUnhNGIyFiA2PW9Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=j0OxU3LEt5kVge1jYwrw3kUHDq7F/n55Vpbp7MVzwKH6IlILjWTTwpQRwcNxmUi03
         KjndGOxiafbE25b8sNuqfeDfkdvwHGqr3l2WLR5RUegD775IAItDljk9FC0/2PPCr+
         6i2s8HU0g3TeT6uEafScpZK62xHIhsenuMshb1C809LX1nSxpivixq/772QWBoO4Sv
         hGne5JteMhb6xqNT3BU1exQ6AX4nq5q1j6cM+iub6GTvryfAFNh2YmlwCfjHKNaZxC
         7TDdF+PEHt0d7jqpI8zt3OIrI2NWDsqUiJ3m62UyOTZEEvPW0P+yypXiN/KOvj6oBg
         TOfXDtVzptGtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 491465C0A31; Wed, 24 Nov 2021 16:47:20 -0800 (PST)
Date:   Wed, 24 Nov 2021 16:47:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        yury.norov@gmail.com
Subject: Re: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Message-ID: <20211125004720.GV641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-6-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123003708.468409-6-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 23, 2021 at 01:37:07AM +0100, Frederic Weisbecker wrote:
> If a user wants to boot without any CPU in offloaded mode initially but
> with the possibility to offload them later using cpusets, provide a way
> to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
> the creation of dormant nocb kthreads.

Huh.  This would have been a use for Yury Norov's "none" bitmask
specifier.  ;-)

I pulled this one in with the usual wordsmithing.

							Thanx, Paul

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  .../admin-guide/kernel-parameters.txt         | 26 ++++++++++++-------
>  kernel/rcu/tree_nocb.h                        | 10 ++++---
>  2 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cd860dc7c60b..6ff1a5f06383 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4351,20 +4351,28 @@
>  				Disable the Correctable Errors Collector,
>  				see CONFIG_RAS_CEC help text.
>  
> -	rcu_nocbs=	[KNL]
> -			The argument is a cpu list, as described above.
> +	rcu_nocbs[=cpu-list]
> +			[KNL] The optional argument is a cpu list,
> +			as described above.
>  
> -			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
> -			the specified list of CPUs to be no-callback CPUs.
> -			Invocation of these CPUs' RCU callbacks will be
> -			offloaded to "rcuox/N" kthreads created for that
> -			purpose, where "x" is "p" for RCU-preempt, and
> -			"s" for RCU-sched, and "N" is the CPU number.
> -			This reduces OS jitter on the offloaded CPUs,
> +			In kernels built with CONFIG_RCU_NOCB_CPU=y, enable the
> +			no-callback CPU mode. Invocation of such CPUs' RCU
> +			callbacks will be offloaded to "rcuox/N" kthreads
> +			created	for that purpose, where "x" is "p" for
> +			RCU-preempt, and "s" for RCU-sched, and "N" is the CPU
> +			number.	This reduces OS jitter on the offloaded CPUs,
>  			which can be useful for HPC and real-time
>  			workloads.  It can also improve energy efficiency
>  			for asymmetric multiprocessors.
>  
> +			If a cpulist is passed as an argument, the specified
> +			list of	CPUs is set to no-callback mode from boot.
> +
> +			If otherwise the '=' sign and the cpulist arguments are
> +			omitted, no CPU will be set to no-callback mode from
> +			boot but cpuset will allow for toggling that mode at
> +			runtime.
> +
>  	rcu_nocb_poll	[KNL]
>  			Rather than requiring that offloaded CPUs
>  			(specified by rcu_nocbs= above) explicitly
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 9d37916278d4..d915780d40c8 100644
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
