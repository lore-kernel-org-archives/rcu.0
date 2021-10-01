Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E762C433EF
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383EC61A10
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355484AbhJARxK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:53:10 -0400
Received: from foss.arm.com ([217.140.110.172]:49524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355478AbhJARxK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 Oct 2021 13:53:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67F00106F;
        Fri,  1 Oct 2021 10:51:25 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB96B3F70D;
        Fri,  1 Oct 2021 10:51:23 -0700 (PDT)
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
Subject: Re: [PATCH 09/11] rcu: Fix callbacks processing time limit retaining cond_resched()
In-Reply-To: <20210929221012.228270-10-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org> <20210929221012.228270-10-frederic@kernel.org>
Date:   Fri, 01 Oct 2021 18:51:21 +0100
Message-ID: <875yugmy5i.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/09/21 00:10, Frederic Weisbecker wrote:
> The callbacks processing time limit makes sure we are not exceeding a
> given amount of time executing the queue.
>
> However its "continue" clause bypasses the cond_resched() call on
> rcuc and NOCB kthreads, delaying it until we reach the limit, which can
> be very long...
>
> Make sure the scheduler has a higher priority than the time limit.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
