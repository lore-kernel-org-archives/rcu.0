Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD5366DDA
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917000; cv=none; b=d/I7hs+Lcvs7saRkZu7bbDaIhguceiL6XRjR4bgxxJy8WkpA16mtwDMO0bWhrvnZ5WZ2c9EpNyZxwQdSbS2UQRDCy30lhnAlpjuSowTBcGyo5/UrP6F9wAuiImLKyjlcAg8j96k1RFjBIGpYTtgidEdv8wEESvYmtcw0WCbpdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917000; c=relaxed/simple;
	bh=yhrKd01hnmxnAX/RvinbfnuNBDJD0uUFxf0hd/vI70U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiSuJfi/xh8mXCSJLuNIh+fObD1CKSRMpaqofoVwMo9wVDIYkIBL88qkkNqkJReHzLDgNrIlbKk1Y3ZfmlAdcfu55s9mjhMn4KdmNmRvlxIJX7uy78Fyp6LAxI1NbhiR0f+R81aDBkgXoaI5UUMKHQvq5L3UDRsse4oI5q/sJSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWn5I7eB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWn5I7eB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C03C19424;
	Thu, 19 Mar 2026 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773916999;
	bh=yhrKd01hnmxnAX/RvinbfnuNBDJD0uUFxf0hd/vI70U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tWn5I7eBrjakzubun9EuO9BeyKd4y7sJW3deI6uu0101EQ2DXtMvNN2HNp/jMQ5lT
	 mSY+y0AEv6Q6ZjMiZsrnbzvr7Ij3B+d0hVoywgZ4ShGVaT3HQ5Pptm8sgTjDZf2jsR
	 03bpR8HLdkKEoFKUOGlbERXBqQCBD8JU5u3o6wlT4m2JiJQJCXlTy22h3985teVx6N
	 3OEtj8JYrH7MaO5r2we/raIve62pHIbJ+5JvTdbfwypSNiZmjJ7lTtIH7USpoBWLfp
	 s8PSvPQE/4ez4QRDBZ1ix2pNSHRZm+8n8861/wgFKxgrVOpyWcDyKUeQd0nkNg2b9O
	 xAO89ltPqcF9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DBB26CE0D7D; Thu, 19 Mar 2026 03:43:17 -0700 (PDT)
Date: Thu, 19 Mar 2026 03:43:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <d3d119d8-7e41-4f22-a3c9-f7feff059a27@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
 <20260318160445.IyUiWV0T@linutronix.de>
 <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>
 <20260318164710.gUolNYgg@linutronix.de>
 <9b685d13-5496-4bc9-ab6a-508bd4bf0f16@paulmck-laptop>
 <20260319085548.UZQk1cyW@linutronix.de>
 <b449bfaf-9a52-492c-bbcd-4756c0a14eb4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b449bfaf-9a52-492c-bbcd-4756c0a14eb4@paulmck-laptop>

On Thu, Mar 19, 2026 at 03:05:40AM -0700, Paul E. McKenney wrote:
> On Thu, Mar 19, 2026 at 09:55:48AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-03-18 11:48:56 [-0700], Paul E. McKenney wrote:
> > > We would need a lockless enqueue, which we have in llist.h.
> > 
> > Only if CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG. Otherwise you must not
> > provide call_rcu_nmi().
> 
> I *think* that BPF is provided only in such architectures, so agreed.

Plus srcu_read_lock_fast() uses atomic_long_inc(), which is supposed to
be NMI-safe anyway, correct?

							Thanx, Paul

> > > The irq-work to actually do the call_rcu() or similar.
> > 
> > reasonable.
> > 
> > > There would also need to be rcu_barrier() changes, for example, to
> > > drain all the llists.
> > > 
> > > > I mean I am curious here who needs it any why ;)
> > > 
> > > You got it right above, BPF.  ;-)
> > > 
> > > They currently check in_nmi() and to the irq-work step themselves.
> > 
> > Then it would make sense since you do actually have users.
> 
> For more fun, they would like to attach BPF programs to call_rcu() and
> call_srcu() internals, which would require a per-task recursion check.
> Or perhaps some other trick.
> 
> 							Thanx, Paul
