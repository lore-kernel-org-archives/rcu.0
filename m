Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B43C34031
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 21:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8D822B48
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 21:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582061887;
	bh=cFPbsFR53RUWHQPCLM3SZK35Bd2a7dVFy68AbGuywR4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aIfx85hgnt0XQNO4t9mwEhEZp5lR9KyoZMZqYdYLYn8xLRp/Pst0ssBRF54P3pyu8
	 gxKAwNPAkMFzqp3ZBAxTQkid/xG+3qEwgX82+pPZH+xSSHesmiFbxVCd4NvDHvVYg7
	 SbXaMJvGYRYR8VNSgahH2nsXc3UYWEo2mbUGwgPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBRViH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgBRViH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 16:38:07 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85DEA2064C;
        Tue, 18 Feb 2020 21:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582061886;
        bh=cFPbsFR53RUWHQPCLM3SZK35Bd2a7dVFy68AbGuywR4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QdbVkXgGmL7swR6YJ6CW3sEIQJyGMdBBbh1+XMIgg3cZd3AloTWEkyCjDbzC3U37U
         w2QkJSdXm73SE1wHYTOSpqVq2GXhdJGhIZtssOS9d3z6+GStAkDHsox9thm0Hplm2a
         30cH4spXPxYQCXTRNTdM3vMIUSf80wb7dgWd8byY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 53C393520856; Tue, 18 Feb 2020 13:38:06 -0800 (PST)
Date:   Tue, 18 Feb 2020 13:38:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 4/4] srcu: Add READ_ONCE() to srcu_struct
 ->srcu_gp_seq load
Message-ID: <20200218213806.GK2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-4-paulmck@kernel.org>
 <20200217124507.GT14914@hirez.programming.kicks-ass.net>
 <20200217183220.GS2935@paulmck-ThinkPad-P72>
 <20200218114334.GX14914@hirez.programming.kicks-ass.net>
 <20200218163405.GF2935@paulmck-ThinkPad-P72>
 <20200218202644.GG11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218202644.GG11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 18, 2020 at 09:26:44PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2020 at 08:34:05AM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 18, 2020 at 12:43:34PM +0100, Peter Zijlstra wrote:
> 
> > > Well, I didn't get further than the Changelog fails to describe an
> > > actual problem and it looks like compare-against-a-constant.
> > > 
> > > (worse, it masks off everything but the 2 lowest bits, so even if there
> > > was a problem with load-tearing, it still wouldn't matter)
> > 
> > There is still the possibility of load fusing. 
> 
> Agreed; that can be an issue. But if so, that then needs to be stated.
> 
> > And the possibility
> > of defending against possible future changes as well as the current
> > snapshot of the code base.
> 
> Sure; and like I said, if you want to use READ_ONCE() I'm not going to
> argue.
> 
> > > I'm not going to argue with you if you want to use READ_ONCE() vs
> > > data_race() and a comment to denote false-positive KCSAN warnings, but I
> > > do feel somewhat strongly that the Changelog should describe the actual
> > > problem -- if there is one -- or just flat out state that this is to
> > > make KCSAN shut up but the code is fine.
> > 
> > The problem is that "the code is fine" is highly subjective and varies
> > over time.  :-/
> > 
> > But in this case there was a real problem, just that I got confused
> > when analyzing.
> 
> Shit happens :-)
> 
> > > That is; every KCSAN report should be analysed, right? All I'm asking is
> > > for that analysis to end up in the Changelog.
> > 
> > Before responding further, I have to ask...
> > 
> > Are you intending your "every KCSAN report should be analyzed" to apply
> > globally or just when someone creates a patch based on such a report?
> 
> Ideally every KCSAN report, but that is a longer term effort. But
> specifically, when someone has written a patch, I expect that same
> someone to have analysed the code. Then it also makes sense to put that
> in the Changelog.
> 
> > In any case, you have acked this patch's successor (thank you very
> > much!), so on this specific patch (or more accurately, its successor)
> > I presume that we are all good.
> 
> We are. That new patch describes a clear problem and fixes it.
> 
> Anyway, the reaoson I'm being difficuly is partly because on the one
> hand I'm just an annoying pendant at times, but also because I've seen
> a bunch of, let's say, hasty, KCSAN patches.

Agreed.  I briefly considered putting KCSAN for RCU on the newbie list,
but looking at a few of them put paid to that idea.  Responding to them
properly does require a reasonably deep understanding of the code.

							Thanx, Paul
