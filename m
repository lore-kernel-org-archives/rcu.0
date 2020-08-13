Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B2DC433E1
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA0D20774
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMNqH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:46:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:35714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMNqC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 09:46:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27092B1B8;
        Thu, 13 Aug 2020 13:46:22 +0000 (UTC)
Date:   Thu, 13 Aug 2020 15:45:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813134558.GM9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <20200813111505.GG9477@dhcp22.suse.cz>
 <871rkallqk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rkallqk.fsf@nanos.tec.linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 13-08-20 15:27:15, Thomas Gleixner wrote:
> Michal Hocko <mhocko@suse.com> writes:
> > On Thu 13-08-20 11:58:40, Uladzislau Rezki wrote:
> > [...]
> >> Sorry for jumping in. We can rely on preemptable() for sure, if CONFIG_PREEMPT_RT
> >> is enabled, something like below:
> >> 
> >> if (IS_ENABLED_RT && preemptebale())
> >
> > Sure. I thought this was an RT specific thing that would be noop
> > otherwise.
> 
> Well, even if RT specific it would be still something returning either
> true or false unconditionally.
> 
> And guarding it with RT is not working either because then you are back
> to square one with the problem which triggered the discussion in the
> first place:
> 
> raw_spin_lock()
>   alloc()
>     if (RT && !preemptible())  <- False because RT == false
>     	goto bail;
> 
>     spin_lock(&zone->lock)  --> LOCKDEP complains
> 
> So either you convince Paul not to do that or you need to do something
> like I suggested in my other reply.

Can we somehow annotate the lock to be safe for nesting for lockdep?
-- 
Michal Hocko
SUSE Labs
