Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6036FBF0;
	Thu,  1 Jan 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767306272; cv=none; b=oIHff77WeljzrMug8OpkTwXR2Rk3fCivaHEGEaGU9/q2t9YasBw2pCq6JzaxPvt1rSR2vnHwYKqSaAKQlM/gm9PM21etMcINnWt15Z1F7bzJYXB1A2BqRwux/nUuPyxGY6CqS+t8PLxm2BYqzw5WQpWkdpa6Yf4Vpa8A7+8Ga2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767306272; c=relaxed/simple;
	bh=UiU2fwnXYRMUM1eGkiC827OHdPHtYSVxsMZhdqQBvGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmQ8rXGWF06qvCSo0HrUtUOe5RnkZFKNYnoQCihLNyUzp94NtHVF5ToiLqfqqrjhCguxOBSmfKganTaGjMt08HCurCjNKxH3J3VqewQCVULYEI+ZxtnDi+dge/mspEcX/TvH/X0NMpxxBDaqDlFrMHW6PkHmvnYUYwMGLkG0i9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pheZQhX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pheZQhX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206CCC4CEF7;
	Thu,  1 Jan 2026 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767306272;
	bh=UiU2fwnXYRMUM1eGkiC827OHdPHtYSVxsMZhdqQBvGY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pheZQhX5/IPyEJMS7GMa9YME9GLgB7KfaxgiK5zdHjUtUYGdIpAlGUaLLjLqb3A0p
	 mRMwwEdwFl3cOWLmuM0LhgpI+FEiegXM24K/M/nDzNmn35pD+nqAlzJmK+7wcBVMg/
	 b1oXMdZSytm5ho/lNIHki4YtS3zmE1DF/Fws8fM82xe6C+TacE3fX1P5PiQScRGcYY
	 Fy7gR9YsNxmmr3jnLDT7OPGNx0lLJ2PJpMl0nH3e10mHJhpOgU+6L7FiSjKqar255S
	 /EMbEKBO9ot4k49nRsC61Q1sbArmA7YusmL7vszgq7BN6R03OfiYG8pRAHqu9rNRwT
	 4PU3t8JV9syyw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92D4DCE11A4; Thu,  1 Jan 2026 14:24:31 -0800 (PST)
Date: Thu, 1 Jan 2026 14:24:31 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC] jiffies_till_first_fqs off by 1
Message-ID: <cc710326-1b49-4892-9805-a197d48d202f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1efce983-639b-430d-a613-03baef81c416@nvidia.com>
 <2f95e414-7d0e-4e2a-9656-25abf84c27ec@paulmck-laptop>
 <20251224020619.GA1297269@joelbox2>
 <b6bd973d-3cc6-4174-aaae-f3d67d8ccca1@paulmck-laptop>
 <20251226021559.GA949635@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226021559.GA949635@joelbox2>

On Thu, Dec 25, 2025 at 09:15:59PM -0500, Joel Fernandes wrote:
> On Thu, Dec 25, 2025 at 10:54:20AM -0800, Paul E. McKenney wrote:
> > On Tue, Dec 23, 2025 at 09:06:19PM -0500, Joel Fernandes wrote:
> > > Hi Paul,
> > > 
> > > On Tue, Dec 23, 2025 at 03:53:23PM -0800, Paul E. McKenney wrote:
> > > > On Tue, Dec 23, 2025 at 12:38:19PM -0500, Joel Fernandes wrote:
> > > > > During studying some synchronize_rcu() latencies, I found that the
> > > > > jiffies_till_first_fqs value passed to the timer tick subsystem does is always
> > > > > off by one. This is natural due to calc_index() rounding up.
> > > > > 
> > > > > For example, jiffies_till_first_fqs=3 means the "Jiffies till first FQS" delay
> > > > > is actually 4ms. And same for the next FQS. In fact, in testing it shows it can
> > > > > never ever be 3ms for HZ=1000. And in rare cases, it will go to 5ms probably due
> > > > > to interrupts.
> > > > > 
> > > > > Considering this, I think it is better to reduce the jiffies_till_first_fqs by 1
> > > > > before passing it to the wait APIs.
> > > > > 
> > > > > But before I wanted to send a patch, I wanted to get everyone's thoughts.
> > > > > Considering this the RFC.
> > > > 
> > > > Inadvertent passing of the value zero?
> > > 
> > > This should not be an issue because at the moment, even a value of
> > > jiffies_till_first_fqs == 0 waits for ~1 jiffie due to schedule_timeout(0).
> > > 
> > > But you raise a good point, we should cap the minimum allowed jiffie value
> > > for the fqs parameters to 1 so that we don't pass schedule_timeout() with
> > > negative values when/if we do the reduce-by-one approach.
> > 
> > There is a potential use case for jiffies_till_first_fqs=0 and no wait,
> > which would be systems that want to scan for idle CPUs immediately after
> > the grace period has been initialized.  Note the word "potential".  ;-)
> 
> Sure, we could add support for that but that would be new behavior that is
> not in the existing code.
> 
> So jiffies_till_first_fqs=0 today, I think it is not 'working as intended'
> because it will never not wait I think.

Agreed.

> So we should fix that too? Or maybe it can be a patch separate from this
> (that I can work on). I think no harming in allowing that mode, at least it
> will be more in line with the expected outcome.

Makes sense!  However, given that no one has complained, care is required.
Someone might be relying on the old behavior.  (In which case an easy
fix would be to make -1 be no waiting, though one might hope for a
better fix.)

							Thanx, Paul

> > If we want to support this, then perhaps we would need to avoid that
> > schedule_timeout(0).  Or rcu_gp_fqs_check_wake(), as the case may be.
> 
> True.
> 
> thanks,
> 
>  - Joel
> 
