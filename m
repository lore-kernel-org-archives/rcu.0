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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187E1C19425
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEE523C91
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 19:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgLIThY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbgLIThW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 14:37:22 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7BFC0613CF;
        Wed,  9 Dec 2020 11:36:41 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so4757997lfg.0;
        Wed, 09 Dec 2020 11:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jH8OAw8LOFPt4TBxe6UIavXjQgmgainyU9Gu6QLTrig=;
        b=hb8Lr9Yx4FJ/a+SiBXO8oYZ1m2D0teBFqYcwE5wF9/4sMBUlqxKy4aVmU4JW4wvCNx
         /MyFbrAFFPIZd5rr10DcE2+t+9pfz1EXvllvsTmgItnvzRK4LSavxLSWD55uR0nENhDk
         x2Pfu+SoMW+pk+aIX8yEmeu5d2s7urXul+KiXDU2oJmZ7sMbHi8sxDhFeaQoglmAq0Vz
         W1+gGJnKy4g+qf8bnnpkal1nlAoj8lmUtwaJmz23o611lvCjw5zNyjLafZXRgPyKv2qs
         1VqyDPS/n/+dwDZwuGkHnxuBMUPOdckWlR1/4QqA/Ndzw/0KQOOC15Ydo43sfZbmsEYA
         +efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jH8OAw8LOFPt4TBxe6UIavXjQgmgainyU9Gu6QLTrig=;
        b=YjEdSclnfEKAZCwWXhvKajpN0JvF74Gd7KHQhzUHvoz0UyTuis3CuyQWaSVNI3w4Uw
         y71C5zXyzmDiBRYRu6jcuytjKFNP/vq4A4gT5ZcaRdao9HdF0t3pLVW6JzphGxHMGx+9
         gWJG9eJmBipITta44ILdCiLiAGQ6I8Ew8cBkC6+HIy6V/SFelyc0tO2AbBx88sAmR3Un
         ghHCtzNnJvJF/b0E1kK/CxP8asId+t71HZU5IObuVv0nZ6eEFZ1SQOFG+Ue3knhv/l6G
         r3oWKcwS0VBPQgASxCcJGHp8HdQ/oxwvTi/F3Gl/oH4WE4CoO2sP4Aq/IjHRfEFsS5fd
         brhQ==
X-Gm-Message-State: AOAM533NXTctC71yD+UPFhTzaz/UGL5evL4Zx+yeZl4nixZ0KBihYyNM
        654MdbH3hvrI6HsBEEoPXhs=
X-Google-Smtp-Source: ABdhPJwD0jJ9vjUSqq3WubuwfRikcevWsrxGJZH7no9Hfhbtk7jPSvjE+PijSgnWRvaBMZvC7s3evQ==
X-Received: by 2002:ac2:5f63:: with SMTP id c3mr1355372lfc.451.1607542600079;
        Wed, 09 Dec 2020 11:36:40 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u11sm267162lfq.142.2020.12.09.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:36:39 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 9 Dec 2020 20:36:37 +0100
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        iamjoonsoo.kim@lge.com, andrii@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 3/5] mm: Make mem_dump_obj() handle vmalloc()
 memory
Message-ID: <20201209193637.GA5757@pc638.lan>
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209011303.32737-3-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 08, 2020 at 05:13:01PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds vmalloc() support to mem_dump_obj().  Note that the
> vmalloc_dump_obj() function combines the checking and dumping, in
> contrast with the split between kmem_valid_obj() and kmem_dump_obj().
> The reason for the difference is that the checking in the vmalloc()
> case involves acquiring a global lock, and redundant acquisitions of
> global locks should be avoided, even on not-so-fast paths.
> 
> Note that this change causes on-stack variables to be reported as
> vmalloc() storage from kernel_clone() or similar, depending on the degree
> of inlining that your compiler does.  This is likely more helpful than
> the earlier "non-paged (local) memory".
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: <linux-mm@kvack.org>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/vmalloc.h |  6 ++++++
>  mm/util.c               | 12 +++++++-----
>  mm/vmalloc.c            | 12 ++++++++++++
>  3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 938eaf9..c89c2be 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -248,4 +248,10 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  int register_vmap_purge_notifier(struct notifier_block *nb);
>  int unregister_vmap_purge_notifier(struct notifier_block *nb);
>  
> +#ifdef CONFIG_MMU
> +bool vmalloc_dump_obj(void *object);
> +#else
> +static inline bool vmalloc_dump_obj(void *object) { return false; }
> +#endif
> +
>  #endif /* _LINUX_VMALLOC_H */
> diff --git a/mm/util.c b/mm/util.c
> index 8c2449f..ee99a0a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -984,6 +984,12 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
>   */
>  void mem_dump_obj(void *object)
>  {
> +	if (kmem_valid_obj(object)) {
> +		kmem_dump_obj(object);
> +		return;
> +	}
> +	if (vmalloc_dump_obj(object))
> +		return;
>  	if (!virt_addr_valid(object)) {
>  		if (object == NULL)
>  			pr_cont(" NULL pointer.\n");
> @@ -993,10 +999,6 @@ void mem_dump_obj(void *object)
>  			pr_cont(" non-paged (local) memory.\n");
>  		return;
>  	}
> -	if (kmem_valid_obj(object)) {
> -		kmem_dump_obj(object);
> -		return;
> -	}
> -	pr_cont(" non-slab memory.\n");
> +	pr_cont(" non-slab/vmalloc memory.\n");
>  }
>  EXPORT_SYMBOL_GPL(mem_dump_obj);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6ae491a..7421719 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3431,6 +3431,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  }
>  #endif	/* CONFIG_SMP */
>  
> +bool vmalloc_dump_obj(void *object)
> +{
> +	struct vm_struct *vm;
> +	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>
Paul, vmalloced addresses are already aligned to PAGE_SIZE, so that one
is odd.

--
Vlad Rezki
