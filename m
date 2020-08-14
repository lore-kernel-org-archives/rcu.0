Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1F1C433E1
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1521220791
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 17:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wX5OLAhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgHNRtk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgHNRtk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 13:49:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9398C061384;
        Fri, 14 Aug 2020 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/DWYIQg4Zv/4dhrJ8l+WPqUqcSkig8Oez/noyo1dnB4=; b=wX5OLAhr2OSoH9QZbUG24jPGC2
        q4wlQaWlfxXqhzQexWddHurg6E1twmTNkxV8kBEARY96ZUefco+MHSC6kqLq59wMdDJDS0fbeo7GG
        DzvXRHGRIrBlJ1sj9aXVW7n48MQSoSzEzVOk9+vS10tcO79jiIYym9QbkCiNHEjiBLdAGg2TJyVkI
        HzVCoW6Jv7dFBdSr8/wnnHLkZMAAA/RBJyzdBubJcnqHeC+mvbMMBG4Oee3sVtVkyUpM0wMaQcy2q
        ZWBuyyGzYv3fjSTQlJ6LzgwhkZJRQXTXBMdz2o7MMCaNqrryFV/kdYBiB4uq0VEB3vettHGCfC1EF
        B2jkL/WQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6dpW-0002jH-Sy; Fri, 14 Aug 2020 17:49:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CB92980C9E; Fri, 14 Aug 2020 19:49:24 +0200 (CEST)
Date:   Fri, 14 Aug 2020 19:49:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200814174924.GI3982@worktop.programming.kicks-ass.net>
References: <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814161106.GA13853@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 09:11:06AM -0700, Paul E. McKenney wrote:
> Just to make sure we are talking about the same thing, please see below
> for an untested patch that illustrates how I was interpreting your words.
> Was this what you had in mind?

No, definitely not.

Also, since we used to be able to use call_rcu() _everywhere_, including
under zone->lock, how's that working with you calling the
page-allocating from it?
