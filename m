Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0145BE7;
	Mon, 20 May 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247534; cv=none; b=fHKniqUzhLqP0Lh+eXUJfpIy5zVpJTRE5W5C+thk4mODa/gEOFYWvGV35D9MnKSCdNw+IUXTa8hGlxLSkb99t080dwYpNAdtPvmhZdWevY0jOqnQPAKjcIpTnFEbKK7wyS6hvdNwW8dtESz5sWEfaNkThFIfCVBZdAK7XInrMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247534; c=relaxed/simple;
	bh=hZDKkVV7OaIgYGaTjsW7Rr9VGim/EKkxGLUtLj7dp4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJbPS6yWieDjuR/tTod76YQVOIN+5arEWtlTXXmlZSshYxxYCjEgzc4QDEHD2+gGDr19XNR+cd0fs7SblZ9JuNsd4P1w2lRYzwcrRL4Npbsdhx+TMkRqrDaXl0Cn7w5KgyHGRDK7S9p1mncPhOjb1fyEliZsdR82DnwdEE3cnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fav/BO76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fav/BO76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EC0C2BD10;
	Mon, 20 May 2024 23:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716247534;
	bh=hZDKkVV7OaIgYGaTjsW7Rr9VGim/EKkxGLUtLj7dp4A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Fav/BO768VQSNjvjT+YMqa22L4y2N1wRkJUL9lkLK81jhWS7tWnV1O5DqniXT5Z8U
	 xmHvUGmj1LbkxuEPVH/yV7QJMU0k9SQqFR0DZV+wocSHv3T4650VtWDxI6xJ+o+S3R
	 9ZoI8wJARd3PKefmeVJE2Ajl6YszgpZvLL8XXYw8/glWbMjzStzzGAOiGht0GMsWp0
	 GR/UsuoqtnfbCu8Zsk9YyDXTSsibfawx11YRATB9Bjpngc2utDRNLtX2WoDnS1sRoi
	 DiC26A5Om+xvc3xjiDq23iyL4gW2PnebPyo0wmdNIAekNpOrYF2W56s4NEXSfD9kFV
	 lP813fOU1hqOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7FB4CE2AA6; Mon, 20 May 2024 16:25:33 -0700 (PDT)
Date: Mon, 20 May 2024 16:25:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] rcu/tasks: Further comment ordering around current
 task snapshot on TASK-TRACE
Message-ID: <24467166-5f00-45f2-867f-40b8a836d085@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240517152303.19689-1-frederic@kernel.org>
 <20240517152303.19689-3-frederic@kernel.org>
 <adf836b2-c660-4dc5-82dd-55d18596c803@paulmck-laptop>
 <Zku1kDj_LjK3WxaA@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zku1kDj_LjK3WxaA@pavilion.home>

On Mon, May 20, 2024 at 10:41:52PM +0200, Frederic Weisbecker wrote:
> Le Mon, May 20, 2024 at 11:48:54AM -0700, Paul E. McKenney a écrit :
> > On Fri, May 17, 2024 at 05:23:03PM +0200, Frederic Weisbecker wrote:
> > > Comment the current understanding of barriers and locking role around
> > > task snapshot.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  kernel/rcu/tasks.h | 18 +++++++++++++++---
> > >  1 file changed, 15 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 6a9ee35a282e..05413b37dd6e 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -1738,9 +1738,21 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
> > >  	for_each_online_cpu(cpu) {
> > >  		rcu_read_lock();
> > >  		/*
> > > -		 * RQ must be locked because no ordering exists/can be relied upon
> > > -		 * between rq->curr write and subsequent read sides. This ensures that
> > > -		 * further context switching tasks will see update side pre-GP accesses.
> > > +		 * RQ lock + smp_mb__after_spinlock() before reading rq->curr serve
> > > +		 * two purposes:
> > > +		 *
> > > +		 * 1) Ordering against previous tasks accesses (though already enforced
> > > +		 *    by upcoming IPIs and post-gp synchronize_rcu()).
> > > +		 *
> > > +		 * 2) Make sure not to miss latest context switch, because no ordering
> > > +		 *    exists/can be relied upon between rq->curr write and subsequent read
> > > +		 *    sides.
> > > +		 *
> > > +		 * 3) Make sure subsequent context switching tasks will see update side
> > > +		 *    pre-GP accesses.
> > > +		 *
> > > +		 * smp_mb() after reading rq->curr doesn't play a significant role and might
> > > +		 * be considered for removal in the future.
> > >  		 */
> > >  		t = cpu_curr_snapshot(cpu);
> > >  		if (rcu_tasks_trace_pertask_prep(t, true))
> > 
> > How about this for that comment?
> > 
> > 		// Note that cpu_curr_snapshot() picks up the target
> > 		// CPU's current task while its runqueue is locked with an
> > 		// smp_mb__after_spinlock().  This ensures that subsequent
> > 		// tasks running on that CPU will see the updater's pre-GP
> > 		// accesses.
> 
> Right but to achieve that, the smp_mb() was already enough, courtesy of
> the official full barrier on schedule that (this one at least) we could rely on:
> 
> Updater             Reader
> ------             -------
> X = 1              rq->curr = A
>                    // another context switch later
> smp_mb()           smp_mb__after_spin_lock() // right after rq_lock on __schedule()
> READ rq->curr      rq->curr = B
>                    READ X
> 
> If the updater misses A, B will see the update on X.
> 
> So I think we still need to justify the rq locking on the comments.
> 
> >                          The trailng smp_mb() in cpu_curr_snapshot()
> > 		// does not currently play a role other than simplify
> > 		// that function's ordering semantics.  If these simplified
> > 		// ordering semantics continue to be redundant, that smp_mb()
> > 		// might be removed.
> 
> That looks good.
> 
> > 
> > I left out the "ordering agains previous tasks accesses" because,
> > as you say, this ordering is provided elsewhere.
> 
> Right!

Good points!  How about the following?

		// Note that cpu_curr_snapshot() picks up the target
		// CPU's current task while its runqueue is locked with
		// an smp_mb__after_spinlock().  This ensures that either
		// the grace-period kthread will see that task's read-side
		// critical section or the task will see the updater's pre-GP
		// accesses.  The trailng smp_mb() in cpu_curr_snapshot()
		// does not currently play a role other than simplify
		// that function's ordering semantics.  If these simplified
		// ordering semantics continue to be redundant, that smp_mb()
		// might be removed.

Keeping in mind that the commit's log fully lays out the troublesome
scenario.

							Thanx, Paul
