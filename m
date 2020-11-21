Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2657C2D0E4
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 01:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894BD24101
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 01:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKUBF6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgKUBF5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 20:05:57 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC6420715;
        Sat, 21 Nov 2020 01:05:55 +0000 (UTC)
Date:   Fri, 20 Nov 2020 20:05:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/5] Provide SRCU polling grace-period
 interfaces
Message-ID: <20201120200553.625ee073@oasis.local.home>
In-Reply-To: <20201121005809.GA16795@paulmck-ThinkPad-P72>
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
        <20201121005809.GA16795@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 20 Nov 2020 16:58:09 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> 	OK, maybe no one needs it, but rcutorture does need it, so here
> 	it is anyway.

Ah, so there was a use case. I was scratching my head a bit before
reading this ;-)

-- Steve
