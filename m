Return-Path: <SRS0=9J+a=7C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7F1C433E0
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 18:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478DF2072C
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 18:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="csPiNuNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETSgA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 May 2020 14:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETSf7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 May 2020 14:35:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DBC061A0E;
        Wed, 20 May 2020 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=LpP3njNeRQlE8pQN/rNMBpiRJ3syO8fJUum3/qmawto=; b=csPiNuNPAaI8C2B9I7+3BVXpP6
        t2g4rmNFkmh5xBRnw1JA3qY7k2C2Id0r36b3orlPJYdmJO9YZVdWLxwXeSuOV7ap2bMKwaFTWHbc6
        s3Osf4Bxet3PqhUXCZTzEz1DCTrOWYkB/LhuSe6LDNLTcb9M7caoRKXReq798pBgQhwf8ARAJCEfq
        OSJ5rgh1oiuoy90omdSEAqNyUrZudjJI7FmEPg78njYambgqwf3B3xo3I5hzCmIWnEXFx9xAZMkw3
        3oNHhfgxTGkUR3uZteTjCsrRdInH9SE7eQxjzOIPvcYF9qHewQ+4pV8lDAg+Zo10CfTseFOJalRNm
        NQqkffMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbTYy-0005GP-LJ; Wed, 20 May 2020 18:35:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C76D2305EEE;
        Wed, 20 May 2020 20:35:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A10E20C3437F; Wed, 20 May 2020 20:35:29 +0200 (CEST)
Date:   Wed, 20 May 2020 20:35:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200520183529.GR317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520174259.GA247557@google.com>
 <20200520182800.sdp6t6bgbhn4kkqk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520182800.sdp6t6bgbhn4kkqk@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 20, 2020 at 08:28:00PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-20 13:42:59 [-0400], Joel Fernandes wrote:
> > Hi Sebastian,
> Hi Joel,
> 
> > For pointer stability, can we just use get_local_ptr() and put_local_ptr()
> > instead of adding an extra lock? This keeps the pointer stable while keeping
> > the section preemptible on -rt. And we already have a lock in rcu_data, I
> > prefer not to add another lock if possible.
> 
> What is this get_local_ptr() doing? I can't find it anywhere…

I suspect it is ({ preempt_disable(); this_cpu_ptr(ptr); }), or
something along those lines.

But yeah, I can't find it either.
