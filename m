Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920EFC433FE
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 20:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58768239D1
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 20:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbgLIUFD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbgLIUFC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 15:05:02 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C303C0613CF;
        Wed,  9 Dec 2020 12:04:22 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y22so3888111ljn.9;
        Wed, 09 Dec 2020 12:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jThNqa4kYRCZdjnOkpYIJI1VUK4ZX4r0JpcMOpJzikc=;
        b=Sp8Zy1Cf6jXe0X3fbl+7IviHFDqEKuqftvqFSshE3LKkNi58+X+wAqVfyxR66/Cuoz
         T0i78NoHMaB47cj/79lOGGccZZLkFLDpxdkjj6+Jzf+jVlJKU+8y2FLFtu9hxeyBZg4+
         Q+axKuCY2F2aDmBA2o+GxutDBTvRmoF9kjO6LYDUQ2tNR5jNDGbV7PLymLCVOG3W38MK
         NiahQqFHN04F1AII6nbnXt3i8kVyqH33O5V+jr13tAHKPeg6S4oiAYhCWDdQQd4VbWZD
         fvNwA62J5vg3VrlptWx5DwjEKZCCW2ob84srgFyLA6efd24UxIpZtglhbGyvJTqN6JuR
         +CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jThNqa4kYRCZdjnOkpYIJI1VUK4ZX4r0JpcMOpJzikc=;
        b=YukZbJ1Oxo0vbT5/LOb5wE/PGSwyrsrankdmhoqmaaBmnDHLRc2GTKqAs7M+QOp3N1
         qe/dqPlt+faGo3hgANPLQHzifXALQrdGxstX75yNDDbwnTh4do7+4ydgbCDcJodmq+ln
         11RTVPSUSXYD7BhIl9m7TH5rLCtsjFOjeRRVygJdqs09U7fyyyrAXdlUuJk+wmQEZ//e
         kW73+dHADV4exp/u4JL4NqN3WjzNbthunhBS9ToCN0Tsi06vnviqzY0cEJW1puHlH0mT
         ZWIOOjJOJdVvzX9Z+i0yc2cygpTeRIb66XDnySI53uMmN+4J9JwC1qAqx7LrNtH8rQJU
         NxYw==
X-Gm-Message-State: AOAM53075yNVI7ok8djNhm8pLSQmQFk1MSW8dow3N75nnNKz/dTmrxMj
        EM63wWJ1QewvLU3T+9IRMH/4OtgvmIPT0g==
X-Google-Smtp-Source: ABdhPJyVhJpaEzrzJ+F34jwVDRJU2akMg6kiuTVDHVbcBAfVXyDYvM+2uYUpXdd9YmZdb68Gx3NNxw==
X-Received: by 2002:a2e:b0d8:: with SMTP id g24mr1722701ljl.351.1607544260980;
        Wed, 09 Dec 2020 12:04:20 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id a15sm272131lfo.299.2020.12.09.12.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:04:19 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 9 Dec 2020 21:04:17 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 3/5] mm: Make mem_dump_obj() handle vmalloc()
 memory
Message-ID: <20201209200417.GA5804@pc638.lan>
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-3-paulmck@kernel.org>
 <20201209193637.GA5757@pc638.lan>
 <20201209194239.GG2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209194239.GG2657@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 11:42:39AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 09, 2020 at 08:36:37PM +0100, Uladzislau Rezki wrote:
> > On Tue, Dec 08, 2020 at 05:13:01PM -0800, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > This commit adds vmalloc() support to mem_dump_obj().  Note that the
> > > vmalloc_dump_obj() function combines the checking and dumping, in
> > > contrast with the split between kmem_valid_obj() and kmem_dump_obj().
> > > The reason for the difference is that the checking in the vmalloc()
> > > case involves acquiring a global lock, and redundant acquisitions of
> > > global locks should be avoided, even on not-so-fast paths.
> > > 
> > > Note that this change causes on-stack variables to be reported as
> > > vmalloc() storage from kernel_clone() or similar, depending on the degree
> > > of inlining that your compiler does.  This is likely more helpful than
> > > the earlier "non-paged (local) memory".
> > > 
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > Cc: <linux-mm@kvack.org>
> > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  include/linux/vmalloc.h |  6 ++++++
> > >  mm/util.c               | 12 +++++++-----
> > >  mm/vmalloc.c            | 12 ++++++++++++
> > >  3 files changed, 25 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > > index 938eaf9..c89c2be 100644
> > > --- a/include/linux/vmalloc.h
> > > +++ b/include/linux/vmalloc.h
> > > @@ -248,4 +248,10 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> > >  int register_vmap_purge_notifier(struct notifier_block *nb);
> > >  int unregister_vmap_purge_notifier(struct notifier_block *nb);
> > >  
> > > +#ifdef CONFIG_MMU
> > > +bool vmalloc_dump_obj(void *object);
> > > +#else
> > > +static inline bool vmalloc_dump_obj(void *object) { return false; }
> > > +#endif
> > > +
> > >  #endif /* _LINUX_VMALLOC_H */
> > > diff --git a/mm/util.c b/mm/util.c
> > > index 8c2449f..ee99a0a 100644
> > > --- a/mm/util.c
> > > +++ b/mm/util.c
> > > @@ -984,6 +984,12 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
> > >   */
> > >  void mem_dump_obj(void *object)
> > >  {
> > > +	if (kmem_valid_obj(object)) {
> > > +		kmem_dump_obj(object);
> > > +		return;
> > > +	}
> > > +	if (vmalloc_dump_obj(object))
> > > +		return;
> > >  	if (!virt_addr_valid(object)) {
> > >  		if (object == NULL)
> > >  			pr_cont(" NULL pointer.\n");
> > > @@ -993,10 +999,6 @@ void mem_dump_obj(void *object)
> > >  			pr_cont(" non-paged (local) memory.\n");
> > >  		return;
> > >  	}
> > > -	if (kmem_valid_obj(object)) {
> > > -		kmem_dump_obj(object);
> > > -		return;
> > > -	}
> > > -	pr_cont(" non-slab memory.\n");
> > > +	pr_cont(" non-slab/vmalloc memory.\n");
> > >  }
> > >  EXPORT_SYMBOL_GPL(mem_dump_obj);
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 6ae491a..7421719 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3431,6 +3431,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> > >  }
> > >  #endif	/* CONFIG_SMP */
> > >  
> > > +bool vmalloc_dump_obj(void *object)
> > > +{
> > > +	struct vm_struct *vm;
> > > +	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > >
> > Paul, vmalloced addresses are already aligned to PAGE_SIZE, so that one
> > is odd.
> 
> They are, but this is to handle things like this:
> 
> 	struct foo {
> 		int a;
> 		struct rcu_head rh;
> 	};
> 
> 	void silly(struct foo *fp)
> 	{
> 		call_rcu(&fp->rh, my_rcu_cb);
> 		call_rcu(&fp->rh, my_other_rcu_cb);
> 	}
> 
> In kernels built with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, this would
> result in a call to mem_dump_obj() and then to vmalloc_dump_obj()
> with a non-page-aligned pointer.
> 
OK, i got it. I thought the functions deals with original vmalloc
pointer. In fact it is not :)

--
Vlad Rezki
