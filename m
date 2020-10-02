Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED384C4363D
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 07:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD42206A2
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 07:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SqC3XLQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgJBHL0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 03:11:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:51870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBHLZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Oct 2020 03:11:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601622684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIUDRMv6oCpat1m7gSDcNYYd2XmvpMkcwYlQlsCJ1pI=;
        b=SqC3XLQcMGZ9Sb9YZP0PRZTA34Gr2lF5MTEwILmKEZDIxkZQV8o3nNG6/OxH0z6kptk4wf
        w5jE2PNxvkB5nnVNvyRYsvDFRIVWTgZw/+3VPuBLeyd0znhxKLWFpXaWZGCRuY+AD7FDu+
        mi88kOYCZ+LaVtK3zIR0tAuzyhgb0h4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15038B317;
        Fri,  2 Oct 2020 07:11:24 +0000 (UTC)
Date:   Fri, 2 Oct 2020 09:11:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201002071123.GB20872@dhcp22.suse.cz>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001192626.GA29606@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 01-10-20 21:26:26, Uladzislau Rezki wrote:
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

Even if a new gfp flag gains a sufficient traction and support I am
_strongly_ opposed against consuming another flag for that. Bit space is
limited.  Besides that we certainly do not want to allow craziness like
__GFP_NO_LOCK | __GFP_RECLAIM (and similar), do we?
-- 
Michal Hocko
SUSE Labs
