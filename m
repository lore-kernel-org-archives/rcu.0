Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA4FC43334
	for <rcu@archiver.kernel.org>; Thu, 14 Jul 2022 20:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbiGNUwA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Jul 2022 16:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiGNUv7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Jul 2022 16:51:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E76758F
        for <rcu@vger.kernel.org>; Thu, 14 Jul 2022 13:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BE46BCE2B58
        for <rcu@vger.kernel.org>; Thu, 14 Jul 2022 20:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AF9C3411C;
        Thu, 14 Jul 2022 20:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657831915;
        bh=z6E6gykq/0uUKG8y2sW68fzFKfapeU3/He8EjmAapdc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Gvco012K19blm48hpCMdjhf5JuNDyXjjcFiPRRCrFTOTi2Ss61GIurHi+uuUmaNzf
         aIwGSmte4VggWETxCXo69HQxFjYOj5m7ZoicGMFTHLE/gY+ORe5CWn5mqgnnBJ4jlr
         csgbUj0fXB0IF744ZHioUS8t+/cyIf3SV8sW7rgrQ3+e7g+4Cke//wC+TeeohC6xlB
         Swtmb8ZzehItS45YTpKsUcJbk38ztcM7ydJtWqZEHITZpZDI6HHTcjq+8mm9gZc+rS
         uV4FTPyAwIS4pz4vIJQQRH9KiIXtDr4F0aUvFj9CFeZb2hvkmoJcRDC1xVzTAMXUne
         VIxZeEthU7GRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 94E7C5C0A40; Thu, 14 Jul 2022 13:51:54 -0700 (PDT)
Date:   Thu, 14 Jul 2022 13:51:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/5] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220713213237.1596225-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713213237.1596225-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 13, 2022 at 09:32:32PM +0000, Joel Fernandes (Google) wrote:
> Hello!
> 
> Please find the next improved version of call_rcu_lazy() attached.  The main
> difference between the previous versions is that:
> - In v2 rcu_barrier is fixed to not hang (I found this to be due to a missing
>   GP thread wakeup), now I am limiting this wake up only to rcu_barrier() as
>   requested by Paul.
> - Fixed checkpatch and build robot issues.
> - Some more changes to 'lazy' parameter passing and consolidation of segcblist
>   functions.
> - more testing via rcutorture and rcuscale.

Thank you!  What I am going to do is to pull these into an experimental
not-for-mainline branch and run the usual set of rcutorture tests.
I will then take a look at the patches.

> Note that these tests were run on v2 patches, I am expecting similar power
> improvements however I've not yet tested power.
> 
> Following are power savings we saw on top of RCU_NOCB_CPU on an Intel platform
> in v2.  The observation is that due to a 'trickle down' effect of RCU
> callbacks, the system is very lightly loaded but constantly running few RCU
> callbacks very often. This confuses the power management hardware that the
> system is active, when it is in fact idle.
> 
> For example, when ChromeOS screen is off and user is not doing anything on the
> system, we can see big power savings.
> Before:
> Pk%pc10 = 72.13
> PkgWatt = 0.58
> CorWatt = 0.04
> 
> After:
> Pk%pc10 = 81.28
> PkgWatt = 0.41
> CorWatt = 0.03

When you update these numbers, please explain what they all are and
evaluate them in the cover letter (or in the relevant patch's commit log).
For final submission, please also include some estimate of the variance.
For example, CorWatt might be essentially the same both before and after,
as in 0.035 and 0.034, or there might be a large difference, as in 0.044
and 0.025.  The 81.28 might be constant in all four digits (ha!), or it
might vary between (say) 80 and 83.  And so on.

Based on our earlier emails, my guess is that Pk%pc10 is the percent of
time that the system is in a low-power state (bigger is better), PkgWatt
is power consumed by the CPU chip (smaller is better), and CorWatt is
power consumed by the CPU core (again, smaller is better).

It all might sound painfully obvious to you right now, but please have
pity on future readers of this series.

> Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> can see that the display pipeline is constantly doing RCU callback queuing due
> to open/close of file descriptors associated with graphics buffers. This is
> attributed to the file_free_rcu() path which this patch series also touches.
> 
> On memory pressure, timeout or queue growing too big, we initiate a flush of of
> the bypass lists holding the lazy CBs.
> 
> Similar results can be achieved by increasing jiffies_till_first_fqs, however
> that also has the effect of slowing down RCU. Especially I saw huge slow down

In the final submission, please quantify "huge slow down".  ;-)

> of function graph tracer when increasing that. That may be possible to fix via
> rcu_expedited=1 boot parameter, however call_rcu_lazy() provides another option
> over slowing down ALL call_rcu() globally. Further using jiffies_till_first_fqs
> approach will still cause a wake up of the main RCU GP kthread, with this work
> we delay even those wakeups.
> 
> One drawback of this series is, if another frequent RCU callback creeps up in
> the future, that's not lazy, then that will again hurt the power. However, I
> believe identifying and fixing those is a more reasonable approach than slowing
> RCU down for the whole system.

Like I said earlier, you are the official call_rcu_lazy() whack-a-mole
developer.  ;-)

							Thanx, Paul

> Disclaimer: I have intentionally not CC'd other subsystem maintainers (like
> net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
> of review and agreements.
> 
> Joel Fernandes (Google) (4):
>   rcu: Introduce call_rcu_lazy() API implementation
>   rcuscale: Add laziness and kfree tests
>   fs: Move call_rcu() to call_rcu_lazy() in some paths
>   rcutorture: Add test code for call_rcu_lazy()
> 
> Vineeth Pillai (1):
>   rcu: shrinker for lazy rcu
> 
>  fs/dcache.c                                   |   4 +-
>  fs/eventpoll.c                                |   2 +-
>  fs/file_table.c                               |   2 +-
>  fs/inode.c                                    |   2 +-
>  include/linux/rcu_segcblist.h                 |   1 +
>  include/linux/rcupdate.h                      |   6 +
>  kernel/rcu/Kconfig                            |   8 +
>  kernel/rcu/rcu.h                              |  12 +
>  kernel/rcu/rcu_segcblist.c                    |  15 +-
>  kernel/rcu/rcu_segcblist.h                    |  20 +-
>  kernel/rcu/rcuscale.c                         |  74 +++++-
>  kernel/rcu/rcutorture.c                       |  60 ++++-
>  kernel/rcu/tree.c                             | 132 ++++++----
>  kernel/rcu/tree.h                             |  10 +-
>  kernel/rcu/tree_nocb.h                        | 239 ++++++++++++++----
>  .../selftests/rcutorture/configs/rcu/TREE11   |  18 ++
>  .../rcutorture/configs/rcu/TREE11.boot        |   8 +
>  17 files changed, 508 insertions(+), 105 deletions(-)
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> 
> -- 
> 2.37.0.144.g8ac04bfd2-goog
> 
