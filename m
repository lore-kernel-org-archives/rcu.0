Return-Path: <SRS0=zn4Z=BJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7672C433DF
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 16:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E77206F5
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596126921;
	bh=hNBBVsAK7K6IcrJd08DZpbBqe4GepnxNtHeJL5JztiE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YGL9xTKGW9TWUp2g1lZr4+slxxNNfi3guRIrgYgdM5+HP0jQqY2QVBquAa7qCUfH7
	 i1wn0XfUgVmri0RPde13GvPUyMPI1J+Fe/iJBvMOleOYjfKOfWuUmzd6mEtsvqv6kE
	 cOxcY4WDNCttzU+IBUWzg90mymMSUQCclQ1z5v6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgG3QfV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgG3QfV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jul 2020 12:35:21 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE6120838;
        Thu, 30 Jul 2020 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596126920;
        bh=hNBBVsAK7K6IcrJd08DZpbBqe4GepnxNtHeJL5JztiE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ohrm45PFR1lVtNFaZNbS4QemNQYgYgOGBMmEUSZTPR8FaiM9lcm/ORDHZHKJCtiYO
         siGSMfGsHaCPcXa/LIXzxV66y6kzjeBdFnJZ+2IvC/y1olSo26XgDHjjcnEeost/nK
         TbQze0WFlxxA519abjLTyOIUTqhVkn/y/C3MeCmU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6669D3520751; Thu, 30 Jul 2020 09:35:20 -0700 (PDT)
Date:   Thu, 30 Jul 2020 09:35:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] rcu/tree: Clarify comments about FQS loop reporting
 quiescent states
Message-ID: <20200730163520.GA9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200730030221.705255-1-joel@joelfernandes.org>
 <20200730030221.705255-2-joel@joelfernandes.org>
 <CAEXW_YSbad9Cium_9f1eA1RfZ2Me9JcX2S-KMe-jRQo8W6AaBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSbad9Cium_9f1eA1RfZ2Me9JcX2S-KMe-jRQo8W6AaBg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 29, 2020 at 11:25:19PM -0400, Joel Fernandes wrote:
> On Wed, Jul 29, 2020 at 11:02 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > At least since v4.19, the FQS loop no longer reports quiescent states
> 
> I meant here, "FQS loop no longer reports quiescent states for offline CPUs."
> 
> Sorry,

You did have me going there for a bit.  ;-)

No period (".") at the end though, unless you fix up the following
to start a new sentence.

> > unless it is a dire situation where an offlined CPU failed to report
> > a quiescent state. Let us clarify the comment in rcu_gp_init() inorder
> > to keep the comment current.

How about the following for this last sentence?

"This commit therefore fixes the comment in rcu_gp_init() to match
the current code."

> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 1e51962b565b..929568ff5989 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1701,8 +1701,8 @@ static bool rcu_gp_init(void)
> >
> >         /*
> >          * Apply per-leaf buffered online and offline operations to the
> > -        * rcu_node tree.  Note that this new grace period need not wait
> > -        * for subsequent online CPUs, and that quiescent-state forcing
> > +        * rcu_node tree.  Note that this new grace period need not wait for
> > +        * subsequent online CPUs, and that RCU hooks in CPU offlining path
> >          * will handle subsequent offline CPUs.

How about something like this?

	...  Note that this new grace period ned not wait for subsequent
	online CPUs, and that RCU hooks in the CPU offlining path, when
	combined with checks in this function, will handle CPUs that
	are currently going offline and that go offline later.

						Thanx, Paul

> >          */
> >         rcu_state.gp_state = RCU_GP_ONOFF;
> > --
> > 2.28.0.rc0.142.g3c755180ce-goog
> >
