Return-Path: <SRS0=c1tG=B4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98301C433E1
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 23:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6299D20786
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 23:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TnIpN1bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHRXZ6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHRXZ6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 19:25:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C0BC061389
        for <rcu@vger.kernel.org>; Tue, 18 Aug 2020 16:25:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so16505340qtg.4
        for <rcu@vger.kernel.org>; Tue, 18 Aug 2020 16:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cBg9mi2UQh4TtluEe91dZKWnRgC9OEpeXNhSZdpu+Ew=;
        b=TnIpN1bcBTX0J/2DTuL5XFSifIOkz7CxM6D5SGYHsrce+haqRHEisFuAV2YYXGTIb9
         wFEqv5KV6AWWxJOBUleQgfIzPg4o9+PoXhbVRR662QnNkD7/fGMVvawdagDF2A9mbRfG
         AZXIk1g4GW4ksCJM5JVZZksmVv/a+VygXxj8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBg9mi2UQh4TtluEe91dZKWnRgC9OEpeXNhSZdpu+Ew=;
        b=tflHzZdIWp8xxpYPpiGtTAvIWIyL1QLxT1otdTWztuZjZIqXEKZ3C3/b41CXJ+aJ+u
         rrF2UwiiHXkjmZ4VItaFwzo67JiSTIUYT5P1urHZ60XSxrycDHb6Po83MbOhkkgtWl2+
         L6/FePELQz5snVY70Fh/57tLPPerXUi3n8jZg6wi4WgYhCllLFUeuAMIxmlHx8mK7RQD
         HHbKSsENIbzCZ+l8P5RuHNu9pVaLB9YsGsd/S8FJDYrOUy8Tg8cEuZwycBITzbpHYCku
         YuwlCNXtaAXumgFvvCfc6nQXfoHsFPp1x67Z3Ky4XniRbL4KJxqL1qlMiZPvQWSSk6Qj
         MoQw==
X-Gm-Message-State: AOAM5328HSFh39qtiVJMgNT8s/A7qvxRrKYsejoHqcBi5UZnkGIfff+F
        7FwMCc42FzCsPse7DrKENlbPoA==
X-Google-Smtp-Source: ABdhPJxbQnp4gZT2pntan3aGDyvxjijLq9LHKEwfJ+zv8BQ2Dfg5TwuA+u9y+wUwsP9WVOm8Ts8rUQ==
X-Received: by 2002:ac8:7205:: with SMTP id a5mr20339399qtp.235.1597793155779;
        Tue, 18 Aug 2020 16:25:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id j15sm21679007qkl.63.2020.08.18.16.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 16:25:55 -0700 (PDT)
Date:   Tue, 18 Aug 2020 19:25:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, qiang.zhang@windriver.com,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
Message-ID: <20200818232554.GA2850477@google.com>
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636>
 <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
 <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72>
 <20200818215511.GA2538@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818215511.GA2538@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 18, 2020 at 11:55:11PM +0200, Uladzislau Rezki wrote:
> > On Tue, Aug 18, 2020 at 03:00:35PM -0400, Joel Fernandes wrote:
> > > On Tue, Aug 18, 2020 at 1:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 17, 2020 at 06:03:54PM -0400, Joel Fernandes wrote:
> > > > > On Fri, Aug 14, 2020 at 2:51 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > > From: Zqiang <qiang.zhang@windriver.com>
> > > > > > >
> > > > > > > Due to cpu hotplug. some cpu may be offline after call "kfree_call_rcu"
> > > > > > > func, if the shrinker is triggered at this time, we should drain each
> > > > > > > possible cpu "krcp".
> > > > > > >
> > > > > > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > > > > > > ---
> > > > > > >  kernel/rcu/tree.c | 6 +++---
> > > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > index 8ce77d9ac716..619ccbb3fe4b 100644
> > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > @@ -3443,7 +3443,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > > > >       unsigned long count = 0;
> > > > > > >
> > > > > > >       /* Snapshot count of all CPUs */
> > > > > > > -     for_each_online_cpu(cpu) {
> > > > > > > +     for_each_possible_cpu(cpu) {
> > > > > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > > > >
> > > > > > >               count += READ_ONCE(krcp->count);
> > > > > > > @@ -3458,7 +3458,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > > > > > >       int cpu, freed = 0;
> > > > > > >       unsigned long flags;
> > > > > > >
> > > > > > > -     for_each_online_cpu(cpu) {
> > > > > > > +     for_each_possible_cpu(cpu) {
> > > > > > >               int count;
> > > > > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > > > >
> > > > > > > @@ -3491,7 +3491,7 @@ void __init kfree_rcu_scheduler_running(void)
> > > > > > >       int cpu;
> > > > > > >       unsigned long flags;
> > > > > > >
> > > > > > > -     for_each_online_cpu(cpu) {
> > > > > > > +     for_each_possible_cpu(cpu) {
> > > > > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > > > >
> > > > > > >               raw_spin_lock_irqsave(&krcp->lock, flags);
> > > > > > >
> > > > > > I agree that it can happen.
> > > > > >
> > > > > > Joel, what is your view?
> > > > >
> > > > > Yes I also think it is possible. The patch LGTM. Another fix could be
> > > > > to drain the caches in the CPU offline path and save the memory. But
> > > > > then it will take hit during __get_free_page(). If CPU
> > > > > offlining/online is not frequent, then it will save the lost memory.
> > > > >
> > > > > I wonder how other per-cpu caches in the kernel work in such scenarios.
> > > > >
> > > > > Thoughts?
> > > >
> > > > Do I count this as an ack or a review?  If not, what precisely would
> > > > you like the submitter to do differently?
> > > 
> > > Hi Paul,
> > > The patch is correct and is definitely an improvement. I was thinking
> > > about whether we should always do what the patch is doing when
> > > offlining CPUs to save memory but now I feel that may not be that much
> > > of a win to justify more complexity.
> > > 
> > > You can take it with my ack:
> > > 
> > > Acked-by: Joel Fernandes <joel@joelfernandes.org>
> > 
> > Thank you all!  I wordsmithed a bit as shown below, so please let
> > me know if I messed anything up.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit fe5d89cc025b3efe682cac122bc4d39f4722821e
> > Author: Zqiang <qiang.zhang@windriver.com>
> > Date:   Fri Aug 14 14:45:57 2020 +0800
> > 
> >     rcu: Shrink each possible cpu krcp
> >     
> >     CPUs can go offline shortly after kfree_call_rcu() has been invoked,
> >     which can leave memory stranded until those CPUs come back online.
> >     This commit therefore drains the kcrp of each CPU, not just the
> >     ones that happen to be online.
> >     
> >     Acked-by: Joel Fernandes <joel@joelfernandes.org>
> >     Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 02ca8e5..d9f90f6 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3500,7 +3500,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> >  	unsigned long count = 0;
> >  
> >  	/* Snapshot count of all CPUs */
> > -	for_each_online_cpu(cpu) {
> > +	for_each_possible_cpu(cpu) {
> >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >  
> >  		count += READ_ONCE(krcp->count);
> > @@ -3515,7 +3515,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >  	int cpu, freed = 0;
> >  	unsigned long flags;
> >  
> > -	for_each_online_cpu(cpu) {
> > +	for_each_possible_cpu(cpu) {
> >  		int count;
> >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >  
> > @@ -3548,7 +3548,7 @@ void __init kfree_rcu_scheduler_running(void)
> >  	int cpu;
> >  	unsigned long flags;
> >  
> > -	for_each_online_cpu(cpu) {
> > +	for_each_possible_cpu(cpu) {
> >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >  
> >  		raw_spin_lock_irqsave(&krcp->lock, flags);
> >
> 
> Should we just clean a krc of a CPU when it goes offline?
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b8ccd7b5af82..6decb9ad2421 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
>  {
>         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> +       struct kfree_rcu_cpu *krcp;
>  
>         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>                 return 0;
>  
> +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> +       krcp = this_cpu_ptr(&krc)
> +       schedule_delayed_work(&krcp->monitor_work, 0);
> +
> 
> A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> Maybe be never.
> 

Yes that is a bug as we discussed on IRC, thanks for following up as well.

We need to acquire the krcp->lock too if no monitor is scheduled then nothing
to do so it does not race with the kfree_rcu_work. So same as what shrinker
does:

		raw_spin_lock_irqsave(&krcp->lock, flags);
		if (krcp->monitor_todo)
			kfree_rcu_drain_unlock(krcp, flags);
		else
			raw_spin_unlock_irqrestore(&krcp->lock, flags);

thanks!

 - Joel

