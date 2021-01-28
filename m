Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7953BC433E6
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298B764DFB
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 14:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhA1O7j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232298AbhA1O6z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 09:58:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7FAE64DE8;
        Thu, 28 Jan 2021 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611845893;
        bh=70skHL26c2uu6S1xdkaZjxMf+ykcMABGtYclFtKAfcg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OguBSFVkSHqI1jyK8IOJ9tmmFkeG1MMSkHM0jk/O9eV6uMTB799yFf3Ck73uLHEyj
         laVerO1xPgp3QSNZWAyOHQUnVXPWo9rsuRxuEov/KoMixq+T7WTF1XK208Xoj+zG+j
         /Wkb77qyiKjalBH6RDzuLIPMXUCuD5aTdTxAEBGy4goJ4b9nedbXj7kOUubpF8TC2j
         uvOTgbrvrwq3xUpwQsZTyjGW8oaRJmlvncMOjvtthOLGXiPMnjkHXtzU64sPVUQMx7
         7lGkAP8UtbHsl6Balo/4JxkZsrcSj8HVrFm9FivltvU3Jd4PuUmEhi0nj5PRO5UbAe
         CNkdk9hObQWOw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 61CD03522748; Thu, 28 Jan 2021 06:58:13 -0800 (PST)
Date:   Thu, 28 Jan 2021 06:58:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kdump always hangs in rcu_barrier() -> wait_for_completion()
Message-ID: <20210128145813.GO2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <SN6PR2101MB1807BDF049D7155201A8178DBFFA1@SN6PR2101MB1807.namprd21.prod.outlook.com>
 <20201126154630.GR1437@paulmck-ThinkPad-P72>
 <MW2PR2101MB18014505C01027A9486D45EEBFF91@MW2PR2101MB1801.namprd21.prod.outlook.com>
 <20201126214226.GS1437@paulmck-ThinkPad-P72>
 <MW2PR2101MB18011DA2FCF66D03BF8BB0CCBFF91@MW2PR2101MB1801.namprd21.prod.outlook.com>
 <20201126235440.GT1437@paulmck-ThinkPad-P72>
 <MW2PR2101MB1787FF5912C90FC4FFEF3993BFBA9@MW2PR2101MB1787.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1787FF5912C90FC4FFEF3993BFBA9@MW2PR2101MB1787.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 28, 2021 at 07:28:20AM +0000, Dexuan Cui wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > Sent: Thursday, November 26, 2020 3:55 PM
> > To: Dexuan Cui <decui@microsoft.com>
> > Cc: boqun.feng@gmail.com; Ingo Molnar <mingo@redhat.com>;
> > rcu@vger.kernel.org; vkuznets <vkuznets@redhat.com>; Michael Kelley
> > <mikelley@microsoft.com>; linux-kernel@vger.kernel.org
> > Subject: Re: kdump always hangs in rcu_barrier() -> wait_for_completion()
> > 
> > On Thu, Nov 26, 2020 at 10:59:19PM +0000, Dexuan Cui wrote:
> > > > From: Paul E. McKenney <paulmck@kernel.org>
> > > > Sent: Thursday, November 26, 2020 1:42 PM
> > > >
> > > > > > Another possibility is that rcu_state.gp_kthread is non-NULL, but that
> > > > > > something else is preventing RCU grace periods from completing, but in
> > > > >
> > > > > It looks like somehow the scheduling is not working here: in rcu_barrier()
> > > > > , if I replace the wait_for_completion() with
> > > > > wait_for_completion_timeout(&rcu_state.barrier_completion, 30*HZ),
> > the
> > > > > issue persists.
> > > >
> > > > Have you tried using sysreq-t to see what the various tasks are doing?
> > >
> > > Will try it.
> > >
> > > BTW, this is a "Generation 2" VM on Hyper-V, meaning sysrq only starts to
> > > work after the Hyper-V para-virtualized keyboard driver loads... So, at this
> > > early point, sysrq is not working. :-( I'll have to hack the code and use a
> > > virtual NMI interrupt to force the sysrq handler to be called.
> > 
> > Whatever works!
> > 
> > > > Having interrupts disabled on all CPUs would have the effect of disabling
> > > > the RCU CPU stall warnings.
> > > > 							Thanx, Paul
> > >
> > > I'm sure the interrupts are not disabled. Here the VM only has 1 virtual CPU,
> > > and when the hang issue happens the virtual serial console is still responding
> > > when I press Enter (it prints a new line) or Ctrl+C (it prints ^C).
> > >
> > > Here the VM does not use the "legacy timers" (PIT, Local APIC timer, etc.) at
> > all.
> > > Instead, the VM uses the Hyper-V para-virtualized timers. It looks the
> > Hyper-V
> > > timer never fires in the kdump kernel when the hang issue happens. I'm
> > > looking into this... I suspect this hang issue may only be specific to Hyper-V.
> > 
> > Fair enough, given that timers not working can also suppress RCU CPU
> > stall warnings.  ;-)
> > 
> > 							Thanx, Paul
> 
> FYI: the issue has been fixed by this fix:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fff7b5e6ee63c5d20406a131b260c619cdd24fd1

Thank you for the update!

							Thanx, Paul
