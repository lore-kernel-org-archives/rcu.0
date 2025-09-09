Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F65223;
	Tue,  9 Sep 2025 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377414; cv=none; b=bbhEMsvvpD0ar8XwU4Dv4xP69mKasfzIXHYnJ/FHetmsAXGqN8c9aRKvAz0izcy50AuEhUm5yqTzxpB4FVdzA2Fml7kZkhkKCIONocmq4zdCa3k+DJOlluhd4dJfapwC9ruLB7qQuX9gMiB246QCGNQXmeiZ0f/YrN+g8CIcaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377414; c=relaxed/simple;
	bh=tsZco8RBN2ARLwRKQybz2Ac7AKZxSxzRkUgis3zqLtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKwumvhDl7dv6yHcFQLuodtBK3zeuUAUK4Q6amoMyNx29TsDcsGJAyTMFQ43O5+W8y6B3jvMNAVMplUOwFx1unB/Pj10ttIGCPDd0U1xYH6l4W8pbaRlEZfl0LJkjIjti/2SW4cmQrltA21Y+FQN/COI6mmQYTpdgTvnEr3HV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYvFn/Ap; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYvFn/Ap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A20C4CEF1;
	Tue,  9 Sep 2025 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757377413;
	bh=tsZco8RBN2ARLwRKQybz2Ac7AKZxSxzRkUgis3zqLtg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tYvFn/ApfUQs7BkuzEMfaUfFXBoBh7noMMx2qpDHMuLkwNyAhLjP3xamokvZOaQG0
	 091H0aorZnH3sYyw0XmLhSpIntEKfU/ZQW2zkYkVyr4NnKtRJ4zW68B6reQvkJc6NT
	 iLIoZhTAGKAkUkOZSP3/D7+WNpxc/jqLZakz58PNkgAqM/ll1GxYBqUDQ4g14hksbu
	 M4Y892aBr0aR3QAaAWvxGLZ9Z7P8TJC5EBUjeDKfZ9gGqrY2C1iwhBlN0FlFQKltxz
	 bKWLQkSTreWX2ji8YpvK1wbm35vv17JhVHZcFs1C+nZLZdM1GCGYKCO4HjdeE/PNlN
	 VqdV8sk0tz7cQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3D83CCE0B32; Mon,  8 Sep 2025 17:23:30 -0700 (PDT)
Date: Mon, 8 Sep 2025 17:23:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
Message-ID: <1a489672-935d-4966-b151-c5248ceaf43b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250908003155.557070-1-qiang.zhang@linux.dev>
 <9dfa7d4f-6e3f-4084-a14f-beb1db06f817@paulmck-laptop>
 <63d537e65b7f4b6f77a16112a871103d07a248d2@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d537e65b7f4b6f77a16112a871103d07a248d2@linux.dev>

On Mon, Sep 08, 2025 at 01:19:44PM +0000, Zqiang wrote:
> > 
> > On Mon, Sep 08, 2025 at 08:31:55AM +0800, Zqiang wrote:
> > 
> > > 
> > > Currently, the srcu_gp_start_if_needed() is always be invoked in
> > >  preempt disable's critical section, this commit therefore remove
> > >  redundant preempt_disable/enable() in srcu_gp_start_if_needed().
> > >  
> > >  Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
> > >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > > 
> > Looks good, but what would be a good way to make this code defend itself
> > against being invoked from someplace else that did have preemption
> > enabled? Especially given that the Tree SRCU version of this function
> > does get invoked with preemption enabled?
> 
> ok, maybe we can add lockdep_assert_preemption_disabled() in
> the srcu_gp_start_if_needed() ?

That sounds like a good idea to me!

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> > 
> >  Thanx, Paul
> > 
> > > 
> > > ---
> > >  kernel/rcu/srcutiny.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >  
> > >  diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > >  index b52ec45698e8..417bd0e4457c 100644
> > >  --- a/kernel/rcu/srcutiny.c
> > >  +++ b/kernel/rcu/srcutiny.c
> > >  @@ -181,10 +181,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> > >  {
> > >  unsigned long cookie;
> > >  
> > >  - preempt_disable(); // Needed for PREEMPT_LAZY
> > >  cookie = get_state_synchronize_srcu(ssp);
> > >  if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> > >  - preempt_enable();
> > >  return;
> > >  }
> > >  WRITE_ONCE(ssp->srcu_idx_max, cookie);
> > >  @@ -194,7 +192,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> > >  else if (list_empty(&ssp->srcu_work.entry))
> > >  list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> > >  }
> > >  - preempt_enable();
> > >  }
> > >  
> > >  /*
> > >  -- 
> > >  2.48.1
> > >
> >
