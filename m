Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EB2C636C8
	for <rcu@archiver.kernel.org>; Sun, 18 Jul 2021 22:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942516101E
	for <rcu@archiver.kernel.org>; Sun, 18 Jul 2021 22:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhGRWza (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Jul 2021 18:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhGRWz3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Jul 2021 18:55:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF2BC061762;
        Sun, 18 Jul 2021 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RHSK5EGB6FHr3oxPvJZpzufbw3Ms9NA52kVasTcg4p4=; b=EO8B14wpWTQwqTdTHNRIsPGLqT
        wOvfRyDsX9UOviGYwZ6BLIZSOb8CNAH48qsNPi0CRJ6xSG9tFMXwvUCP3tM3OEK2nQvhOArtaBSfE
        bXaA5NbN5MMB/fpIg1U7PR4ROUcddLqQa5S9BKCm0ibaKVzDluRcku6kRN5Dk+pF2ksqzAFAAxU2b
        H/FePW411Q6kY2HM9g8JIVC6oD3kfulR9lETb8rwxMswGtNvjxDxFWTWyASrLxZi0KZjN4m0B9LPf
        6P7FfzVWDYjvBOlG/ZWNOFdyMVJDTz0tx0KYghGMOprXcwYI96BFG97OYG17pLT87GvlOJ09Ko38/
        WlThaU3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5FdI-006MEM-As; Sun, 18 Jul 2021 22:51:56 +0000
Date:   Sun, 18 Jul 2021 23:51:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chris Clayton <chris2553@googlemail.com>,
        Chris Rankin <rankincj@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: linux-5.13.2: warning from kernel/rcu/tree_plugin.h:359
Message-ID: <YPSweHyCrD2q2Pue@casper.infradead.org>
References: <c9fd1311-662c-f993-c8ef-54af036f2f78@googlemail.com>
 <2245518.LNIG0phfVR@natalenko.name>
 <6698965.kvI7vG0SvZ@natalenko.name>
 <20210718215914.GQ4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718215914.GQ4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jul 18, 2021 at 02:59:14PM -0700, Paul E. McKenney wrote:
> > > https://lore.kernel.org/lkml/CAK2bqVK0Q9YcpakE7_Rc6nr-E4e2GnMOgi5jJj=_Eh_1k
> > > EHLHA@mail.gmail.com/
> 
> But this one does show this warning in v5.12.17:
> 
> 	WARN_ON_ONCE(!preempt && rcu_preempt_depth() > 0);
> 
> This is in rcu_note_context_switch(), and could be caused by something
> like a schedule() within an RCU read-side critical section.  This would
> of course be RCU-usage bugs, given that you are not permitted to block
> within an RCU read-side critical section.
> 
> I suggest checking the functions in the stack trace to see where the
> rcu_read_lock() is hiding.  CONFIG_PROVE_LOCKING might also be helpful.

I'm not sure I see it in this stack trace.

Is it possible that there's something taking the rcu read lock in an
interrupt handler, then returning from the interrupt handler without
releasing the rcu lock?  Do we have debugging that would fire if
somebody did this?
