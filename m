Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ACFC34026
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 11:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF991207FD
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 11:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tscj4Oj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgBRLoH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:44:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgBRLoH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 06:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G/0EgupJEaHk9RaTtMo/9IBvZaaTF/4ZawtZFbgF/9E=; b=Tscj4Oj8Yj316IA3nRe7+EQqNk
        NDVNlRcWFSpj2cy67ISumsXr2T9KNj8QEICy4OBpbVi70qzA6hBkPqK00PZzZVCAxLvrplWrdz3ST
        IHS+yj6A9MIvZH3JpoU0va3VZCOShingHwW3jxEUQ30mdiFSo1R3DNXlBXfw75gGw7/NmwypH9R8s
        cuSMlDoIWUFyfOK49j8DrkzywWPDJTDIRFVOAPEJ9LuVXKyIb6JpJQEZ3UQtEAcTCNSKfLwL1yQ0/
        7X50tEg8vPxXAJ4ynQ7ga2hvBLAKjh3g2j9Gl+MhJFfj5fW+AWR3S6RyC3KMA6Ljrz413k/ItFzz8
        EuCbySnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j41Hu-0002QZ-9u; Tue, 18 Feb 2020 11:43:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52FB630008D;
        Tue, 18 Feb 2020 12:41:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00124203E6A01; Tue, 18 Feb 2020 12:43:34 +0100 (CET)
Date:   Tue, 18 Feb 2020 12:43:34 +0100
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
Message-ID: <20200218114334.GX14914@hirez.programming.kicks-ass.net>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-4-paulmck@kernel.org>
 <20200217124507.GT14914@hirez.programming.kicks-ass.net>
 <20200217183220.GS2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217183220.GS2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 10:32:20AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 17, 2020 at 01:45:07PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 14, 2020 at 04:29:32PM -0800, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > The load of the srcu_struct structure's ->srcu_gp_seq field in
> > > srcu_funnel_gp_start() is lockless, so this commit adds the requisite
> > > READ_ONCE().
> > > 
> > > This data race was reported by KCSAN.
> > 
> > But is there in actual fact a data-race? AFAICT this code was just fine.
> 
> Now that you mention it, the lock is held at that point, isn't it?  So if
> that READ_ONCE() actually does anything, there is a bug somewhere else.
> 
> Good catch, I will drop this patch, thank you!

Well, I didn't get further than the Changelog fails to describe an
actual problem and it looks like compare-against-a-constant.

(worse, it masks off everything but the 2 lowest bits, so even if there
was a problem with load-tearing, it still wouldn't matter)

I'm not going to argue with you if you want to use READ_ONCE() vs
data_race() and a comment to denote false-positive KCSAN warnings, but I
do feel somewhat strongly that the Changelog should describe the actual
problem -- if there is one -- or just flat out state that this is to
make KCSAN shut up but the code is fine.

That is; every KCSAN report should be analysed, right? All I'm asking is
for that analysis to end up in the Changelog.

> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/srcutree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 119a373..90ab475 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -678,7 +678,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> > >  
> > >  	/* If grace period not already done and none in progress, start it. */
> > >  	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
> > > -	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
> > > +	    rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_IDLE) {
> > >  		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
> > >  		srcu_gp_start(ssp);
> > >  		if (likely(srcu_init_done))
> > > -- 
> > > 2.9.5
> > > 
