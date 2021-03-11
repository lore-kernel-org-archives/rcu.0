Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9A6C433DB
	for <rcu@archiver.kernel.org>; Thu, 11 Mar 2021 23:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9CD64F8F
	for <rcu@archiver.kernel.org>; Thu, 11 Mar 2021 23:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCKXYT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Mar 2021 18:24:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCKXX7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Mar 2021 18:23:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0942F64F70;
        Thu, 11 Mar 2021 23:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615505039;
        bh=sg173eixY03gYcCrohhV7a+jDtOKCKdMN7GdLo07jf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7Yeqhq2ivqWboeyZ2ZHogw+F4RHh5LdarqESebWWq44RTSg7jcNSd8fffIFAZ43/
         nc9aYjuyseujZvjoBlREdFl/svhhk6P2IxEEs24+fz4N5OKzLQB1BsRPEHEe3X5ucW
         8CsGsLpyDLf2/frToHAzCd8/SjXEDepJ04EHX5VuTmnPj9d+/0oI9Cr3VcRCSygivB
         urW2Dbllt+zNQ/0jMBygBWnWR50fTecxzX/1j3bS5JBMN15LVYkPMPhwT1wpJyWMk9
         YN0b2CZ3/vgcOTwlqajYmBWlHrCgaxaM8MdrR415X8+0dDgDwON7PHDm0vPTMihHyF
         rOLKELvCkaMDg==
Date:   Fri, 12 Mar 2021 00:23:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 07/10] rcu: Prevent dyntick-idle until
 ksoftirqd has been spawned
Message-ID: <20210311232357.GA29548@lothringen>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
 <20210304000019.22459-7-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304000019.22459-7-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 03, 2021 at 04:00:16PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> After interrupts have enabled at boot but before some random point
> in early_initcall() processing, softirq processing is unreliable.
> If softirq sees a need to push softirq-handler invocation to ksoftirqd
> during this time, then those handlers can be delayed until the ksoftirqd
> kthreads have been spawned, which happens at some random point in the
> early_initcall() processing.  In many cases, this delay is just fine.
> However, if the boot sequence blocks waiting for a wakeup from a softirq
> handler, this delay will result in a silent-hang deadlock.
> 
> This commit therefore prevents these hangs by ensuring that the tick
> stays active until after the ksoftirqd kthreads have been spawned.
> This change causes the tick to eventually drain the backlog of delayed
> softirq handlers, breaking this deadlock.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_plugin.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 2d60377..36212de 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1255,6 +1255,11 @@ static void rcu_prepare_kthreads(int cpu)
>   */
>  int rcu_needs_cpu(u64 basemono, u64 *nextevt)
>  {
> +	/* Through early_initcall(), need tick for softirq handlers. */
> +	if (!IS_ENABLED(CONFIG_HZ_PERIODIC) && !this_cpu_ksoftirqd()) {
> +		*nextevt = 1;
> +		return 1;
> +	}
>  	*nextevt = KTIME_MAX;
>  	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
>  	       !rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist);
> @@ -1350,6 +1355,12 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
>  
>  	lockdep_assert_irqs_disabled();
>  
> +	/* Through early_initcall(), need tick for softirq handlers. */
> +	if (!IS_ENABLED(CONFIG_HZ_PERIODIC) && !this_cpu_ksoftirqd()) {
> +		*nextevt = 1;
> +		return 1;
> +	}
> +
>  	/* If no non-offloaded callbacks, RCU doesn't need the CPU. */
>  	if (rcu_segcblist_empty(&rdp->cblist) ||
>  	    rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist)) {


I suspect rcutiny should be concerned as well?

In fact this patch doesn't look necessary because can_stop_idle_tick() refuse
to stop the tick when softirqs are pending.

Thanks.
