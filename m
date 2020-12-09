Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D078C4361B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2E323C8F
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 19:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbgLITn1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387873AbgLITnU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 14:43:20 -0500
Date:   Wed, 9 Dec 2020 11:42:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607542959;
        bh=7iFrWD0GhmOKVrp+RF5EBq1l/SLFCT+Au3bEhC/pRSI=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UvOkcEgozn0thI74AugbRWokEZTllnGGBrbwwzK1pmmzcLCKqDaQOnYJla+yoP6Zn
         VgeAcUqfMrbPfD46Hpbvjs1PkH3n4QrX2mQldkwUpz4CUAa4OhFiD8+gCiyo/GmNxQ
         1tglt2/y1p6r0716vWmOD9wvjkgeSK2q+8zOQMnozQT68rOdceDJd0xeeZE2BG8VxH
         8XQHryZ7rKa98xzsQBFq4WraG2DoYNzvxMWB/tXsmrlBertJyaQsghZJQWrP3ncnVv
         o88inUcpP/LNIDk22Y7ymCYzd20aOCPApHL68iG98u2IdCQhmuC2BvFGJK4PpQitrW
         mvf3bhRt6TquA==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        iamjoonsoo.kim@lge.com, andrii@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 3/5] mm: Make mem_dump_obj() handle vmalloc()
 memory
Message-ID: <20201209194239.GG2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-3-paulmck@kernel.org>
 <20201209193637.GA5757@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209193637.GA5757@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 08:36:37PM +0100, Uladzislau Rezki wrote:
> On Tue, Dec 08, 2020 at 05:13:01PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds vmalloc() support to mem_dump_obj().  Note that the
> > vmalloc_dump_obj() function combines the checking and dumping, in
> > contrast with the split between kmem_valid_obj() and kmem_dump_obj().
> > The reason for the difference is that the checking in the vmalloc()
> > case involves acquiring a global lock, and redundant acquisitions of
> > global locks should be avoided, even on not-so-fast paths.
> > 
> > Note that this change causes on-stack variables to be reported as
> > vmalloc() storage from kernel_clone() or similar, depending on the degree
> > of inlining that your compiler does.  This is likely more helpful than
> > the earlier "non-paged (local) memory".
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: <linux-mm@kvack.org>
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  include/linux/vmalloc.h |  6 ++++++
> >  mm/util.c               | 12 +++++++-----
> >  mm/vmalloc.c            | 12 ++++++++++++
> >  3 files changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 938eaf9..c89c2be 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -248,4 +248,10 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> >  int register_vmap_purge_notifier(struct notifier_block *nb);
> >  int unregister_vmap_purge_notifier(struct notifier_block *nb);
> >  
> > +#ifdef CONFIG_MMU
> > +bool vmalloc_dump_obj(void *object);
> > +#else
> > +static inline bool vmalloc_dump_obj(void *object) { return false; }
> > +#endif
> > +
> >  #endif /* _LINUX_VMALLOC_H */
> > diff --git a/mm/util.c b/mm/util.c
> > index 8c2449f..ee99a0a 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -984,6 +984,12 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
> >   */
> >  void mem_dump_obj(void *object)
> >  {
> > +	if (kmem_valid_obj(object)) {
> > +		kmem_dump_obj(object);
> > +		return;
> > +	}
> > +	if (vmalloc_dump_obj(object))
> > +		return;
> >  	if (!virt_addr_valid(object)) {
> >  		if (object == NULL)
> >  			pr_cont(" NULL pointer.\n");
> > @@ -993,10 +999,6 @@ void mem_dump_obj(void *object)
> >  			pr_cont(" non-paged (local) memory.\n");
> >  		return;
> >  	}
> > -	if (kmem_valid_obj(object)) {
> > -		kmem_dump_obj(object);
> > -		return;
> > -	}
> > -	pr_cont(" non-slab memory.\n");
> > +	pr_cont(" non-slab/vmalloc memory.\n");
> >  }
> >  EXPORT_SYMBOL_GPL(mem_dump_obj);
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 6ae491a..7421719 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3431,6 +3431,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> >  }
> >  #endif	/* CONFIG_SMP */
> >  
> > +bool vmalloc_dump_obj(void *object)
> > +{
> > +	struct vm_struct *vm;
> > +	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> >
> Paul, vmalloced addresses are already aligned to PAGE_SIZE, so that one
> is odd.

They are, but this is to handle things like this:

	struct foo {
		int a;
		struct rcu_head rh;
	};

	void silly(struct foo *fp)
	{
		call_rcu(&fp->rh, my_rcu_cb);
		call_rcu(&fp->rh, my_other_rcu_cb);
	}

In kernels built with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, this would
result in a call to mem_dump_obj() and then to vmalloc_dump_obj()
with a non-page-aligned pointer.

							Thanx, Paul
