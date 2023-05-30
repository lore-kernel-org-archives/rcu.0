Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B20AC7EE23
	for <rcu@archiver.kernel.org>; Tue, 30 May 2023 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjE3J1h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 May 2023 05:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjE3J1S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 May 2023 05:27:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C091E77;
        Tue, 30 May 2023 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YGnwDGPWaj1wM5ohiXtoRKNtCYZ1i8Q7KV5owZIHFf0=; b=DjY1MJJiu6hf7xjfPEede0fXKw
        EXw5HsAeuiGhaxVwsAzllEUOGYYYTU2DfOei8MfAgi8mPP3FnZCJsFJcTI5NV8xSlfKocHHeZx02U
        wMh5+a8lqTNEEytvd9QmKxxCQf+6Vz0q2lt39tRfv15c5uYwTWWedBzls+f1+FyRWZ6mLJVpmjdjL
        nmxRAYDGnwnfMhJa3/Cfm3F92l0eCQRXFBiSzZwi4mThZPgCtaQhcqmrA8N2tQYlR805K3CUoGTb2
        7+dYhZckEr89Dboqd3SWEwI+hf2rR9S22cowGo1cHj+O+bZERYADKgZDcNikJEeAe4cH7PzHsj0iF
        ljLI86ag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3vcF-006AJ1-T4; Tue, 30 May 2023 09:26:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75C8F3001C3;
        Tue, 30 May 2023 11:26:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D396214873C3; Tue, 30 May 2023 11:26:07 +0200 (CEST)
Date:   Tue, 30 May 2023 11:26:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <20230530092607.GB149947@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, May 27, 2023 at 12:18:04PM -0700, Linus Torvalds wrote:

> And before you say "unlock order doesn't matter" - that's actually not
> true. Unlock order does matter when you have things like
> "spin_lock_irq()" where the irq-off region then protects other locks
> too.

So I had already verified that GCC keeps them ordered, I see the
subthread with Ian and the documentation update request -- so all good
there.

Also, lockdep would scream bloody murder if you get that wrong, so I
can certainly add something to the selftests that would detect this.

