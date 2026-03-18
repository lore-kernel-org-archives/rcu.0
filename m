Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9430EF75
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859739; cv=none; b=RJSanm0wQoyh3w2iIP/qDGrJhRBYzi/4oyQiPCxjHkINaTuc1fGlXtuYrrOPUtkkK1U7Cx+4wkiFahjZVc1bugjEgk8oakn0r6poAGzCigOsYJqYCKkZ0DlTKdnRtrLAEmAG7A/A9OI/hOYYpmaOdeNw4g5j89LYr2CceikC8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859739; c=relaxed/simple;
	bh=oEvF0uXvwc/vGO03pQPkfNIqKmyceZ3wlRF/D/Nr7D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1phU9zOX0UwJU2FnfsCf/pgWuAZV4GRKt7pZa9UM3iLdPVnWlogFivWMW5EayQvemtKSET6LpAVbKN9uLMU+H4r8pbO+bTmvEkQC2/i+kAr1Bbwo0tgGUeVrm3wpahiWrpZMIytCqXNgTLWL6rQ24YajXYMbbxAQEORNaCBhw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR3JwdYA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR3JwdYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE1AC19421;
	Wed, 18 Mar 2026 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859738;
	bh=oEvF0uXvwc/vGO03pQPkfNIqKmyceZ3wlRF/D/Nr7D0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JR3JwdYApNoC6Ja4N/D0g26KvSd4z4PbedbGkl8e3DTHENZei4sP0/AydYg4TR+ZJ
	 QzagZY9THEdH2tE31HEamiWHKYzzbofT5QW7Neu7RY8UkGfV5jXzE5P0CUn/U64pXx
	 fQYhucoypJUpvxJpDGdUv44i7D3Fw4O7xELQixL5eUx6Xw7ff9TzWOQUP/X4oDOKKg
	 wRAHvbaNf6TcM6MaVZv5daaFWqUTdBYVgC81rdRptJHrEYHsKySoFsQ0KExR4cly6f
	 4Er2feyP487SFQ3LJ4r4lFAUYSmkk8ZT7krBc2PG9qp5q8G4/XwAPUE7pC2gDznwLJ
	 f87QqvaJEgthA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0F3D0CE098B; Wed, 18 Mar 2026 11:48:56 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:48:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <9b685d13-5496-4bc9-ab6a-508bd4bf0f16@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
 <20260318160445.IyUiWV0T@linutronix.de>
 <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>
 <20260318164710.gUolNYgg@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318164710.gUolNYgg@linutronix.de>

On Wed, Mar 18, 2026 at 05:47:10PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-18 09:32:07 [-0700], Paul E. McKenney wrote:
> > > What remains?
> > 
> > With that patch, we no longer have call_srcu() directly acquiring a
> > non-raw spinlock, but as you say, we still have the wakeup problem.
> 
> Isn't this is just srcu_funnel_gp_start()? And where you could ensure
> that it is always a delayed worked (delay always 1+) that is scheduled
> so that it always setups a timer and never does a direct wake.
> 
> > > Popular? Okay. Keep me posted, please.
> > 
> > Will do.  Just out of curiosity, what are your concerns?
> 
> We don't have many NMI code paths and the possibilities are quite dense.
> I would imagine having this possibility would lead to things that
> wouldn't be needed otherwise. I mean we don't even allow allocating
> memory from hardirq (except for _nolock() variant which I think is used
> by bpf for $reasons) but need to call rcu_free from NMI.
> This would require to remove an item from some kind of data structure
> without regular locking. Unless RCU is used to get a delayed invocation
> of some sorts.

We would need a lockless enqueue, which we have in llist.h.

The irq-work to actually do the call_rcu() or similar.

There would also need to be rcu_barrier() changes, for example, to
drain all the llists.

> I mean I am curious here who needs it any why ;)

You got it right above, BPF.  ;-)

They currently check in_nmi() and to the irq-work step themselves.

							Thanx, Paul
