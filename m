Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5880DC3DA7A
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 16:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjAEQEm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Jan 2023 11:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjAEQEW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Jan 2023 11:04:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F51AA23;
        Thu,  5 Jan 2023 08:04:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47DB4B81B2B;
        Thu,  5 Jan 2023 16:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A05C433EF;
        Thu,  5 Jan 2023 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672934657;
        bh=yhqmO4W7iEj/wI0BPaNckvCdrqswNWLvZRYjSWx2gZQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aXWwkepPj1socKEmQkjlmFzLTlzZpWG3L4BzrXjzDqVabNfK6Wc/EmLFi2R09V3kL
         cAMA0+dy1OAVj6eZO5nHxr7bkJEAgDeTk8j8xktjx284bhOE1zG5BLWzZBeOZwYqAZ
         iZQs0r3xlW1V4p9syM2u2KEaUyKKnA4ri5jHB5BCW2d8637xoohHrCu5JJHthXuP5b
         RLQfLWVZsnGQOBCfqJ22dN1dM7jX0lE1ILp5riwS6FQVijWbiibk5Qum3RzbHzlHBj
         GRXdAnutL1p8908uwqfVCzxzHIcwPjPqo2F0f39frm4DbJEOmqip+tyktKEonQHnS+
         hFTtuNrFnPDbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 87B0D5C029A; Thu,  5 Jan 2023 08:04:17 -0800 (PST)
Date:   Thu, 5 Jan 2023 08:04:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH rcu 27/27] rcu: Remove CONFIG_SRCU
Message-ID: <20230105160417.GZ4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-27-paulmck@kernel.org>
 <87r0w9csqn.fsf@jogness.linutronix.de>
 <20230105152351.GP4028633@paulmck-ThinkPad-P17-Gen-1>
 <871qo9c71z.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qo9c71z.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 05, 2023 at 04:58:40PM +0106, John Ogness wrote:
> On 2023-01-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> $ git grep CONFIG_SRCU
> >> drivers/base/core.c:#ifdef CONFIG_SRCU
> >> drivers/base/core.c:#else /* !CONFIG_SRCU */
> >> drivers/base/core.c:#endif /* !CONFIG_SRCU */
> >> fs/locks.c:#if IS_ENABLED(CONFIG_SRCU)
> >> fs/locks.c:#else /* !IS_ENABLED(CONFIG_SRCU) */
> >> fs/locks.c:#endif /* IS_ENABLED(CONFIG_SRCU) */
> >> kernel/notifier.c:#ifdef CONFIG_SRCU
> >> kernel/notifier.c:#endif /* CONFIG_SRCU */
> >
> > In the -rcu tree, these are removed by these commits:
> >
> > 1798c5b6b0ea ("drivers/base: Remove CONFIG_SRCU")
> > 19aa50512372 ("fs: Remove CONFIG_SRCU")
> > fe0c9bd625ad ("kernel/notifier: Remove CONFIG_SRCU")
> >
> >> Should those be removed before this patch?
> >
> > When I merge the -rcu tree's "dev" branch with current mainline, "git
> > grep CONFIG_SRCU" gives me no output.  Am I fat-fingering something
> > here?
> 
> Sorry, I checked against the wrong branch. You are good.
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thank you, and I will apply this on the next rebase.

							Thanx, Paul
