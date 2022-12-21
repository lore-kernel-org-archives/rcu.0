Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01FAC4332F
	for <rcu@archiver.kernel.org>; Wed, 21 Dec 2022 12:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiLUML1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Dec 2022 07:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUML0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Dec 2022 07:11:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146332628;
        Wed, 21 Dec 2022 04:11:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA1DCB81B80;
        Wed, 21 Dec 2022 12:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44B4C433D2;
        Wed, 21 Dec 2022 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671624681;
        bh=Yi1sF85S9MiMleKMdbGeKCC7UjazMd8nprfYlJnsE3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4coD86hzo9BMcqjlDxy02GuxStiRxBs7xL/tkcssh1jWhItk0rGK2OU6Y+XqdM+m
         5bCE/Dvs25Y8XxNOf/CZBK5cTmRJcCeRcqKyiDe4Bnu4OCTQ7MEIaSzAHGC0QFVSba
         8LasEW8ba5HXLLdduosoIp5JXLoVPLvCt6pULlbHDcqp1mP/qTaarv3nm3vuNQXrkW
         Oiv/KPZDSZixi0sPUpL/Bv4jaknANlXpZb67jJCbfdqA8Y+HkEJ++L8zaa8UKLefwN
         dpIVZr/qXVfJ/NCEpKj+cVjmA3rtzmHnLTNuhUFDBPBdgDeHOE89mBRejlQlaQqeN4
         miJmNHppBoxmg==
Date:   Wed, 21 Dec 2022 13:11:18 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221221121118.GA35081@lothringen>
References: <20221220140714.GB22763@lothringen>
 <CA83E649-8C79-4D39-9BFE-BBEF95968B98@joelfernandes.org>
 <20221220224459.GA25175@lothringen>
 <CAEXW_YSAv+MzZoW9RK9H3E6DAyZH+wB=4bMy5nXTOExSwgSwAg@mail.gmail.com>
 <20221221004957.GA29021@lothringen>
 <20221221005858.GA29316@lothringen>
 <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 20, 2022 at 10:43:25PM -0500, Mathieu Desnoyers wrote:
> On 2022-12-20 19:58, Frederic Weisbecker wrote:
> > On Wed, Dec 21, 2022 at 01:49:57AM +0100, Frederic Weisbecker wrote:
> > > On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
> > > > On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > > Agreed about (1).
> > > > 
> > > > > _ In (2), E pairs with the address-dependency between idx and lock_count.
> > > > 
> > > > But that is not the only reason. If that was the only reason for (2),
> > > > then there is an smp_mb() just before the next-scan post-flip before
> > > > the lock counts are read.
> > > 
> > > The post-flip barrier makes sure the new idx is visible on the next READER's
> > > turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
> > > may appear unordered from the update side POV if there is no barrier between the
> > > scan and the flip.
> > > 
> > > If you remove the smp_mb() from the litmus test I sent, things explode.
> > 
> > Or rather, look at it the other way, if there is no barrier between the lock
> > scan and the index flip (E), then the index flip can appear to be written before the
> > lock is read. Which means you may start activating the index before you finish
> > reading it (at least it appears that way from the readers pont of view).
> 
> Considering that you can have pre-existing readers from arbitrary index
> appearing anywhere in the grace period (because a reader can fetch the
> index and be preempted for an arbitrary amount of time before incrementing
> the lock count), the grace period algorithm needs to deal with the fact that
> a newcoming reader can appear in a given index either before or after the
> flip.

True but the number of preempted tasks is bound and there is a forward progress guarantee.

> I don't see how flipping the index before or after loading the unlock/lock
> values would break anything (except for unlikely counter overflow situations
> as previously discussed).

Forward progress guarantee.

Thanks.

> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
