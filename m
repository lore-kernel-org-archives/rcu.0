Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBFAC433E1
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 19:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C208206B2
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 19:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHMTNu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:13:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgHMTNu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 15:13:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4D2CAF2F;
        Thu, 13 Aug 2020 19:14:10 +0000 (UTC)
Date:   Thu, 13 Aug 2020 21:13:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     peterz@infradead.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813191347.GV9477@dhcp22.suse.cz>
References: <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <20200813154159.GR4295@paulmck-ThinkPad-P72>
 <20200813155412.GP9477@dhcp22.suse.cz>
 <20200813160442.GV4295@paulmck-ThinkPad-P72>
 <20200813161357.GQ9477@dhcp22.suse.cz>
 <20200813162904.GX4295@paulmck-ThinkPad-P72>
 <20200813183121.GY2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813183121.GY2674@hirez.programming.kicks-ass.net>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 13-08-20 20:31:21, Peter Zijlstra wrote:
> On Thu, Aug 13, 2020 at 09:29:04AM -0700, Paul E. McKenney wrote:
[...]
> > 3.	Reusing existing GFP_ flags/values/whatever to communicate
> > 	the raw-context information that was to be communicated by
> > 	the new GFP_ flag.
> > 
> > 4.	Making lockdep forgive acquiring spinlocks while holding
> > 	raw spinlocks, but only in CONFIG_PREEMPT_NONE=y kernels.
> > 
> > Am I missing anything?
> 
> How would 4 solve anything?

Nothing on its own but along with http://lkml.kernel.org/r/20200813075027.GD9477@dhcp22.suse.cz
it would allow at least _some_ NOWAIT semantic for RT atomic contexts
and prevent from lockdep false positives for !RT trees.
-- 
Michal Hocko
SUSE Labs
