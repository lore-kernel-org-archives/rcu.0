Return-Path: <SRS0=zn4Z=BJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC671C433E0
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 23:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C737E2083E
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 23:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596150913;
	bh=oxwyOx8jwW/tVMrcFjtdX/o8qfSOBbq4s5iWI+sSfew=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Q5t9LPo1K4AYbFHrY6HEbSGXk9toPhoeDc2fr+vivBQvNDtrK1LDkKS7a/zfxrDCC
	 fro3n0Ei4hIRN9woHdMJ7O4eMYqOa9U4E1ot99sSKLvgeJl0HUuNKGU3jd9xX56OH5
	 p1d2u1i6SrXyFVz3eMH4qYbqRKHW6E6NgLEuvTx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgG3XPN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgG3XPN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jul 2020 19:15:13 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA3D20809;
        Thu, 30 Jul 2020 23:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596150912;
        bh=oxwyOx8jwW/tVMrcFjtdX/o8qfSOBbq4s5iWI+sSfew=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0U6S0d3NMXQ4PzJpuzZLxpogk5zq5XW+i+bzVqUj88HTzm6lxR4tdRGJcY5PmVvRF
         cC/zIBgx5VnNfKQaYW+plxjlmEIjIx3m1L9Y9+ydR3G6VcTDZ7oFz8Bxk4Cx3WuHzx
         zmoUNvqwQpaaKozoeYTWld8/9E/bG3IPznLvM8Zo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B8FDC3522635; Thu, 30 Jul 2020 16:15:12 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:15:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org, arnd@arndb.de,
        bigeasy@linutronix.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        urezki@gmail.com, zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200730231512.GD9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
 <20200730222057.GA423051@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730222057.GA423051@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 31, 2020 at 12:20:57AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > Hello, Ingo!
> > 
> > This pull request contains the following changes:
> > 
> > 1.	Documentation updates.
> > 
> > 	https://lore.kernel.org/lkml/20200623000923.GA25047@paulmck-ThinkPad-P72
> > 
> > 2.	Miscellaneous fixes.
> > 
> > 	https://lore.kernel.org/lkml/20200623002128.GA25456@paulmck-ThinkPad-P72
> > 
> > 3.	kfree_rcu updates.
> > 
> > 	https://lore.kernel.org/lkml/20200624201200.GA28901@paulmck-ThinkPad-P72
> > 
> > 4.	RCU tasks updates.
> > 
> > 	https://lore.kernel.org/lkml/20200623002423.GA25869@paulmck-ThinkPad-P72
> > 
> > 5.	Read-side scalability tests.
> > 
> > 	https://lore.kernel.org/lkml/20200623002941.GA26089@paulmck-ThinkPad-P72
> > 
> > 6.	SRCU updates.
> > 
> > 	https://lore.kernel.org/lkml/20200623003310.GA26539@paulmck-ThinkPad-P72
> > 
> > 7.	Torture-test updates.
> > 
> > 	https://lore.kernel.org/lkml/20200623003731.GA26717@paulmck-ThinkPad-P72
> > 
> > All of these have been subjected to the kbuild test robot and -next
> > testing, and are available in the git repository based on v5.8-rc3 at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> > 
> > for you to fetch changes up to 13625c0a4074d3bab61b1dc70a828b574255f339:
> > 
> >   Merge branches 'doc.2020.06.29a', 'fixes.2020.06.29a', 'kfree_rcu.2020.06.29a', 'rcu-tasks.2020.06.29a', 'scale.2020.06.29a', 'srcu.2020.06.29a' and 'torture.2020.06.29a' into HEAD (2020-06-29 12:03:15 -0700)
> 
> >  61 files changed, 2395 insertions(+), 680 deletions(-)
> 
> Pulled into tip:core/rcu, thanks a lot Paul!
> 
> I assume the fix Uladzislau Rezki is working on will resolve Sebastian 
> Andrzej Siewior's objections?

One way or another, yes.  We have several options, but the nicest one
requires changes outside of RCU, so cannot be carried out in time for the
upcoming merge window.  If that fails, we have other less-nice options
that -can- be confined to RCU, at least in the short term.

But one way or another, the issue that Sebastian raised will be resolved.

							Thanx, Paul
