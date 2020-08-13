Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB2CC433E1
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 18:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE218206B2
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 18:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VB2gdtur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMS0j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMS0j (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 14:26:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AE0C061757;
        Thu, 13 Aug 2020 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g1eoHHh3zLR/ThuflE/IIEVilQA8iEgwq53pEaNkKwg=; b=VB2gdturL+7LgHaS8LxLHFXDTa
        bLTMvaJYqbwN4Db9n5mKZhleZEgHlz2IbIAi0Jc/dxJXlJLuKNbA2rhtlna4bMiUQnondbJF668XW
        MuheGCTTRBsEMYcm5O3a/PI4rEOP4VxowuFgfgerojrAcqDXntlo/4fVK+fBwTgC5RnjjjgQbTvcK
        071pQthrqZnZEnFrOBHcmsWC52L+65BE5NqfomhXEFYC8y2Q9GVgxBb9NlJGu9bzH01JDRrdA3A4O
        ZBkDgPu/2VlwM+oRk75h9m3z0eWEMXlEx4l1zF3CJw0Ep15pvgq7cIDOgwUFOU09ItaBDn0Hhz20B
        /KqrI3lA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6Hvj-0001UJ-9N; Thu, 13 Aug 2020 18:26:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2E823011F0;
        Thu, 13 Aug 2020 20:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D632C2B3D4AD4; Thu, 13 Aug 2020 20:26:18 +0200 (CEST)
Date:   Thu, 13 Aug 2020 20:26:18 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813182618.GX2674@hirez.programming.kicks-ass.net>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgcqty0e.fsf@nanos.tec.linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 04:34:57PM +0200, Thomas Gleixner wrote:
> Michal Hocko <mhocko@suse.com> writes:
> > On Thu 13-08-20 15:22:00, Thomas Gleixner wrote:
> >> It basically requires to convert the wait queue to something else. Is
> >> the waitqueue strict single waiter?
> >
> > I would have to double check. From what I remember only kswapd should
> > ever sleep on it.
> 
> That would make it trivial as we could simply switch it over to rcu_wait.
> 
> >> So that should be:
> >> 
> >> 	if (!preemptible() && gfp == GFP_RT_NOWAIT)
> >> 
> >> which is limiting the damage to those callers which hand in
> >> GFP_RT_NOWAIT.
> >> 
> >> lockdep will yell at invocations with gfp != GFP_RT_NOWAIT when it hits
> >> zone->lock in the wrong context. And we want to know about that so we
> >> can look at the caller and figure out how to solve it.
> >
> > Yes, that would have to somehow need to annotate the zone_lock to be ok
> > in those paths so that lockdep doesn't complain.
> 
> That opens the worst of all cans of worms. If we start this here then
> Joe programmer and his dog will use these lockdep annotation to evade
> warnings and when exposed to RT it will fall apart in pieces. Just that
> at that point Joe programmer moved on to something else and the usual
> suspects can mop up the pieces. We've seen that all over the place and
> some people even disable lockdep temporarily because annotations don't
> help.
> 
> PeterZ might have opinions about that too I suspect.

PeterZ is mightily confused by all of this -- also heat induced brain
melt.

I thought the rule was:

 - No allocators (alloc/free) inside raw_spinlock_t, full-stop.

Why are we trying to craft an exception?
