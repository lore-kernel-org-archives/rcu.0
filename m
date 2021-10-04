Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ABAC433FE
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6543E61166
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 13:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhJDNeL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235098AbhJDNcp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 Oct 2021 09:32:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B242619F5;
        Mon,  4 Oct 2021 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633353288;
        bh=hODNmxSSaaHr3OC4EIv08au/aKqXNrYAxsD5uypDWt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0wOPEX7XWB4Ep3Bly6qwKTm12w3G4JMNNRTQuW9u3C6lNtdKEl1AWi/CdsJBLs+J
         1iG9qn8HDcY1Fal2OHMdWLbOkcXHYRhfS0ypTDxLXk6LnT5ll7vplOrYzd7NuO33Du
         G8/9bKdudjQU33Q6Jt8fEJxSiLAXutbEdgyOhKjG0MpruN5qCxJvI7Zy3uoPVkmtW4
         rkMydmfM5J/qYdIsj47dK9yzd/2daMaTFlyqntpiK2NTUNIy/O95oVG08OhyDrN9cw
         qULPyz2nUS4zj0Tbuae9ejzucxfML/jYeQ4MIqECyP5dvXW6nd/abpkvxu9NaKsvaq
         MTGJ8MK9I5t+Q==
Date:   Mon, 4 Oct 2021 15:14:45 +0200
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
Subject: Re: [PATCH 05/11] rcu/nocb: Make rcu_core() callbacks acceleration
 (de-)offloading safe
Message-ID: <20211004131445.GA273854@lothringen>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-6-frederic@kernel.org>
 <87a6jsmy6o.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6jsmy6o.mognet@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 01, 2021 at 06:50:39PM +0100, Valentin Schneider wrote:
> On 30/09/21 00:10, Frederic Weisbecker wrote:
> > When callbacks are offloaded, the NOCB kthreads handle the callbacks
> > progression on behalf of rcu_core().
> >
> > However during the (de-)offloading process, the kthread may not be
> > entirely up to the task. As a result some callbacks grace period
> > sequence number may remain stale for a while because rcu_core() won't
> > take care of them either.
> >
> 
> But that should be taken care of at the tail end of the (de)offloading
> process, either by rcu_core() or by the NOCB kthreads, no?

True but the (de-)offloading process can take a random amount of time to
complete. During this time if the queue of callbacks is already huge, things
can explode.

> 
> Or is it e.g. in the case of offloading, we want to make sure an rcu_core()
> invocation runs callback acceleration because even if the NOCB GP/CB
> kthreads are being set up, we're not guaranteed is going to do that
> straight away?

Right.

> 
> IIUC it would be a similar case for deoffload when we stash the NOCB GP/CB
> kthreads and get rcu_core() running concurrently.

You got it!

Thanks.
