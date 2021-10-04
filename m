Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8B0C433F5
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 13:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8454061215
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 13:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhJDNtp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238812AbhJDNtj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 Oct 2021 09:49:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3660461207;
        Mon,  4 Oct 2021 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633355270;
        bh=Q5hvqfnKBpjb+385DGba5PUqwwPhzc1+obGuMOt5Cas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LR1Erv2KL7VPucFJYsYakwzIaxnTNRD9CK7Vl6lrgkvccBRZmr6p7IsUHNvDlb3Kk
         6qvIJuyEZ7ZTOtBnr8OScrs46pcBjbIVl4fIf2u1wdqIBKMop2B7vGM/IN9j1Zhgix
         aex/6DtN5JmJiYClaNNxHi0iLURKUGMsQfOoCd2deM7XudTSYC0dOYVVIMd2nilfGO
         7OYhsX/wGITSQ+n9DlV0s/eFrdJvIO91YmW/FaXYMHPOfVg9Ok7JxMejp/DOQGUdgJ
         pUFgbW9ikyMyT0XSEkYcedtfepeMHcKjKXDk0h0ow1VIzTTrgYULoYIIGTpH6YCc4J
         TRB6MCS6NT2xw==
Date:   Mon, 4 Oct 2021 15:47:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 10/11] rcu: Apply callbacks processing time limit only on
 softirq
Message-ID: <20211004134748.GD273854@lothringen>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-11-frederic@kernel.org>
 <874ka0my57.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ka0my57.mognet@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 01, 2021 at 06:51:32PM +0100, Valentin Schneider wrote:
> On 30/09/21 00:10, Frederic Weisbecker wrote:
> > Time limit only makes sense when callbacks are serviced in softirq mode
> > because:
> >
> > _ In case we need to get back to the scheduler,
> >   cond_resched_tasks_rcu_qs() is called after each callback.
> >
> > _ In case some other softirq vector needs the CPU, the call to
> >   local_bh_enable() before cond_resched_tasks_rcu_qs() takes care about
> >   them via a call to do_softirq().
> >
> > _ The time spent on other tasks after scheduling out, or on softirqs
> >   processing, is spuriously accounted to the time limit.
> >
> 
> That wasn't the case before ("rcu: Fix callbacks processing time limit
> retaining cond_resched()")

But if cond_resched_tasks_rcu_qs() was called and then on the next iteration
tlimit is checked, the time spent scheduling out is included, right?

Thanks.

> , though under PREEMPT_RT that *was* true (since
> bh-off remains preemptible). So I'd say that's a change we want.
> 
> > Therefore, make sure the time limit only applies to softirq mode.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
