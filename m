Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA61E863
	for <rcu@vger.kernel.org>; Sun,  9 Jun 2024 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717952616; cv=none; b=Icco3V2gNyy0wR4wYv27vr7F952V+DN4ua8lOSrYg+lJlE6j1UH7Y8+2hvXHEwjRXAnO/xcmOQdkXZSPrTLIULZ1F3tYCJUyHD2DtzKAQZuB25hgew4STODzQ8dPgV31f35WlfRAi0Pha+50uGxAfF8Ec5D3X8lsPfWMe9pciqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717952616; c=relaxed/simple;
	bh=CxX/R8/3nrVw2jnX0m/iz3sQOTNH/s4gKjUErpcIEvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtT+45lQzOtmLGjLyL8PLXo+em8ixaLjfjoJxO3RsabdPgBOfxAKkYykqK5O+6WaptsTvLtWnzl/hIbXh+M3QvbFbffq8B6L0WhH8w5hhqpEU8yLdVc92+PTdk/jhDqmrBzvRg+rmJmu7KtlmE40qXWicceBSFIyueJQCvyWbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqlE3gfq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqlE3gfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFAAC2BD10;
	Sun,  9 Jun 2024 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717952616;
	bh=CxX/R8/3nrVw2jnX0m/iz3sQOTNH/s4gKjUErpcIEvM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JqlE3gfqF8MrC0rhCYC3DSdPBOsKfnvZw44OQgdz/cHSHj2t2wnQLZz7h8AMn6b92
	 4UhwhamUny/JKWaM+UFPcJgEho5rRACt2lyvCBuPjoR7lCXOWckBCZtvaxODVxHxem
	 YctSbLQdM+hv3OS2LSXLNNc3McTghJExpc+N1vI02lRZvk4cwiajDvfAFEVggaOB/v
	 GcOZaaogT1/AdG/Ta/74VaBdWfQTuSmE9m19Lc2KdftPzI3UhTsL2a5lcPAYwyYbeX
	 /+jjRvG/Gn7cTbAsbekNhI+krl6HCcOLb5Cr2f3PCOmhYEY7+I0aJ0aeCXwgNNxyNy
	 ojac90rDMb1fQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BBEDCCE22D7; Sun,  9 Jun 2024 10:03:35 -0700 (PDT)
Date: Sun, 9 Jun 2024 10:03:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <21a32cbb-d388-4a8c-9298-ef8c82330f9e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>
 <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>
 <alpine.DEB.2.22.394.2405272226510.3330@hadrien>
 <ZlXIDZLMNPc7E7XE@pc636>
 <2dd5bafb-ceb1-238d-2f51-83ebf135b73@inria.fr>
 <ZlXaPuA4lC2ANTdN@pc636>
 <2ec7eb0f-0950-4d65-b33a-64df7c5f89c9@paulmck-laptop>
 <77531e55-3418-d4be-f538-7ddc904ed88f@inria.fr>
 <Zl76AZ_0H5xb1cFl@pc638.lan>
 <alpine.DEB.2.22.394.2406091158420.3474@hadrien>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2406091158420.3474@hadrien>

On Sun, Jun 09, 2024 at 12:00:58PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 4 Jun 2024, Uladzislau Rezki wrote:
> 
> > On Fri, May 31, 2024 at 06:02:01PM +0200, Julia Lawall wrote:
> > > Here are the changes proposed by Coccinelle.
> > >
> > > I didn't succeed to compile the powerpc code, but the rest has been
> > > compile tested.
> > >
> > > julia
> > >
> > > commit 1881f31fe3ad693d07ecff45985dd0e87534923f
> > > Author: Julia Lawall <Julia.Lawall@inria.fr>
> > > Date:   Wed May 29 18:54:41 2024 +0200
> > >
> > >     misc
> > >
> > > diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
> > > index ce79ac33e8d3..d904e13e069b 100644
> > > --- a/arch/powerpc/kvm/book3s_mmu_hpte.c
> > > +++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
> > > @@ -92,12 +92,6 @@ void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
> > >  	spin_unlock(&vcpu3s->mmu_lock);
> > >  }
> > >
> > > -static void free_pte_rcu(struct rcu_head *head)
> > > -{
> > > -	struct hpte_cache *pte = container_of(head, struct hpte_cache, rcu_head);
> > > -	kmem_cache_free(hpte_cache, pte);
> > > -}
> > > -
> > >  static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
> > >  {
> > >  	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
> > > @@ -126,7 +120,7 @@ static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
> > >
> > >  	spin_unlock(&vcpu3s->mmu_lock);
> > >
> > > -	call_rcu(&pte->rcu_head, free_pte_rcu);
> > > +	kfree_rcu(pte, rcu_head);
> > >  }
> > >
> > >  static void kvmppc_mmu_pte_flush_all(struct kvm_vcpu *vcpu)
> > > diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> > > index 25dd4db11121..ce82770c72ab 100644
> > > --- a/block/blk-ioc.c
> > > +++ b/block/blk-ioc.c
> > > @@ -32,13 +32,6 @@ static void get_io_context(struct io_context *ioc)
> > >  	atomic_long_inc(&ioc->refcount);
> > >  }
> > >
> > > -static void icq_free_icq_rcu(struct rcu_head *head)
> > > -{
> > > -	struct io_cq *icq = container_of(head, struct io_cq, __rcu_head);
> > > -
> > > -	kmem_cache_free(icq->__rcu_icq_cache, icq);
> > > -}
> > > -
> > >  /*
> > >   * Exit an icq. Called with ioc locked for blk-mq, and with both ioc
> > >   * and queue locked for legacy.
> > > @@ -102,7 +95,7 @@ static void ioc_destroy_icq(struct io_cq *icq)
> > >  	 */
> > >  	icq->__rcu_icq_cache = et->icq_cache;
> > >  	icq->flags |= ICQ_DESTROYED;
> > > -	call_rcu(&icq->__rcu_head, icq_free_icq_rcu);
> > > +	kfree_rcu(icq, __rcu_head);
> > >  }
> > >
> > >  /*
> > > diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
> > > index 0ba714ca5185..e4e1638fce1b 100644
> > > --- a/drivers/net/wireguard/allowedips.c
> > > +++ b/drivers/net/wireguard/allowedips.c
> > > @@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
> > >  	}
> > >  }
> > >
> > > -static void node_free_rcu(struct rcu_head *rcu)
> > > -{
> > > -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
> > > -}
> > > -
> > >  static void root_free_rcu(struct rcu_head *rcu)
> > >  {
> > >  	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
> > > @@ -330,13 +325,13 @@ void wg_allowedips_remove_by_peer(struct allowedips *table,
> > >  			child = rcu_dereference_protected(
> > >  					parent->bit[!(node->parent_bit_packed & 1)],
> > >  					lockdep_is_held(lock));
> > > -		call_rcu(&node->rcu, node_free_rcu);
> > > +		kfree_rcu(node, rcu);
> > >  		if (!free_parent)
> > >  			continue;
> > >  		if (child)
> > >  			child->parent_bit_packed = parent->parent_bit_packed;
> > >  		*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
> > > -		call_rcu(&parent->rcu, node_free_rcu);
> > > +		kfree_rcu(parent, rcu);
> > >  	}
> > >  }
> > >
> > > diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
> > > index acaa0825e9bb..49d626ff33a9 100644
> > > --- a/fs/ecryptfs/dentry.c
> > > +++ b/fs/ecryptfs/dentry.c
> > > @@ -51,12 +51,6 @@ static int ecryptfs_d_revalidate(struct dentry *dentry, unsigned int flags)
> > >
> > >  struct kmem_cache *ecryptfs_dentry_info_cache;
> > >
> > > -static void ecryptfs_dentry_free_rcu(struct rcu_head *head)
> > > -{
> > > -	kmem_cache_free(ecryptfs_dentry_info_cache,
> > > -		container_of(head, struct ecryptfs_dentry_info, rcu));
> > > -}
> > > -
> > >  /**
> > >   * ecryptfs_d_release
> > >   * @dentry: The ecryptfs dentry
> > > @@ -68,7 +62,7 @@ static void ecryptfs_d_release(struct dentry *dentry)
> > >  	struct ecryptfs_dentry_info *p = dentry->d_fsdata;
> > >  	if (p) {
> > >  		path_put(&p->lower_path);
> > > -		call_rcu(&p->rcu, ecryptfs_dentry_free_rcu);
> > > +		kfree_rcu(p, rcu);
> > >  	}
> > >  }
> > >
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index a20c2c9d7d45..eba5083504c7 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -571,13 +571,6 @@ opaque_hashval(const void *ptr, int nbytes)
> > >  	return x;
> > >  }
> > >
> > > -static void nfsd4_free_file_rcu(struct rcu_head *rcu)
> > > -{
> > > -	struct nfs4_file *fp = container_of(rcu, struct nfs4_file, fi_rcu);
> > > -
> > > -	kmem_cache_free(file_slab, fp);
> > > -}
> > > -
> > >  void
> > >  put_nfs4_file(struct nfs4_file *fi)
> > >  {
> > > @@ -585,7 +578,7 @@ put_nfs4_file(struct nfs4_file *fi)
> > >  		nfsd4_file_hash_remove(fi);
> > >  		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
> > >  		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
> > > -		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
> > > +		kfree_rcu(fi, fi_rcu);
> > >  	}
> > >  }
> > >
> > > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > > index 7c29f4afc23d..338c52168e61 100644
> > > --- a/fs/tracefs/inode.c
> > > +++ b/fs/tracefs/inode.c
> > > @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
> > >  	return &ti->vfs_inode;
> > >  }
> > >
> > > -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
> > > -{
> > > -	struct tracefs_inode *ti;
> > > -
> > > -	ti = container_of(rcu, struct tracefs_inode, rcu);
> > > -	kmem_cache_free(tracefs_inode_cachep, ti);
> > > -}
> > > -
> > >  static void tracefs_free_inode(struct inode *inode)
> > >  {
> > >  	struct tracefs_inode *ti = get_tracefs(inode);
> > > @@ -70,7 +62,7 @@ static void tracefs_free_inode(struct inode *inode)
> > >  	list_del_rcu(&ti->list);
> > >  	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
> > >
> > > -	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
> > > +	kfree_rcu(ti, rcu);
> > >  }
> > >
> > >  static ssize_t default_read_file(struct file *file, char __user *buf,
> > > diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> > > index b924f0f096fa..bad5db979664 100644
> > > --- a/kernel/time/posix-timers.c
> > > +++ b/kernel/time/posix-timers.c
> > > @@ -412,18 +412,11 @@ static struct k_itimer * alloc_posix_timer(void)
> > >  	return tmr;
> > >  }
> > >
> > > -static void k_itimer_rcu_free(struct rcu_head *head)
> > > -{
> > > -	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
> > > -
> > > -	kmem_cache_free(posix_timers_cache, tmr);
> > > -}
> > > -
> > >  static void posix_timer_free(struct k_itimer *tmr)
> > >  {
> > >  	put_pid(tmr->it_pid);
> > >  	sigqueue_free(tmr->sigq);
> > > -	call_rcu(&tmr->rcu, k_itimer_rcu_free);
> > > +	kfree_rcu(tmr, rcu);
> > >  }
> > >
> > >  static void posix_timer_unhash_and_free(struct k_itimer *tmr)
> > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > index 003474c9a77d..367fc459cbd2 100644
> > > --- a/kernel/workqueue.c
> > > +++ b/kernel/workqueue.c
> > > @@ -5022,12 +5022,6 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
> > >  	return NULL;
> > >  }
> > >
> > > -static void rcu_free_pwq(struct rcu_head *rcu)
> > > -{
> > > -	kmem_cache_free(pwq_cache,
> > > -			container_of(rcu, struct pool_workqueue, rcu));
> > > -}
> > > -
> > >  /*
> > >   * Scheduled on pwq_release_worker by put_pwq() when an unbound pwq hits zero
> > >   * refcnt and needs to be destroyed.
> > > @@ -5073,7 +5067,7 @@ static void pwq_release_workfn(struct kthread_work *work)
> > >  		raw_spin_unlock_irq(&nna->lock);
> > >  	}
> > >
> > > -	call_rcu(&pwq->rcu, rcu_free_pwq);
> > > +	kfree_rcu(pwq, rcu);
> > >
> > >  	/*
> > >  	 * If we're the last pwq going away, @wq is already dead and no one
> > > diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> > > index c77591e63841..6d04b48f7e2c 100644
> > > --- a/net/bridge/br_fdb.c
> > > +++ b/net/bridge/br_fdb.c
> > > @@ -73,13 +73,6 @@ static inline int has_expired(const struct net_bridge *br,
> > >  	       time_before_eq(fdb->updated + hold_time(br), jiffies);
> > >  }
> > >
> > > -static void fdb_rcu_free(struct rcu_head *head)
> > > -{
> > > -	struct net_bridge_fdb_entry *ent
> > > -		= container_of(head, struct net_bridge_fdb_entry, rcu);
> > > -	kmem_cache_free(br_fdb_cache, ent);
> > > -}
> > > -
> > >  static int fdb_to_nud(const struct net_bridge *br,
> > >  		      const struct net_bridge_fdb_entry *fdb)
> > >  {
> > > @@ -329,7 +322,7 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
> > >  	if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &f->flags))
> > >  		atomic_dec(&br->fdb_n_learned);
> > >  	fdb_notify(br, f, RTM_DELNEIGH, swdev_notify);
> > > -	call_rcu(&f->rcu, fdb_rcu_free);
> > > +	kfree_rcu(f, rcu);
> > >  }
> > >
> > >  /* Delete a local entry if no other port had the same address.
> > > diff --git a/net/can/gw.c b/net/can/gw.c
> > > index 37528826935e..ffb9870e2d01 100644
> > > --- a/net/can/gw.c
> > > +++ b/net/can/gw.c
> > > @@ -577,13 +577,6 @@ static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
> > >  			  gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj);
> > >  }
> > >
> > > -static void cgw_job_free_rcu(struct rcu_head *rcu_head)
> > > -{
> > > -	struct cgw_job *gwj = container_of(rcu_head, struct cgw_job, rcu);
> > > -
> > > -	kmem_cache_free(cgw_cache, gwj);
> > > -}
> > > -
> > >  static int cgw_notifier(struct notifier_block *nb,
> > >  			unsigned long msg, void *ptr)
> > >  {
> > > @@ -603,7 +596,7 @@ static int cgw_notifier(struct notifier_block *nb,
> > >  			if (gwj->src.dev == dev || gwj->dst.dev == dev) {
> > >  				hlist_del(&gwj->list);
> > >  				cgw_unregister_filter(net, gwj);
> > > -				call_rcu(&gwj->rcu, cgw_job_free_rcu);
> > > +				kfree_rcu(gwj, rcu);
> > >  			}
> > >  		}
> > >  	}
> > > @@ -1168,7 +1161,7 @@ static void cgw_remove_all_jobs(struct net *net)
> > >  	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
> > >  		hlist_del(&gwj->list);
> > >  		cgw_unregister_filter(net, gwj);
> > > -		call_rcu(&gwj->rcu, cgw_job_free_rcu);
> > > +		kfree_rcu(gwj, rcu);
> > >  	}
> > >  }
> > >
> > > @@ -1236,7 +1229,7 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
> > >
> > >  		hlist_del(&gwj->list);
> > >  		cgw_unregister_filter(net, gwj);
> > > -		call_rcu(&gwj->rcu, cgw_job_free_rcu);
> > > +		kfree_rcu(gwj, rcu);
> > >  		err = 0;
> > >  		break;
> > >  	}
> > > diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> > > index f474106464d2..3ed92e583417 100644
> > > --- a/net/ipv4/fib_trie.c
> > > +++ b/net/ipv4/fib_trie.c
> > > @@ -292,15 +292,9 @@ static const int inflate_threshold = 50;
> > >  static const int halve_threshold_root = 15;
> > >  static const int inflate_threshold_root = 30;
> > >
> > > -static void __alias_free_mem(struct rcu_head *head)
> > > -{
> > > -	struct fib_alias *fa = container_of(head, struct fib_alias, rcu);
> > > -	kmem_cache_free(fn_alias_kmem, fa);
> > > -}
> > > -
> > >  static inline void alias_free_mem_rcu(struct fib_alias *fa)
> > >  {
> > > -	call_rcu(&fa->rcu, __alias_free_mem);
> > > +	kfree_rcu(fa, rcu);
> > >  }
> > >
> > >  #define TNODE_VMALLOC_MAX \
> > > diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
> > > index 5bd759963451..5ab56f4cb529 100644
> > > --- a/net/ipv4/inetpeer.c
> > > +++ b/net/ipv4/inetpeer.c
> > > @@ -128,11 +128,6 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
> > >  	return NULL;
> > >  }
> > >
> > > -static void inetpeer_free_rcu(struct rcu_head *head)
> > > -{
> > > -	kmem_cache_free(peer_cachep, container_of(head, struct inet_peer, rcu));
> > > -}
> > > -
> > >  /* perform garbage collect on all items stacked during a lookup */
> > >  static void inet_peer_gc(struct inet_peer_base *base,
> > >  			 struct inet_peer *gc_stack[],
> > > @@ -168,7 +163,7 @@ static void inet_peer_gc(struct inet_peer_base *base,
> > >  		if (p) {
> > >  			rb_erase(&p->rb_node, &base->rb_root);
> > >  			base->total--;
> > > -			call_rcu(&p->rcu, inetpeer_free_rcu);
> > > +			kfree_rcu(p, rcu);
> > >  		}
> > >  	}
> > >  }
> > > @@ -242,7 +237,7 @@ void inet_putpeer(struct inet_peer *p)
> > >  	WRITE_ONCE(p->dtime, (__u32)jiffies);
> > >
> > >  	if (refcount_dec_and_test(&p->refcnt))
> > > -		call_rcu(&p->rcu, inetpeer_free_rcu);
> > > +		kfree_rcu(p, rcu);
> > >  }
> > >  EXPORT_SYMBOL_GPL(inet_putpeer);
> > >
> > > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > > index 31d77885bcae..bafc49de270e 100644
> > > --- a/net/ipv6/ip6_fib.c
> > > +++ b/net/ipv6/ip6_fib.c
> > > @@ -198,16 +198,9 @@ static void node_free_immediate(struct net *net, struct fib6_node *fn)
> > >  	net->ipv6.rt6_stats->fib_nodes--;
> > >  }
> > >
> > > -static void node_free_rcu(struct rcu_head *head)
> > > -{
> > > -	struct fib6_node *fn = container_of(head, struct fib6_node, rcu);
> > > -
> > > -	kmem_cache_free(fib6_node_kmem, fn);
> > > -}
> > > -
> > >  static void node_free(struct net *net, struct fib6_node *fn)
> > >  {
> > > -	call_rcu(&fn->rcu, node_free_rcu);
> > > +	kfree_rcu(fn, rcu);
> > >  	net->ipv6.rt6_stats->fib_nodes--;
> > >  }
> > >
> > > diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
> > > index bf140ef781c1..c3c893ddb6ee 100644
> > > --- a/net/ipv6/xfrm6_tunnel.c
> > > +++ b/net/ipv6/xfrm6_tunnel.c
> > > @@ -178,12 +178,6 @@ __be32 xfrm6_tunnel_alloc_spi(struct net *net, xfrm_address_t *saddr)
> > >  }
> > >  EXPORT_SYMBOL(xfrm6_tunnel_alloc_spi);
> > >
> > > -static void x6spi_destroy_rcu(struct rcu_head *head)
> > > -{
> > > -	kmem_cache_free(xfrm6_tunnel_spi_kmem,
> > > -			container_of(head, struct xfrm6_tunnel_spi, rcu_head));
> > > -}
> > > -
> > >  static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
> > >  {
> > >  	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
> > > @@ -200,7 +194,7 @@ static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
> > >  			if (refcount_dec_and_test(&x6spi->refcnt)) {
> > >  				hlist_del_rcu(&x6spi->list_byaddr);
> > >  				hlist_del_rcu(&x6spi->list_byspi);
> > > -				call_rcu(&x6spi->rcu_head, x6spi_destroy_rcu);
> > > +				kfree_rcu(x6spi, rcu_head);
> > >  				break;
> > >  			}
> > >  		}
> > > diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> > > index 2f191e50d4fc..fbb730cd2d38 100644
> > > --- a/net/kcm/kcmsock.c
> > > +++ b/net/kcm/kcmsock.c
> > > @@ -1580,14 +1580,6 @@ static int kcm_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
> > >  	return err;
> > >  }
> > >
> > > -static void free_mux(struct rcu_head *rcu)
> > > -{
> > > -	struct kcm_mux *mux = container_of(rcu,
> > > -	    struct kcm_mux, rcu);
> > > -
> > > -	kmem_cache_free(kcm_muxp, mux);
> > > -}
> > > -
> > >  static void release_mux(struct kcm_mux *mux)
> > >  {
> > >  	struct kcm_net *knet = mux->knet;
> > > @@ -1615,7 +1607,7 @@ static void release_mux(struct kcm_mux *mux)
> > >  	knet->count--;
> > >  	mutex_unlock(&knet->mutex);
> > >
> > > -	call_rcu(&mux->rcu, free_mux);
> > > +	kfree_rcu(mux, rcu);
> > >  }
> > >
> > >  static void kcm_done(struct kcm_sock *kcm)
> > > diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
> > > index 8715617b02fe..587bfcb79723 100644
> > > --- a/net/netfilter/nf_conncount.c
> > > +++ b/net/netfilter/nf_conncount.c
> > > @@ -275,14 +275,6 @@ bool nf_conncount_gc_list(struct net *net,
> > >  }
> > >  EXPORT_SYMBOL_GPL(nf_conncount_gc_list);
> > >
> > > -static void __tree_nodes_free(struct rcu_head *h)
> > > -{
> > > -	struct nf_conncount_rb *rbconn;
> > > -
> > > -	rbconn = container_of(h, struct nf_conncount_rb, rcu_head);
> > > -	kmem_cache_free(conncount_rb_cachep, rbconn);
> > > -}
> > > -
> > >  /* caller must hold tree nf_conncount_locks[] lock */
> > >  static void tree_nodes_free(struct rb_root *root,
> > >  			    struct nf_conncount_rb *gc_nodes[],
> > > @@ -295,7 +287,7 @@ static void tree_nodes_free(struct rb_root *root,
> > >  		spin_lock(&rbconn->list.list_lock);
> > >  		if (!rbconn->list.count) {
> > >  			rb_erase(&rbconn->node, root);
> > > -			call_rcu(&rbconn->rcu_head, __tree_nodes_free);
> > > +			kfree_rcu(rbconn, rcu_head);
> > >  		}
> > >  		spin_unlock(&rbconn->list.list_lock);
> > >  	}
> > > diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
> > > index 21fa550966f0..9dcaef6f3663 100644
> > > --- a/net/netfilter/nf_conntrack_expect.c
> > > +++ b/net/netfilter/nf_conntrack_expect.c
> > > @@ -367,18 +367,10 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
> > >  }
> > >  EXPORT_SYMBOL_GPL(nf_ct_expect_init);
> > >
> > > -static void nf_ct_expect_free_rcu(struct rcu_head *head)
> > > -{
> > > -	struct nf_conntrack_expect *exp;
> > > -
> > > -	exp = container_of(head, struct nf_conntrack_expect, rcu);
> > > -	kmem_cache_free(nf_ct_expect_cachep, exp);
> > > -}
> > > -
> > >  void nf_ct_expect_put(struct nf_conntrack_expect *exp)
> > >  {
> > >  	if (refcount_dec_and_test(&exp->use))
> > > -		call_rcu(&exp->rcu, nf_ct_expect_free_rcu);
> > > +		kfree_rcu(exp, rcu);
> > >  }
> > >  EXPORT_SYMBOL_GPL(nf_ct_expect_put);
> > >
> > > diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
> > > index 0859b8f76764..c2b9b954eb53 100644
> > > --- a/net/netfilter/xt_hashlimit.c
> > > +++ b/net/netfilter/xt_hashlimit.c
> > > @@ -256,18 +256,11 @@ dsthash_alloc_init(struct xt_hashlimit_htable *ht,
> > >  	return ent;
> > >  }
> > >
> > > -static void dsthash_free_rcu(struct rcu_head *head)
> > > -{
> > > -	struct dsthash_ent *ent = container_of(head, struct dsthash_ent, rcu);
> > > -
> > > -	kmem_cache_free(hashlimit_cachep, ent);
> > > -}
> > > -
> > >  static inline void
> > >  dsthash_free(struct xt_hashlimit_htable *ht, struct dsthash_ent *ent)
> > >  {
> > >  	hlist_del_rcu(&ent->node);
> > > -	call_rcu(&ent->rcu, dsthash_free_rcu);
> > > +	kfree_rcu(ent, rcu);
> > >  	ht->count--;
> > >  }
> > >  static void htable_gc(struct work_struct *work);
> > Looks good. What is about extra below useres:
> >
> > lima_sched.c
> > ipmr.c
> > ip6mr.c
> >
> > <snip>
> > diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> > index bbf3f8feab94..21ec6fbe732e 100644
> > --- a/drivers/gpu/drm/lima/lima_sched.c
> > +++ b/drivers/gpu/drm/lima/lima_sched.c
> > @@ -64,19 +64,11 @@ static const char *lima_fence_get_timeline_name(struct dma_fence *fence)
> >  	return f->pipe->base.name;
> >  }
> >
> > -static void lima_fence_release_rcu(struct rcu_head *rcu)
> > -{
> > -	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> > -	struct lima_fence *fence = to_lima_fence(f);
> > -
> > -	kmem_cache_free(lima_fence_slab, fence);
> > -}
> > -
> >  static void lima_fence_release(struct dma_fence *fence)
> >  {
> >  	struct lima_fence *f = to_lima_fence(fence);
> >
> > -	call_rcu(&f->base.rcu, lima_fence_release_rcu);
> > +	kfree_rcu(f, base.rcu);
> >  }
> >
> >  static const struct dma_fence_ops lima_fence_ops = {
> > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > index 6c750bd13dd8..7a9496e51dc8 100644
> > --- a/net/ipv4/ipmr.c
> > +++ b/net/ipv4/ipmr.c
> > @@ -711,7 +711,7 @@ static void ipmr_cache_free_rcu(struct rcu_head *head)
> >
> >  static void ipmr_cache_free(struct mfc_cache *c)
> >  {
> > -	call_rcu(&c->_c.rcu, ipmr_cache_free_rcu);
> > +	kfree_rcu(c, _c.rcu);
> >  }
> >
> >  /* Destroy an unresolved cache entry, killing queued skbs
> > diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> > index dd342e6ecf3f..c236f2d0c88f 100644
> > --- a/net/ipv6/ip6mr.c
> > +++ b/net/ipv6/ip6mr.c
> > @@ -762,7 +762,7 @@ static inline void ip6mr_cache_free_rcu(struct rcu_head *head)
> >
> >  static inline void ip6mr_cache_free(struct mfc6_cache *c)
> >  {
> > -	call_rcu(&c->_c.rcu, ip6mr_cache_free_rcu);
> > +	kfree_rcu(c, _c.rcu);
> >  }
> >
> >  /* Destroy an unresolved cache entry, killing queued skbs
> > <snip>
> >
> > ?
> 
> These look ok to me.  In the last two cases, the callback function is also
> stored in a data structure, eg:
> 
> static struct mfc6_cache *ip6mr_cache_alloc(void)
> {
> 	struct mfc6_cache *c = kmem_cache_zalloc(mrt_cachep, GFP_KERNEL);
> 	if (!c)
> 		return NULL;
> 	c->_c.mfc_un.res.last_assert = jiffies - MFC_ASSERT_THRESH - 1;
> 	c->_c.mfc_un.res.minvif = MAXMIFS;
> 	c->_c.free = ip6mr_cache_free_rcu;
> 	refcount_set(&c->_c.mfc_un.res.refcount, 1);
> 	return c;
> }
> 
> Should that be left as it is?

Given that ->_c.free isn't used in the RCU callback, I am guessing that
this is intended for debugging purposes, so that you can see from a crash
dump how this will be freed.  But I could be completely off-base here.

One approach would be to remove the ->_c.free field and call attention
to this in the patches' commit logs.

Another would be to instead put the address of the allocation function
in ->_c.free, and again call attention to this in the commit logs.

Is there a better approach than these three?  ;-)

							Thanx, Paul
