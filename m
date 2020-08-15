Return-Path: <SRS0=YobW=BZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD34C433E4
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C902313A
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QpVoHrg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgHOV7X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgHOVvm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A83FC03B3CC;
        Sat, 15 Aug 2020 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uh5b1Zi8rpoAM9tbVh8FYIudAQvkcb56FXgomtc6XxY=; b=QpVoHrg3VaM4bpXpHnxjE5Pqhn
        hOJNzS5WPctryjHFzSbw1aI1mx/Fpbl9s/NaP0k9W99oWt49VFIKHpQ78Gns82a0wrVjKO1JniW1c
        cvyl7hCoaRoxBpO/Ih9t4dHi4Yec7trjvrMxWCA6ylAg1CYMWEcJAzXgC64ci+dAU5BDox1Jxm2O2
        UKLvHzcnjY3MZe1OXlMOmkGl6sekJ2CLpfoIeiZmWLGVPvU3w52fzu54kS/e8LIGKiDzocqqEGH4O
        ZhJ7ChmPPCn79IdWZsTVmJLeBqAM75Gx+Uetn7obHpndjItdqVWDWnY7+ktfmDGxRF8u7acybnKx8
        S85jRifA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6rXe-0000tl-RW; Sat, 15 Aug 2020 08:27:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56151980C9E; Sat, 15 Aug 2020 10:27:54 +0200 (CEST)
Date:   Sat, 15 Aug 2020 10:27:54 +0200
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
Message-ID: <20200815082754.GM3982@worktop.programming.kicks-ass.net>
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
> 
> As a matter of fact I assume^Wdeclare that removing struct rcu_head which
> provides a fallback is not an option at all. I know that you want to,
> but it wont work ever. Dream on, but as we agreed on recently there is
> this thing called reality which ruins everything.

It never was going to work, freeing memory can never hard rely on the
success of allocating memory.
