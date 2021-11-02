Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A621C433F5
	for <rcu@archiver.kernel.org>; Tue,  2 Nov 2021 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E0C61058
	for <rcu@archiver.kernel.org>; Tue,  2 Nov 2021 16:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKBQeK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234848AbhKBQLp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 Nov 2021 12:11:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F18160720;
        Tue,  2 Nov 2021 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635869350;
        bh=IkNuwYiuj6Jty/6VEkW5Do38hdsBLfJh+7EZIKqlk4g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P4SV4aqm66MoxBjyYLwkhBVZ7gdXKoqdr4CE+6Us0pZo5JMvBT6pEQ+9MR0/Bv/n4
         OpkM+qW8FsJ12eLLDyXwd1k5lyZxQ+ebAdsy7p5PGVoV6j+k+5i5kCmJLwjMiRbLuI
         blfQ5rUw+PMfYwRLuDCxRS71Xs6tkPqbl83R4YSy0xfDNvuhSnsMf7dlhSoeJoZ+dD
         vBEaqLwiylqV45mVkuX4/PfYZlfbVgW+tApNEgycOEU/ogl0sLy8boXdnFen+prNo7
         LIpjC9oqEAkdTtciixm7caKP55u5pGjSxiPly/JKBqVKEWOqOc2y86LxiBcb+z0AuS
         62cbamAlueAaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 38B775C0248; Tue,  2 Nov 2021 09:09:10 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:09:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     dave@stgolabs.net, joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        rcu@vger.kernel.org, philip.li@intel.com, lizhijian@cn.fujitsu.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] rcuscale: alwaly log error message
Message-ID: <20211102160910.GJ880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211029094029.22501-1-zhijianx.li@intel.com>
 <20211029094029.22501-6-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029094029.22501-6-zhijianx.li@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 29, 2021 at 05:40:28PM +0800, Li Zhijian wrote:
> Generally, error message should be logged anyhow.
> 
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>

And I queued this one, thank you!

The last patch also need to be ported to -rcu.  Please port it and
the other one and resubmit them.

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 2cc34a22a506..5c8449a8827a 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -50,8 +50,8 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
>  	pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s)
>  #define VERBOSE_SCALEOUT_STRING(s) \
>  	do { if (verbose) pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s); } while (0)
> -#define VERBOSE_SCALEOUT_ERRSTRING(s) \
> -	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s); } while (0)
> +#define SCALEOUT_ERRSTRING(s) \
> +	pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s)
>  
>  /*
>   * The intended use cases for the nreaders and nwriters module parameters
> @@ -514,11 +514,11 @@ rcu_scale_cleanup(void)
>  	 * during the mid-boot phase, so have to wait till the end.
>  	 */
>  	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
> -		VERBOSE_SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
> +		SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
>  	if (rcu_gp_is_normal() && gp_exp)
> -		VERBOSE_SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
> +		SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
>  	if (gp_exp && gp_async)
> -		VERBOSE_SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
> +		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
>  
>  	if (torture_cleanup_begin())
>  		return;
> @@ -845,7 +845,7 @@ rcu_scale_init(void)
>  	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
>  			       GFP_KERNEL);
>  	if (reader_tasks == NULL) {
> -		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
> +		SCALEOUT_ERRSTRING("out of memory");
>  		firsterr = -ENOMEM;
>  		goto unwind;
>  	}
> @@ -865,7 +865,7 @@ rcu_scale_init(void)
>  		kcalloc(nrealwriters, sizeof(*writer_n_durations),
>  			GFP_KERNEL);
>  	if (!writer_tasks || !writer_durations || !writer_n_durations) {
> -		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
> +		SCALEOUT_ERRSTRING("out of memory");
>  		firsterr = -ENOMEM;
>  		goto unwind;
>  	}
> -- 
> 2.32.0
> 
