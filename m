Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A3199389;
	Thu,  6 Jun 2024 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697523; cv=none; b=hUVBed2hGeFvxN1LQPJ8YwEIH4JMgtk4+p4RimIS3cdjSjgme/+8PZYOYTQ7zv/Rrf6R7ZiQ3QKoG/J9J0gvxm2Xb76hn4GcqOFd78nw3BXSxMnAvrqAxAQ9Og0ZqGHj13XXRLie8nrGR5uY6WbBxX5kdw8/N00kBUzCCbuUPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697523; c=relaxed/simple;
	bh=rahIpKZsGpZl2GO/jcg+ZxtQQuJCfpWo2UtJ417xTUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMqMYLvd7MWssRBwVq3yLhXSws57WJWiVAANLXrpfFiJsJU557I01fnD+MqU54iQQd64bMyqo/byZg/99NCnLhtjox5y4gp4Wm7ChbRVNiki+RS2gFV0OCF0b9zANPGEpb/u7n+LN5ODOfirLxgZ9ujnxnSwuLeG/FHwvixNHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=octv4Whv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="octv4Whv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C271EC2BD10;
	Thu,  6 Jun 2024 18:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717697522;
	bh=rahIpKZsGpZl2GO/jcg+ZxtQQuJCfpWo2UtJ417xTUw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=octv4WhvBePeFZZ7velpQzLtev96q76IfX8815xAMcWB094Tr6JRjwZ7nR4LPR9Xs
	 53zumoRdLP7y38JHxw3o6f9GxytjeiC1is8PNEz1zhgkz+I7MAEIjH+cjkZui3gQpc
	 TWom6+lJO94GhpTjiUI33wEbgothq1eDMFQOE5oS6zIkkLUpvSJfOVulwr1fcu86ju
	 rEgU91FGQHRzyOiIHOr/2csuQQm4Y6XSvMxqoVLNw9jY8/7+PlPrKieWhyJ91PVovI
	 EMfmq4Cp9bkzYypKi7UpyMdhu363uhDXrtpF4nNez52jO0l1S/3BAqKUdRRVHFEcQW
	 Fms/kBSgmutGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 47419CE3F34; Thu,  6 Jun 2024 11:12:02 -0700 (PDT)
Date: Thu, 6 Jun 2024 11:12:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH rcu 3/9] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Message-ID: <beb31a51-253e-4bc4-a73c-456f2bf2fd06@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-3-paulmck@kernel.org>
 <ZmCTvMVlOMFv0-zd@localhost.localdomain>
 <CAFwiDX8yGCEiZE-VC0i=VoGByQArQkwG7beVvQO5wRGsK8rdPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX8yGCEiZE-VC0i=VoGByQArQkwG7beVvQO5wRGsK8rdPQ@mail.gmail.com>

On Thu, Jun 06, 2024 at 11:28:07AM +0530, Neeraj upadhyay wrote:
> On Wed, Jun 5, 2024 at 10:05 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Le Tue, Jun 04, 2024 at 03:23:49PM -0700, Paul E. McKenney a écrit :
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > >
> > > In the synchronize_rcu() common case, we will have less than
> > > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > > is pointless just to free the last injected wait head since at that point,
> > > all the users have already been awakened.
> > >
> > > Introduce a new counter to track this and prevent the wakeup in the
> > > common case.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
> > >  kernel/rcu/tree.h |  1 +
> > >  2 files changed, 31 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 6ba36d9c09bde..2fe08e6186b4d 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
> > >       .ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> > >       .srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> > >               rcu_sr_normal_gp_cleanup_work),
> > > +     .srs_cleanups_pending = ATOMIC_INIT(0),
> > >  };
> > >
> > >  /* Dump rcu_node combining tree at boot to verify correct setup. */
> > > @@ -1633,8 +1634,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > >        * the done tail list manipulations are protected here.
> > >        */
> > >       done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > -     if (!done)
> > > +     if (!done) {
> > > +             /* See comments below. */
> > > +             atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> >
> > This condition is not supposed to happen. If the work is scheduled,
> > there has to be a wait_queue in rcu_state.srs_done_tail. And decrementing
> > may make things worse.
> >
> 
> I also don't see a scenario where this can happen. However, if we are
> returning from here, given that for every queued work we do an
> increment of rcu_state.srs_cleanups_pending, I think it's safer to
> decrement in this
> case, as that counter tracks only the work queuing and execution counts.
> 
>     atomic_inc(&rcu_state.srs_cleanups_pending);
>     if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
>         atomic_dec(&rcu_state.srs_cleanups_pending);

Linus Torvald's general rule is that if you cannot imagine how a bug
can happen, don't attempt to clean up after it.  His rationale (which
is *almost* always a good one) is that not knowing how the bug happens
means that attempts to clean up will usually just make matters worse.
And all too often, the clean-up code makes debugging more difficult.

One example exception to this rule is when debug-objects detects a
duplicate call_rcu().  In that case, we ignore that second call_rcu().
But the reason is that experience has shown that the usual cause really
is someone doing a duplicate call_rcu(), and also that ignoring the
second call_rcu() makes debugging easier.

So what is it that Frederic and I are missing here?

							Thanx, Paul

> Thanks
> Neeraj
> 
> > So this should be:
> >
> > if (WARN_ON_ONCE(!done))
> >    return;
> >
> > Thanks.
> >
> 
