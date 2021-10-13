Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA89C433EF
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 00:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0380B60C49
	for <rcu@archiver.kernel.org>; Wed, 13 Oct 2021 00:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhJMAeS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235130AbhJMAeS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Oct 2021 20:34:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 020AF60BD3;
        Wed, 13 Oct 2021 00:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634085136;
        bh=15tIGEmSRDeMwHSZMOGrUI9+rPbGgXy1OpVbejEK7kU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uAQYzu9SNl5G14X8qWMZx1tPoylG1EMLGH32unznrqTabc2As9oPqnAZvcd70Kdfh
         ++uaD2i3xE7KAScEIgfvAWxuIdfPxo9dDYn10ES01of/EbwMFMnZ5R/wr5z4o6dv9y
         j39zHWgcpQXfuX5T34jpknDdV3+H8kzunUlGbGPrd8yYPaUGS9jmomK13jp/WL5VGH
         gYDRC9z3aYAENEzlYIzIvLCMcf1DDZQ5GnzWkOxD6VdPbzWNFQFLB8Hq4m1nrbzTyN
         hLUPGEGJ/0WJPijgnmQfg8xCyT7Q0Qz76QnsDbDiHvIi9SBGGqKAKZSUiKFtjsXZlN
         hLowohCPdeg9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C84E25C0887; Tue, 12 Oct 2021 17:32:15 -0700 (PDT)
Date:   Tue, 12 Oct 2021 17:32:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB
 + a few other fixes v2
Message-ID: <20211013003215.GP880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211011145140.359412-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011145140.359412-1-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 11, 2021 at 04:51:29PM +0200, Frederic Weisbecker wrote:
> Hi,
> 
> No code change in this v2, only changelogs:
> 
> * Add tags from Valentin and Sebastian
> 
> * Remove last reference to SEGCBLIST_SOFTIRQ_ONLY (thanks Valentin)
> 
> * Rewrite changelog for "rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check"
>   after off-list debates with Paul.
> 
> * Remove the scenario with softirq interrupting rcuc on
>   "rcu/nocb: Limit number of softirq callbacks only on softirq" as it's
>   probably not possible (thanks Valentin).
> 
> * Remove the scenario with task spent scheduling out accounted on tlimit
>   as it's not possible (thanks Valentin)
>   (see "rcu: Apply callbacks processing time limit only on softirq")
> 
> * Fixed changelog of
>   "rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread"
>   (thanks Sebastian).
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/rt-v2
> 
> HEAD: 2c9349986d5f70a555195139665841cd98e9aba4
> 
> Thanks,
> 	Frederic

Nice!

I queued these for further review and testing.  I reworked the commit log
of 6/11 to give my idea of the reason, though I freely admit that this
reason is not as compelling as it no doubt seemed when I wrote that code.

							Thanx, Paul

> ---
> 
> Frederic Weisbecker (10):
>       rcu/nocb: Make local rcu_nocb_lock_irqsave() safe against concurrent deoffloading
>       rcu/nocb: Prepare state machine for a new step
>       rcu/nocb: Invoke rcu_core() at the start of deoffloading
>       rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
>       rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
>       rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
>       rcu/nocb: Limit number of softirq callbacks only on softirq
>       rcu: Fix callbacks processing time limit retaining cond_resched()
>       rcu: Apply callbacks processing time limit only on softirq
>       rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread
> 
> Thomas Gleixner (1):
>       rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe
> 
> 
>  include/linux/rcu_segcblist.h | 51 ++++++++++++++++++-------
>  kernel/rcu/rcu_segcblist.c    | 10 ++---
>  kernel/rcu/rcu_segcblist.h    | 12 +++---
>  kernel/rcu/tree.c             | 87 +++++++++++++++++++++++++++++--------------
>  kernel/rcu/tree.h             | 16 +++++---
>  kernel/rcu/tree_nocb.h        | 29 ++++++++++++---
>  6 files changed, 141 insertions(+), 64 deletions(-)
