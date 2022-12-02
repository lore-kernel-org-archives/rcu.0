Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE0CC4332F
	for <rcu@archiver.kernel.org>; Fri,  2 Dec 2022 22:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiLBWRS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLBWRR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Dec 2022 17:17:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA183336
        for <rcu@vger.kernel.org>; Fri,  2 Dec 2022 14:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 693A7B822BD
        for <rcu@vger.kernel.org>; Fri,  2 Dec 2022 22:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9E8C433C1;
        Fri,  2 Dec 2022 22:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670019433;
        bh=hj288ni2N8g+X8fUCmCNn55/4n7vgcyjniIr4qGGf0A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=E6oJZSFPw7OEf8qnoYAufvlMCVmZh+QtD5buC8RNfgqMKJe4NxtG1wqCk5i2rif2s
         IF++0kp/jOluilYyJaJTM4qwemY83GSLY3iywksyvhfgRbBlHVUAVUckY4KMhwbs81
         2UUbrtZrCsBfamNGwuZqXF1356g+AxBsXfZ3FU5L/dKh87VKh+RLjd65+c9IdUIwKt
         LoCkp/ya4C2XJAKMf/grHIROLHewbe5zyW5oh7/5D/CDNAtW6YmvclEws1hZOZ1/8A
         29fo+3AxGfQSAr5xg/kFP5wDRWY5ue2iGrRUDVTXUfd2gIwRa5AP8CpRWrRS8iuA0L
         7UGuIE0Hvb9ew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7698B5C095D; Fri,  2 Dec 2022 14:17:13 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:17:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <piliu@redhat.com>
Cc:     rcu@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCHv2] srcu: Eliminate the requirement of SRCU_SIZE_WAIT_CALL
Message-ID: <20221202221713.GH4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221128082816.28518-2-kernelfans@gmail.com>
 <20221130033459.16372-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130033459.16372-1-piliu@redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 30, 2022 at 11:34:59AM +0800, Pingfan Liu wrote:
> From: Pingfan Liu <kernelfans@gmail.com>
> 
> The state SRCU_SIZE_WAIT_CALL is only used in srcu_gp_start_if_needed().
> And it is not needed. Because counter_wrap_check has guarantee that both
> srcu_gp_seq_needed and srcu_gp_seq_needed_exp are not far behind
> srcu_gp_seq and no false alarm will be raised by the statement in
> srcu_gp_start_if_needed()
> 
>   ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)
> 
> As a result, once if SRCU_SIZE_WAIT_BARRIER is seen, the tree snp can be
> used immediately, not need to wait for another srcu_gp_end() to update
> the srcu_gp_seq_needed and srcu_gp_seq_needed_exp to avoid false alarm.

During the SRCU_SIZE_WAIT_BARRIER state, all callbacks are queued onto
the boot CPU's callback list, but the srcu_barrier() function scans all
of the CPUs' callback lists.

So can't this cause srcu_gp_start_if_needed() to rcu_segcblist_advance()
and rcu_segcblist_accelerate() a callback list that is guaranteed to be
empty?  Without this change, the might-not-be-empty boot CPU's callback
list is dealt with.

What am I missing here?  More specifically, what benefits does this
change provide?  I am not yet seeing any.

							Thanx, Paul

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> To: rcu@vger.kernel.org
> ---
> v1 -> v2:
>  rebase onto dev branch
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index b25f77df9e5e..b0278d1e9c1f 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1165,7 +1165,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  	 */
>  	idx = __srcu_read_lock_nmisafe(ssp);
>  	ss_state = smp_load_acquire(&ssp->srcu_size_state);
> -	if (ss_state < SRCU_SIZE_WAIT_CALL)
> +	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
>  		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
>  	else
>  		sdp = raw_cpu_ptr(ssp->sda);
> -- 
> 2.31.1
> 
