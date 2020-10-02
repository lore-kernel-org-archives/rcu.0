Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350E0C4363D
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 08:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A9D206B6
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 08:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgJBIGa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 04:06:30 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:59925 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbgJBIGa (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 2 Oct 2020 04:06:30 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id CB18EF8067
        for <rcu@vger.kernel.org>; Fri,  2 Oct 2020 09:06:27 +0100 (IST)
Received: (qmail 20516 invoked from network); 2 Oct 2020 08:06:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Oct 2020 08:06:27 -0000
Date:   Fri, 2 Oct 2020 09:06:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201002080624.GB3227@techsingularity.net>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201001192626.GA29606@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 01, 2020 at 09:26:26PM +0200, Uladzislau Rezki wrote:
> > 
> > No, I meant going back to idea of new gfp flag, but adjust the implementation in
> > the allocator (different from what you posted in previous version) so that it
> > only looks at the flag after it tries to allocate from pcplist and finds out
> > it's empty. So, no inventing of new page allocator entry points or checks such
> > as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> > affect existing fast paths.
> >
> OK. Now i see. Please have a look below at the patch, so we fully understand
> each other. If that is something that is close to your view or not:
> 
> <snip>
> t a/include/linux/gfp.h b/include/linux/gfp.h
> index c603237e006c..7e613560a502 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -39,8 +39,9 @@ struct vm_area_struct;
>  #define ___GFP_HARDWALL                0x100000u
>  #define ___GFP_THISNODE                0x200000u
>  #define ___GFP_ACCOUNT         0x400000u
> +#define ___GFP_NO_LOCKS                0x800000u
>  #ifdef CONFIG_LOCKDEP
> -#define ___GFP_NOLOCKDEP       0x800000u
> +#define ___GFP_NOLOCKDEP       0x1000000u
>  #else
>  #define ___GFP_NOLOCKDEP       0
>  #endif
> @@ -215,16 +216,22 @@ struct vm_area_struct;
>   * %__GFP_COMP address compound page metadata.
>   *
>   * %__GFP_ZERO returns a zeroed page on success.
> + *
> + * %__GFP_NO_LOCKS order-0 allocation without sleepable-locks.
> + * It obtains a page from the per-cpu-list and considered as
> + * lock-less. No other actions are performed, thus it returns
> + * NULL if per-cpu-list is empty.
>   */
>  #define __GFP_NOWARN   ((__force gfp_t)___GFP_NOWARN)
>  #define __GFP_COMP     ((__force gfp_t)___GFP_COMP)
>  #define __GFP_ZERO     ((__force gfp_t)___GFP_ZERO)
> +#define __GFP_NO_LOCKS ((__force gfp_t)___GFP_NO_LOCKS)
> 

I'm not a fan of the GFP flag approach simply because we've had cases
before where GFP flags were used in inappropriate contexts like
__GFP_MEMALLOC which led to a surprising amount of bugs, particularly
from out-of-tree drivers but also in-tree drivers. Of course, there
are limited GFP flags available too but at least the comment should
be as robust as possible. Maybe something like

 * %__GFP_NO_LOCKS attempts order-0 allocation without sleepable-locks. It
 * attempts to obtain a page without acquiring any spinlocks. This
 * should only be used in a context where the holder holds a
 * raw_spin_lock that cannot be released for the allocation request.
 * This may be necessary in PREEMPT_RT kernels where a
 * raw_spin_lock is held which does not sleep tries to acquire a
 * spin_lock that can sleep with PREEMPT_RT. This should not be
 * confused with GFP_ATOMIC contexts. Like atomic allocation
 * requests, there is no guarantee a page will be returned and
 * the caller must be able to deal with allocation failures.
 * The risk of allocation failure is higher than using GFP_ATOMIC.

It's verbose but it would be hard to misinterpret. I think we're
going to go through a period of time before people get familiar
with PREEMPT_RT-related hazards as various comments that were
true are going to be misleading for a while.

For anyone reviewing, any use of __GFP_NO_LOCKS should meet a high
standard where there is no alternative except to use the flags. i.e. a
higher standard "but I'm an important driver".

-- 
Mel Gorman
SUSE Labs
