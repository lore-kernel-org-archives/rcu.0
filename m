Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7403282F0E;
	Fri,  2 Oct 2026 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900852; cv=none; b=UCp+WbYRK7LThEZnLarIqyjxy9Mjp1jQuJ1/vOEzi9DcGh2ss5FO6Z+U4f1s5q4oho/Y+ZimJ6KXZGm9na6ezbwCELy/Seca2BuyKRNtpXQ++X5cSgRTszGRvTBMXQURnmUPxe/jpjSd+Ng+lBBFoVJmdtjP4lHDQxRLlTTlv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900852; c=relaxed/simple;
	bh=CUvgWm+5OdfHevZXgVZ4keCnXCiw9wK6OxBzCd/STEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7njQ0FxGNiXfjPWJ7l2JZl3FFVdoeru6WV7ZGAW1MZKr9OYzrKyqrGlQKgoh2ECW7BUWi/KJv74jnXSpfc96hwGS7x2VB6bJn3cgu0/qGjtXW0hho3aXRkHHxfmliLgSbF65qsVSz2Au7HGHsrV87YGffSOwjlvWKc70uEKLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/wAG9O9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/wAG9O9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787E11F000FF;
	Fri,  2 Oct 2026 00:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790900850;
	bh=vGD/xJmN3jRQ/9mFwT49vqqR3wAzJIrIOp0UoriNDDU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=a/wAG9O9FvdYtF7pkvgcYxq+s6iu2l5Wd14cNT77QelSdZou6MVwWtwRt/xCmeRSq
	 DNpRBNnxQrmc+TBYRzyEo2idhij0VGyi2a/XFDmOSd1cxiSyFLzZL7cCqVIpcxtibv
	 grMpx6YHnzxHVunr+Ar7M0r+Q31P9fmVgORKwUZ8iufurLlC8+AXyyFPCLQFr0N7/v
	 1MS+E/XFoh9ZTLuW8zmzfEK3z7J6DLHOFbA5HG/F1W9rILBBz9dZEu8X6mBIBL3i+7
	 H6gB9Kp6qVBLncNyap7euf39NYhoqmX/FlOpskZ+FCDZLi7Y10fqKkw99lxkVK64RU
	 bWTsc394TlwRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3BB95CE0AE4; Thu,  1 Oct 2026 17:27:30 -0700 (PDT)
Date: Thu, 1 Oct 2026 17:27:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Sunho Park <shpark061104@gmail.com>,
	syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH 09/19] srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in
 cleanup_srcu_struct()
Message-ID: <01ada958-6f12-4c56-9559-7c21501c0b54@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
 <20260919003521.3134552-9-paulmck@kernel.org>
 <ar2o5yyB-o12pAos@google.com>
 <a79c83e1-a7ae-407b-8b11-0a031be2faf1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79c83e1-a7ae-407b-8b11-0a031be2faf1@paulmck-laptop>

On Wed, Sep 30, 2026 at 05:57:21PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 30, 2026 at 05:27:19PM -0700, Sean Christopherson wrote:
> > On Fri, Sep 18, 2026, Paul E. McKenney wrote:
> > > From: Sunho Park <shpark061104@gmail.com>
> > > 
> > > The WARN_ON() added by commit 78a38cbf6f20 ("srcu: Queue sdp->work
> > > when the delay timer is successfully deleted") uses rcu_segcblist_n_cbs()
> > > to detect callbacks that srcu_barrier() failed to wait for. However, the
> > > ->len counter is decremented only at the end of srcu_invoke_callbacks(),
> > > after the invoking loop has finished. Since srcu_barrier() can return
> > > right after the barrier callback is invoked, cleanup_srcu_struct() can see
> > > a non-zero n_cbs even though the cblist is already physically empty,
> > > falsely triggering the WARN_ON() together with a still-pending delay_work
> > > timer.
> > > 
> > > This can be triggered as follows, as seen in the syzbot report against
> > > kvm_destroy_vm() -> cleanup_srcu_struct(&kvm->srcu):
> > > 
> > > 1. call_srcu(&kvm->srcu, &bus->rcu, __free_bus) starts SRCU grace
> > >    period GP1.
> > > 
> > > 2. GP1 ends: a delay timer is armed and sdp->work is queued, but
> > >    sdp->work has not run yet.
> > > 
> > > 3. Another call_srcu(&kvm->srcu, &bus->rcu, __free_bus) call invokes
> > >    srcu_segcblist_advance(), which moves the GP1 callback to
> > >    RCU_DONE_TAIL, and starts SRCU grace period GP2.
> > > 
> > > 4. srcu_barrier() is called. It queues its barrier callback after the
> > >    GP2 callback and waits for srcu_invoke_callbacks() to invoke it.
> > > 
> > > 5. GP2 ends: another delay timer is armed, and the sdp->work queued in
> > >    step 2 begins to run. Its srcu_invoke_callbacks() call invokes
> > >    srcu_segcblist_advance() again, moving the GP2 and barrier callbacks
> > >    to RCU_DONE_TAIL as well, and then invokes all of them. However,
> > >    rcu_segcblist_add_len(), which updates srcu_cblist's ->len, has not
> > >    run yet at this point.
> > > 
> > > 6. srcu_barrier() returns once its callback has been invoked, and
> > >    cleanup_srcu_struct() starts running. It finds the delay timer
> > >    armed in step 5 still pending and srcu_cblist's ->len still
> > >    non-zero (because step 5 has not reached rcu_segcblist_add_len()
> > >    yet), and WARN_ON() fires even though every callback has actually
> > >    been invoked.
> > > 
> > > Use rcu_segcblist_empty(), which checks the actual head of the cblist,
> > > instead of rcu_segcblist_n_cbs(), which checks the racy ->len counter.
> > > Callbacks that have genuinely not been invoked yet still leave the list
> > > non-empty, so the WARN_ON() still catches callers that skip srcu_barrier()
> > > or queue callbacks after it.
> > > 
> > > Link: https://lore.kernel.org/rcu/e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev/T/#t
> > > Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=d4faf7db59e11f6fd1ab
> > > Fixes: 78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is successfully deleted")
> > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > Signed-off-by: Sunho Park <shpark061104@gmail.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > 
> > Is this going to be grabbed for 7.3?  It shows up relatively frequently in KVM.
> > Not so much that it's truly problematic/alarming, but enough that it definitely
> > stands out.
> > 
> > Tested-by: Sean Christopherson <seanjc@google.com>
> 
> I wasn't thinking in terms of doing so, figuring that the almost-here
> merge window would be good enough.  But it does seem to apply cleanly.
> Any other votes for pushing it into 7.3?  If I do so, it must be soon.

I take it back.  Unless there are objections to my pushing this into v7.3
(instead of waiting until the v7.4 merge window), I will push it tomorrow
(Friday October 2), Pacific Time.

> Either way, I will of course apply your Tested-by.

And done!

							Thanx, Paul
