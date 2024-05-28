Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5616F260
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902469; cv=none; b=MtBCyiVdOYvj2GtpSH7i+yiXFIl8q+de8eFsKbhxAJsDheyLUyhNVg7YR5va6fjXoPMeOhhRbem4VvhLu8+8rrQwxK5gKymURtB9G9TpyYBawUTPNEvMZbFxqH74SCuK0tZH8gBpmAHuk2Zl8nWQSOTr7klPc9Mq8SOWqG8wiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902469; c=relaxed/simple;
	bh=jUT7ta2rPf6p1WcZxZkGxJqhBj/QjntpJpJl0hdDO50=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVjROcOKWkeV4QPiwYMxxaQ1vLk8mjH+WUGZ26Pi/pi9oVa8m8MKWbSWFnRcsTZ2x6g4pvUdjDiSK7jmoXDiilIySkvUD7aXs2rh+Fh8DH7HY+ZF83lm/1a49XLjHYkqLqrF66BebTS9AUx+lkMvfySwzMCkEyHaO3YPYnx3mlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij1ZwSID; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij1ZwSID"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e95a60454fso9136391fa.1
        for <rcu@vger.kernel.org>; Tue, 28 May 2024 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716902466; x=1717507266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXVQeHY6tAgT2cR7UV7fRM7xYi2AxOuPJoQ0kCYU9tM=;
        b=ij1ZwSIDaGMGS/hgXMfS9olFzY6NC6Puy8d6B9H/qQoI9haB6HGh6879n9KQD+dL52
         3y7fmWFWh10rREaeBzm4qgz1kK1NqrszcVOHelr3PgyRdv6M3cOqP0L7lztD08vKWCyb
         RaeXO2uLyBkZC954Y1wq8LxBi8x6RgLGGwQBAiflvDckigqt+FOFQVZ6Zxnl2y5DzjAq
         cSY3mWpZK07A78oqs9xGpatcEJw9bSp3sCpGfE7vvqYvroA5UvwzzP5s+zfv+BY1pl+g
         sPCRIKiiqhLmz3BiUqjlioaBqvjuvj3hwcqUU3gnQM40LNN5034dCzkIgOhXvn46treK
         dugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902466; x=1717507266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXVQeHY6tAgT2cR7UV7fRM7xYi2AxOuPJoQ0kCYU9tM=;
        b=G6Lnpa8dUt+vrWnxWi9YQHFtjexJnAadnhFG0i4bKpL59ye67OcjeKZoskhDRsR6M6
         W7YrL8M+g6hEfVJIOe2iENSEUSaF/2AFCcX8VHjHCT0GRrDOhhvBeYBZQMlriMsseK+L
         VtURvTz4fyl6unq9IByLC0Y1MGaDHRt9GtpW0trMjtzZ4V9RnzkfH5+zcYYr8Gnb4Sbf
         qpDa6y4sLFtBvdlqRiZVVJT7XHayITMrQfUkd2YRR9V3/wdgMX/qXpnZLRRSdTDKdtuY
         IeEmNpVOs1OMYhw/TSPADwZuLgkLHQ6+PlIRRcvDFytQsNOG3g8XTVY93YCy/Z8ZonNd
         zUEg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2gNYGSQ5X4cPYI3AauDzyOJc9yiFvxq2T71ebsOlRTB3caZHyToW5NHX6+ofR0swuPIabZnkSeuk2RbG3aTOqZn3
X-Gm-Message-State: AOJu0YxzSWKJENnsW17YqsjSCxxufYgTxF+xBLUVWWb9D6xgKpeSikdW
	jhylZvuo7DXZNvBzVroPVr37dh7AquZOYR2yZXQ2IvdzmeUwf05F
X-Google-Smtp-Source: AGHT+IFm/iWYb0lm2G8Hh7/weYnf9OTvd9wXHxG3uAC/HX4CB+gAkndqgsdY/hkJSme+5B7olDLSuQ==
X-Received: by 2002:a2e:a592:0:b0:2d4:54f2:c409 with SMTP id 38308e7fff4ca-2e95b282910mr92739591fa.38.1716902465603;
        Tue, 28 May 2024 06:21:05 -0700 (PDT)
Received: from pc636 (host-95-193-70-101.mobileonline.telia.com. [95.193.70.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc4a7asm22749691fa.3.2024.05.28.06.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:21:05 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 May 2024 15:21:02 +0200
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <ZlXaPuA4lC2ANTdN@pc636>
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
 <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>
 <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>
 <alpine.DEB.2.22.394.2405272226510.3330@hadrien>
 <ZlXIDZLMNPc7E7XE@pc636>
 <2dd5bafb-ceb1-238d-2f51-83ebf135b73@inria.fr>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dd5bafb-ceb1-238d-2f51-83ebf135b73@inria.fr>

On Tue, May 28, 2024 at 02:08:20PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 28 May 2024, Uladzislau Rezki wrote:
> 
> > Hello.
> >
> > >
> > >
> > > On Mon, 27 May 2024, Paul E. McKenney wrote:
> > >
> > > > On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> > > > >
> > > > >
> > > > > On Mon, 27 May 2024, Vlastimil Babka wrote:
> > > > >
> > > > > > Hi,
> > > > > >
> > > > > > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > > > > > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > > > > > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > > > > > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > > > > > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > > > > > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > > > > > to take this task, feel free to.
> > > > >
> > > > > Thanks for the suggestion!  I will try to look into it.
> > > >
> > > > Thank you both!
> > >
> > > I found the following functions.  Do you want some other information, such
> > > as where they are called from?
> > >
> > > Ignore the -s at the beginning of some lines.  Those are for emphasis. not
> > > to suggest to remove the code.
> > >
> > > I checked that the functions are only used in calls to call_rcu.
> > >
> > > Without more effort, Coccinelle only looks for functions defined in the
> > > same file.  Here are the functions that are passed to call_rcu where the
> > > function is not defined in the same file:
> > >
> > > need definition for audit_free_rule_rcu
> > > need definition for __i915_gem_free_object_rcu
> > > need definition for io_eventfd_ops
> > > need definition for ip_vs_dest_dst_rcu_free
> > > need definition for __put_task_struct_rcu_cb
> > > need definition for radix_tree_node_rcu_free
> > >
> > > They all do something more, although radix_tree_node_rcu_free doesn't do
> > > much more (some memsets).
> > >
> > > julia
> > >
> > > diff -u -p /home/jll/linux/drivers/net/wireguard/allowedips.c /tmp/nothing/drivers/net/wireguard/allowedips.c
> > > --- /home/jll/linux/drivers/net/wireguard/allowedips.c
> > > +++ /tmp/nothing/drivers/net/wireguard/allowedips.c
> > > @@ -50,7 +50,6 @@ static void push_rcu(struct allowedips_n
> > >
> > >  static void node_free_rcu(struct rcu_head *rcu)
> > >  {
> > > -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
> > >  }
> > >
> > >  static void root_free_rcu(struct rcu_head *rcu)
> > > diff -u -p /home/jll/linux/fs/ecryptfs/dentry.c /tmp/nothing/fs/ecryptfs/dentry.c
> > > --- /home/jll/linux/fs/ecryptfs/dentry.c
> > > +++ /tmp/nothing/fs/ecryptfs/dentry.c
> > > @@ -53,8 +53,6 @@ struct kmem_cache *ecryptfs_dentry_info_
> > >
> > >  static void ecryptfs_dentry_free_rcu(struct rcu_head *head)
> > >  {
> > > -	kmem_cache_free(ecryptfs_dentry_info_cache,
> > > -		container_of(head, struct ecryptfs_dentry_info, rcu));
> > >  }
> > >
> > >  /**
> > > diff -u -p /home/jll/linux/kernel/fork.c /tmp/nothing/kernel/fork.c
> > > --- /home/jll/linux/kernel/fork.c
> > > +++ /tmp/nothing/kernel/fork.c
> > > @@ -378,7 +378,6 @@ static struct kmem_cache *thread_stack_c
> > >
> > >  static void thread_stack_free_rcu(struct rcu_head *rh)
> > >  {
> > > -	kmem_cache_free(thread_stack_cache, rh);
> > >  }
> > >
> > >  static void thread_stack_delayed_free(struct task_struct *tsk)
> > > diff -u -p /home/jll/linux/kernel/workqueue.c /tmp/nothing/kernel/workqueue.c
> > > --- /home/jll/linux/kernel/workqueue.c
> > > +++ /tmp/nothing/kernel/workqueue.c
> > > @@ -5024,8 +5024,6 @@ fail:
> > >
> > >  static void rcu_free_pwq(struct rcu_head *rcu)
> > >  {
> > > -	kmem_cache_free(pwq_cache,
> > > -			container_of(rcu, struct pool_workqueue, rcu));
> > >  }
> > >
> > >  /*
> > > diff -u -p /home/jll/linux/net/ipv4/inetpeer.c /tmp/nothing/net/ipv4/inetpeer.c
> > > --- /home/jll/linux/net/ipv4/inetpeer.c
> > > +++ /tmp/nothing/net/ipv4/inetpeer.c
> > > @@ -130,7 +130,6 @@ static struct inet_peer *lookup(const st
> > >
> > >  static void inetpeer_free_rcu(struct rcu_head *head)
> > >  {
> > > -	kmem_cache_free(peer_cachep, container_of(head, struct inet_peer, rcu));
> > >  }
> > >
> > >  /* perform garbage collect on all items stacked during a lookup */
> > > diff -u -p /home/jll/linux/net/ipv6/xfrm6_tunnel.c /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> > > --- /home/jll/linux/net/ipv6/xfrm6_tunnel.c
> > > +++ /tmp/nothing/net/ipv6/xfrm6_tunnel.c
> > > @@ -180,8 +180,6 @@ EXPORT_SYMBOL(xfrm6_tunnel_alloc_spi);
> > >
> > >  static void x6spi_destroy_rcu(struct rcu_head *head)
> > >  {
> > > -	kmem_cache_free(xfrm6_tunnel_spi_kmem,
> > > -			container_of(head, struct xfrm6_tunnel_spi, rcu_head));
> > >  }
> > >
> > >  static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
> > > diff -u -p /home/jll/linux/security/security.c /tmp/nothing/security/security.c
> > > --- /home/jll/linux/security/security.c
> > > +++ /tmp/nothing/security/security.c
> > > @@ -1599,7 +1599,6 @@ static void inode_free_by_rcu(struct rcu
> > >  	/*
> > >  	 * The rcu head is at the start of the inode blob
> > >  	 */
> > > -	kmem_cache_free(lsm_inode_cache, head);
> > >  }
> > >
> > >  /**
> > >
> > See below some extra functions which can be eliminated. How i found them:
> >
> > find ./ -name "*.c" -o -name "*.h" | xargs grep -rn call_rcu -B 10 | grep kmem_cache_free
> >
> > <snip>
> >  static void nfsd4_free_file_rcu(struct rcu_head *rcu);
> 
> Thanks.  I tried to find this kind of issue, but it turned up nothing.
> There must be some mistake, and I will try again.
> 
You are welcome. Also there are several places like below:

<snip>
static void blk_free_queue_rcu(struct rcu_head *rcu_head)
{
        struct request_queue *q = container_of(rcu_head,
                        struct request_queue, rcu_head);

        percpu_ref_exit(&q->q_usage_counter);
        kmem_cache_free(blk_requestq_cachep, q);
}

static void blk_free_queue(struct request_queue *q)
{
        blk_free_queue_stats(q->stats);
        if (queue_is_mq(q))
                blk_mq_release(q);

        ida_free(&blk_queue_ida, q->id);
        call_rcu(&q->rcu_head, blk_free_queue_rcu);
}
<snip>

and potentially it can be also replaced:

<snip>
diff --git a/block/blk-core.c b/block/blk-core.c
index 82c3ae22d76d..898d6990600d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -257,15 +257,6 @@ void blk_clear_pm_only(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_clear_pm_only);

-static void blk_free_queue_rcu(struct rcu_head *rcu_head)
-{
-       struct request_queue *q = container_of(rcu_head,
-                       struct request_queue, rcu_head);
-
-       percpu_ref_exit(&q->q_usage_counter);
-       kmem_cache_free(blk_requestq_cachep, q);
-}
-
 static void blk_free_queue(struct request_queue *q)
 {
        blk_free_queue_stats(q->stats);
@@ -273,7 +264,8 @@ static void blk_free_queue(struct request_queue *q)
                blk_mq_release(q);

        ida_free(&blk_queue_ida, q->id);
-       call_rcu(&q->rcu_head, blk_free_queue_rcu);
+       percpu_ref_exit(&q->q_usage_counter);
+       kfree_rcu(q, rcu_head);
 }

 /**
<snip>

but a maintainer of "blk-core.c" should check it if a usage counter can
be updated before a completion of GP.

Probably we can skip as of now such cases, so i do not have a strong
opinion here.

--
Uladzislau Rezki
