Return-Path: <SRS0=Gqt/=DB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB7C4346E
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 15:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63D12311A
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600961915;
	bh=z0bSE1PpsW/DNtkm7wsszU+8HwHLVybbm1u4JVedcis=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=djVZj6/JwCtQBzZodY5orfowE14ri8IUbNRGxlRTD80pH5CBm7TmKdU3R6/WrzM2B
	 uDeGogzQbyehkdYUchzA8IeQCAKZNxwxEO+tALer4FrzCnJJIoxfqF0vwrG5KJLmYA
	 A38uk9HQd9quNv4u9N9SO/lcnG0z9Rsc4cTLFP20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgIXPif (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Sep 2020 11:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgIXPif (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Sep 2020 11:38:35 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8105A221EB;
        Thu, 24 Sep 2020 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600961914;
        bh=z0bSE1PpsW/DNtkm7wsszU+8HwHLVybbm1u4JVedcis=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Buyy92eb0jwKS/TTpBvg/MWMHPwLq7CPlTGEBnbCuva+0VbTTOVf+vH674sb5cYIH
         2An1YWExAJGfDwLbGSHpd5qKlEJZ9uVUAThfi31MajHl1xw274Kl2Ur2Oq1Yl8rSoG
         rRvqHxQA6/pKL39qnpL4HlV/cOUfbAgUoIdmn7vI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2A57835201B3; Thu, 24 Sep 2020 08:38:34 -0700 (PDT)
Date:   Thu, 24 Sep 2020 08:38:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200924153834.GW29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200924111907.GE2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924111907.GE2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 24, 2020 at 01:19:07PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 10:16:14AM +0200, Uladzislau Rezki wrote:
> > The key point is "enough". We need pages to make a) fast progress b) support
> > single argument of kvfree_rcu(one_arg). Not vice versa. That "enough" depends
> > on scheduler latency and vague pre-allocated number of pages, it might
> > be not enough what would require to refill it more and more or we can overshoot
> > that would lead to memory overhead. So we have here timing issues and
> > not accurate model. IMHO.
> 
> I'm firmly opposed to the single argument kvfree_rcu() idea, that's
> requiring memory to free memory.

Not quite.

First, there is a fallback when memory allocation fails.  Second,
in heavy-use situations, there is only one allocation per about
500 kvfree_rcu() calls on 64-bit systems.  Third, there are other
long-standing situations that require allocating memory in order to
free memory.

So I agree that it is a good general rule of thumb to avoid allocating
on free paths, but there are exceptions.  This is one of them.

						Thanx, Paul
