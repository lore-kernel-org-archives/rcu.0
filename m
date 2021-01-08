Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E38EC433DB
	for <rcu@archiver.kernel.org>; Fri,  8 Jan 2021 15:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C689F23888
	for <rcu@archiver.kernel.org>; Fri,  8 Jan 2021 15:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbhAHPgo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Jan 2021 10:36:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:54714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbhAHPgo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Jan 2021 10:36:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A8CAACC6;
        Fri,  8 Jan 2021 15:36:01 +0000 (UTC)
Subject: Re: [PATCH v4 sl-b 0/6] Export return addresses etc. for better
 diagnostics
To:     paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, ming.lei@redhat.com,
        axboe@kernel.dk, kernel-team@fb.com
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
 <20210106134843.ed8e298da92d4fe93b6aa259@linux-foundation.org>
 <20210106234212.GA20560@paulmck-ThinkPad-P72>
 <20210108002657.GA21084@paulmck-ThinkPad-P72>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3673d778-163d-15e5-5774-1651926991f6@suse.cz>
Date:   Fri, 8 Jan 2021 16:35:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108002657.GA21084@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 1/8/21 1:26 AM, Paul E. McKenney wrote:
> On Wed, Jan 06, 2021 at 03:42:12PM -0800, Paul E. McKenney wrote:
>> On Wed, Jan 06, 2021 at 01:48:43PM -0800, Andrew Morton wrote:
>> > On Tue, 5 Jan 2021 17:16:03 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> > 
>> > > This is v4 of the series the improves diagnostics by providing access
>> > > to additional information including the return addresses, slab names,
>> > > offsets, and sizes collected by the sl*b allocators and by vmalloc().
>> > 
>> > Looks reasonable.  And not as bloaty as I feared, but it does add ~300
>> > bytes to my allnoconfig build.  Is the CONFIG_ coverage as tight as it
>> > could be?
>> 
>> Glad I managed to exceed your expectations.  ;-)
>> 
>> Let's see...  When I do an allnoconfig build, it has CONFIG_PRINTK=n.
>> Given that this facility is based on printk(), I could create an
>> additional patch that #ifdef'ed everything out in CONFIG_PRINTK=n kernels.
>> This would uglify things a bit, but it would save ~300 bytes.
>> 
>> If I don't hear otherwise from you, I will put something together,
>> test it, and send it along.
> 
> And is a first draft, very lightly tested.  Thoughts?

Looks ok, but I'm not sure it's worth the trouble, there's probably tons of
other code that could be treated like this and nobody is doing that
systematically (at least I haven't heard about kernel tinyfication effort for
years)... Up to Andrew I guess.

Thanks,
Vlastimil

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 4164efdca255093a423b55f44bd788b46d9c648f
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Jan 7 13:46:11 2021 -0800
> 
>     mm: Don't build mm_dump_obj() on CONFIG_PRINTK=n kernels
>     
>     The mem_dump_obj() functionality adds a few hundred bytes, which is a
>     small price to pay.  Except on kernels built with CONFIG_PRINTK=n, in
>     which mem_dump_obj() messages will be suppressed.  This commit therefore
>     makes mem_dump_obj() be a static inline empty function on kernels built
>     with CONFIG_PRINTK=n and excludes all of its support functions as well.
>     This avoids kernel bloat on systems that cannot use mem_dump_obj().
>     
>     Cc: Christoph Lameter <cl@linux.com>
>     Cc: Pekka Enberg <penberg@kernel.org>
>     Cc: David Rientjes <rientjes@google.com>
>     Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>     Cc: <linux-mm@kvack.org>
>     Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index af7d050..ed75a3a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3169,7 +3169,11 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
>  
>  extern int sysctl_nr_trim_pages;
>  
> +#ifdef CONFIG_PRINTK
>  void mem_dump_obj(void *object);
> +#else
> +static inline void mem_dump_obj(void *object) {}
> +#endif
>  
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_MM_H */
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 7ae6040..0c97d78 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -186,8 +186,10 @@ void kfree(const void *);
>  void kfree_sensitive(const void *);
>  size_t __ksize(const void *);
>  size_t ksize(const void *);
> +#ifdef CONFIG_PRINTK
>  bool kmem_valid_obj(void *object);
>  void kmem_dump_obj(void *object);
> +#endif
>  
>  #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
>  void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index c18f475..3c8a765 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -246,7 +246,7 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  int register_vmap_purge_notifier(struct notifier_block *nb);
>  int unregister_vmap_purge_notifier(struct notifier_block *nb);
>  
> -#ifdef CONFIG_MMU
> +#if defined(CONFIG_MMU) && defined(CONFIG_PRINTK)
>  bool vmalloc_dump_obj(void *object);
>  #else
>  static inline bool vmalloc_dump_obj(void *object) { return false; }
> diff --git a/mm/slab.c b/mm/slab.c
> index dcc55e7..965d277 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3635,6 +3635,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
>  EXPORT_SYMBOL(__kmalloc_node_track_caller);
>  #endif /* CONFIG_NUMA */
>  
> +#ifdef CONFIG_PRINTK
>  void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>  {
>  	struct kmem_cache *cachep;
> @@ -3654,6 +3655,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>  	if (DEBUG && cachep->flags & SLAB_STORE_USER)
>  		kpp->kp_ret = *dbg_userword(cachep, objp);
>  }
> +#endif
>  
>  /**
>   * __do_kmalloc - allocate memory
> diff --git a/mm/slab.h b/mm/slab.h
> index ecad9b5..d2e39ab 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -615,6 +615,7 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
>  	return false;
>  }
>  
> +#ifdef CONFIG_PRINTK
>  #define KS_ADDRS_COUNT 16
>  struct kmem_obj_info {
>  	void *kp_ptr;
> @@ -626,5 +627,6 @@ struct kmem_obj_info {
>  	void *kp_stack[KS_ADDRS_COUNT];
>  };
>  void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page);
> +#endif
>  
>  #endif /* MM_SLAB_H */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b594413..20b2cc6 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -537,6 +537,7 @@ bool slab_is_available(void)
>  	return slab_state >= UP;
>  }
>  
> +#ifdef CONFIG_PRINTK
>  /**
>   * kmem_valid_obj - does the pointer reference a valid slab object?
>   * @object: pointer to query.
> @@ -610,6 +611,7 @@ void kmem_dump_obj(void *object)
>  		pr_info("    %pS\n", kp.kp_stack[i]);
>  	}
>  }
> +#endif
>  
>  #ifndef CONFIG_SLOB
>  /* Create a cache during boot when no slab services are available yet */
> diff --git a/mm/slob.c b/mm/slob.c
> index ef87ada..8726931 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -461,11 +461,13 @@ static void slob_free(void *block, int size)
>  	spin_unlock_irqrestore(&slob_lock, flags);
>  }
>  
> +#ifdef CONFIG_PRINTK
>  void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>  {
>  	kpp->kp_ptr = object;
>  	kpp->kp_page = page;
>  }
> +#endif
>  
>  /*
>   * End of slob allocator proper. Begin kmem_cache_alloc and kmalloc frontend.
> diff --git a/mm/slub.c b/mm/slub.c
> index 3c1a843..9e205e4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3919,6 +3919,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PRINTK
>  void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>  {
>  	void *base;
> @@ -3958,6 +3959,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>  #endif
>  #endif
>  }
> +#endif
>  
>  /********************************************************************
>   *		Kmalloc subsystem
> diff --git a/mm/util.c b/mm/util.c
> index 5487022..2d497fe 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -983,6 +983,7 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PRINTK
>  /**
>   * mem_dump_obj - Print available provenance information
>   * @object: object for which to find provenance information.
> @@ -1013,3 +1014,4 @@ void mem_dump_obj(void *object)
>  	}
>  	pr_cont(" non-slab/vmalloc memory.\n");
>  }
> +#endif
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e3229ff..5002fd6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3448,6 +3448,7 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  }
>  #endif	/* CONFIG_SMP */
>  
> +#ifdef CONFIG_PRINTK
>  bool vmalloc_dump_obj(void *object)
>  {
>  	struct vm_struct *vm;
> @@ -3460,6 +3461,7 @@ bool vmalloc_dump_obj(void *object)
>  		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
>  	return true;
>  }
> +#endif
>  
>  #ifdef CONFIG_PROC_FS
>  static void *s_start(struct seq_file *m, loff_t *pos)
> 

