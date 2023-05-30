Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74151C77B7A
	for <rcu@archiver.kernel.org>; Tue, 30 May 2023 09:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjE3JfP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 May 2023 05:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjE3JfN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 May 2023 05:35:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA849C;
        Tue, 30 May 2023 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g7fUJD6rbDzuWW1q3C6cTYg4WrNyI/NCOvGUuWRnOEM=; b=RdnRnTEIcNgRZ0UFVkJouvlJEt
        KxXF6WttRbwn23A5ARXE7cbYAIPJYfm2RG2Nu2NfZRq5gmGrqq2PLX51oxmDrbA2lIj6g2kw+1F9K
        Qz6HHdqpve2uLWPt9HQsD+ChlisikQqKsh6a+BEIq+j7zyfftEzdiyiAC6Usy3TNmp2RqhlublK7A
        /i8kMDRq0jZhu+kYfADEBplGXAP9rOngZiStKHsRgcS9Zj67KfGxmOCsPgN5O8jy3DN1RBpKA/mLD
        ZShrfYrWgFrQP+6NbEATV/dLSZ8yV6FY1dqPcD3RXzNk+wDQ1Nv5/JhJIL0otmiwrL9cozcEFQ4Sc
        /EKGa0lA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3vkj-006AfG-7j; Tue, 30 May 2023 09:34:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A78783001C3;
        Tue, 30 May 2023 11:34:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D2A4214873C1; Tue, 30 May 2023 11:34:52 +0200 (CEST)
Date:   Tue, 30 May 2023 11:34:52 +0200
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
Message-ID: <20230530093452.GA153810@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 30, 2023 at 11:23:42AM +0200, Peter Zijlstra wrote:

> Yes, it's a wee bit more involved, but I'm thinking it gives a fair
> amount of flexibility and we don't need to ret rid of
> -Wdeclaration-after-statement.

One other thing I forgot to point put; it allows things like:

	int store_fd(int fd)
	{
		ptr_guard(fdput, f) = fdget(fd);
		void *ret;
		if (!f.file)
			return -EBADF;
		ret = xa_store(&xarray, f.file->private, f);
		if (xa_is_err(ret))
			return xa_err(ret);
		f = null_ptr(fdput); // xarray now owns f
		return 0;
	}

Where we can assign null_ptr() to clear the guard and inhibit the
cleanup function to pass ownership around.
