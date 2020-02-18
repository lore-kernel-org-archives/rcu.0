Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB33BC34031
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 07:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E612176D
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 07:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5dnJOjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgBRH5J (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:57:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgBRH5J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 02:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AExAkzw9n/z+X9jSusHiiwiSq/UXf7xpnYR0xiHMOyU=; b=A5dnJOjyYViUeAiDMa7tNb6JvK
        H3laV49Wjbunu0kUtvHCKX5N3rjDU/dblyKV6QIAcJqjBlWdgxMGT/XmYq6P5ZajjCo5495V8wMqQ
        j1dWpqyoKpMwcdmY14ENO/7r8n+LKVjBGZskMb48Ean220PMfEwgNRFI6D3PW66OvL6CEN7hGR95K
        7h0MOJJun0t0XzG4vwT1/oibYSuKkSTRy5At+/i0+XOcJ/huh5/3CUzjH1dbr60C8DtGyxWdT8fR7
        Av9UjwXHfoKTKGUaWv4LXnn6Nj+3kWAFwf2VdO7ozFCwtKAIQGHmmSeYN/yPDZkx9TIpl2sCKJ7FO
        FeDSjyiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3xkS-0004Vs-6U; Tue, 18 Feb 2020 07:56:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23EEE300606;
        Tue, 18 Feb 2020 08:54:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B982F201482E9; Tue, 18 Feb 2020 08:56:48 +0100 (CET)
Date:   Tue, 18 Feb 2020 08:56:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200218075648.GW14914@hirez.programming.kicks-ass.net>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217181615.GP2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217181615.GP2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 10:16:16AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 17, 2020 at 01:38:51PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 14, 2020 at 04:25:18PM -0800, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > The RCU tasks list of callbacks, rcu_tasks_cbs_head, is sampled locklessly
> > > by rcu_tasks_kthread() when waiting for work to do.  This commit therefore
> > > applies READ_ONCE() to that lockless sampling and WRITE_ONCE() to the
> > > single potential store outside of rcu_tasks_kthread.
> > > 
> > > This data race was reported by KCSAN.  Not appropriate for backporting
> > > due to failure being unlikely.
> > 
> > What failure is possible here? AFAICT this is (again) one of them
> > load-complare-against-constant-discard patterns that are impossible to
> > mess up.
> 
> First, please keep in mind that this is RCU code.  Rather uncomplicated
> for RCU, to be sure, but still RCU code.
> 
> The failure modes are thus as follows:
> 
> o	I produce a patch for which KCSAN gives a legitimate warning,
> 	but this warning is obscured by a pile of other warnings.
> 	Yes, we should continue improving KCSAN's ability to adapt
> 	to the users desired compiler-optimization risk level, but
> 	in RCU's case that risk level is set quite low.
> 
> 	In RCU, what others are calling false positives are therefore
> 	addressed.  Yes, this does cost me a bit of work, but it is
> 	trivial compared to the work required to track down a real bug.
> 
> o	Someone optimizes or otherwise changes the wait/wakeup code,
> 	which inadvertently gives the compiler more scope for mischief.
> 
> In short, within RCU, I am handling all KCSAN complaints.  This is looking
> to be an extremely inexpensive insurance policy for RCU.  Other subsystems
> are of course free to make their own tradeoffs, and subsystems having
> less-aggressive concurrency control might be well-advised to take a
> different path than the one I am taking.

I just took offence at the Changelog wording. It seems to suggest there
actually is a problem, there is not.
