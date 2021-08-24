Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2B4C4320A
	for <rcu@archiver.kernel.org>; Tue, 24 Aug 2021 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AEB61360
	for <rcu@archiver.kernel.org>; Tue, 24 Aug 2021 13:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhHXNwk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhHXNwk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Aug 2021 09:52:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49DDC061757;
        Tue, 24 Aug 2021 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dphydDBhsChUJLwVEWb00CCa8GMnSbiXaH5DNPOezEE=; b=WgteAEox+UaTlhamNZdxg/s7qR
        z5eA3h8+N4u2yKj5aNwh4Otf8bP+nrCl+Q/ir19VSbLNr6kocFWJuP9kO531c5RhJA2pQcjOzt3K1
        x7W2alyXMnyn6sEDFCohsV7osUy5jLzDw9yLdQcj33/UGUOH7HqHLiX9r3hhdDG3XbeNkghzjSx74
        RfxjccfIoHISWBoUV/L124T1o3Zfrt+XDAibgcUZHl8eDt1VSllYVjzF3a7S8c8FAAeGgF70Od/hy
        +A0I3zLAngdCqBxx5/BONlehN8O4FVp9OpFEXsfmGpmgU5q2+/554EvCOc2ALx9kT9LoSTL9bLcwy
        UO0sDjjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIWnH-00B7Uv-6Y; Tue, 24 Aug 2021 13:49:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84199300024;
        Tue, 24 Aug 2021 15:48:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 756432C5B4A98; Tue, 24 Aug 2021 15:48:46 +0200 (CEST)
Date:   Tue, 24 Aug 2021 15:48:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH V2][RFC] lockdep: improve comments in wait-type checks
Message-ID: <YST4vtfcbJGKqoYD@hirez.programming.kicks-ass.net>
References: <20210811025920.20751-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811025920.20751-1-zhouzhouyi@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 11, 2021 at 10:59:20AM +0800, Zhouyi Zhou wrote:
> comments in wait-type checks be improved by mentioning the
> PREEPT_RT kernel configure option.
> 
> Many thanks
> Zhouyi
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Acked goes after sobs, fixed that for you.

Thanks!
