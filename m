Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3881C433EF
	for <rcu@archiver.kernel.org>; Sat,  9 Apr 2022 16:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiDIQjy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 9 Apr 2022 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbiDIQjy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 9 Apr 2022 12:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835E388
        for <rcu@vger.kernel.org>; Sat,  9 Apr 2022 09:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D41760B59
        for <rcu@vger.kernel.org>; Sat,  9 Apr 2022 16:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD06C385A4;
        Sat,  9 Apr 2022 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649522264;
        bh=HqhPPP25sGb3cKXbG1r9CNONuKBKnGkPq3ApzIa1Hmc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KUTarF0+mp4M5YrktNrmlCWQXlmruS/pKYIMU+/J9ZnXD+VQxpSEjj2/A5DrnYXZV
         NchjKRuEdQdpM4LTANHvIP6jWIJnwmQJIXSgRHUNTnDARpjgfAzH/9Yy2NrWVE+0LU
         kVWreRoSbyNNB5eAESycBqNYFOXn97PHY7gQjiT7pBmCKbgej72zDegOlab5ikk0Nq
         eUbq0qUb6DR9jvhemw4AhO0cSGa7QKth7lKGVdIxShfY7i41yINHQ9ib47sqbXPyiq
         wXfCGXVRPK30tENFtaSjy2ewmgii+NmWP0WCUVL2PP1MnKxPgMeHzxiJ2JCtpCCuUB
         q4hS1gBBfs+ZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D0E45C09EF; Sat,  9 Apr 2022 09:37:44 -0700 (PDT)
Date:   Sat, 9 Apr 2022 09:37:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmckrcu@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Fw: rc6 splat
Message-ID: <20220409163744.GR4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yje18NgLjpPo7VEp@casper.infradead.org>
 <SA1PR15MB49655CF8AC3998CA9A7CE903B8169@SA1PR15MB4965.namprd15.prod.outlook.com>
 <20220321043813.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <20220321071327.GA798064@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2woW2UuPg1rSYYc+S6k7qd9JwM4gJFMHhiVcBkDewE_Nw@mail.gmail.com>
 <20220321155746.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220322104909.GB701946@lothringen>
 <CAABZP2ws9oP9sv0Pzbb059+Fm=dmaNWD5VxMZt92QB7m7Nm=GQ@mail.gmail.com>
 <CAABZP2yzi6ZPxoVu=3+EHiBW3EFEjxTkibSL-FbnSLaj9LBcrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2yzi6ZPxoVu=3+EHiBW3EFEjxTkibSL-FbnSLaj9LBcrQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Apr 09, 2022 at 06:44:27AM +0800, Zhouyi Zhou wrote:
> [CC RCU and Frederic and Matthew]
> 
> Hi Paul
> 
> After several days'  experiment on my Thinkpad P1 gen 4 (Intel 11800H
> 8 core 16 threads), I found that it is CONFIG_NFS_V4 that makes the
> difference.
> If I remove CONFIG_NFS_V4 from TASKS01, the probability of triggering
> the warning is significantly increased!
> 
> And, Yes, there is no CONFIG_NFS_V4 in Matthew's original email.
> 
> This is very interesting. After debugging the kernel, I found
> init_nfs_v4 does a lot of work, did it lend grace period to the test?
> I am very happy to continue to do research on this topic ;-)
> 
> Thank you for your guidance!

Thank you for chasing this down!  I am running some tests with
"--kconfig CONFIG_NFS_V4=n" to see what happens.

I am having some trouble imagining how init_nfs_v4() would help RCU Tasks
grace period go forwards, but it is a proven fact that the objective
universe has a much more capable imagination than I do.  ;-)

If left to yourself, what would be the next debugging step that you
would take?

							Thanx, Paul

> Thanks
> Zhouyi
> 
> On Tue, Mar 22, 2022 at 8:31 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > Dear Frederic
> >
> > I may not be right, please correct me if so
> >
> > On Tue, Mar 22, 2022 at 6:49 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > >
> > > On Mon, Mar 21, 2022 at 08:57:46AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Mar 21, 2022 at 11:46:28PM +0800, Zhouyi Zhou wrote:
> > > > > Hi Paul and Willy
> > > > >
> > > > > I can reproduce the bug. Following is what I do:
> > > > > 1.1 git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > > 1.2 cd linux
> > > > > 1.3 cp http://154.223.142.244/20220321/config-20220321 to .config
> > > > > 1.4 make vmlinux -j 16
> > > > > 1.5 kvm -smp 4 -net none     -serial file:/tmp/console.log -m 512
> > > > > -kernel vmlinux -append "console=ttyS0"
> > > > > 1.6 the /tmp/console.log is uploaded to
> > > > > http://154.223.142.244/20220321/console.log
> > > > >
> > > > > 2.1 wget https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.17-rc6.tar.gz
> > > > > 2.2 - 2.6 the result is similar.
> > > > >
> > > > > I am very interested in this topic.
> > > > > Could you please give me about a week to make a full understand of the
> > > > > meaning of the warning, and try the fixes one by one, and
> > > > > find out what happens?
> > > >
> > > > Works for me!  The eventual fix likely involves some version of Valentin
> > > > Schneider's patchset that provides APIs that allow RCU to detect the
> > > > current preemption state.  Which can change at runtime.  A prototype of
> > > > this patch is on -rcu here:
> > > >
> > > > 2436ee0b4cea ("EXP preempt/dynamic: Introduce preempt mode accessors")
> > > >
> > > > It is entirely possible that the fix might need to go to mainline sooner
> > > > rather than later.
> > >
> > > I guess it's possible to do that but that patch alone shouldn't fix anything.
> > > Also, what is the issue exactly? :-)
> > The issue is with certain kernel configuration
> > (http://154.223.142.244/20220321/config-2022032), the mainline (and
> > -rcu ) kernel  will warn
> > "call_rcu_tasks() has been failed" in rcu_tasks_verify_self_tests.
> > (http://154.223.142.244/20220321/console.log)
> >
> > Kind Regard
> > Zhouyi
> > > I can't rewind far enough the conversation.
> > >
> > > Thanks.
