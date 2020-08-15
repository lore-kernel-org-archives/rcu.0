Return-Path: <SRS0=YobW=BZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C50C433DF
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303FD2053B
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L/7ul3MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgHOVvZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbgHOVvW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055BDC03B3D0;
        Sat, 15 Aug 2020 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pkS7z3ao03yPLdIGYL9tG9q63NVqZ+TpW9PfCZt8oys=; b=L/7ul3MKsMrF7vWFB9Ph0PY0hg
        +Wrv23G+mNVzExWozkDqWEcrqyDpNmp4bgihjtsFx2veXlJlN6DevE7WbJfH2I1n4oFCN0GuUpzTf
        VY79AWM7eA+g14iycUVzXdQcho2vLxHb8xDoNgIgcLrYCaM8AcZHV8R9PZFU3X6dIZaQg1iU9NfgY
        mBy696Lk5WsMxhVOysn+oSmps0iL/ytu7zw6Q4DJIchbCjbhHnVXc3Pq0vI4p8FPu1bdaygCdtEo1
        ceCV9N//ZzsESLaouX4qtGOnCnQeDOAA+hTd6Bngcf7lFXG3fdh8MaBQotaqKRhlz1AOPxP8N4wXp
        pgwrOxuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6rm9-0003vH-PT; Sat, 15 Aug 2020 08:42:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9B6F980C9E; Sat, 15 Aug 2020 10:42:50 +0200 (CEST)
Date:   Sat, 15 Aug 2020 10:42:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org, Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200815084250.GN3982@worktop.programming.kicks-ass.net>
References: <20200814180141.GP4295@paulmck-ThinkPad-P72>
 <87tux4kefm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tux4kefm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 15, 2020 at 01:14:53AM +0200, Thomas Gleixner wrote:

> #1 trivial fix is to force switching to an high prio thread or a soft
>    interrupt which does the allocation

Yeah, push the alocation out to another context. I did consider it, but
why bother?

Also, raising a softirq can't be done from every context, that's a whole
new problem. You can do irq_work I suppose, but not all architectures
support the self-IPI yet.

All in all, it's just more complexity than the fairly trivial
__alloc_page_lockless().

Whichever way around, we can't rely on the allocation.
