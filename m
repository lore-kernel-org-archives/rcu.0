Return-Path: <SRS0=BSCp=DM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D47C4363A
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 15:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50485206DD
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 15:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="siWcipuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgJEPlF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Oct 2020 11:41:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:37116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgJEPlE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Oct 2020 11:41:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601912461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oW1Tkgb2hG9B9FfQz5daexKC4SibgqnT1L43hD3UHvA=;
        b=siWcipuHhenmrJBe4dP6lR4NDNs/vxNjersBOj8MtQm9jwo9L0ltIzZVEMnkDEO1X3mtCV
        FwXv52jXmCS14xyXh6vwDL6FIT4gWiOKYSXWCoSbV0//9VHVe7cwUSl7vpuS2H+PaMMhOR
        Yc03c3LV4OTJWB0l30q/7R9oyu4M2RE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 942C8AC97;
        Mon,  5 Oct 2020 15:41:01 +0000 (UTC)
Date:   Mon, 5 Oct 2020 17:41:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201005154100.GF4555@dhcp22.suse.cz>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
 <20201002090507.GB4555@dhcp22.suse.cz>
 <20201005150801.GC17959@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005150801.GC17959@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon 05-10-20 17:08:01, Uladzislau Rezki wrote:
> On Fri, Oct 02, 2020 at 11:05:07AM +0200, Michal Hocko wrote:
> > On Fri 02-10-20 09:50:14, Mel Gorman wrote:
> > > On Fri, Oct 02, 2020 at 09:11:23AM +0200, Michal Hocko wrote:
> > > > On Thu 01-10-20 21:26:26, Uladzislau Rezki wrote:
> > > > > > 
> > > > > > No, I meant going back to idea of new gfp flag, but adjust the implementation in
> > > > > > the allocator (different from what you posted in previous version) so that it
> > > > > > only looks at the flag after it tries to allocate from pcplist and finds out
> > > > > > it's empty. So, no inventing of new page allocator entry points or checks such
> > > > > > as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> > > > > > affect existing fast paths.
> > > > > >
> > > > > OK. Now i see. Please have a look below at the patch, so we fully understand
> > > > > each other. If that is something that is close to your view or not:
> > > > > 
> > > > > <snip>
> > > > > t a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > index c603237e006c..7e613560a502 100644
> > > > > --- a/include/linux/gfp.h
> > > > > +++ b/include/linux/gfp.h
> > > > > @@ -39,8 +39,9 @@ struct vm_area_struct;
> > > > >  #define ___GFP_HARDWALL                0x100000u
> > > > >  #define ___GFP_THISNODE                0x200000u
> > > > >  #define ___GFP_ACCOUNT         0x400000u
> > > > > +#define ___GFP_NO_LOCKS                0x800000u
> > > > 
> > > > Even if a new gfp flag gains a sufficient traction and support I am
> > > > _strongly_ opposed against consuming another flag for that. Bit space is
> > > > limited. 
> > > 
> > > That is definitely true. I'm not happy with the GFP flag at all, the
> > > comment is at best a damage limiting move. It still would be better for
> > > a memory pool to be reserved and sized for critical allocations.
> > 
> > Completely agreed. The only existing usecase is so special cased that a
> > dedicated pool is not only easier to maintain but it should be also much
> > better tuned for the specific workload. Something not really feasible
> > with the allocator.
> > 
> > > > Besides that we certainly do not want to allow craziness like
> > > > __GFP_NO_LOCK | __GFP_RECLAIM (and similar), do we?
> > > 
> > > That would deserve to be taken to a dumpster and set on fire. The flag
> > > combination could be checked in the allocator but the allocator path fast
> > > paths are bad enough already.
> > 
> > If a new allocation/gfp mode is absolutely necessary then I believe that
> > the most reasoanble way forward would be
> > #define GFP_NO_LOCK	((__force gfp_t)0)
> > 
> Agree. Even though i see that some code should be adjusted for it. There are
> a few users of the __get_free_page(0); So, need to double check it:

Yes, I believe I have pointed that out in the previous discussion.

> <snip>
> [    0.650351] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [    0.651083] #PF: supervisor read access in kernel mode
> [    0.651639] #PF: error_code(0x0000) - not-present page
> [    0.652200] PGD 0 P4D 0
> [    0.652523] Oops: 0000 [#1] SMP NOPTI
> [    0.652668] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc7-next-20200930+ #140
> [    0.652668] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [    0.652668] RIP: 0010:__find_event_file+0x21/0x80
> <snip>
> 
> Apart of that. There is a post_alloc_hook(), that gets called from the prep_new_page().
> If "debug page alloc enabled", it maps a page for debug purposes invoking kernel_map_pages().
> __kernel_map_pages() is ARCH specific. For example, powerpc variant uses sleep-able locks
> what can be easily converted to raw variant. 

Yes, there are likely more surprises like that. I am not sure about
kasan, page owner (which depens on the stack unwinder) and others which
hook into this path.
-- 
Michal Hocko
SUSE Labs
