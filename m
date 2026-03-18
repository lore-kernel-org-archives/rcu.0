Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA43EBF3B
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859524; cv=none; b=DaJz9Dyw9qw6aOnVMNI61R180lCGnuP63McyfLIL53d+HsQEjncPtiBVScVv4YwV3tOF3QEM6D0qzGDSzmfSEdRwk3bI8FRl9YMlhzfCbqoSL6IPLy3QTkTw1onOiwlAK2cCF+Fdxfn9oLLFKFh4Tfz0MmMFFX+yzIdIF0pzeb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859524; c=relaxed/simple;
	bh=lx4a4VCvtwpGXczIyJApAGWYUAMSzJfW6I61mZV8Xk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnO60AEvK3czwzupyX8b74U1ZG4rri2qS/OPSD74fRVt8pvITWn77/bNuIQy7Z3inqfze1Ms8fbRaReyQnxmJ0xQy1EZxxcftv1UQBFG9u3HNZiywXjg4LNC+2MKGKeKW6Tb7aJ5WIWFXoZ15tg2H7V3UafrTJt2e8fYzxcc2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBzr2Spb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBzr2Spb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BF0C2BC9E;
	Wed, 18 Mar 2026 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859523;
	bh=lx4a4VCvtwpGXczIyJApAGWYUAMSzJfW6I61mZV8Xk8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lBzr2SpbyG8Fg0Q0XCHqPxP2bCZu7gOej9vSItLLo43hYNLwBngZYY1Z4z/a5Dvqd
	 uO6E0+USM3PXwN9CWqhJiqCUViQmgq+N33P3qk5buXbduXcscx5q+f9OybQnZ8jGJM
	 Mjj48/LXlQpuA95SfVPtSuTERq0Yt9o7rVNIvXjKT1LpKaehmLmvZam+/+HaDu4GCL
	 NsCVQ8dSsCmpwUwF6BDbSYJtVZWzhlkAhyr9brDUINlMlLBEMNm7Us/+ulYdcfL76p
	 2+O0p409ZK97NOLpd6ew/bttE219RVtgj3eH7BiIFO1Cg2scJIe6pgHphMyOTB/71n
	 xzNXHflwtblJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 545E6CE098B; Wed, 18 Mar 2026 11:45:21 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:45:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <0f0fa46f-4d41-4e79-a6be-46b832c6ae65@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
 <20260318160445.IyUiWV0T@linutronix.de>
 <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>
 <abrV4VResx7QERRo@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abrV4VResx7QERRo@tardis.local>

On Wed, Mar 18, 2026 at 09:42:09AM -0700, Boqun Feng wrote:
> On Wed, Mar 18, 2026 at 09:32:07AM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 18, 2026 at 05:04:45PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-03-18 08:43:32 [-0700], Paul E. McKenney wrote:
> > > > > Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
> > > > > nesting right. The wakeup problem remains, right?
> > > > > But looking at the code, there is just srcu_funnel_gp_start(). If its
> > > > > srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
> > > > > then there will be always a timer and never a direct wake up of the
> > > > > worker. Wouldn't that work?
> > > > 
> > > > Right, that patch fixes one lockdep problem, but another remains.
> > > 
> > > What remains?
> > 
> > With that patch, we no longer have call_srcu() directly acquiring a
> > non-raw spinlock, but as you say, we still have the wakeup problem.
> 
> I don't think we have a wakeup problem since we use workqueue to defer
> the wakeup, but maybe I'm missing something here?

You are right, I was confused.  We instead have a deadlock problem.

							Thanx, Paul
