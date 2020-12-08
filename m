Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEFEC433FE
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D185E23A5B
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 14:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgLHOeZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgLHOeZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 09:34:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2594C061749;
        Tue,  8 Dec 2020 06:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SVCgdEyETcdSak9KarEgBeEBFYEAH8CDfRx9r+OybXE=; b=n6svlB0TaK+KXOOD0IfElbWisr
        lsc58MAYLqYsEfJr60fsj0w7AeBUONu1tIcMYsCGIUgTGj2PHgZ20XHmPd7YxSK5KHZtkG0HCPiJs
        BCf43bJhApz0oy+D38i6reSAaLXKX+4Shn3eVircED2rgLZHkhhamVigdj29MRA+djJTmR6/LG5W+
        tM9Sb83WVVv/GdwabN/QJOzH/FqD+lEbIwgRBPGZb1pWysT/btzwGng1Wkm0/qjVog0jHB5qKHyYx
        XkiD+xT7+8uh6uIHPFzXXQ0kwiNmwuYdzkHowdUzx3g+C+UnpEIgmMD98V8ia1iROH5496SMOAoT6
        O3W5bPtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kme3U-0000S2-AL; Tue, 08 Dec 2020 14:33:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1ABBA3006D0;
        Tue,  8 Dec 2020 15:33:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D97622365CC68; Tue,  8 Dec 2020 15:33:24 +0100 (CET)
Date:   Tue, 8 Dec 2020 15:33:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC lockdep 4/4] lockdep/selftest: Add wait context selftests
Message-ID: <20201208143324.GB2414@hirez.programming.kicks-ass.net>
References: <20201208103112.2838119-1-boqun.feng@gmail.com>
 <20201208103112.2838119-5-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208103112.2838119-5-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 08, 2020 at 06:31:12PM +0800, Boqun Feng wrote:
> These tests are added for two purposes:
> 
> *	Test the implementation of wait context checks and related
> 	annotations.
> 
> *	Semi-document the rules for wait context nesting when
> 	PROVE_RAW_LOCK_NESTING=y.

Documentation/locking/locktypes.rst should have that.

> The test cases are only avaible for PROVE_RAW_LOCK_NESTING=y, as wait
> context checking makes more sense for that configuration.

Looks about right ;-)
