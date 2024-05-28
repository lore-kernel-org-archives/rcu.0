Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395C16D31C
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897811; cv=none; b=EzajZDpmXrIDiXtdUikmqA0GZYIY8ZpehT2JSjdNvMLIfOGOiMHJKdDpM0gLdbLVF0C3bAH/bzjWoLAnnhCCgUwQkySfBy5v24o5caxpNNn58NgateB6iRZT/F06ZVWddIK6OGFOuA+GtPZm9F72MtslL05tIwjZt41KSIVfOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897811; c=relaxed/simple;
	bh=FpZW23XIL3UPg/X6J8gvFe59J6iqWY4baWyEDVO7MlM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXaRCachatwrvgWPF+WtrqSOxMcfchA/StTLrx+uIqXF9QhxgCa/1nSgaMi+T8Df2IyqZ++N0kw31y4yQlP1u/YQlOVrHXkELJbNLdkhURWFromxHk2VnPBjGgXa5QXWuLvzaWIgcGuWw+MpE/SZBos0F+JSsTeYhmhclq26phs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCMbGKld; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCMbGKld"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e95a60dfcdso7744041fa.1
        for <rcu@vger.kernel.org>; Tue, 28 May 2024 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716897808; x=1717502608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8Bcb+tJI9CaJKfaspgOHTiOBQF++jxzyxHUR5Y5tUM=;
        b=hCMbGKldjYiwXQ9oL/ywW7nL+Q/y+0Kl54viwMobCQr8v6sD+gZ+CBPiDrf5ZLR98P
         nNTFnPBkOWgELm/CmR6QGaIiLta9UK40clea3LiY+nkJikb6arqwWPcPMkGixnZWfh/n
         WNrSatLel2SBE8lI83zfdf77GuWnDeTHvjszSuSO0hdPX0Hhvd7Wq9dgrknunbNmaxgt
         lL2HxdhkDuoeLs9/IelkhXB2VG3RYzIX5k5pZNP2/FVr9uJZuBgOj0dCHS25r8o4YKUL
         vNnKNVIPBXLm6qb+xNy2HNzw3JP68WKYDlPQaO65Us+3czzNS8PiMOvyI9Q9lMHj3cbe
         6ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897808; x=1717502608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8Bcb+tJI9CaJKfaspgOHTiOBQF++jxzyxHUR5Y5tUM=;
        b=McdxvxjxZd4EKjCgzzAwhMeVbbKEPjxMcBsbTKXwdXwvwZNYC5CqYxuGeLFMY/BCV9
         M0+YmAUM95wCMmCOdW2CwUSH1qfvifJevSlOC0ieFLOQTDv4MsT1Oud9UT8fEH2GbjyN
         6xMsWPmAAb2054aePreIJrubvP+YEbfDfLJ8o2wOQMn+MhC08oUoY0VS0ChuNp0wAwG4
         PPz3ZoiUIpOmyof6bRpG7WTRMAJr0rwUje829yvu7bLtGwIRlB1fl1EmUbPVLnI1vua5
         /jwfIHTWU4Bcj9ELZZlNW5kPm+okRQleg6SxXlbrQEqjgeG6eZ9Zb9XJkidiljjglMqP
         LobQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlELwOVcOmiFyExZqBmG2ttgpGDumEm8UxWpReqe+DSh2qpfw1ygRALSMHfXQ1U9IbqWdJ4C6+1F6FJ3HGYBJ2tpsP
X-Gm-Message-State: AOJu0Yx9gAZEI0qj7mo/rNDkZ70qRozeSXJSKUhELLWSt0lBMyq5/riv
	7fdwXTaBFoMOckkiPdzCEtLWGid41QqqnLIm0ubbkbuBZJm0qXv1
X-Google-Smtp-Source: AGHT+IFhc0q6fLKGmGcPnwrDiqp9b6C3AO8YZ/nh8PZIVQx8SvxLDWHJM0kS61lQx+h1F+g4l+WkQg==
X-Received: by 2002:a2e:9101:0:b0:2e8:10ca:2437 with SMTP id 38308e7fff4ca-2e95b2db206mr72027361fa.50.1716897807830;
        Tue, 28 May 2024 05:03:27 -0700 (PDT)
Received: from pc636 (host-95-193-70-101.mobileonline.telia.com. [95.193.70.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc4a9esm22494371fa.16.2024.05.28.05.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:03:27 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 May 2024 14:03:25 +0200
To: Julia Lawall <julia.lawall@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <ZlXIDZLMNPc7E7XE@pc636>
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
 <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>
 <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>
 <alpine.DEB.2.22.394.2405272226510.3330@hadrien>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2405272226510.3330@hadrien>

Hello.

> 
> 
> On Mon, 27 May 2024, Paul E. McKenney wrote:
> 
> > On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Mon, 27 May 2024, Vlastimil Babka wrote:
> > >
> > > > Hi,
> > > >
> > > > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > > > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > > > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > > > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > > > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > > > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > > > to take this task, feel free to.
> > >
> > > Thanks for the suggestion!  I will try to look into it.
> >
> > Thank you both!
> 
> I found the following functions.  Do you want some other information, such
> as where they are called from?
> 
> Ignore the -s at the beginning of some lines.  Those are for emphasis. not
> to suggest to remove the code.
> 
> I checked that the functions are only used in calls to call_rcu.
> 
> Without more effort, Coccinelle only looks for functions defined in the
> same file.  Here are the functions that are passed to call_rcu where the
> function is not defined in the same file:
> 
> need definition for audit_free_rule_rcu
> need definition for __i915_gem_free_object_rcu
> need definition for io_eventfd_ops
> need definition for ip_vs_dest_dst_rcu_free
> need definition for __put_task_struct_rcu_cb
> need definition for radix_tree_node_rcu_free
> 
> They all do something more, although radix_tree_node_rcu_free doesn't do
> much more (some memsets).
> 
> julia
> 
> diff -u -p /home/jll/linux/drivers/net/wireguard/allowedips.c /tmp/nothing/drivers/net/wireguard/allowedips.c
> --- /home/jll/linux/drivers/net/wireguard/allowedips.c
> +++ /tmp/nothing/drivers/net/wireguard/allowedips.c
> @@ -50,7 +50,6 @@ static void push_rcu(struct allowedips_n
> 
>  static void node_free_rcu(struct rcu_head *rcu)
>  {
> -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
>  }
> 
>  static void root_free_rcu(struct rcu_head *rcu)
> diff -u -p /home/jll/linux/fs/ecryptfs/dentry.c /tmp/nothing/fs/ecryptfs/dentry.c
> --- /home/jll/linux/fs/ecryptfs/dentry.c
> +++ /tmp/nothing/fs/ecryptfs/dentry.c
> @@ -53,8 +53,6 @@ struct kmem_cache *ecryptfs_dentry_info_
> 
>  static void ecryptfs_dentry_free_rcu(struct rcu_head *head)
>  {
> -	kmem_cache_free(ecryptfs_dentry_info_cache,
> -		container_of(head, struct ecryptfs_dentry_info, rcu));
>  }
> 
>  /**
> diff -u -p /home/jll/linux/kernel/fork.c /tmp/nothing/kernel/fork.c
> --- /home/jll/linux/kernel/fork.c
> +++ /tmp/nothing/kernel/fork.c
> @@ -378,7 +378,6 @@ static struct kmem_cache *thread_stack_c
> 
>  static void thread_stack_free_rcu(struct rcu_head *rh)
>  {
> -	kmem_cache_free(thread_stack_cache, rh);
>  }
> 
>  static void thread_stack_delayed_free(struct task_struct *tsk)
> diff -u -p /home/jll/linux/kernel/workqueue.c /tmp/nothing/kernel/workqueue.c
> --- /home/jll/linux/kernel/workqueue.c
> +++ /tmp/nothing/kernel/workqueue.c
> @@ -5024,8 +5024,6 @@ fail:
> 
>  static void rcu_free_pwq(struct rcu_head *rcu)
>  {
> -	kmem_cache_free(pwq_cache,
> -			container_of(rcu, struct pool_workqueue, rcu));
>  }
> 
>  /*
> diff -u -p /home/jll/linux/net/ipv4/inetpeer.c /tmp/nothing/net/ipv4/inetpeer.c
> --- /home/jll/linux/net/ipv4/inetpeer.c
> +++ /tmp/nothing/net/ipv4/inetpeer.c
> @@ -130,7 +130,6 @@ static struct inet_peer *lookup(const st
> 
>  static void inetpeer_free_rcu(struct rcu_head *head)
>  {
> -	kmem_cache_free(peer_cachep, container_of(head, struct inet_peer, rcu));
>  }
> 
>  /* perform garbage collect on all items stacked during a lookup */
> diff -u -p /home/jll/linux/net/ipv6/xfrm6_tunnel.c /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> --- /home/jll/linux/net/ipv6/xfrm6_tunnel.c
> +++ /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> @@ -180,8 +180,6 @@ EXPORT_SYMBOL(xfrm6_tunnel_alloc_spi);
> 
>  static void x6spi_destroy_rcu(struct rcu_head *head)
>  {
> -	kmem_cache_free(xfrm6_tunnel_spi_kmem,
> -			container_of(head, struct xfrm6_tunnel_spi, rcu_head));
>  }
> 
>  static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
> diff -u -p /home/jll/linux/security/security.c /tmp/nothing/security/security.c
> --- /home/jll/linux/security/security.c
> +++ /tmp/nothing/security/security.c
> @@ -1599,7 +1599,6 @@ static void inode_free_by_rcu(struct rcu
>  	/*
>  	 * The rcu head is at the start of the inode blob
>  	 */
> -	kmem_cache_free(lsm_inode_cache, head);
>  }
> 
>  /**
> 
See below some extra functions which can be eliminated. How i found them:

find ./ -name "*.c" -o -name "*.h" | xargs grep -rn call_rcu -B 10 | grep kmem_cache_free

<snip>
 static void nfsd4_free_file_rcu(struct rcu_head *rcu);
 static void lima_fence_release(struct dma_fence *fence);
 void intel_context_free(struct intel_context *ce);
 static void ipmr_cache_free(struct mfc_cache *c);
 static inline void alias_free_mem_rcu(struct fib_alias *fa);
 dsthash_free(struct xt_hashlimit_htable *ht, struct dsthash_ent *ent);
 void nf_ct_expect_put(struct nf_conntrack_expect *exp);
 static void node_free(struct net *net, struct fib6_node *fn);
 static inline void ip6mr_cache_free(struct mfc6_cache *c);
 static void posix_timer_free(struct k_itimer *tmr);
 static void thread_stack_delayed_free(struct task_struct *tsk);
<snip>

Those are can be replaced by directly calling of kfree_rcu() instead of call_rcu().

--
Uladzislau Rezki
