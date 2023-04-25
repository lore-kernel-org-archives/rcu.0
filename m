Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C7EC6FD18
	for <rcu@archiver.kernel.org>; Tue, 25 Apr 2023 10:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjDYKOG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Apr 2023 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjDYKOF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Apr 2023 06:14:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CBD128;
        Tue, 25 Apr 2023 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Xao8VXHXtYxC11f7dTDeUqso5VLtQcIrTD4ahlklA8=; b=R2GEs91SzfaV305Pp+soejzYsE
        +eKEXbYoCK3TuI1jyR7yff98zE+cCgKNLqJZ+8ipEETxbVNwqBTzUnkMnPQ9YS4TDBm3FK7fYc+ip
        EdoaPNB43SYxk0LXdYuo/iKpeX8mb6/EXdDHp02+DvX16pmtanJkHbUEY0CLbyJ8UV1/1tVROkv2L
        6oy2yzYErfx6iOBJWaVbHVd3Ldaj8d8vDQt3Vn2qRNlSrwfen1waN63un8Pwk+FONpa2mjFlsHcVu
        nlJZXuF4wC15/UtMrZRh2H/2FKJSqWr+P/+HOqXdeXD8m/ivluScDKGCC1AadIgckMT3VPeE0+0dW
        7H7xkPyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prFfu-001Kl7-FN; Tue, 25 Apr 2023 10:13:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F26A33000D5;
        Tue, 25 Apr 2023 12:13:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C291241955DA; Tue, 25 Apr 2023 12:13:25 +0200 (CEST)
Date:   Tue, 25 Apr 2023 12:13:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
Message-ID: <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux>
 <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org>
 <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 24, 2023 at 02:55:11PM -0400, Joel Fernandes wrote:
> This is amazing debugging Boqun, like a boss! One comment below:
> 
> > > > Or something simple I haven't thought of? :)
> > >
> > > At what points can r13 change?  Only when some particular functions are
> > > called?
> > >
> >
> > r13 is the local paca:
> >
> >         register struct paca_struct *local_paca asm("r13");
> >
> > , which is a pointer to percpu data.
> >
> > So if a task schedule from one CPU to anotehr CPU, the value gets
> > changed.
> 
> It appears the whole issue, per your analysis, is that the stack
> checking code in gcc should not cache or alias r13, and must read its
> most up-to-date value during stack checking, as its value may have
> changed during a migration to a new CPU.
> 
> Did I get that right?
> 
> IMO, even without a reproducer, gcc on PPC should just not do that,
> that feels terribly broken for the kernel. I wonder what clang does,
> I'll go poke around with compilerexplorer after lunch.
> 
> Adding +Peter Zijlstra as well to join the party as I have a feeling
> he'll be interested. ;-)

I'm a little confused; the way I understand the whole stack protector
thing to work is that we push a canary on the stack at call and on
return check it is still valid. Since in general tasks randomly migrate,
the per-cpu validation canary should be the same on all CPUs.

Additionally, the 'new' __srcu_read_{,un}lock_nmisafe() functions use
raw_cpu_ptr() to get 'a' percpu sdp, preferably that of the local cpu,
but no guarantees.

Both cases use r13 (paca) in a racy manner, and in both cases it should
be safe.
