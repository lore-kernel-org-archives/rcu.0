Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D1C4361B
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 11:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BFF23D56
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 11:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgLJLka (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 06:40:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:59554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgLJLk3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 06:40:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E9E4AD75;
        Thu, 10 Dec 2020 11:39:45 +0000 (UTC)
Subject: Re: [PATCH v2 sl-b 3/5] mm: Make mem_dump_obj() handle vmalloc()
 memory
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        iamjoonsoo.kim@lge.com, andrii@kernel.org, linux-mm@kvack.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-3-paulmck@kernel.org>
 <1c25ca09-ec43-df31-a5ba-476397637a53@suse.cz>
 <20201209232310.GI2657@paulmck-ThinkPad-P72>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <576aa539-5f07-97b3-dd3a-8fe6aac5da99@suse.cz>
Date:   Thu, 10 Dec 2020 11:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209232310.GI2657@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 12/10/20 12:23 AM, Paul E. McKenney wrote:
> On Wed, Dec 09, 2020 at 06:51:20PM +0100, Vlastimil Babka wrote:
>> On 12/9/20 2:13 AM, paulmck@kernel.org wrote:
>> > From: "Paul E. McKenney" <paulmck@kernel.org>
>> > 
>> > This commit adds vmalloc() support to mem_dump_obj().  Note that the
>> > vmalloc_dump_obj() function combines the checking and dumping, in
>> > contrast with the split between kmem_valid_obj() and kmem_dump_obj().
>> > The reason for the difference is that the checking in the vmalloc()
>> > case involves acquiring a global lock, and redundant acquisitions of
>> > global locks should be avoided, even on not-so-fast paths.
>> > 
>> > Note that this change causes on-stack variables to be reported as
>> > vmalloc() storage from kernel_clone() or similar, depending on the degree
>> > of inlining that your compiler does.  This is likely more helpful than
>> > the earlier "non-paged (local) memory".
>> > 
>> > Cc: Andrew Morton <akpm@linux-foundation.org>
>> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> > Cc: <linux-mm@kvack.org>
>> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
>> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> 
>> ...
>> 
>> > --- a/mm/vmalloc.c
>> > +++ b/mm/vmalloc.c
>> > @@ -3431,6 +3431,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>> >  }
>> >  #endif	/* CONFIG_SMP */
>> >  
>> > +bool vmalloc_dump_obj(void *object)
>> > +{
>> > +	struct vm_struct *vm;
>> > +	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>> > +
>> > +	vm = find_vm_area(objp);
>> > +	if (!vm)
>> > +		return false;
>> > +	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
>> 
>> Would it be useful to print the vm area boundaries too?
> 
> Like this?

Yeah, thanks!

> I also considered instead using vm->size, but that always seems to include
> an extra page, so a 4-page span is listed as having 20480 bytes and a
> one-page span is 8192 bytes.  This might be more accurate in some sense,
> but would be quite confusing to someone trying to compare this size with
> that requested in the vmalloc() call.

Right.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 33e0469c289c2f78e5f0d0c463c8ee3357d273c0
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Dec 9 15:15:27 2020 -0800
> 
>     mm: Make mem_obj_dump() vmalloc() dumps include start and length
>     
>     This commit adds the starting address and number of pages to the vmalloc()
>     information dumped by way of vmalloc_dump_obj().
>     
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>     Cc: <linux-mm@kvack.org>
>     Reported-by: Andrii Nakryiko <andrii@kernel.org>
>     Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7421719..77b1100 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3439,7 +3439,8 @@ bool vmalloc_dump_obj(void *object)
>  	vm = find_vm_area(objp);
>  	if (!vm)
>  		return false;
> -	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
> +	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> +		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
>  	return true;
>  }
>  
> 

