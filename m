Return-Path: <SRS0=6ydw=B3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC9C433E3
	for <rcu@archiver.kernel.org>; Mon, 17 Aug 2020 08:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EC72063A
	for <rcu@archiver.kernel.org>; Mon, 17 Aug 2020 08:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgHQI2y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:28:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgHQI2x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Aug 2020 04:28:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B44B9AC1C;
        Mon, 17 Aug 2020 08:29:15 +0000 (UTC)
Date:   Mon, 17 Aug 2020 10:28:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200817082849.GA28270@dhcp22.suse.cz>
References: <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
 <20200814174924.GI3982@worktop.programming.kicks-ass.net>
 <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
 <20200816225655.GA17869@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816225655.GA17869@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon 17-08-20 00:56:55, Uladzislau Rezki wrote:
[...]
> Michal asked to provide some data regarding how many pages we need and how
> "lockless allocation" behaves when it comes to success vs failed scenarios.
> 
> Please see below some results. The test case is a tight loop of 1 000 000 allocations
> doing kmalloc() and kfree_rcu():

It would be nice to cover some more realistic workloads as well.

> sudo ./test_vmalloc.sh run_test_mask=2048 single_cpu_test=1
> 
> <snip>
>  for (i = 0; i < 1 000 000; i++) {
>   p = kmalloc(sizeof(*p), GFP_KERNEL);
>   if (!p)
>    return -1;
> 
>   p->array[0] = 'a';
>   kvfree_rcu(p, rcu);
>  }
> <snip>
> 
> wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_0.png

If I understand this correctly then this means that failures happen very
often because pcp pages are not recycled quicklly enough.

> wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_8.png

1/8 of the memory in pcp lists is quite large and likely not something
used very often.

Both these numbers just make me think that a dedicated pool of page
pre-allocated for RCU specifically might be a better solution. I still
haven't read through that branch of the email thread though so there
might be some pretty convincing argments to not do that.

> Also i would like to underline, that kfree_rcu() reclaim logic can be improved further,
> making the drain logic more efficient when it comes to time, thus to reduce a footprint
> as a result number of required pages.
> 
> --
> Vlad Rezki

-- 
Michal Hocko
SUSE Labs
