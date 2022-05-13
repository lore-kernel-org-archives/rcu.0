Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C86C433F5
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 00:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359168AbiEMAXQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 20:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358471AbiEMAXP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 20:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E19E712EA
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 17:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEAE862097
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 00:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D41C385B8;
        Fri, 13 May 2022 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652401393;
        bh=vKzAvtSWR2YYVs9hLRyr1oQQjbkD44u5oECq1yiSLU0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=E1MgO84+w2iwiHCMV32sdVxag4k5U7kYN/HdqbLbxmPqkRhiWfENV7gaRa/awRxDX
         qNGdQ4a2FTohJGFSns12ai3e8Lw3Su4gdiLcY1Oj3rP99BjMi2FDlQyNjMxxXYKKja
         pj6Ojkn4xUYkLRRLkWr9IqtVsY+DX0PdikHB00lnLhtnxBlXAPv3fyzWkW3WIIhc9C
         HmSspbIIdEICFFtISm8bQJ9cX6gDecA0tqTzxUyS4ZtpaFRiMHOf7rqj8kaJuRWbNX
         07GS7aH0meHr4J+rVz6pWOgCoBpa8N0ntltnsbjzXiuAYAOsVbHiEwkOweBwreUEr/
         EnoOLBFWVk97w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C1DF85C051B; Thu, 12 May 2022 17:23:12 -0700 (PDT)
Date:   Thu, 12 May 2022 17:23:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <20220513002312.GB1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 11, 2022 at 11:17:59PM -0400, Joel Fernandes wrote:
> On Wed, May 11, 2022 at 11:04 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > Hello!
> > Please find the proof of concept version of call_rcu_lazy() attached. This
> > gives a lot of savings when the CPUs are relatively idle. Huge thanks to
> > Rushikesh Kadam from Intel for investigating it with me.
> >
> > Some numbers below:
> >
> > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > system is very lightly loaded but constantly running few RCU callbacks very
> > often. This confuses the power management hardware that the system is active,
> > when it is in fact idle.
> >
> > For example, when ChromeOS screen is off and user is not doing anything on the
> > system, we can see big power savings.
> > Before:
> > Pk%pc10 = 72.13
> > PkgWatt = 0.58
> > CorWatt = 0.04
> >
> > After:
> > Pk%pc10 = 81.28
> > PkgWatt = 0.41
> > CorWatt = 0.03
> >
> > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > can see that the display pipeline is constantly doing RCU callback queuing due
> > to open/close of file descriptors associated with graphics buffers. This is
> > attributed to the file_free_rcu() path which this patch series also touches.
> >
> > This patch series adds a simple but effective, and lockless implementation of
> > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > initiate a flush of one or more per-CPU lists.
> >
> > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > of function graph tracer when increasing that.
> >
> > One drawback of this series is, if another frequent RCU callback creeps up in
> > the future, that's not lazy, then that will again hurt the power. However, I
> > believe identifying and fixing those is a more reasonable approach than slowing
> > RCU down for the whole system.
> >
> > NOTE: Add debug patch is added in the series toggle /proc/sys/kernel/rcu_lazy
> > at runtime to turn it on or off globally. It is default to on. Further, please
> > use the sysctls in lazy.c for further tuning of parameters that effect the
> > flushing.
> >
> > Disclaimer 1: Don't boot your personal system on it yet anticipating power
> > savings, as TREE07 still causes RCU stalls and I am looking more into that, but
> > I believe this series should be good for general testing.

Sometimes OOM conditions result in stalls.

> > Disclaimer 2: I have intentionally not CC'd other subsystem maintainers (like
> > net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
> > of review and agreements.

We will of course need them to look at the call_rcu_lazy() conversions
at some point, but in the meantime, experimentation is fine.  I looked
at a few, but quickly decided to defer to the people with a better
understanding of the code.

> I did forget to add Disclaimer 3, that this breaks rcu_barrier() and
> support for that definitely needs work.

Good to know.  ;-)

With this in place, can the system survive a userspace close(open())
loop, or does that result in OOM?  (I am not worried about battery
lifetime while close(open()) is running, just OOM resistance.)

Does waiting for the shrinker to kick in suffice, or should the
system pressure be taken into account?  As in the "total" numbers
from /proc/pressure/memory.

Again, it is very good to see this series!

							Thanx, Paul
