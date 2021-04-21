Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5235CC433ED
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 17:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285446145D
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 17:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbhDURam (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:30:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242135AbhDURam (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Apr 2021 13:30:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF1146145A;
        Wed, 21 Apr 2021 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619026209;
        bh=Kg+L7L5MnQr8ri1Son24ac2eGLQrFFY6Xdrl0VYSxQI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pbcvQO5igVyhs1GtiLnZkxt231dSqHE6eLSTBn8V/FRIDlUwNZmOaF8lDuGGRi2nc
         g/x9BAoPkU4C3kuJlhO8BHgpeBva7FqBmqs7crBYljbnHGqomkEZ2owWOJq1rWPNzG
         JD0kPZtkXqngPUwwjSxwrZY14MfFRefB609m8A1vZJb25mLgtroKsv4cUZ8iCjOTlb
         cMxPX6DFjJcgXknORd17sFgApZcaQdzN2l4XmYXEEIXZQ7bRG7b1eAOnxPYl9Wfalx
         ixKwgb/rt3xst7rOycH6VVSI9Z47isYxtMem6yYe3JH2LTMNgTCslhULbgpvO+16ql
         NbZZ/UrkrGt3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 879D15C0267; Wed, 21 Apr 2021 10:30:08 -0700 (PDT)
Date:   Wed, 21 Apr 2021 10:30:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/2] bitmap_parselist: support 'all' semantics
Message-ID: <20210421173008.GV975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210421031326.72816-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421031326.72816-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 20, 2021 at 08:13:24PM -0700, Yury Norov wrote:
> RCU code supports a special group 'all' which selects all bits in a bitmap.
> We have recently added 'N' extension for bitmap parse, so that '0-N' would
> have exactly the same meaning as 'all'. But because the 'all' is already
> used by RCU, it would be reasonable to support it in core bitmap code as a
> common and easy-readable alias for '0-N'.
> 
> Moving the 'all' support to core bitmap code adds another level of
> flexibility for system configuration by supporting patterns. For example,
> every second bit in cpumask may be selected like this:
> 	isolcpus=all:1/2
> 
> v2:
>  - cleanup patch 1;
>  - in patch 2 explain why dropping legacy comment.

Nice!

I have pulled this into -rcu with some minor updates, including replacing
the "isolcpus=all" with "rcu_nocbs=all:1/2" per Steve Rostedt's feedback.

Could you please check to make sure that I didn't mess anything up?

If tests go well, this will go into -next later today or tomorrow.
Although I cannot prove that this will not make the upcoming merge window,
but Murphy insists that it will instead be the v5.14 merge window.

							Thanx, Paul

> Yury Norov (2):
>   bitmap_parse: support 'all' semantics
>   rcu/tree_plugin: don't handle the case of 'all' CPU range
> 
>  Documentation/admin-guide/kernel-parameters.rst | 5 +++++
>  kernel/rcu/tree_plugin.h                        | 9 +++------
>  lib/bitmap.c                                    | 9 +++++++++
>  lib/test_bitmap.c                               | 7 +++++++
>  4 files changed, 24 insertions(+), 6 deletions(-)
> 
> -- 
> 2.25.1
> 
