Return-Path: <SRS0=9ZY9=C7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB062C2D0E2
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 22:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B006720735
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600812044;
	bh=VzrZMpqwNjj7GLA1FO+ZBXW3i0yjDRa5NIGJNS+NvyI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ozy2P19Df6LPVOzbCStB8j5RUnJD15V5CHIh/mcrQf6uoZQfxTO5oT++rNrtMzLBm
	 f9HFfUWmsNUK6VsaCUYtrprUxrqZWLVjh4uayLTBqZU8VqpMcJ9ioXWhxqAiclBE1R
	 2jYxwHYaZnFJQPtgb7Xz8Ce/A/ci3v0dm0GVYqqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIVWAo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIVWAo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Sep 2020 18:00:44 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78073206B5;
        Tue, 22 Sep 2020 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600812043;
        bh=VzrZMpqwNjj7GLA1FO+ZBXW3i0yjDRa5NIGJNS+NvyI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dqj/BZXLnAj8fYN4lRmi2+zahTBkQ6eqj7HhJGcc5HTzUJKxjyvLBsf25w9LHt3wC
         dX8vKdn6kfDAg0y1Qwp9tVai72L3sll6+i0lbfQ7D4FqINkfOkXQbB9kCznxZFvzIi
         138hF0hp5I+/qoyKXhx7BuZlJSKDHxaUdKzUDOu0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2120135227BD; Tue, 22 Sep 2020 15:00:43 -0700 (PDT)
Date:   Tue, 22 Sep 2020 15:00:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] srcu: Fix static initialization
Message-ID: <20200922220043.GF29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200908144306.33355-1-aik@ozlabs.ru>
 <cc25257d-804e-8cf7-150b-e6bdbaf184be@ozlabs.ru>
 <20200909115010.GG29330@paulmck-ThinkPad-P72>
 <37f76aac-d8e3-8ab1-24e9-c417b719e2a6@ozlabs.ru>
 <20200910185353.GS29330@paulmck-ThinkPad-P72>
 <611a6a87-f673-c5b7-3b60-58805fba580a@ozlabs.ru>
 <20200911135208.GX29330@paulmck-ThinkPad-P72>
 <20200916161224.GA30546@paulmck-ThinkPad-P72>
 <ef2179e0-ddad-05c0-2292-9b9dcfd348f9@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2179e0-ddad-05c0-2292-9b9dcfd348f9@ozlabs.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 22, 2020 at 10:41:37AM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 17/09/2020 02:12, Paul E. McKenney wrote:
> > On Fri, Sep 11, 2020 at 06:52:08AM -0700, Paul E. McKenney wrote:
> >> On Fri, Sep 11, 2020 at 03:09:41PM +1000, Alexey Kardashevskiy wrote:
> >>> On 11/09/2020 04:53, Paul E. McKenney wrote:
> >>>> On Wed, Sep 09, 2020 at 10:31:03PM +1000, Alexey Kardashevskiy wrote:
> > 
> > [ . . . ]
> > 
> >>>>> init_srcu_struct_nodes() assumes ssp->sda!=NULL but alloc_percpu() fails
> >>>>> here:
> >>>>>
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/percpu.c#n1734
> >>>>> ===
> >>>>> 	} else if (mutex_lock_killable(&pcpu_alloc_mutex)) {
> >>>>> 			pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
> >>>>> 			return NULL;
> >>>>> ===
> >>>>>
> >>>>> I am still up to reading that osr-rcuusage.pdf to provide better
> >>>>> analysis :) Thanks,
> >>>>
> >>>> Ah, got it!  Does the following patch help?
> >>>>
> >>>> There will likely also need to be changes to cleanup_srcu_struct(),
> >>>> but first let's see if I understand the problem.  ;-)
> >>>>
> >>>> 							Thanx, Paul
> >>>>
> >>>> ------------------------------------------------------------------------
> >>>>
> >>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >>>> index c13348e..6f7880a 100644
> >>>> --- a/kernel/rcu/srcutree.c
> >>>> +++ b/kernel/rcu/srcutree.c
> >>>> @@ -177,11 +177,13 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >>>>  	INIT_DELAYED_WORK(&ssp->work, process_srcu);
> >>>>  	if (!is_static)
> >>>>  		ssp->sda = alloc_percpu(struct srcu_data);
> >>>> +	if (!ssp->sda)
> >>>> +		return -ENOMEM;
> >>>>  	init_srcu_struct_nodes(ssp, is_static);
> >>>>  	ssp->srcu_gp_seq_needed_exp = 0;
> >>>>  	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
> >>>>  	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
> >>>
> >>> The line above confuses me a bit. What you propose returns without
> >>> smp_store_release() called which should not matter I suppose.
> >>
> >> The idea is that if init_srcu_struct() returns -ENOMEM, the structure
> >> has not been initialized and had better not be used.  If the calling code
> >> cannot handle that outcome, then the calling code needs to do something
> >> to insulate init_srcu_struct() from signals.  One thing that it could
> >> do would be to invoke init_srcu_struct() from a workqueue handler and
> >> wait for this handler to complete.
> >>
> >> Please keep in mind that there is nothing init_srcu_struct() can do
> >> about this:  The srcu_struct is useless unless alloc_percpu() succeeds.
> >>
> >> And yes, I do need to update the header comments to make this clear.
> >>
> >>> Otherwise it should work, although I cannot verify right now as my box
> >>> went down and since it is across Pacific - it may take time to power
> >>> cycle it :) Thanks,
> >>
> >> I know that feeling!  And here is hoping that the box is out of reach
> >> of the local hot spots.  ;-)
> > 
> > Just following up...  Did that patch help?
> 
> Yes it did.
> 
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thank you, and I will apply on the next rebase.

							Thanx, Paul
