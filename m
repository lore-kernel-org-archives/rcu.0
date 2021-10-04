Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C747C4167B
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0857A61215
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhJDNpQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238531AbhJDNmh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 Oct 2021 09:42:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43A68611C1;
        Mon,  4 Oct 2021 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633354423;
        bh=VBNyuBWaGGeiz4eo+6WYbAYMe7rfGlYX4fKuRgp3h5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnrVnElGMBJOYhSeu5pT6SOJdG7aycc2nklWKualjjUF1hHYKRjZE0ByA4j9QHpoD
         2/OGW/cbP8i5wuRpiEzFMRt9A3i3N7791Zjk3ISRSqJjUysBvjcQUHj9DIlcK2UsX8
         d9uVg0vX8lOrlHabyBxrGzAXAMwTmElEA+1HEjOwbxz0IzZJTVRnOa1eEEatUtUObX
         jrC2v1VL2vqDBFz3SGOedcTnx0JrZehqsXrY1gdW601SpBSE0UCSmpUEKtRDCiCTzp
         kwwAH2SBYsLmnl1ORwFoxnJyXvE17vVCExwJCm0ByM4zdW2naAbEBamAlR4OV0rxvf
         4zMB8DY8jorSQ==
Date:   Mon, 4 Oct 2021 15:33:41 +0200
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
Subject: Re: [PATCH 07/11] rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
Message-ID: <20211004133341.GB273854@lothringen>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-8-frederic@kernel.org>
 <878rzcmy68.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rzcmy68.mognet@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 01, 2021 at 06:50:55PM +0100, Valentin Schneider wrote:
> On 30/09/21 00:10, Frederic Weisbecker wrote:
> > Instead of hardcoding IRQ save and nocb lock, use the consolidated
> > API.
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
> Just one comment nit below.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> > ---
> >  kernel/rcu/tree.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b1fc6e498d90..1971a4e15e96 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2492,8 +2492,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
> 
> While at it:
> 
> -	 * Extract the list of ready callbacks, disabling to prevent
> +-	 * Extract the list of ready callbacks, disabling IRQs to prevent

Good catch, applied that in the patch.

Thanks.
