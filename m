Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFC13D2A2;
	Mon, 10 Jun 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032379; cv=none; b=Glze2DhD7m60e16bHb2g3J656FYXoehoGXzuTzmiAWo7qVEn3tVNHJN4nrZhWeRQkts8BgnsQAveSQKJWygj35mrNOabABcus1hymWRzA8HpoEoPR7AzRtqreN4igQo340j5DxhavdHjP98AnePbAavRpk7hEWbQo8PkLr/plOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032379; c=relaxed/simple;
	bh=V7GYawRo5XZ8bJwwWXYg1kOKgGFBMi/WhHM5W4k7Zvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbdM+YXUbytVh74PzE09XNNaXRz0oqXfenelqJTmsbzgRe84bSGj9HZz2dx+rdPQiGwdAUBQY03qNP0J0lLqbKam6BsagN/ufdc9AfReknh0TnswRHfotCuhKyOAczEV7pAgl7NcHLsId36/mWe6t8IT7i34l+rHoUiqsaSWPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po5IksS3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po5IksS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8ADC2BBFC;
	Mon, 10 Jun 2024 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718032378;
	bh=V7GYawRo5XZ8bJwwWXYg1kOKgGFBMi/WhHM5W4k7Zvk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=po5IksS3tIroV4rnfdyyEU2pW0qGmO2jOqRXsCWOi6kHQqhpQEy6bUyq9ZXNzW5mL
	 w7y3Bc9F/1OyD6Lr0rJ/LrSLjsykpNXkZAE8VMTQkdVskF+CDfVSuy41VQUKa1wkTS
	 p0KoPex2eUkJSERqg2OykwqhJuZbCLJ9GzxiWzPZf/g66W42xrk96SULynfS+hINt8
	 HARm1YIWwoivlrAyiZt2e4ZaEnNLNK3BsehmxSCb+J8ygE2V5SktZuYa+nkEVRtfoU
	 S+1AjTAq/U87A/PDXkOrlNz5QWUBQQTXbPt38OjDF1uLPStWzQXwtxToOgK+l+2iHY
	 sN1XtvRhSB8jg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2BA4FCE2373; Mon, 10 Jun 2024 08:12:58 -0700 (PDT)
Date: Mon, 10 Jun 2024 08:12:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH rcu 3/9] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Message-ID: <3900dfd9-f2e7-4206-930b-2247186a37db@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-3-paulmck@kernel.org>
 <ZmCTvMVlOMFv0-zd@localhost.localdomain>
 <CAFwiDX8yGCEiZE-VC0i=VoGByQArQkwG7beVvQO5wRGsK8rdPQ@mail.gmail.com>
 <beb31a51-253e-4bc4-a73c-456f2bf2fd06@paulmck-laptop>
 <CAFwiDX-x4=_N2szD2QZhAEkU+kx_eTscz2bcyHqikHq7m=rkpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX-x4=_N2szD2QZhAEkU+kx_eTscz2bcyHqikHq7m=rkpQ@mail.gmail.com>

On Fri, Jun 07, 2024 at 07:21:55AM +0530, Neeraj upadhyay wrote:
> On Thu, Jun 6, 2024 at 11:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Jun 06, 2024 at 11:28:07AM +0530, Neeraj upadhyay wrote:
> > > On Wed, Jun 5, 2024 at 10:05 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >
> > > > Le Tue, Jun 04, 2024 at 03:23:49PM -0700, Paul E. McKenney a écrit :
> > > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > >
> > > > > In the synchronize_rcu() common case, we will have less than
> > > > > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > > > > is pointless just to free the last injected wait head since at that point,
> > > > > all the users have already been awakened.
> > > > >
> > > > > Introduce a new counter to track this and prevent the wakeup in the
> > > > > common case.
> > > > >
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
> > > > >  kernel/rcu/tree.h |  1 +
> > > > >  2 files changed, 31 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 6ba36d9c09bde..2fe08e6186b4d 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
> > > > >       .ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> > > > >       .srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> > > > >               rcu_sr_normal_gp_cleanup_work),
> > > > > +     .srs_cleanups_pending = ATOMIC_INIT(0),
> > > > >  };
> > > > >
> > > > >  /* Dump rcu_node combining tree at boot to verify correct setup. */
> > > > > @@ -1633,8 +1634,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > >        * the done tail list manipulations are protected here.
> > > > >        */
> > > > >       done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > > > -     if (!done)
> > > > > +     if (!done) {
> > > > > +             /* See comments below. */
> > > > > +             atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> > > >
> > > > This condition is not supposed to happen. If the work is scheduled,
> > > > there has to be a wait_queue in rcu_state.srs_done_tail. And decrementing
> > > > may make things worse.
> > > >
> > >
> > > I also don't see a scenario where this can happen. However, if we are
> > > returning from here, given that for every queued work we do an
> > > increment of rcu_state.srs_cleanups_pending, I think it's safer to
> > > decrement in this
> > > case, as that counter tracks only the work queuing and execution counts.
> > >
> > >     atomic_inc(&rcu_state.srs_cleanups_pending);
> > >     if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
> > >         atomic_dec(&rcu_state.srs_cleanups_pending);
> >
> > Linus Torvald's general rule is that if you cannot imagine how a bug
> > can happen, don't attempt to clean up after it.  His rationale (which
> > is *almost* always a good one) is that not knowing how the bug happens
> > means that attempts to clean up will usually just make matters worse.
> > And all too often, the clean-up code makes debugging more difficult.
> >
> 
> Ok. Thanks for sharing this info!
> 
> > One example exception to this rule is when debug-objects detects a
> > duplicate call_rcu().  In that case, we ignore that second call_rcu().
> > But the reason is that experience has shown that the usual cause really
> > is someone doing a duplicate call_rcu(), and also that ignoring the
> > second call_rcu() makes debugging easier.
> >
> > So what is it that Frederic and I are missing here?
> 
> Maybe nothing. As kworker context does not modify srs_done_tail and
> invalid values
> of srs_done_tail  can only be caused by the GP kthread manipulations
> of  srs_done_tail , my thought here was, we can keep the pending
> rcu_sr_normal_gp_cleanup_work count consistent with the number of
> queue_work() and kworker executions, even when we see unexpected
> srs_done_tail values like these. However, as you described the general rule
> is to not attempt any clean up for such scenarios.

So "if (WARN_ON_ONCE(!done) return;"?

Or is there a better way?

							Thanx, Paul
