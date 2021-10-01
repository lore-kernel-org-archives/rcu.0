Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D407C433F5
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C0361A8E
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355479AbhJARw5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:52:57 -0400
Received: from foss.arm.com ([217.140.110.172]:49506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355478AbhJARw4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 Oct 2021 13:52:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CCF1106F;
        Fri,  1 Oct 2021 10:51:12 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2233F70D;
        Fri,  1 Oct 2021 10:51:10 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 08/11] rcu/nocb: Limit number of softirq callbacks only on softirq
In-Reply-To: <20210929221012.228270-9-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org> <20210929221012.228270-9-frederic@kernel.org>
Date:   Fri, 01 Oct 2021 18:51:08 +0100
Message-ID: <877dewmy5v.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/09/21 00:10, Frederic Weisbecker wrote:
> The current condition to limit the number of callbacks executed in a
> row checks the offloaded state of the rdp. Not only is it volatile
> but it is also misleading: the rcu_core() may well be executing
> callbacks concurrently with NOCB kthreads, and the offloaded state
> would then be verified on both cases. As a result the limit would
> spuriously not apply anymore on softirq while in the middle of
> (de-)offloading process.
>
> Another issue with the condition is that rcu_is_callbacks_kthread()
> doesn't check if we are actually running callbacks from rcuc itself or
> from a softirq interrupting rcuc.
>

Doesn't rcutree.use_softirq imply rcuc is never woken, in which case
RCU_SOFTIRQ can't interrupt rcuc (e.g. while run atop an IRQ exit)?
I suppose during the (de)offload sequence we could have RCU_SOFTIRQ running
atop the NOCB CB kthread, but that's not something
rcu_is_callbacks_kthread() detects.

Also, why is rcu_is_callbacks_kthread() hardcoded to false for
!CONFIG_RCU_BOOST? Isn't it relevant for do_rcu_batch() ratelimiting
regardless (at least before your patches)?
