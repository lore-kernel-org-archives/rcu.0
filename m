Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA757EE3F2F
	for <rcu@archiver.kernel.org>; Fri, 15 Sep 2023 14:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjIOOpa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Sep 2023 10:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbjIOOp3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Sep 2023 10:45:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5927E2111
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 07:45:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47F0C433C8;
        Fri, 15 Sep 2023 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694789124;
        bh=cBw1k9tUxJ3rWd5N9B0H5a4UlS36Lvf+UEYeTBNYSNY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ms1peBLDWikcXUKPmFskS5zQyR9d3tebetnNYLqQCTfhE9CQCZVMxkY2HocTqQ8to
         J34VNwI+jAB5njXgD9UZKMBooEuACMHnMuXUerYatCJeB+qdJ9taKn5U88oNZ6W5w3
         oEJ0n3DLDZGMc+acmxW3mRCFuVEZqViG5c/4O4x4Af4/uf5QTnJbYFZ89tqb6mZfcq
         NYPLX0QPD8EGMkCJ7lQKiZPfQzWv9VjpP5rtY3Id2TUHXzH9OHlLmEyATvMH9YLkNF
         ZYHOIVUAAeTvGZLYW1LdcWK6thRw4nw6Q2G7MAfgqTCQDUfM5ORwaL0Q1ukT1CUTtU
         CGmMmPUQbhvuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9D0CCCE1DF8; Fri, 15 Sep 2023 07:45:20 -0700 (PDT)
Date:   Fri, 15 Sep 2023 07:45:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <7ecec718-dec8-411f-9dbd-dbe5fa946450@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com>
 <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
 <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
 <fe78cd08-1b2c-4ab0-bbf7-8d324b4fa77f@paulmck-laptop>
 <20230914131351.GA2274683@google.com>
 <885bb95b-9068-45f9-ba46-3feb650a3c45@paulmck-laptop>
 <20230914185627.GA2520229@google.com>
 <20230914215324.GA1972295@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914215324.GA1972295@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 14, 2023 at 09:53:24PM +0000, Joel Fernandes wrote:
> On Thu, Sep 14, 2023 at 06:56:27PM +0000, Joel Fernandes wrote:
> > On Thu, Sep 14, 2023 at 08:23:38AM -0700, Paul E. McKenney wrote:
> > > On Thu, Sep 14, 2023 at 01:13:51PM +0000, Joel Fernandes wrote:
> > > > On Thu, Sep 14, 2023 at 04:11:26AM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Sep 13, 2023 at 04:30:20PM -0400, Joel Fernandes wrote:
> > > > > > On Mon, Sep 11, 2023 at 4:16 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > [..]
> > > > > > > > I am digging deeper to see why the rcu_preempt thread cannot be pushed out
> > > > > > > > and then I'll also look at why is it being pushed out in the first place.
> > > > > > > >
> > > > > > > > At least I have a strong repro now running 5 instances of TREE03 in parallel
> > > > > > > > for several hours.
> > > > > > >
> > > > > > > Very good!  Then why not boot with rcutorture.onoff_interval=0 and see if
> > > > > > > the problem still occurs?  If yes, then there is definitely some reason
> > > > > > > other than CPU hotplug that makes this happen.
> > > > > > 
> > > > > > Hi Paul,
> > > > > > So looks so far like onoff_interval=0 makes the issue disappear. So
> > > > > > likely hotplug related. I am ok with doing the cpus_read_lock during
> > > > > > boost testing and seeing if that fixes it. If it does, I can move on
> > > > > > to the next thing in my backlog.
> > > > > > 
> > > > > > What do you think? Or should I spend more time root-causing it? It is
> > > > > > most like runaway RT threads combined with the CPU hotplug threads,
> > > > > > making scheduling of the rcu_preempt thread not happen. But I can't
> > > > > > say for sure without more/better tracing (Speaking of better tracing,
> > > > > > I am adding core-dump support to rcutorture, but it is not there yet).
> > > > > 
> > > > > This would not be the first time rcutorture has had trouble with those
> > > > > threads, so I am for adding the cpus_read_lock().
> > > > > 
> > > > > Additional root-causing might be helpful, but then again, you might
> > > > > have higher priority things to worry about.  ;-)
> > > > 
> > > > No worries. Unfortunately putting cpus_read_lock() around the boost test
> > > > causes hangs. I tried something like the following [1]. If you have a diff, I can
> > > > quickly try something to see if the issue goes away as well.
> > > 
> > > The other approaches that occur to me are:
> > > 
> > > 1.	Synchronize with the torture.c CPU-hotplug code.  This is a bit
> > > 	tricky as well.
> > > 
> > > 2.	Rearrange the testing to convert one of the TREE0* scenarios that
> > > 	is not in CFLIST (TREE06 or TREE08) to a real-time configuration,
> > > 	with boosting but without CPU hotplug.	Then remove boosting
> > > 	from TREE04.
> > > 
> > > Of these, #2 seems most productive.  But is there a better way?
> > 
> > We could have the gp thread at higher priority for TREE03. What I see
> > consistently is that the GP thread gets migrated from CPU M to CPU N only to
> > be immediately sent back. Dumping the state showed CPU N is running ksoftirqd
> > which is also a rt priority 2.  Making rcu_preempt 3 and ksoftirqd 2 might
> > give less of a run-around to rcu_preempt maybe enough to prevent the grace
> > period from stalling. I am not sure if this will fix it, but I am running a
> > test to see how it goes, will let you know.
> 
> That led to a lot of fireworks. :-) I am thinking though, do we really need
> to run a boost kthread on all CPUs? I think that might be the root cause
> because the boost threads run on all CPUs except perhaps the one dying.
> 
> We could run them on just the odd, or even ones and still be able to get
> sufficient boost testing. This may be especially important without RT
> throttling. I'll go ahead and queue a test like that.
> 
> Thoughts?

The problem with this is that it will often render RCU priority boosting
unnecessary.  Any kthread preempted within an RCU read-side critical
section will with high probability quickly be resumed on one of the
even-numbered CPUs.

Or were you also planning to bind the rcu_torture_reader() kthreads to
a specific CPU, preventing such migration?  Or am I missing something
here?

							Thanx, Paul
