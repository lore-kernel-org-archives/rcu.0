Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3FC4363D
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 09:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E8520672
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 09:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Is53JiSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgJBJHp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 05:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBJHo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Oct 2020 05:07:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA7AC0613D0;
        Fri,  2 Oct 2020 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aAAbxNegoG0OkRLdkHrUKEVk3WJTcefZ9uoKJBagbcQ=; b=Is53JiSI75kIUyBY7cS1XVXNGy
        vcnb11qkmV1+lP+B9NJDFbDoAl3sln8dwUFS4vI2bFzddaNCp+7oJznrW2qsPeEWo2f7xEu+duoSA
        7LktTOOVSg9ArSRL5Aj+L1PRbQjvuN81GMaXBBG15XSpScFw4/+mDpgC27gvy8y3Nd7DDjaSuu7OT
        A233bwcpaDi8gvUmWWkUEUpzJHQtvpFVwW6y4Z6i2XtSp83s9vaub71axs27XMXQZ20y1j9UnFxNo
        DVTNYv+JMwxnHj5TlCin3oTlIFH/FruijUpiyTMhqKRpZgXpJom+fcIRROCA4NMEWtN17eBDXWg3M
        FKmdTrGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOH2K-0007M3-72; Fri, 02 Oct 2020 09:07:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 343843011E6;
        Fri,  2 Oct 2020 11:07:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E38020104626; Fri,  2 Oct 2020 11:07:29 +0200 (CEST)
Date:   Fri, 2 Oct 2020 11:07:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201002090729.GU2628@hirez.programming.kicks-ass.net>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002085014.GC3227@techsingularity.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 02, 2020 at 09:50:14AM +0100, Mel Gorman wrote:
> On Fri, Oct 02, 2020 at 09:11:23AM +0200, Michal Hocko wrote:

> > > +#define ___GFP_NO_LOCKS                0x800000u
> > 
> > Even if a new gfp flag gains a sufficient traction and support I am
> > _strongly_ opposed against consuming another flag for that. Bit space is
> > limited. 
> 
> That is definitely true. I'm not happy with the GFP flag at all, the
> comment is at best a damage limiting move. It still would be better for
> a memory pool to be reserved and sized for critical allocations.

This is one of the reasons I did a separate allocation function. No GFP
flag to leak into general usage.

> > Besides that we certainly do not want to allow craziness like
> > __GFP_NO_LOCK | __GFP_RECLAIM (and similar), do we?
> 
> That would deserve to be taken to a dumpster and set on fire. The flag
> combination could be checked in the allocator but the allocator path fast
> paths are bad enough already.

Isn't that what we have CONFIG_DEBUG_VM for?
