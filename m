Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF1139D0E;
	Mon, 20 May 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237715; cv=none; b=jJ5dGLoorxpXQPP6Kh2fGQpvN8eeFKTBP/Cg3lxosZNhGazfXdsWgsmodkKfLpDftLSQvwnep4ikWgR8WPYo+XHY4hGChBMmfsCNhRcKObrUNfrwInHZs1zT8qt2Hnp7moKN66yO/vrHot7ICBzRA7T/DUKuMzUSNeUG49kNW+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237715; c=relaxed/simple;
	bh=332uotyHgsRjV8zXN63yqkX7v33lBZk0a3pKZFZP7UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/JoawGBoZuR8xKwEYTytREeRahH/4sj7/OOLkIY8Cbo/qdMaBf7AiPw+rUtvG7kCx30mQZZYWbqr0uEjq2puDc16P10QlTGZ4WaRKRXWzpQPvwZDSV3/U+WQkTIbfN8KrMP42/7aWFVIv5Lqa0WMWcXendp8hpT9v/Zs955QSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msXNfngF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msXNfngF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D695EC4AF07;
	Mon, 20 May 2024 20:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716237715;
	bh=332uotyHgsRjV8zXN63yqkX7v33lBZk0a3pKZFZP7UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msXNfngFeXkPEKygsJPsnorN+goDLGFG/Sv1gHLtYT2SGO7RzL5+ePNnKvqr17OAS
	 2PCDK0axh9dtTXEWerTnQy1i3uz6SM9h/UJYOtHONFo/Ghyokh/EvEX0yOM2ayta2j
	 x9pnW8R9b9TNtUt1HEtG1WlvLEbY89JWoP/BmIc4KgGNeNU/CmYobqNvcsTaxDRiUP
	 PAXM8LsNG+CnURQzEo8gj7m70N3rwnYq/HD1oLAbApqItmYnoGFQmN1PpdEoX6opac
	 AHYRsrpM8R5ziBc4SRDBnCTxSp4saphwj8upMEwsrW5xFxkMQbrscBAPlucjes/+ri
	 ghM0R0IMNPZIw==
Date: Mon, 20 May 2024 22:41:52 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] rcu/tasks: Further comment ordering around current
 task snapshot on TASK-TRACE
Message-ID: <Zku1kDj_LjK3WxaA@pavilion.home>
References: <20240517152303.19689-1-frederic@kernel.org>
 <20240517152303.19689-3-frederic@kernel.org>
 <adf836b2-c660-4dc5-82dd-55d18596c803@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adf836b2-c660-4dc5-82dd-55d18596c803@paulmck-laptop>

Le Mon, May 20, 2024 at 11:48:54AM -0700, Paul E. McKenney a écrit :
> On Fri, May 17, 2024 at 05:23:03PM +0200, Frederic Weisbecker wrote:
> > Comment the current understanding of barriers and locking role around
> > task snapshot.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tasks.h | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 6a9ee35a282e..05413b37dd6e 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1738,9 +1738,21 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
> >  	for_each_online_cpu(cpu) {
> >  		rcu_read_lock();
> >  		/*
> > -		 * RQ must be locked because no ordering exists/can be relied upon
> > -		 * between rq->curr write and subsequent read sides. This ensures that
> > -		 * further context switching tasks will see update side pre-GP accesses.
> > +		 * RQ lock + smp_mb__after_spinlock() before reading rq->curr serve
> > +		 * two purposes:
> > +		 *
> > +		 * 1) Ordering against previous tasks accesses (though already enforced
> > +		 *    by upcoming IPIs and post-gp synchronize_rcu()).
> > +		 *
> > +		 * 2) Make sure not to miss latest context switch, because no ordering
> > +		 *    exists/can be relied upon between rq->curr write and subsequent read
> > +		 *    sides.
> > +		 *
> > +		 * 3) Make sure subsequent context switching tasks will see update side
> > +		 *    pre-GP accesses.
> > +		 *
> > +		 * smp_mb() after reading rq->curr doesn't play a significant role and might
> > +		 * be considered for removal in the future.
> >  		 */
> >  		t = cpu_curr_snapshot(cpu);
> >  		if (rcu_tasks_trace_pertask_prep(t, true))
> 
> How about this for that comment?
> 
> 		// Note that cpu_curr_snapshot() picks up the target
> 		// CPU's current task while its runqueue is locked with an
> 		// smp_mb__after_spinlock().  This ensures that subsequent
> 		// tasks running on that CPU will see the updater's pre-GP
> 		// accesses.

Right but to achieve that, the smp_mb() was already enough, courtesy of
the official full barrier on schedule that (this one at least) we could rely on:

Updater             Reader
------             -------
X = 1              rq->curr = A
                   // another context switch later
smp_mb()           smp_mb__after_spin_lock() // right after rq_lock on __schedule()
READ rq->curr      rq->curr = B
                   READ X

If the updater misses A, B will see the update on X.

So I think we still need to justify the rq locking on the comments.

>                          The trailng smp_mb() in cpu_curr_snapshot()
> 		// does not currently play a role other than simplify
> 		// that function's ordering semantics.  If these simplified
> 		// ordering semantics continue to be redundant, that smp_mb()
> 		// might be removed.

That looks good.

> 
> I left out the "ordering agains previous tasks accesses" because,
> as you say, this ordering is provided elsewhere.

Right!

Thanks.
