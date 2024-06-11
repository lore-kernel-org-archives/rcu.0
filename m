Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98F42067
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126753; cv=none; b=gsnVIXvqMbi77d7D3Z6ChBgyEttc2lBa/YUicquIvdKKGondGQUKb8kvgPmKaeuaoLufEC0GseYU+iij0yS8lXm8MUtVnT5KannfMwGJ0QVxpKhEB2IxBWVHLYJO1md1pcJnSVBTxWCR1Mj0pXUVSc0L7h8yu8aRJWpb/3wOCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126753; c=relaxed/simple;
	bh=h3Fw4LVxQan3oHF80TjCbqhGZePFij6LDDZYP2gTes8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouIE8go9PvaRwqcng0mnQ/Th5feMICmjtugMU2930uzrvOqgWc0bU1OX/KeBi0NXGCFhSyvq2MdRtxzqNi9ZpEU0RYKGEgaNeY9IvI2QZRPlF3aMG3NkqGr4UM7ayIzoZh8Ffs2ckvUHAHdqqGTbsjzoDHxp8SYJUyk++CW5M14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSUMuMCe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSUMuMCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D832CC2BD10;
	Tue, 11 Jun 2024 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718126752;
	bh=h3Fw4LVxQan3oHF80TjCbqhGZePFij6LDDZYP2gTes8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iSUMuMCenL4iT+NZT/XWrri2sMiE9aRMA9swLcBgvI3EqacJ3eYmHSFISIeUE57eB
	 P6OWwnb4e24EZiAfB1fdKeBkMfRgAF/93b2eBXQdXVLJmVitL7Y9Afuf3NElb65V6F
	 L2eYpliZMoXgiN0gJkjzRxDMgIRbF7bFDl999NlIoslsGS4dpJ/nGkuogaqUfT4c4m
	 tPiv4dkVIK29J38zoGV2ruEopKUslcu09izr3WUTH98yOf4CmeWwBed4QYshjQtpdT
	 3E4f7Vd5z4sM6hazKeriJ458eoDFUrCXvQ6/AODd/IQKdvYbGV/Hp5s0gRAU07trsN
	 RptVypv0xLOLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63D7ECE0991; Tue, 11 Jun 2024 10:25:52 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:25:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <c751813a-0ab7-4629-bdc4-00f472ae18ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <alpine.DEB.2.22.394.2405272226510.3330@hadrien>
 <ZlXIDZLMNPc7E7XE@pc636>
 <2dd5bafb-ceb1-238d-2f51-83ebf135b73@inria.fr>
 <ZlXaPuA4lC2ANTdN@pc636>
 <2ec7eb0f-0950-4d65-b33a-64df7c5f89c9@paulmck-laptop>
 <77531e55-3418-d4be-f538-7ddc904ed88f@inria.fr>
 <Zl76AZ_0H5xb1cFl@pc638.lan>
 <alpine.DEB.2.22.394.2406091158420.3474@hadrien>
 <21a32cbb-d388-4a8c-9298-ef8c82330f9e@paulmck-laptop>
 <Zmh-EYvXqL3JBt1p@pc638.lan>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmh-EYvXqL3JBt1p@pc638.lan>

On Tue, Jun 11, 2024 at 06:40:49PM +0200, Uladzislau Rezki wrote:
> > > 
> > > These look ok to me.  In the last two cases, the callback function is also
> > > stored in a data structure, eg:
> > > 
> > > static struct mfc6_cache *ip6mr_cache_alloc(void)
> > > {
> > > 	struct mfc6_cache *c = kmem_cache_zalloc(mrt_cachep, GFP_KERNEL);
> > > 	if (!c)
> > > 		return NULL;
> > > 	c->_c.mfc_un.res.last_assert = jiffies - MFC_ASSERT_THRESH - 1;
> > > 	c->_c.mfc_un.res.minvif = MAXMIFS;
> > > 	c->_c.free = ip6mr_cache_free_rcu;
> > > 	refcount_set(&c->_c.mfc_un.res.refcount, 1);
> > > 	return c;
> > > }
> > > 
> > > Should that be left as it is?
> > 
> > Given that ->_c.free isn't used in the RCU callback, I am guessing that
> > this is intended for debugging purposes, so that you can see from a crash
> > dump how this will be freed.  But I could be completely off-base here.
> > 
> > One approach would be to remove the ->_c.free field and call attention
> > to this in the patches' commit logs.
> > 
> > Another would be to instead put the address of the allocation function
> > in ->_c.free, and again call attention to this in the commit logs.
> > 
> > Is there a better approach than these three?  ;-)
> > 
> IMO, "_c.free" should be removed:

Why not send the patch and see what the maintainers say?  If they object,
you can always fall back to one of the other two methods, depending on
the nature of their objection.

							Thanx, Paul

> diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
> index 9dd4bf157255..45f220f761df 100644
> --- a/include/linux/mroute_base.h
> +++ b/include/linux/mroute_base.h
> @@ -130,7 +130,6 @@ enum {
>   * @refcount: reference count for this entry
>   * @list: global entry list
>   * @rcu: used for entry destruction
> - * @free: Operation used for freeing an entry under RCU
>   */
>  struct mr_mfc {
>  	struct rhlist_head mnode;
> @@ -156,13 +155,12 @@ struct mr_mfc {
>  	} mfc_un;
>  	struct list_head list;
>  	struct rcu_head	rcu;
> -	void (*free)(struct rcu_head *head);
>  };
>  
>  static inline void mr_cache_put(struct mr_mfc *c)
>  {
>  	if (refcount_dec_and_test(&c->mfc_un.res.refcount))
> -		call_rcu(&c->rcu, c->free);
> +		kfree_rcu(c, rcu);
>  }
>  
>  static inline void mr_cache_hold(struct mr_mfc *c)
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 6c750bd13dd8..5d2e339f09cc 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -702,16 +702,9 @@ static int vif_delete(struct mr_table *mrt, int vifi, int notify,
>  	return 0;
>  }
>  
> -static void ipmr_cache_free_rcu(struct rcu_head *head)
> -{
> -	struct mr_mfc *c = container_of(head, struct mr_mfc, rcu);
> -
> -	kmem_cache_free(mrt_cachep, (struct mfc_cache *)c);
> -}
> -
>  static void ipmr_cache_free(struct mfc_cache *c)
>  {
> -	call_rcu(&c->_c.rcu, ipmr_cache_free_rcu);
> +	kfree_rcu(c, _c.rcu);
>  }
>  
>  /* Destroy an unresolved cache entry, killing queued skbs
> @@ -959,7 +952,6 @@ static struct mfc_cache *ipmr_cache_alloc(void)
>  	if (c) {
>  		c->_c.mfc_un.res.last_assert = jiffies - MFC_ASSERT_THRESH - 1;
>  		c->_c.mfc_un.res.minvif = MAXVIFS;
> -		c->_c.free = ipmr_cache_free_rcu;
>  		refcount_set(&c->_c.mfc_un.res.refcount, 1);
>  	}
>  	return c;
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index dd342e6ecf3f..1634fa794ea2 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -753,16 +753,9 @@ static int mif6_delete(struct mr_table *mrt, int vifi, int notify,
>  	return 0;
>  }
>  
> -static inline void ip6mr_cache_free_rcu(struct rcu_head *head)
> -{
> -	struct mr_mfc *c = container_of(head, struct mr_mfc, rcu);
> -
> -	kmem_cache_free(mrt_cachep, (struct mfc6_cache *)c);
> -}
> -
>  static inline void ip6mr_cache_free(struct mfc6_cache *c)
>  {
> -	call_rcu(&c->_c.rcu, ip6mr_cache_free_rcu);
> +	kfree_rcu(c, _c.rcu);
>  }
>  
>  /* Destroy an unresolved cache entry, killing queued skbs
> @@ -985,7 +978,6 @@ static struct mfc6_cache *ip6mr_cache_alloc(void)
>  		return NULL;
>  	c->_c.mfc_un.res.last_assert = jiffies - MFC_ASSERT_THRESH - 1;
>  	c->_c.mfc_un.res.minvif = MAXMIFS;
> -	c->_c.free = ip6mr_cache_free_rcu;
>  	refcount_set(&c->_c.mfc_un.res.refcount, 1);
>  	return c;
>  }
> 
> --
> Uladzislau Rezki
