Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C56C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE622078D
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgHMNlm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:41:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMNll (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 09:41:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 506B6B153;
        Thu, 13 Aug 2020 13:42:02 +0000 (UTC)
Date:   Thu, 13 Aug 2020 15:41:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813134039.GL9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <20200813132931.GA26290@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813132931.GA26290@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 13-08-20 15:29:31, Uladzislau Rezki wrote:
[...]
> I was a bit out of focus and did not mention about one thing. Identifying the context
> type using preemtable() primitives looks a bit not suitable, IMHO. GFP_* flags are
> not supposed to identify a context type, because it is not possible for all cases.

Yes, GFP flags do not identify context and that is why my draft didn't
really consider gfp flags for anything but the retry logic which is
already gfp based already. The buddy allocator path simply always bails
out for those rt atomic paths whenever it gets close to zone->lock

> But that i

You meant to say more I guess

> Also, to bail out based on a context's type will not allow to get a page from atomic
> contexts, what we try to achieve :)

Yes lockdep will need some special treatment but I suspect we want to
address the underlying problem first and only then take care of the
lockdep.

> Whereas, i mean, we do have possibility to do lock-less per-cpu-list allocation without
> touching any zone lock.
> 
> if (gfp_mask == 0) {
>    check_pcp_lists();
>       if (page)
>           return page;
> 
>     bail out here without doing farther logic, like pre-fetching.
>     return NULL;
> }

The existing code does that already. __rmqueue_pcplist will go
rmqueue_bulk only when pcp lists are empty. Or did I miss your point?

-- 
Michal Hocko
SUSE Labs
