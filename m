Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EDB16F859
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906553; cv=none; b=I+7vpYmjcVJaTDzSsUMsum5CQKr6VJg3awL1R34k3fqI1ZzIY+5zwlihczIsT9dlez5N/OoApfgJ/Wyhen1RoXo9rWeVeCXHFOHybuJX6AMIlw04SPLC+3VG4Ugbkoj4V9XU2r1llgWNPNIpBzDyv2r96ggA67CWZ/g1yFKSVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906553; c=relaxed/simple;
	bh=NviLABIc30JqHrgbrB574ijIJfU2gfwyOcA6sTzzM6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBTCYqbUEDI/A8pUALLIE/1De7n3ZJHplkV6OAdv1rGWWrVGPw6Ln15kkgunIlwY0TyP4N23F1IRsbj5YoT7nZAsQazgNA108Km6u+dcTguAA3qn2rVLNLonn9Z0JO958xiMDhekXEXrLCEdDT4t+BZYDL4G4pgP+Ri4Kikw+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGB5RhMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGB5RhMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC2AC3277B;
	Tue, 28 May 2024 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716906553;
	bh=NviLABIc30JqHrgbrB574ijIJfU2gfwyOcA6sTzzM6w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EGB5RhMKjXS6WAGU/Qa4j6/cyaQ3HWFcY3Lpnz6opVp3E2J9Og3gocMQphIj04RQr
	 1Xq9B9+7uNO6oFZQnkc+YaDWZbhp0kxoY8xew1WamavWyNqNFcH74gO/vh6Sp4DzWr
	 lI8HvNu6yeS+JLjzD5sj/1+fXedZAmzDiYd30dWq4IdYIG5d8LFel6CqxFot6ZHOYn
	 mtC5FKnwISnMprtodEm/f+9dsOvVL86k/d/RyEAc4MxMXr1eTIhbsHyEpC8Hy/AMJD
	 HzON/6g7/PHQz8eaPouozD23UTdEXzZygq7lQs5JySyuirhs5DPeGCoOnOpcMnGVSg
	 UY3z1JOMHsPCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8F454CE0C56; Tue, 28 May 2024 07:29:12 -0700 (PDT)
Date: Tue, 28 May 2024 07:29:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <2ec7eb0f-0950-4d65-b33a-64df7c5f89c9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
 <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>
 <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>
 <alpine.DEB.2.22.394.2405272226510.3330@hadrien>
 <ZlXIDZLMNPc7E7XE@pc636>
 <2dd5bafb-ceb1-238d-2f51-83ebf135b73@inria.fr>
 <ZlXaPuA4lC2ANTdN@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlXaPuA4lC2ANTdN@pc636>

On Tue, May 28, 2024 at 03:21:02PM +0200, Uladzislau Rezki wrote:
> On Tue, May 28, 2024 at 02:08:20PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Tue, 28 May 2024, Uladzislau Rezki wrote:
> > 
> > > Hello.
> > >
> > > >
> > > >
> > > > On Mon, 27 May 2024, Paul E. McKenney wrote:
> > > >
> > > > > On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> > > > > >
> > > > > >
> > > > > > On Mon, 27 May 2024, Vlastimil Babka wrote:
> > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > > > > > > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > > > > > > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > > > > > > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > > > > > > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > > > > > > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > > > > > > to take this task, feel free to.
> > > > > >
> > > > > > Thanks for the suggestion!  I will try to look into it.
> > > > >
> > > > > Thank you both!
> > > >
> > > > I found the following functions.  Do you want some other information, such
> > > > as where they are called from?
> > > >
> > > > Ignore the -s at the beginning of some lines.  Those are for emphasis. not
> > > > to suggest to remove the code.
> > > >
> > > > I checked that the functions are only used in calls to call_rcu.
> > > >
> > > > Without more effort, Coccinelle only looks for functions defined in the
> > > > same file.  Here are the functions that are passed to call_rcu where the
> > > > function is not defined in the same file:
> > > >
> > > > need definition for audit_free_rule_rcu
> > > > need definition for __i915_gem_free_object_rcu
> > > > need definition for io_eventfd_ops
> > > > need definition for ip_vs_dest_dst_rcu_free
> > > > need definition for __put_task_struct_rcu_cb
> > > > need definition for radix_tree_node_rcu_free
> > > >
> > > > They all do something more, although radix_tree_node_rcu_free doesn't do
> > > > much more (some memsets).
> > > >
> > > > julia
> > > >
> > > > diff -u -p /home/jll/linux/drivers/net/wireguard/allowedips.c /tmp/nothing/drivers/net/wireguard/allowedips.c
> > > > --- /home/jll/linux/drivers/net/wireguard/allowedips.c
> > > > +++ /tmp/nothing/drivers/net/wireguard/allowedips.c
> > > > @@ -50,7 +50,6 @@ static void push_rcu(struct allowedips_n
> > > >
> > > >  static void node_free_rcu(struct rcu_head *rcu)
> > > >  {
> > > > -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
> > > >  }
> > > >
> > > >  static void root_free_rcu(struct rcu_head *rcu)
> > > > diff -u -p /home/jll/linux/fs/ecryptfs/dentry.c /tmp/nothing/fs/ecryptfs/dentry.c
> > > > --- /home/jll/linux/fs/ecryptfs/dentry.c
> > > > +++ /tmp/nothing/fs/ecryptfs/dentry.c
> > > > @@ -53,8 +53,6 @@ struct kmem_cache *ecryptfs_dentry_info_
> > > >
> > > >  static void ecryptfs_dentry_free_rcu(struct rcu_head *head)
> > > >  {
> > > > -	kmem_cache_free(ecryptfs_dentry_info_cache,
> > > > -		container_of(head, struct ecryptfs_dentry_info, rcu));
> > > >  }
> > > >
> > > >  /**
> > > > diff -u -p /home/jll/linux/kernel/fork.c /tmp/nothing/kernel/fork.c
> > > > --- /home/jll/linux/kernel/fork.c
> > > > +++ /tmp/nothing/kernel/fork.c
> > > > @@ -378,7 +378,6 @@ static struct kmem_cache *thread_stack_c
> > > >
> > > >  static void thread_stack_free_rcu(struct rcu_head *rh)
> > > >  {
> > > > -	kmem_cache_free(thread_stack_cache, rh);
> > > >  }
> > > >
> > > >  static void thread_stack_delayed_free(struct task_struct *tsk)
> > > > diff -u -p /home/jll/linux/kernel/workqueue.c /tmp/nothing/kernel/workqueue.c
> > > > --- /home/jll/linux/kernel/workqueue.c
> > > > +++ /tmp/nothing/kernel/workqueue.c
> > > > @@ -5024,8 +5024,6 @@ fail:
> > > >
> > > >  static void rcu_free_pwq(struct rcu_head *rcu)
> > > >  {
> > > > -	kmem_cache_free(pwq_cache,
> > > > -			container_of(rcu, struct pool_workqueue, rcu));
> > > >  }
> > > >
> > > >  /*
> > > > diff -u -p /home/jll/linux/net/ipv4/inetpeer.c /tmp/nothing/net/ipv4/inetpeer.c
> > > > --- /home/jll/linux/net/ipv4/inetpeer.c
> > > > +++ /tmp/nothing/net/ipv4/inetpeer.c
> > > > @@ -130,7 +130,6 @@ static struct inet_peer *lookup(const st
> > > >
> > > >  static void inetpeer_free_rcu(struct rcu_head *head)
> > > >  {
> > > > -	kmem_cache_free(peer_cachep, container_of(head, struct inet_peer, rcu));
> > > >  }
> > > >
> > > >  /* perform garbage collect on all items stacked during a lookup */
> > > > diff -u -p /home/jll/linux/net/ipv6/xfrm6_tunnel.c /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> > > > --- /home/jll/linux/net/ipv6/xfrm6_tunnel.c
> > > > +++ /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> > > > @@ -180,8 +180,6 @@ EXPORT_SYMBOL(xfrm6_tunnel_alloc_spi);
> > > >
> > > >  static void x6spi_destroy_rcu(struct rcu_head *head)
> > > >  {
> > > > -	kmem_cache_free(xfrm6_tunnel_spi_kmem,
> > > > -			container_of(head, struct xfrm6_tunnel_spi, rcu_head));
> > > >  }
> > > >
> > > >  static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
> > > > diff -u -p /home/jll/linux/security/security.c /tmp/nothing/security/security.c
> > > > --- /home/jll/linux/security/security.c
> > > > +++ /tmp/nothing/security/security.c
> > > > @@ -1599,7 +1599,6 @@ static void inode_free_by_rcu(struct rcu
> > > >  	/*
> > > >  	 * The rcu head is at the start of the inode blob
> > > >  	 */
> > > > -	kmem_cache_free(lsm_inode_cache, head);
> > > >  }
> > > >
> > > >  /**
> > > >
> > > See below some extra functions which can be eliminated. How i found them:
> > >
> > > find ./ -name "*.c" -o -name "*.h" | xargs grep -rn call_rcu -B 10 | grep kmem_cache_free
> > >
> > > <snip>
> > >  static void nfsd4_free_file_rcu(struct rcu_head *rcu);
> > 
> > Thanks.  I tried to find this kind of issue, but it turned up nothing.
> > There must be some mistake, and I will try again.
> > 
> You are welcome. Also there are several places like below:
> 
> <snip>
> static void blk_free_queue_rcu(struct rcu_head *rcu_head)
> {
>         struct request_queue *q = container_of(rcu_head,
>                         struct request_queue, rcu_head);
> 
>         percpu_ref_exit(&q->q_usage_counter);
>         kmem_cache_free(blk_requestq_cachep, q);
> }
> 
> static void blk_free_queue(struct request_queue *q)
> {
>         blk_free_queue_stats(q->stats);
>         if (queue_is_mq(q))
>                 blk_mq_release(q);
> 
>         ida_free(&blk_queue_ida, q->id);
>         call_rcu(&q->rcu_head, blk_free_queue_rcu);
> }
> <snip>
> 
> and potentially it can be also replaced:
> 
> <snip>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 82c3ae22d76d..898d6990600d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -257,15 +257,6 @@ void blk_clear_pm_only(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_clear_pm_only);
> 
> -static void blk_free_queue_rcu(struct rcu_head *rcu_head)
> -{
> -       struct request_queue *q = container_of(rcu_head,
> -                       struct request_queue, rcu_head);
> -
> -       percpu_ref_exit(&q->q_usage_counter);
> -       kmem_cache_free(blk_requestq_cachep, q);
> -}
> -
>  static void blk_free_queue(struct request_queue *q)
>  {
>         blk_free_queue_stats(q->stats);
> @@ -273,7 +264,8 @@ static void blk_free_queue(struct request_queue *q)
>                 blk_mq_release(q);
> 
>         ida_free(&blk_queue_ida, q->id);
> -       call_rcu(&q->rcu_head, blk_free_queue_rcu);
> +       percpu_ref_exit(&q->q_usage_counter);
> +       kfree_rcu(q, rcu_head);
>  }
> 
>  /**
> <snip>

This should be functionally fine, but could inflict serious memory
contention on the last few readers.  Which, for all I know, might
be just fine.

As you say:

> but a maintainer of "blk-core.c" should check it if a usage counter can
> be updated before a completion of GP.
> 
> Probably we can skip as of now such cases, so i do not have a strong
> opinion here.

							Thanx, Paul
