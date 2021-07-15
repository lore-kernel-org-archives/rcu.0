Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4F8C07E96
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 03:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60C46102A
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 03:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhGODym (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Jul 2021 23:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhGODym (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Jul 2021 23:54:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E877A61260;
        Thu, 15 Jul 2021 03:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626321109;
        bh=zIDGkmlUgIcJ8m1hju69tcRsdb7X1rACjkflE4i/S8M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J4LGlPDKjIyWxmNQMGq6+gL9PG/MTFmW6So3m0K4toC2VEGpR9B00yqlzZ8RsErDR
         Jvz+4IB8pweMsC2/Wi19i2C/qhtckSSCkCFpBV9636xsbt1FJY/b8CBAQWTqD112YO
         MTvV996YH5FzKVNK6nS/yNOOvNmKuCNLbGFTtQh/1Oy0uO/9JRC3hNv+mDLCqPFN+w
         cvYXFBuGsrM9DRK4EK4nod+ekDx1DZ/nxrPiHDUs/f2UuhyRYB2SlIlrLRfYYndeUN
         uE/kGRBc1zV9L4/DyyKYkd7g/3aGy141GSaC/u0xnXAyjzrVIxSk6HPF51WfUNKlMw
         0Rx2I0qbdZG3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 90AD15C03DE; Wed, 14 Jul 2021 20:51:49 -0700 (PDT)
Date:   Wed, 14 Jul 2021 20:51:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
Message-ID: <20210715035149.GI4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210713005645.8565-1-zhouzhouyi@gmail.com>
 <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
 <20210713131812.GV4397@paulmck-ThinkPad-P17-Gen-1>
 <20210713151908.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zO6WpaYW33V_Di5naxr1TRm0tokCmTZahDuXmRupxd=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2zO6WpaYW33V_Di5naxr1TRm0tokCmTZahDuXmRupxd=A@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 14, 2021 at 12:44:36PM +0800, Zhouyi Zhou wrote:
> On Tue, Jul 13, 2021 at 11:19 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Jul 13, 2021 at 06:18:12AM -0700, Paul E. McKenney wrote:
> > > On Tue, Jul 13, 2021 at 09:09:04AM -0400, Mathieu Desnoyers wrote:
> > > > ----- On Jul 13, 2021, at 12:16 AM, paulmck paulmck@kernel.org wrote:
> > > >
> > > > > On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
> > > > >> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > >>
> > > > >> Hi Paul,
> > > > >>
> > > > >> During my studying of RCU, I did a grep in the kernel source tree.
> > > > >> I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
> > > > >> should be CONFIG_TASKS_TRACE_RCU instead.
> > > > >>
> > > > >> Without memory fencing, the idle/userspace task inspection may not
> > > > >> be so accurate.
> > > > >>
> > > > >> Thanks for your constant encouragement for my studying.
> > > > >>
> > > > >> Best Wishes
> > > > >> Zhouyi
> > > > >>
> > > > >> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > >
> > > > > Good eyes, and those could cause real bugs, so thank you!
> > > >
> > > > Hi Paul,
> > > >
> > > > This makes me wonder: what is missing testing-wise in rcutorture to
> > > > catch those issues with testing before they reach mainline ?
> > >
> > > My guess:  Running on weakly ordered architectures.  ;-)
> >
> > And another guess:  A tool that identifies use of Kconfig options
> > that are not defined in any Kconfig* file.
> Based on Paul's second guess ;-),  I did a small research, and I think
> the best answer is to modify scripts/checkpatch.pl. We modify checkpatch.pl
> to identify use of Kconfig options that are not defined in any Kconfig* file.
> 
> As I am a C/C++ programmer, I would be glad to take some time to learn
> perl (checkpatch is implented in perl) first if no other volunteer is
> about to do it ;-)

I haven't heard anyone else volunteer.  ;-)

Others might have opinions on where best to implement these checks,
but I must confess that I have not given it much thought.

							Thanx, Paul
