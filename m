Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB060EED61A
	for <rcu@archiver.kernel.org>; Fri, 15 Sep 2023 16:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjIOQ6H (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Sep 2023 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjIOQ5n (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Sep 2023 12:57:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC419BC
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 09:57:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EDAC433C7;
        Fri, 15 Sep 2023 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694797058;
        bh=WNM8e4jPrjeur6PJ5jLQSVLHHzsOZHwQGpqP+j11ScI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h8J75v/XspHtrv3cx+O1nSkTZ8uYPmKanijuzG45SZfGRI/jigUvimw25Xk8OLws+
         esgcFjTFf4WrCQqcL5WQ4lEAPsYWP3PxeYVrEXdPe/OrpSU90piQY5T8TQWAyrLEAa
         DTJPRjqzbbMICY0qWK7Wl80k/eryvqO0UPaCCuUjJlTN7bGEz3X/wmfrI4v7lWVfZ6
         jYVjW78+rY/b/+szKmNNBI20Spo0OpIGuJFqxoDGlVnwsWN9h0eOpgo+15fuUt3lTD
         mme99QAZ1w/gnlNjFpUwKrRQzE/KwYZgWuwxZZTfzkeOyJitzW9M5CsI1bp6CclVbb
         g752tLGJomUwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B1A4ECE20DE; Fri, 15 Sep 2023 09:57:34 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:57:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <d8f43d7a-3e42-4be7-a8c9-dcbff2ca87ef@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
 <fe78cd08-1b2c-4ab0-bbf7-8d324b4fa77f@paulmck-laptop>
 <20230914131351.GA2274683@google.com>
 <885bb95b-9068-45f9-ba46-3feb650a3c45@paulmck-laptop>
 <20230914185627.GA2520229@google.com>
 <20230914215324.GA1972295@google.com>
 <20230915001331.GA1235904@google.com>
 <20230915113313.GA2909128@google.com>
 <ddc6c9d3-f9c7-46ab-a11e-0841148baa3a@paulmck-laptop>
 <20230915163711.GA3116200@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915163711.GA3116200@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 15, 2023 at 04:37:11PM +0000, Joel Fernandes wrote:
> Hi Paul,
> Thanks! I merged replies to 3 threads into this one to make it easier to follow.
> 
> On Fri, Sep 15, 2023 at 07:53:15AM -0700, Paul E. McKenney wrote:
> > On Fri, Sep 15, 2023 at 11:33:13AM +0000, Joel Fernandes wrote:
> > > On Fri, Sep 15, 2023 at 12:13:31AM +0000, Joel Fernandes wrote:
> [...]
> > > On the other hand, I came up with a real fix [1] and I am currently testing it.
> > > This is to fix a live lock between RT push and CPU hotplug's
> > > select_fallback_rq()-induced push. I am not sure if the fix works but I have
> > > some faith based on what I'm seeing in traces. Fingers crossed. I also feel
> > > the real fix is needed to prevent these issues even if we're able to hide it
> > > by halving the total rcutorture boost threads.
> > 
> > This don't-schedule-on-dying CPUs approach does quite look promising
> > to me!
> > 
> > Then again, I cannot claim to be a scheduler expert.  And I am a bit
> > surprised that this does not already happen.  Which makes me wonder
> > (admittedly without evidence either way) whether there is some CPU-hotplug
> > race that it might induce.  But then again, figuring this sort of thing
> > out is what part of the scheduler guys are there for, right?  ;-)
> 
> Yes it looks promising. Actually this sort of thing also seems to be already
> done in CFS, it just not there in RT. So maybe it is OK. Testing so far
> showed me pretty good results even with hotplug testing. Here is hoping!
> 
> > > > On the other hand, I came up with a real fix [1] and I am currently testing it.
> > > > This is to fix a live lock between RT push and CPU hotplug's
> > > > select_fallback_rq()-induced push. I am not sure if the fix works but I have
> > > > some faith based on what I'm seeing in traces. Fingers crossed. I also feel
> > > > the real fix is needed to prevent these issues even if we're able to hide it
> > > > by halving the total rcutorture boost threads.
> > > 
> > > So that fixed it without any changes to RCU. Below is the updated patch also
> > > for the archives. Though I'm rewriting it slightly differently and testing
> > > that more. The main thing I am doing in the new patch is I find that RT
> > > should not select !cpu_active() CPUs since those have the scheduler turned
> > > off. Though checking for cpu_dying() also works. I could not find any
> > > instance where cpu_dying() != cpu_active() but there could be a tiny window
> > > where that is true. Anyway, I'll make some noise with scheduler folks once I
> > > have the new version of the patch tested.
> > > 
> > > Also halving the number of RT boost threads makes it less likely to occur but
> > > does not work. Not too surprising since the issue actually may not be related
> > > to too many RT threads but rather a lockup between hotplug and RT..
> > 
> > Again, looks promising!  When I get the non-RCU -rcu stuff moved to
> > v6.6-rc1 and appropriately branched and tested, I will give it a go on
> > the test setup here.
> 
> Thanks a lot, and I have enclosed a simpler updated patch below which also
> similarly shows very good results. This is the one I would like to test
> more and send to scheduler folks. I'll send it out once I have it tested more
> and also possibly after seeing your results (I am on vacation next week so
> there's time).

Much nicer!  This is just on current mainline, correct?

> > > We could run them on just the odd, or even ones and still be able to get
> > > sufficient boost testing. This may be especially important without RT
> > > throttling. I'll go ahead and queue a test like that.
> > > 
> > > Thoughts?
> > 
> > The problem with this is that it will often render RCU priority boosting
> > unnecessary.  Any kthread preempted within an RCU read-side critical
> > section will with high probability quickly be resumed on one of the
> > even-numbered CPUs.
> > 
> > Or were you also planning to bind the rcu_torture_reader() kthreads to
> > a specific CPU, preventing such migration?  Or am I missing something
> > here?
> 
> You are right, I see now why you were running them on all CPUs. One note
> though, af the RCU reader threads are CFS, they will not be immediately
> pushed out so maybe it may work (unlike if the RCU reader threads being
> preempted were RT). However testing shows thread-halving does not fix the
> issue anyway so we can scratch that. Instead, below is the updated patch for
> don't schedule-on-dying/inactive CPUs approach which is showing really good
> results!

I will admit that you did have me going there for a minute or two.  ;-)

> And I'll most likely see you the week after, after entering into a 4-day
> quiescent state. ;-)

Have a great time away!!!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> ---8<-----------------------
> 
> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> Subject: [PATCH] RT: Alternative fix for livelock with hotplug
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/cpupri.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index a286e726eb4b..42c40cfdf836 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -101,6 +101,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
>  
>  	if (lowest_mask) {
>  		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
> +		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
>  
>  		/*
>  		 * We have to ensure that we have at least one bit
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
