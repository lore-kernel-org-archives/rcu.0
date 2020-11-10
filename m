Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2236C388F7
	for <rcu@archiver.kernel.org>; Tue, 10 Nov 2020 09:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4622420781
	for <rcu@archiver.kernel.org>; Tue, 10 Nov 2020 09:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hKtZEUZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgKJJZg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Nov 2020 04:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgKJJZf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Nov 2020 04:25:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE05C0613CF;
        Tue, 10 Nov 2020 01:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wq+ij2TJkR5cIhqi0Eotd597W/3lBKoslQHpf2US1aA=; b=hKtZEUZSclJesS/lCykU15ktfx
        S4sVoP2e55tAFshBHiP+kGDet8JNX5wpPVCeBeSpLRRWZn5j2IWY99dSibLc4zZWzow17wQblmOGm
        fnZ2LXA/EP7BBZXgRGntzesiL2zuQjd72I6IwI7KUHoevbB6EW032r0M3NwCLidFwcGMBOv36qODp
        pwjarbHliy72aD7GMcJkLGyY/WEfoila0pdpUkCF/oM2vlPiyg3PZ4jA3bZ8NRSX1HxcfGg39wvri
        kkeFfx8rTmHV0i7h5HaS6dRviO67QkOJOjzGfBMj2khGeJwZpRFuS0goWeo+1OHjPpr9nSzRDzWHl
        X7gIhMvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcPtk-0001yg-Ra; Tue, 10 Nov 2020 09:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D77BD301E02;
        Tue, 10 Nov 2020 10:25:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 876442C09A7E0; Tue, 10 Nov 2020 10:25:05 +0100 (CET)
Date:   Tue, 10 Nov 2020 10:25:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Hui Su <sh_def@163.com>
Subject: Re: [PATCH tip/core/rcu 4/4] docs/rcu: Update the call_rcu() API
Message-ID: <20201110092505.GY2594@hirez.programming.kicks-ass.net>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-4-paulmck@kernel.org>
 <20201109122424.GN2594@hirez.programming.kicks-ass.net>
 <20201110012032.GN3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110012032.GN3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 09, 2020 at 05:20:32PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 09, 2020 at 01:24:24PM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 05, 2020 at 03:05:10PM -0800, paulmck@kernel.org wrote:
> > > From: Hui Su <sh_def@163.com>
> > > 
> > > This commit updates the documented API of call_rcu() to use the
> > > rcu_callback_t typedef instead of the open-coded function definition.
> > > 
> > > Signed-off-by: Hui Su <sh_def@163.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  Documentation/RCU/whatisRCU.rst | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > > index fb3ff76..1a4723f 100644
> > > --- a/Documentation/RCU/whatisRCU.rst
> > > +++ b/Documentation/RCU/whatisRCU.rst
> > > @@ -497,8 +497,7 @@ long -- there might be other high-priority work to be done.
> > >  In such cases, one uses call_rcu() rather than synchronize_rcu().
> > >  The call_rcu() API is as follows::
> > >  
> > > -	void call_rcu(struct rcu_head * head,
> > > -		      void (*func)(struct rcu_head *head));
> > > +	void call_rcu(struct rcu_head *head, rcu_callback_t func);
> > 
> > Personally I much prefer the old form, because now I have to go look up
> > rcu_callback_t to figure out wtf kind of signature is actually required.
> 
> How about if this part of the documentation read as follows:
> 
> 	typedef void (*rcu_callback_t)(struct rcu_head *head);
> 	void call_rcu(struct rcu_head *head, rcu_callback_t func);
> 
> Wold that help?

Sure; but now it's more verbose than it was ;-)
