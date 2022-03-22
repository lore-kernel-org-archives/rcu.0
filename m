Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2411CC433F5
	for <rcu@archiver.kernel.org>; Tue, 22 Mar 2022 14:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiCVO1g (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Mar 2022 10:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiCVOZ0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Mar 2022 10:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4011D8BE35
        for <rcu@vger.kernel.org>; Tue, 22 Mar 2022 07:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847D161668
        for <rcu@vger.kernel.org>; Tue, 22 Mar 2022 14:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0EDC340EC;
        Tue, 22 Mar 2022 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958861;
        bh=McKgM/G1jy4Ql/az1t7e80K+rn/K5QhAu4cWP45Z5xc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GPtEEig3+Wl0kU25U+q/6/lj5Bb6Av6R0FiDp07JE3m+9bZZa2sA5TlMtbV3rgamx
         SPkXxdpiJw/Kzn4+lq+25xMzvU6b4Sud798WVWg6LPMoCDTe7DV0rSpb+NHm7DyAO1
         nMa3920eLpDUckELUg/5SY0jL1Ch8WEHaWrmY2FriJorFmT5TMGn1gIQy7QgHdqa8/
         V/b95v7+2zEwGwWZbcPC0/U3W9WIpQL6IYcat8G3Kcmq5nCmmDx5XLDy3lP/R86Uak
         s06reLmEDmylId4cc8ZM0huyWwsXqIvyZyfjNcQtN1FQMhz4k0bbnwxnWoir0QS8lo
         n1O5WB3yaVENQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7D4E75C015B; Tue, 22 Mar 2022 07:21:01 -0700 (PDT)
Date:   Tue, 22 Mar 2022 07:21:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Paul McKenney <paulmckrcu@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Fw: rc6 splat
Message-ID: <20220322142101.GQ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yje18NgLjpPo7VEp@casper.infradead.org>
 <SA1PR15MB49655CF8AC3998CA9A7CE903B8169@SA1PR15MB4965.namprd15.prod.outlook.com>
 <20220321043813.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <20220321071327.GA798064@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2woW2UuPg1rSYYc+S6k7qd9JwM4gJFMHhiVcBkDewE_Nw@mail.gmail.com>
 <20220321155746.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220322104909.GB701946@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322104909.GB701946@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 22, 2022 at 11:49:09AM +0100, Frederic Weisbecker wrote:
> On Mon, Mar 21, 2022 at 08:57:46AM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 21, 2022 at 11:46:28PM +0800, Zhouyi Zhou wrote:
> > > Hi Paul and Willy
> > > 
> > > I can reproduce the bug. Following is what I do:
> > > 1.1 git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
> > > 1.2 cd linux
> > > 1.3 cp http://154.223.142.244/20220321/config-20220321 to .config
> > > 1.4 make vmlinux -j 16
> > > 1.5 kvm -smp 4 -net none     -serial file:/tmp/console.log -m 512
> > > -kernel vmlinux -append "console=ttyS0"
> > > 1.6 the /tmp/console.log is uploaded to
> > > http://154.223.142.244/20220321/console.log
> > > 
> > > 2.1 wget https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.17-rc6.tar.gz
> > > 2.2 - 2.6 the result is similar.
> > > 
> > > I am very interested in this topic.
> > > Could you please give me about a week to make a full understand of the
> > > meaning of the warning, and try the fixes one by one, and
> > > find out what happens?
> > 
> > Works for me!  The eventual fix likely involves some version of Valentin
> > Schneider's patchset that provides APIs that allow RCU to detect the
> > current preemption state.  Which can change at runtime.  A prototype of
> > this patch is on -rcu here:
> > 
> > 2436ee0b4cea ("EXP preempt/dynamic: Introduce preempt mode accessors")
> > 
> > It is entirely possible that the fix might need to go to mainline sooner
> > rather than later.
> 
> I guess it's possible to do that but that patch alone shouldn't fix anything.
> Also, what is the issue exactly? :-)
> I can't rewind far enough the conversation.

I am no longer entirely sure myself.  I initially thought that this
was the issue where CONFIG_PREEMPT_DYNAMIC=y was confusing Tasks RCU,
but Zhouyi can make something happen in current -rcu.

							Thanx, Paul
