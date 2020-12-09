Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C4CC4361B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 23:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF6422CE3
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 23:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgLIXXv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 18:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLIXXv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 18:23:51 -0500
Date:   Wed, 9 Dec 2020 15:23:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607556190;
        bh=FNkanjJRiKGUHvoOf8PjH4Glcl/rM8Sr+vJWnZnM2Fg=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kC4FMincGXAIuGjcw2vg52OYrjhASaFkyzOXsRBrhaJdTJT66PVkMuv2nu2Yp8ly1
         Q9YR+F5unST9t6G3aED6/FvHgh0Kmel47VDVjb2nczzFdtmXyR8P+DutyqNUuBThbc
         Hnkx9jnkwLCGh6qsqD4HGxBShJzfHoSdjqY/v/q7TrAtkxwG15emUkUxm+vGZkgC28
         tvv2C0esuULdSJw/RgJ/M/j0SeqD6PPZ/qEirWuncC+c1QjW0kStX3yQzRpH/yEXY1
         9/kyRHeux2lmkFLAQ19PROIKgRDJY/CuGsr4ukiEzU/Hg9r6xRyq7T7pwpMo04Tkuk
         y7ChaDCe7CeqA==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        iamjoonsoo.kim@lge.com, andrii@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 3/5] mm: Make mem_dump_obj() handle vmalloc()
 memory
Message-ID: <20201209232310.GI2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-3-paulmck@kernel.org>
 <1c25ca09-ec43-df31-a5ba-476397637a53@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c25ca09-ec43-df31-a5ba-476397637a53@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 06:51:20PM +0100, Vlastimil Babka wrote:
> On 12/9/20 2:13 AM, paulmck@kernel.org wrote:
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
> 
> ...
> 
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
> > +
> > +	vm = find_vm_area(objp);
> > +	if (!vm)
> > +		return false;
> > +	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
> 
> Would it be useful to print the vm area boundaries too?

Like this?

I also considered instead using vm->size, but that always seems to include
an extra page, so a 4-page span is listed as having 20480 bytes and a
one-page span is 8192 bytes.  This might be more accurate in some sense,
but would be quite confusing to someone trying to compare this size with
that requested in the vmalloc() call.

							Thanx, Paul

------------------------------------------------------------------------

commit 33e0469c289c2f78e5f0d0c463c8ee3357d273c0
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Dec 9 15:15:27 2020 -0800

    mm: Make mem_obj_dump() vmalloc() dumps include start and length
    
    This commit adds the starting address and number of pages to the vmalloc()
    information dumped by way of vmalloc_dump_obj().
    
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
    Cc: <linux-mm@kvack.org>
    Reported-by: Andrii Nakryiko <andrii@kernel.org>
    Suggested-by: Vlastimil Babka <vbabka@suse.cz>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7421719..77b1100 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3439,7 +3439,8 @@ bool vmalloc_dump_obj(void *object)
 	vm = find_vm_area(objp);
 	if (!vm)
 		return false;
-	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
+	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
+		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
 	return true;
 }
 
