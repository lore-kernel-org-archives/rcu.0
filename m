Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83AF3B3BFE;
	Tue,  8 Sep 2026 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910572; cv=none; b=Vui8u6XXKeyFmkJg1c2d88jnqcOtCm2PeBBXWGpUhl7LuxTWZwwgGjA+N/tlnQej3iwJEsifSevuNt3mQhOHCUrk1WOUuLmYlreAMjfZG0QGTPZYaJ67PvKRBBrigrSXPDyplnTUjmsAsLEYszxEIOmBP3e9U+g/UwV8j9yaUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910572; c=relaxed/simple;
	bh=h1YkXJxeMvFyPRcJOGnkLWrVHpm58uYb9M1xZnunVEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djhflm0JT0CkM4R6GcbvtcDy9c860s8A7hRczh8OkeiH/B0JU0u9soUXV5INS6rc2lw1UUdxb61FvOqs5F+Wj7GXYqKPE53ZdgWSZWnTnXTFI4CNGS1XmYMwl760UTpKUZyF8XY0DodaWeu+UpUUGYcSbrk31FoiUb1YZCHGzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjyyV4iS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjyyV4iS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D241F00A3A;
	Tue,  8 Sep 2026 23:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788910571;
	bh=ItxpD5djqpSKC8SsIibDrkWm2+ywzpwf+r9dNkgm2rI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=VjyyV4iSWPpMuGw6kwPs+gB6bMlvOMB+8F6yoV5ednnFQfmzFRupqIhnn95yUn7FQ
	 wiEwR/0hvFxkn7oSP5brUMTveg2u1/F7UbGWgmAcxGducooi46KuupI3VXf6t88j88
	 +e4LpOJcV924o6qA/2wSczxZx/fH3W1jQ1u0dXYNKuqyDNMc5MzXqGEdjLTs+qWAYZ
	 ZdZ1nIvLkIre5xm5/qd8vCILA9gmVSrcnDdQ1EUM/5izFnOUyVM6bp6N6nfaCC31Mb
	 JEBg/CElADxJiNuuPR+F+JDMQ5sIHagkntoqZGPpSDgkU9KKwYtpj6wNatuQWwvyHz
	 HdPNX6740QU2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33F4DCE18F4; Tue,  8 Sep 2026 16:36:11 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:36:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] srcutree: Make init_srcu_struct_atomic() prevent
 transition to big
Message-ID: <343676e0-8ab2-4bb1-94c0-57c7da9a1f2d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-7-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-7-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:22PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> The is_atomic parameter of init_srcu_struct_fields() exists so that
> atomic SRCU never transitions to big, but neither
> init_srcu_struct_atomic() nor its lockdep counterpart
> __init_srcu_struct_atomic() sets it.
> 
> On systems where srcutree.convert_to_big selects SRCU_SIZING_INIT,
> this needlessly allocates a full srcu_node combining tree for any
> dynamically initialized atomic srcu_struct, despite atomic SRCU
> having neither callbacks nor srcu_barrier() operations.
> 
> Pass true from both atomic entry points, adding an is_atomic parameter
> to __init_srcu_struct_common().
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Given that we have this commit, is this patch needed?

4e01d5320a2f ("srcutree: Suppress to-big transition for atomic SRCU")

If so, please tell me what I am missing.

						Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2af36db37fa9..01f224a56b41 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -305,26 +305,27 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static, bool
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  
>  static int
> -__init_srcu_struct_common(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
> +__init_srcu_struct_common(struct srcu_struct *ssp, const char *name,
> +			  struct lock_class_key *key, bool is_atomic)
>  {
>  	/* Don't re-initialize a lock while it is held. */
>  	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
>  	lockdep_init_map(&ssp->dep_map, name, key, 0);
> -	return init_srcu_struct_fields(ssp, false, false);
> +	return init_srcu_struct_fields(ssp, false, is_atomic);
>  }
>  
>  int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
>  			     struct lock_class_key *key)
>  {
>  	ssp->srcu_reader_flavor = 0;
> -	return __init_srcu_struct_common(ssp, name, key);
> +	return __init_srcu_struct_common(ssp, name, key, false);
>  }
>  EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);
>  
>  int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
>  {
>  	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST;
> -	return __init_srcu_struct_common(ssp, name, key);
> +	return __init_srcu_struct_common(ssp, name, key, false);
>  }
>  EXPORT_SYMBOL_GPL(__init_srcu_struct_fast);
>  
> @@ -332,14 +333,14 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
>  				   struct lock_class_key *key)
>  {
>  	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST_UPDOWN;
> -	return __init_srcu_struct_common(ssp, name, key);
> +	return __init_srcu_struct_common(ssp, name, key, false);
>  }
>  EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
>  
>  int __init_srcu_struct_atomic(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
>  {
>  	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
> -	return __init_srcu_struct_common(ssp, name, key);
> +	return __init_srcu_struct_common(ssp, name, key, true);
>  }
>  EXPORT_SYMBOL_GPL(__init_srcu_struct_atomic);
>  
> @@ -414,7 +415,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_fast_updown);
>  int init_srcu_struct_atomic(struct srcu_struct *ssp)
>  {
>  	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
> -	return init_srcu_struct_fields(ssp, false, false);
> +	return init_srcu_struct_fields(ssp, false, true);
>  }
>  EXPORT_SYMBOL_GPL(init_srcu_struct_atomic);
>  
> -- 
> 2.43.0
> 
