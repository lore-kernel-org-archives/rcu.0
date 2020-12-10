Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD072C433FE
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 17:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CC123A7C
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 17:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392761AbgLJRdj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 12:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392735AbgLJRc6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 12:32:58 -0500
Date:   Thu, 10 Dec 2020 09:32:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607621535;
        bh=4/WHkUzeavj9mKcv+TASwIh8F5hNbpMIM5yLpToKpK0=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XICNLYjULpeYoLlXnIndCGEhUCi2jHlOd95cWN4uztiQCFhwmlZkWPIE4DogpsEiU
         /2deG+dNKzAU2sdoUEOwG6zN48Z0wKFCsSw4lvslFPK6TDsDj4obEiGfBNwzVIF4ki
         uI7EbzIaQGwLvZTjr3Ocge/XnZmWW2bFfUE76pbi4QMkS3QOfCC5e5QKFAxhCKgv4B
         0tfUcumLv2eSw6x3ZFFiHBXbKrgY6DJ5vHA9vczaE5wmm77T0oMbJc/sOogI5+mbu7
         ICtvRJHg6xj7g8B/7On7i40zvNWtmPlWCTWWnZoBAHe1uniZttcbxJiKelLyn5ORlT
         jxcDtvWT1SIQg==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/2] rcu-tasks: move RCU-tasks initialization out of
 core_initcall()
Message-ID: <20201210173214.GU2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209203728.GA5972@pc638.lan>
 <875z59hjau.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z59hjau.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 11, 2020 at 12:39:21AM +1100, Daniel Axtens wrote:
> Hi Vlad,
> 
> >> Initialize the RCU-tasks earlier, before *_initcall() callbacks are
> >> invoked. Do it after the workqueue subsytem is up and running. That
> >> gives us a possibility to make use of synchronize_rcu_tasks*() wait
> >> API in early_initcall() callbacks.
> >> 
> >> Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> >> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Tested-by: Daniel Axtens <dja@axtens.net>

I will apply on the next rebase, thank you!

							Thanx, Paul

> >> ---
> >>  include/linux/rcupdate.h |  6 ++++++
> >>  init/main.c              |  1 +
> >>  kernel/rcu/tasks.h       | 26 ++++++++++++++++++++++----
> >>  3 files changed, 29 insertions(+), 4 deletions(-)
> >> 
> > I still don't have a powerPC hw so far, even though i have sent a request
> > to the osuosl.org. It would be appreciated if Michael or Daniel could run
> > and verify it.
> 
> Sorry it's taken me so long to get to this. Your patch fixes things for
> me. Thanks!
> 
> BTW, I'm happy to see you taking on the challenge of RCU after your good
> work on vmalloc - all the best with it!
> 
> Kind regards,
> Daniel
> 
> >
> > Thank you in advance!
> >
> > --
> > Vlad Rezki
