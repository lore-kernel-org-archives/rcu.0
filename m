Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC435A79B;
	Thu, 10 Sep 2026 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788998891; cv=none; b=OlH6UV+/N1tHuvsSTF8Kh0gvwWhWzfD1zZ7/UrSGjpNoCAGwUW4coxNXmFE+g9I8YHsG/fuWUdu7AVjEDidVQbJuO3FV3pnQGgGl9ZIDztIi8TjJBziBaD5g+GGzTNnKMz2kjJYzHn3hHrz+Caiz7yu7Qepx9J698Y/BMqJBVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788998891; c=relaxed/simple;
	bh=lwA44wf2BvU73LcugwMw3rtq9V4Vzw5jjMY4iUcwa/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9clUw+Fxq2TFB4Vue7MP4hjJ4ypGli/c1B6+EWngqy0HedpQhZh4hhU+fKnf2KXHteVoxLMiMtWuPuG7eSlzHZxhh1Wt0oxEGrv4hWVdu3JIfVf9DESWA6BA1dXAYpsV/WH7MoKFMkCb7cn8RD7ggKWZyAYozmCiEl8XnQt0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjPU+JXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjPU+JXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC731F000FF;
	Thu, 10 Sep 2026 00:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788998889;
	bh=wLLqbXliph5xt7C4pQ1G+FEb+N62UYxuVUrZxtHGcHc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=gjPU+JXRKKp0Btu0QR6eKZb5hFSRWFR2ZZYr8unDnp+sOIJMhEBtfF7rhrVFuyncr
	 6PYD9dzE8HARolRBCwur1p66HJ3uZ8MnK3C9rub1RBLnLcnTJYBcamPiYMJyAxFh7Z
	 ai3y77yu67bX2o73UcBSSy4Ihj4JBFsEQifzHJaaC0h2Zw+eMriTxix+ETFe6xAUjP
	 J4UW/At0dFpaGEt3qqQiRT5Rj/xM6QHDkbX35A6LZUitNtRXlg4+LkCLLTVqSMfKuv
	 9qz+/EOO81vXgpDcl+PqqMVAq0GKjkkOR80Zlt/kYI9Cf0mT2DLaunY2nlLoLo3xn1
	 UEZxGwk70z/gQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 42A40CE0869; Wed,  9 Sep 2026 17:08:09 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:08:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] srcutree: Make init_srcu_struct_atomic() prevent
 transition to big
Message-ID: <a10394c8-053a-4394-ab10-1973c78ea3be@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <343676e0-8ab2-4bb1-94c0-57c7da9a1f2d@paulmck-laptop>
 <20260909023417.2427143-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909023417.2427143-1-kunwu.chan@gmail.com>

On Wed, Sep 09, 2026 at 10:34:16AM +0800, Kunwu Chan wrote:
> On Tue, 8 Sep 2026 16:36:11 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Mon, Sep 07, 2026 at 03:58:22PM +0800, Kunwu Chan wrote:
> > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > 
> > > The is_atomic parameter of init_srcu_struct_fields() exists so that
> > > atomic SRCU never transitions to big, but neither
> > > init_srcu_struct_atomic() nor its lockdep counterpart
> > > __init_srcu_struct_atomic() sets it.
> > > 
> > > On systems where srcutree.convert_to_big selects SRCU_SIZING_INIT,
> > > this needlessly allocates a full srcu_node combining tree for any
> > > dynamically initialized atomic srcu_struct, despite atomic SRCU
> > > having neither callbacks nor srcu_barrier() operations.
> > > 
> > > Pass true from both atomic entry points, adding an is_atomic parameter
> > > to __init_srcu_struct_common().
> > > 
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > 
> > Given that we have this commit, is this patch needed?
> > 
> > 4e01d5320a2f ("srcutree: Suppress to-big transition for atomic SRCU")
> > 
> > If so, please tell me what I am missing.
> 
> Yes, this patch is still needed. The is_atomic mechanism is there, but 
> the atomic initialization paths still pass false.
> 
> In particular, init_srcu_struct_atomic() passes false directly, while the 
> lockdep path goes through __init_srcu_struct_common(), which also passes false.
> 
> This patch makes both atomic entry points propagate true.

Very good, queued and pushed!

							Thanx, Paul

> Thanks,
> KunWu
> 
> > 
> > 						Thanx, Paul
> > 
> > > ---
> > >  kernel/rcu/srcutree.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 2af36db37fa9..01f224a56b41 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -305,26 +305,27 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static, bool
> > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > >  
> > >  static int
> > > -__init_srcu_struct_common(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
> > > +__init_srcu_struct_common(struct srcu_struct *ssp, const char *name,
> > > +			  struct lock_class_key *key, bool is_atomic)
> > >  {
> > >  	/* Don't re-initialize a lock while it is held. */
> > >  	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
> > >  	lockdep_init_map(&ssp->dep_map, name, key, 0);
> > > -	return init_srcu_struct_fields(ssp, false, false);
> > > +	return init_srcu_struct_fields(ssp, false, is_atomic);
> > >  }
> > >  
> > >  int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
> > >  			     struct lock_class_key *key)
> > >  {
> > >  	ssp->srcu_reader_flavor = 0;
> > > -	return __init_srcu_struct_common(ssp, name, key);
> > > +	return __init_srcu_struct_common(ssp, name, key, false);
> > >  }
> > >  EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);
> > >  
> > >  int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
> > >  {
> > >  	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST;
> > > -	return __init_srcu_struct_common(ssp, name, key);
> > > +	return __init_srcu_struct_common(ssp, name, key, false);
> > >  }
> > >  EXPORT_SYMBOL_GPL(__init_srcu_struct_fast);
> > >  
> > > @@ -332,14 +333,14 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
> > >  				   struct lock_class_key *key)
> > >  {
> > >  	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST_UPDOWN;
> > > -	return __init_srcu_struct_common(ssp, name, key);
> > > +	return __init_srcu_struct_common(ssp, name, key, false);
> > >  }
> > >  EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
> > >  
> > >  int __init_srcu_struct_atomic(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
> > >  {
> > >  	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
> > > -	return __init_srcu_struct_common(ssp, name, key);
> > > +	return __init_srcu_struct_common(ssp, name, key, true);
> > >  }
> > >  EXPORT_SYMBOL_GPL(__init_srcu_struct_atomic);
> > >  
> > > @@ -414,7 +415,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_fast_updown);
> > >  int init_srcu_struct_atomic(struct srcu_struct *ssp)
> > >  {
> > >  	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
> > > -	return init_srcu_struct_fields(ssp, false, false);
> > > +	return init_srcu_struct_fields(ssp, false, true);
> > >  }
> > >  EXPORT_SYMBOL_GPL(init_srcu_struct_atomic);
> > >  
> > > -- 
> > > 2.43.0
> > > 
> > 
> 
