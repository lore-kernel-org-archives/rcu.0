Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE77C433F5
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B862761A10
	for <rcu@archiver.kernel.org>; Fri,  1 Oct 2021 17:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhJARwL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:52:11 -0400
Received: from foss.arm.com ([217.140.110.172]:49438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231852AbhJARwL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 Oct 2021 13:52:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9C94106F;
        Fri,  1 Oct 2021 10:50:26 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08A123F70D;
        Fri,  1 Oct 2021 10:50:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 04/11] rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe
In-Reply-To: <20210929221012.228270-5-frederic@kernel.org>
References: <20210929221012.228270-1-frederic@kernel.org> <20210929221012.228270-5-frederic@kernel.org>
Date:   Fri, 01 Oct 2021 18:50:22 +0100
Message-ID: <87bl48my75.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/09/21 00:10, Frederic Weisbecker wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> While reporting a quiescent state for a given CPU, rcu_core() takes
> advantage of the freshly loaded grace period sequence number and the
> locked rnp to accelerate the callbacks whose sequence number have been
> assigned a stale value.
>
> This action is only necessary when the rdp isn't offloaded, otherwise
> the NOCB kthreads already take care of the callbacks progression.
>
> However the check for the offloaded state is volatile because it is
> performed outside the IRQs disabled section. It's possible for the
> offloading process to preempt rcu_core() at that point on PREEMPT_RT.
>
> This is dangerous because rcu_core() may end up accelerating callbacks
> concurrently with NOCB kthreads without appropriate locking.
>
> Fix this with moving the offloaded check inside the rnp locking section.
>
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
