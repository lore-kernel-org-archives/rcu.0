Return-Path: <SRS0=VCsE=EP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0499CC2D0A3
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 12:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84964206CB
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 12:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pjhICHrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgKIMV5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgKIMV4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Nov 2020 07:21:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F78C0613CF;
        Mon,  9 Nov 2020 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lo1/YZJ60PDURw//yTKYZnX3pdE1wM16etWDAmUtFRw=; b=pjhICHrM3eR4uIrNFE4t/28ZFK
        1j9Du9Tq+OjnCR8k4XxcUymdhlaBzmdAPspUA8GbUuGGLSdUkAB2irMJ1Km5qy/3+1/AXtxD+VRyF
        AHeC1U7hmSElLZNKDc26GidSnfu01Y1n/qxp/PTGpadnToggGm7RpTrP/TirXts95aiSuqyFMtuFB
        kwGkT9cIg/DTx5nE6wqSReHOIMiMBFicrpneUhZA1dd8lpBteemH8HjobgVW9+VMuoEqjv3Nya9FO
        1+Gt0m/4RW/PBYkYh9jsQdUs8x5GDPXIeU0eyIl9xzu6dFJdAjL7S0iYuI066QdrITasayx8HmDMq
        1r2mk3uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc6Ax-0001RS-Kq; Mon, 09 Nov 2020 12:21:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FAA4306099;
        Mon,  9 Nov 2020 13:21:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D993203C5333; Mon,  9 Nov 2020 13:21:33 +0100 (CET)
Date:   Mon, 9 Nov 2020 13:21:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/4] doc: Present the role of READ_ONCE()
Message-ID: <20201109122133.GL2594@hirez.programming.kicks-ass.net>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105230510.18660-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 05, 2020 at 03:05:07PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds an explanation of the special cases where READ_ONCE()
> may be used in place of a member of the rcu_dereference() family.

I am confused, there is no actual difference between rcu_dereference()
and READ_ONCE() today. So we _may_ use READ_ONCE() at all times.

Now granted, we probably don't want that, but that does leave me
somewhat confused vs the wording here.
