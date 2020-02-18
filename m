Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5991DC3404B
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339FF2173E
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 20:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oen+0qmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBRU1G (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:27:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgBRU1F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 15:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MsmkZg6wZrEhezy9R5YbQTUgrdTDhzPB+OkYnO5Pl0U=; b=Oen+0qmNRjfXIHYz20JeeFGcoE
        QEkZxoj1f8cyZZrwUcdG+/PN62xbB41Ig8cC4hmVseF2UTRP6/MwtB5RjknENoDaVceDgK5dGOhUX
        704AD+q+nLumZg0j5/aE3dqIYNE/It3a4G/NhNwCDBj5EqCxTnyS+imld0ZwuUSmV9LrNvbxfnv52
        DI4nKSzCxOVDC9+1xH3kWbx2ZvvUM9jP8rm2qDL4yr/S08OSAbypMRojEuzG57MXl/upMFsyiiP/0
        PA/WFbjCMGcTdBSgWV0saNu+kZMEr/qIUdvpZGB0q/jvEjQmxmbyHIut7K0tj/g8GYGVEjeoiEyy2
        m2EXOsNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j49SB-0004D6-3O; Tue, 18 Feb 2020 20:26:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F2E4980E56; Tue, 18 Feb 2020 21:26:45 +0100 (CET)
Date:   Tue, 18 Feb 2020 21:26:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 4/4] srcu: Add READ_ONCE() to srcu_struct
 ->srcu_gp_seq load
Message-ID: <20200218202644.GG11457@worktop.programming.kicks-ass.net>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-4-paulmck@kernel.org>
 <20200217124507.GT14914@hirez.programming.kicks-ass.net>
 <20200217183220.GS2935@paulmck-ThinkPad-P72>
 <20200218114334.GX14914@hirez.programming.kicks-ass.net>
 <20200218163405.GF2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218163405.GF2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 18, 2020 at 08:34:05AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 18, 2020 at 12:43:34PM +0100, Peter Zijlstra wrote:

> > Well, I didn't get further than the Changelog fails to describe an
> > actual problem and it looks like compare-against-a-constant.
> > 
> > (worse, it masks off everything but the 2 lowest bits, so even if there
> > was a problem with load-tearing, it still wouldn't matter)
> 
> There is still the possibility of load fusing. 

Agreed; that can be an issue. But if so, that then needs to be stated.

> And the possibility
> of defending against possible future changes as well as the current
> snapshot of the code base.

Sure; and like I said, if you want to use READ_ONCE() I'm not going to
argue.

> > I'm not going to argue with you if you want to use READ_ONCE() vs
> > data_race() and a comment to denote false-positive KCSAN warnings, but I
> > do feel somewhat strongly that the Changelog should describe the actual
> > problem -- if there is one -- or just flat out state that this is to
> > make KCSAN shut up but the code is fine.
> 
> The problem is that "the code is fine" is highly subjective and varies
> over time.  :-/
> 
> But in this case there was a real problem, just that I got confused
> when analyzing.

Shit happens :-)

> > That is; every KCSAN report should be analysed, right? All I'm asking is
> > for that analysis to end up in the Changelog.
> 
> Before responding further, I have to ask...
> 
> Are you intending your "every KCSAN report should be analyzed" to apply
> globally or just when someone creates a patch based on such a report?

Ideally every KCSAN report, but that is a longer term effort. But
specifically, when someone has written a patch, I expect that same
someone to have analysed the code. Then it also makes sense to put that
in the Changelog.

> In any case, you have acked this patch's successor (thank you very
> much!), so on this specific patch (or more accurately, its successor)
> I presume that we are all good.

We are. That new patch describes a clear problem and fixes it.

Anyway, the reaoson I'm being difficuly is partly because on the one
hand I'm just an annoying pendant at times, but also because I've seen
a bunch of, let's say, hasty, KCSAN patches.
