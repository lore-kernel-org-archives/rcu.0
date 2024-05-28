Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995971753
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898109; cv=none; b=LcpWHjKEqAmKNYEvY/QdjuoGL/J3tCh+hERTwxc0Ksix2rctL+DrMXdhD1xyCfiir/7ZVPN6vtjpngv991Mw1coCcN90Iwyyr9EPN0D3WrjhqrCMgChrqKavAzFqobI8ibGNgnuY4fa/fI3hbVyynwyoW/IG+pQ6u8nDRkz5uNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898109; c=relaxed/simple;
	bh=ncMBeSj9gd3zrNvBOVnC5pN8ADIvplVJ8pvzuLS9Hek=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BTkLt/GJ3j1PkbOmY7mCI+Ud77IJYQJTR8oWT9AKTsnj3fGZLuE5kyTMfWRkE2c+ndsFlChpIo8h1WhFsjp9zlKZphL2KbV+oCuAPkTUt0jfcrLI/u5jUIrlQED7KKn53HlsyG2gP9Wil6NYgYKHG8macfJ1yAfQMyeom2VDoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=dmTAZ/Lj; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="dmTAZ/Lj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WkYcaK24B1G4SYg3BmIR6wP1ac8fQ0u2Z8GojBBIG4I=;
  b=dmTAZ/Lj0NlBgW9JAh4SJVk5o43DGgyo/45D0OHEJvqf6Pl5cpdDjKaY
   uHRjcjfY241XTLLHDpSJGenY/HKkMRzPF3rhoVLw4zygvGdxbtBQ4Khre
   byBCfBlvfPP1cEKW5m3GkTH4i+iY0+jfoZ+TuWBRSEIg5v0VMtmB0W7Kx
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,195,1712613600"; 
   d="scan'208";a="88165127"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 14:08:21 +0200
Date: Tue, 28 May 2024 14:08:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Uladzislau Rezki <urezki@gmail.com>
cc: "Paul E. McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, RCU <rcu@vger.kernel.org>, 
    cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to
 kfree_rcu
In-Reply-To: <ZlXIDZLMNPc7E7XE@pc636>
Message-ID: <2dd5bafb-ceb1-238d-2f51-83ebf135b73@inria.fr>
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz> <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr> <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop> <alpine.DEB.2.22.394.2405272226510.3330@hadrien> <ZlXIDZLMNPc7E7XE@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 28 May 2024, Uladzislau Rezki wrote:

> Hello.
>
> >
> >
> > On Mon, 27 May 2024, Paul E. McKenney wrote:
> >
> > > On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Mon, 27 May 2024, Vlastimil Babka wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > > > > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > > > > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > > > > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > > > > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > > > > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > > > > to take this task, feel free to.
> > > >
> > > > Thanks for the suggestion!  I will try to look into it.
> > >
> > > Thank you both!
> >
> > I found the following functions.  Do you want some other information, such
> > as where they are called from?
> >
> > Ignore the -s at the beginning of some lines.  Those are for emphasis. not
> > to suggest to remove the code.
> >
> > I checked that the functions are only used in calls to call_rcu.
> >
> > Without more effort, Coccinelle only looks for functions defined in the
> > same file.  Here are the functions that are passed to call_rcu where the
> > function is not defined in the same file:
> >
> > need definition for audit_free_rule_rcu
> > need definition for __i915_gem_free_object_rcu
> > need definition for io_eventfd_ops
> > need definition for ip_vs_dest_dst_rcu_free
> > need definition for __put_task_struct_rcu_cb
> > need definition for radix_tree_node_rcu_free
> >
> > They all do something more, although radix_tree_node_rcu_free doesn't do
> > much more (some memsets).
> >
> > julia
> >
> > diff -u -p /home/jll/linux/drivers/net/wireguard/allowedips.c /tmp/nothing/drivers/net/wireguard/allowedips.c
> > --- /home/jll/linux/drivers/net/wireguard/allowedips.c
> > +++ /tmp/nothing/drivers/net/wireguard/allowedips.c
> > @@ -50,7 +50,6 @@ static void push_rcu(struct allowedips_n
> >
> >  static void node_free_rcu(struct rcu_head *rcu)
> >  {
> > -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
> >  }
> >
> >  static void root_free_rcu(struct rcu_head *rcu)
> > diff -u -p /home/jll/linux/fs/ecryptfs/dentry.c /tmp/nothing/fs/ecryptfs/dentry.c
> > --- /home/jll/linux/fs/ecryptfs/dentry.c
> > +++ /tmp/nothing/fs/ecryptfs/dentry.c
> > @@ -53,8 +53,6 @@ struct kmem_cache *ecryptfs_dentry_info_
> >
> >  static void ecryptfs_dentry_free_rcu(struct rcu_head *head)
> >  {
> > -	kmem_cache_free(ecryptfs_dentry_info_cache,
> > -		container_of(head, struct ecryptfs_dentry_info, rcu));
> >  }
> >
> >  /**
> > diff -u -p /home/jll/linux/kernel/fork.c /tmp/nothing/kernel/fork.c
> > --- /home/jll/linux/kernel/fork.c
> > +++ /tmp/nothing/kernel/fork.c
> > @@ -378,7 +378,6 @@ static struct kmem_cache *thread_stack_c
> >
> >  static void thread_stack_free_rcu(struct rcu_head *rh)
> >  {
> > -	kmem_cache_free(thread_stack_cache, rh);
> >  }
> >
> >  static void thread_stack_delayed_free(struct task_struct *tsk)
> > diff -u -p /home/jll/linux/kernel/workqueue.c /tmp/nothing/kernel/workqueue.c
> > --- /home/jll/linux/kernel/workqueue.c
> > +++ /tmp/nothing/kernel/workqueue.c
> > @@ -5024,8 +5024,6 @@ fail:
> >
> >  static void rcu_free_pwq(struct rcu_head *rcu)
> >  {
> > -	kmem_cache_free(pwq_cache,
> > -			container_of(rcu, struct pool_workqueue, rcu));
> >  }
> >
> >  /*
> > diff -u -p /home/jll/linux/net/ipv4/inetpeer.c /tmp/nothing/net/ipv4/inetpeer.c
> > --- /home/jll/linux/net/ipv4/inetpeer.c
> > +++ /tmp/nothing/net/ipv4/inetpeer.c
> > @@ -130,7 +130,6 @@ static struct inet_peer *lookup(const st
> >
> >  static void inetpeer_free_rcu(struct rcu_head *head)
> >  {
> > -	kmem_cache_free(peer_cachep, container_of(head, struct inet_peer, rcu));
> >  }
> >
> >  /* perform garbage collect on all items stacked during a lookup */
> > diff -u -p /home/jll/linux/net/ipv6/xfrm6_tunnel.c /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> > --- /home/jll/linux/net/ipv6/xfrm6_tunnel.c
> > +++ /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> > @@ -180,8 +180,6 @@ EXPORT_SYMBOL(xfrm6_tunnel_alloc_spi);
> >
> >  static void x6spi_destroy_rcu(struct rcu_head *head)
> >  {
> > -	kmem_cache_free(xfrm6_tunnel_spi_kmem,
> > -			container_of(head, struct xfrm6_tunnel_spi, rcu_head));
> >  }
> >
> >  static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
> > diff -u -p /home/jll/linux/security/security.c /tmp/nothing/security/security.c
> > --- /home/jll/linux/security/security.c
> > +++ /tmp/nothing/security/security.c
> > @@ -1599,7 +1599,6 @@ static void inode_free_by_rcu(struct rcu
> >  	/*
> >  	 * The rcu head is at the start of the inode blob
> >  	 */
> > -	kmem_cache_free(lsm_inode_cache, head);
> >  }
> >
> >  /**
> >
> See below some extra functions which can be eliminated. How i found them:
>
> find ./ -name "*.c" -o -name "*.h" | xargs grep -rn call_rcu -B 10 | grep kmem_cache_free
>
> <snip>
>  static void nfsd4_free_file_rcu(struct rcu_head *rcu);

Thanks.  I tried to find this kind of issue, but it turned up nothing.
There must be some mistake, and I will try again.

julia

>  static void lima_fence_release(struct dma_fence *fence);
>  void intel_context_free(struct intel_context *ce);
>  static void ipmr_cache_free(struct mfc_cache *c);
>  static inline void alias_free_mem_rcu(struct fib_alias *fa);
>  dsthash_free(struct xt_hashlimit_htable *ht, struct dsthash_ent *ent);
>  void nf_ct_expect_put(struct nf_conntrack_expect *exp);
>  static void node_free(struct net *net, struct fib6_node *fn);
>  static inline void ip6mr_cache_free(struct mfc6_cache *c);
>  static void posix_timer_free(struct k_itimer *tmr);
>  static void thread_stack_delayed_free(struct task_struct *tsk);
> <snip>
>
> Those are can be replaced by directly calling of kfree_rcu() instead of call_rcu().
>
> --
> Uladzislau Rezki
>
