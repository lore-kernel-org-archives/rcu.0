Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AE2C4727E
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA226208C7
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601568236;
	bh=tPAbUsIyJx/7A7VHjxZeeEsElWnfl/HBPtl67O4vTvc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OluzIxR945xUM8Q/4XLIk1umFp8YT0yn+AS2sXyfe7JFr6i9r2HwvuYwHouR4I2nW
	 GUAZCyYFhkqYnqrhoYadW91Xqm4Oqp7/jfpQ2Nx62S4cD+2JjN3/CeFTpE7qa6zav3
	 7S7xWvEe/4fTo9FNnDPzL0XFXj5dDILdXEeDZYTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgJAQDz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732242AbgJAQDz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 12:03:55 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0124620872;
        Thu,  1 Oct 2020 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601568235;
        bh=tPAbUsIyJx/7A7VHjxZeeEsElWnfl/HBPtl67O4vTvc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HvzwcNriJ1FpPxUkkMHDDjM8CjnqGRzMzcIOPJ00vQgPr1sbggefQpPQRzKfXGQkC
         NS69q07UzhQsb1c/SWQoajUgnWuHFPtlWhrsmznKxJfoz0gb2FAG/5A4V22q9/yv/F
         Vi1dJ9FEFq0fDdvPTWhlUWhTXMHtBYgMHn5q6gc8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BC88D3522B33; Thu,  1 Oct 2020 09:03:54 -0700 (PDT)
Date:   Thu, 1 Oct 2020 09:03:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH tip/core/rcu 11/15] drm/i915: Cleanup PREEMPT_COUNT
 leftovers
Message-ID: <20201001160354.GC29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-11-paulmck@kernel.org>
 <160153665673.4398.6268028176406103680@jlahtine-mobl.ger.corp.intel.com>
 <871riigxp9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871riigxp9.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 01, 2020 at 10:25:06AM +0200, Thomas Gleixner wrote:
> On Thu, Oct 01 2020 at 10:17, Joonas Lahtinen wrote:
> > Quoting paulmck@kernel.org (2020-09-29 02:30:58)
> >> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> >> removed. Cleanup the leftovers before doing so.
> >
> > Change looks fine:
> >
> > Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Applied, thank you!

> > Are you looking for us to merge or merge through another tree?
> >
> > If us, did the base patch always enabling PREEMPT_COUNT go into 5.9 or is
> > it heading to 5.10? We can queue this earliest for 5.11 as drm-next closed
> > for 5.10 at week of -rc5.
> 
> If at all it goes through rcu/tip because it depends on the earlier patches.

I was figuring on sending a pull request later today, Pacific Time.

							Thanx, Paul
