Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275EEC433F5
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7FA61A10
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhJARw1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:52:27 -0400
Received: from foss.arm.com ([217.140.110.172]:49460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355467AbhJARw1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 Oct 2021 13:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB6BE106F;
        Fri,  1 Oct 2021 10:50:42 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AD573F70D;
        Fri,  1 Oct 2021 10:50:41 -0700 (PDT)
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
Subject: Re: [PATCH 05/11] rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
In-Reply-To: <20210929221012.228270-6-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org> <20210929221012.228270-6-frederic@kernel.org>
Date:   Fri, 01 Oct 2021 18:50:39 +0100
Message-ID: <87a6jsmy6o.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/09/21 00:10, Frederic Weisbecker wrote:
> When callbacks are offloaded, the NOCB kthreads handle the callbacks
> progression on behalf of rcu_core().
>
> However during the (de-)offloading process, the kthread may not be
> entirely up to the task. As a result some callbacks grace period
> sequence number may remain stale for a while because rcu_core() won't
> take care of them either.
>

But that should be taken care of at the tail end of the (de)offloading
process, either by rcu_core() or by the NOCB kthreads, no?

Or is it e.g. in the case of offloading, we want to make sure an rcu_core()
invocation runs callback acceleration because even if the NOCB GP/CB
kthreads are being set up, we're not guaranteed is going to do that
straight away?

IIUC it would be a similar case for deoffload when we stash the NOCB GP/CB
kthreads and get rcu_core() running concurrently.

> Fix this with forcing callbacks acceleration from rcu_core() as long
> as the offloading process isn't complete.
>
