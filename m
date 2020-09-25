Return-Path: <SRS0=1ltc=DC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E259C4363D
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 08:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C331D207C4
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 08:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F/txyV+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgIYIQH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Sep 2020 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIYIQH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Sep 2020 04:16:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AC3C0613CE;
        Fri, 25 Sep 2020 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZgLaEQC68e3osNgfcIO9sC8Nptsdd/ClKs7+Bia7+kw=; b=F/txyV+eBo5XBPj0NJcZTnQdIq
        GNgRwctMGuVIVJZbmGpZgFenxsBE4CYdCw8MBhiea6kPhSZI7ydVJTY6/ldjFu3nBBEJm955Z7gRS
        XIoiYCcIQmxcrlJ8FoFffN5rVX0Zxz/oLboLPtUxwRSZ0K7azhuqOsn3VuoTgSSfgdqNIOx7fL15+
        7yBLhuSHc+BvUdtmnsdqnEH4bZWuFlU5+7E7WFDoZFs6fNDBRuYXl8XUsgpY1PqFKfYCsL8+RSvDQ
        ZCE/n3+2YVeFS5LDyaqZ3ZpMak7NvGBz48LIS+nFrC4W0w8cNMzeAoTZP/5Z5cjXhFRuZhQOo56HB
        kZevFGIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLitV-0006lZ-Ij; Fri, 25 Sep 2020 08:15:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8280B302753;
        Fri, 25 Sep 2020 10:15:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65EAF20BCC910; Fri, 25 Sep 2020 10:15:52 +0200 (CEST)
Date:   Fri, 25 Sep 2020 10:15:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200925081552.GS2628@hirez.programming.kicks-ass.net>
References: <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200924111907.GE2628@hirez.programming.kicks-ass.net>
 <20200924152112.GB19013@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924152112.GB19013@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 24, 2020 at 05:21:12PM +0200, Uladzislau Rezki wrote:
> On Thu, Sep 24, 2020 at 01:19:07PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 24, 2020 at 10:16:14AM +0200, Uladzislau Rezki wrote:
> > > The key point is "enough". We need pages to make a) fast progress b) support
> > > single argument of kvfree_rcu(one_arg). Not vice versa. That "enough" depends
> > > on scheduler latency and vague pre-allocated number of pages, it might
> > > be not enough what would require to refill it more and more or we can overshoot
> > > that would lead to memory overhead. So we have here timing issues and
> > > not accurate model. IMHO.
> > 
> > I'm firmly opposed to the single argument kvfree_rcu() idea, that's
> > requiring memory to free memory.
> > 
> Hmm.. The problem is there is a demand in it:

People demand ponies all the time, the usual answer is: No.
