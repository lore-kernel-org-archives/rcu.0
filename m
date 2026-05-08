Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DCB2F8EB8;
	Fri,  8 May 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261240; cv=none; b=sBeaLmpGiaHkq0iUFUXyyQd8L9obVIy/GYOt7WiqPr2HWolda6nrxx8/iC8U3AXadEnPYdtsvlXVDfrYsG+RcfBE0tKwiZ3cERYTblq/ddGgeseOsupjiEpEzAUZ9g3w9IQS808Hr9N7sSrTyaaLztZqCfrYh5ZrSinAtrpt7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261240; c=relaxed/simple;
	bh=krdrZSQHBfncuysT9Vf1jPA717T3+HOXl1ZNqZnwEfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPphvf+Rs9rMHULlQ7WG3HKoofW+sgpuWFrIvc+6rlySAMYQisZAReeTWjsnGWQJasIu1AUKdlM8dHFBbVZSy2aWbCFP04tYt7gkij+eMrZkYmaLJGUi1Lxy3HgseMf8qIJLgN96biYD303ehP9jXGuqO1lVGTX0z+oBDAHmyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyNaFrBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyNaFrBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79FEC2BCB0;
	Fri,  8 May 2026 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778261239;
	bh=krdrZSQHBfncuysT9Vf1jPA717T3+HOXl1ZNqZnwEfY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TyNaFrBTF+EOKBsF8orjwTsG+pvj680o8rmog/VTVzR6DMjJyR9bj7wVeajCka/os
	 LFg2vELxHho4RB5USSkAAQH07ynhVCGYvsAlCA+rsG9Jax/smDesjZoj7Fc2RVy2/H
	 Rp94fA2xelStYuBwS/3Zvc/WrlAfI86OGgxAVSronpHvqL71BQlvSrOd46oUS+36jY
	 5wWQ6D4FmDlDjGGU77X57MVwJAT6tFGNDbEjTvVRvUDY5ZMdY4CLqUAOFLorCuYo2k
	 Jx7h88rp5EqESeHAffVzhhZQEin6JRC0K4ZgPym6GpWxN0l3I+jHm9J0nNLhVwddfJ
	 tGRZW0UZmDIwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5F0D8CE06FB; Fri,  8 May 2026 10:27:19 -0700 (PDT)
Date: Fri, 8 May 2026 10:27:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/7] Miscellaneous RCU changes for v7.2
Message-ID: <b5a26fde-5615-43b4-a9bf-a6b3dc634462@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
 <af4YMkfQYtgZNuHl@milan>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4YMkfQYtgZNuHl@milan>

On Fri, May 08, 2026 at 07:06:58PM +0200, Uladzislau Rezki wrote:
> On Thu, May 07, 2026 at 10:09:42AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series contains miscellaneous RCU updates for v7.2:
> > 
> > 1.	Don't queue workqueue handlers to never-online CPUs.
> > 
> > 2.	Fix kerneldoc header comment typo in srcu_down_read_fast().
> > 
> > 3.	Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace().
> > 
> > 4.	Mark rcu_read_lock_tasks_trace() and friend BPF-only.
> > 
> > 5.	Simplify rcu_do_batch() by applying clamp().
> > 
> > 6.	Simplify param_set_next_fqs_jiffies() by applying clamp_val().
> > 
> > 7.	Document rcu_access_pointer() feeding into cmpxchg().
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  b/include/linux/rcupdate.h |   12 +++++++-----
> >  b/include/linux/srcu.h     |    2 +-
> >  b/kernel/rcu/srcutree.c    |   12 ++++++------
> >  b/kernel/rcu/tree.c        |    2 +-
> >  b/scripts/checkpatch.pl    |    2 --
> >  kernel/rcu/tree.c          |    2 +-
> >  scripts/checkpatch.pl      |    3 +++
> >  7 files changed, 19 insertions(+), 16 deletions(-)
> > 
> Will you resend Paul? Combining 3 and 4?

I will resend, just to simplify later rebasing on your version if
nothing else.  ;-)

							Thanx, Paul

> Or i can take it and combine 3 and 4 on my own.
> 
> --
> Uladzislau Rezki
