Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CD282F31;
	Sat, 21 Mar 2026 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123667; cv=none; b=W4sseyHWuxn5l9BTt7w+urW5Uw+C/34c5kQ7JmufbrEOmqf7wztmgAYy7kLS/9jSDuwZzGWbmPAxPAsosIqTy5LQGbbMOjPkxcVy99U+xCqIQ5f00xKvlFx5l9zhNxT/9Tnzx1EpWTP3TnoyPs0Yt1gSHE2iMkqcJMBMPD7rCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123667; c=relaxed/simple;
	bh=lca9x2zmzGiMQOYaJS44l8fFrd5GtaQjpIzWyFXbnv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct0P/UgUDvCG/CB+bikFgbRYJXX8XiXTnMsneObAhllieyoTIqawxieERwLrwpdFb1rlZ8za0pwbbTd98TKY8nzrW9J7/cCGxMDIEeb9fSbrH2/HXls1v7UGLjHMddmG12ySHdEe9P2od4NXQ9768yvFe4oSNwRTOz8urnGDoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHUNUILP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHUNUILP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28675C19421;
	Sat, 21 Mar 2026 20:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123667;
	bh=lca9x2zmzGiMQOYaJS44l8fFrd5GtaQjpIzWyFXbnv0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cHUNUILPVNJiuj5BgNARLV84S3fsbr52mXrU9l455H2bChu0rGFcVYpJ7GnXqNxEg
	 8yMTOQBKOkjS7s2Qf+bSgKvNcuYGQ27pugEGUV5SEuFlX5mf3FB1RWHsAxFsMZwsRj
	 p8Eig54WelsxA/cUL26oSWg7IucvErvSc8Rr6yeMgCRn+97FOpC6ej6d3iku0rrku3
	 +5NUQq7qsX/lxAcSPIcawbhbLkP8HyjfuDXQbeqD70t3gBuUKS/pYDSx1/yA/UxUiN
	 6w83lJljAYHP+ex/bxjWeGD5H3PeeE6BFKn9R9ZN3V6poNzs2zcfkXEUg71+2AiiVO
	 YRf5FEGPdjctA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 15273CE0D53; Sat, 21 Mar 2026 13:07:45 -0700 (PDT)
Date: Sat, 21 Mar 2026 13:07:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <4d2b07a9-e3fd-4a95-8924-0839bdfc28b3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <b4857e4f-5a8d-4ccc-9e8b-df57718e4aee@paulmck-laptop>
 <ab7SQ3L1F-ap7mNl@tardis.local>
 <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
 <ab7eQ0QDNV9ZjQMN@tardis.local>
 <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
 <ab71Vz9zmlVywWQT@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab71Vz9zmlVywWQT@tardis.local>

On Sat, Mar 21, 2026 at 12:45:27PM -0700, Boqun Feng wrote:
> On Sat, Mar 21, 2026 at 12:31:04PM -0700, Paul E. McKenney wrote:
> > On Sat, Mar 21, 2026 at 11:06:59AM -0700, Boqun Feng wrote:
> > > On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
> > > [...]
> > > > > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > > > > +	delay = srcu_get_delay(ssp);
> > > > > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > > > > 
> > > > > 
> > > > > It was fixed differently in v2:
> > > > > 
> > > > > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > > > > 
> > > > > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > > > > overly careful code is probably fine ;-)
> > > > > 
> > > > > Thanks for the testing and feedback.
> > > > 
> > > > OK, I will try that one, thank you!
> > > > 
> > > > FYI, with my change on your earlier version, SRCU-T got deadlocks between
> > > > the pi-lock and the workqueue pool lock.  Which might or might not be
> > > > particularly urgent.
> > > > 
> > > 
> > > I just checked my run yesterday, I also hit it. It's probably what
> > > Zqiang has found:
> > > 
> > > 	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/
> > > 
> > > We have a queue_work_on() in srcu_schedule_cbs_sdp(), so
> > > 
> > >     srcu_torture_deferred_free():
> > >       raw_spin_lock_irqsave(->pi_lock,...);
> > >       call_srcu():
> > >         if (snp == snp_leaf && snp_seq != s) {
> > >            srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
> > > 	     if (!delay)
> > >                queue_work_on(...)
> > > 
> > > I was about to reply to Zqiang, fixing that could be a touch design
> > > decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
> > > incoming.
> > 
> > Just to be clear, SRCU-T is Tiny SRCU rather than Tree SRCU.  So perhaps
> > lower priority, though perhaps not lower irritation.  ;-)
> 
> I see, there is a schedule_work() in srcutiny's
> srcu_gp_start_if_needed(). But it couldn't cause deadlock on UP since
> locks are (almost) no-op. Maybe we can make RCU torture only test it on
> SMP?

Like this, you mean?  I will give it a shot tomorrow.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3c8e4cd5b83e6..afef343eb8a19 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -843,7 +843,7 @@ static unsigned long srcu_torture_completed(void)
 static void srcu_torture_deferred_free(struct rcu_torture *rp)
 {
 	unsigned long flags;
-	bool lockit = jiffies & 0x1;
+	bool lockit = IS_ENABLED(CONFIG_SMP) && (jiffies & 0x1);
 
 	if (lockit)
 		raw_spin_lock_irqsave(&current->pi_lock, flags);
