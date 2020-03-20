Return-Path: <SRS0=HuQd=5F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECEAC4332B
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 17:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B0020767
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584723882;
	bh=VH3g1gFndfzl5vdDr5dD8kRr/B9u2LZmudWDxRf8Mf4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qvffoBIL4Jhv2IJ+GgQDzlohqvOAuvAU79x7pTC4AUsBzdbS+60BR+Q3nmKx7XKs4
	 WsYkX65H1b0x8c2UqqNsvD4twOBk5NTh3L57mZUlgdHrzvn10eAeEHVZGdz4N5Z+AI
	 +VsQeg9kEunKgeqF+cv5s9jimpECsHyrgE4B6kNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCTREm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbgCTREm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Mar 2020 13:04:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B2320724;
        Fri, 20 Mar 2020 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584723880;
        bh=VH3g1gFndfzl5vdDr5dD8kRr/B9u2LZmudWDxRf8Mf4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=chI1eSiJFrdkIi5LJcaLEaVvVxXAWRVGxOpx+q9Swlg9tOrOEmFCuIKtuCujay0Ib
         KS4zuFbuiDM/Zp+Thlx8qI1R8mAJSGJrG66CF6oV4nBjeOtA5s0r2bHoewD3/OWOuP
         aTU8IoqrvICaq2AaIFHhxdeJpEAL6/suUFhl0BCo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9461635226B4; Fri, 20 Mar 2020 10:04:40 -0700 (PDT)
Date:   Fri, 20 Mar 2020 10:04:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next build error (8)
Message-ID: <20200320170440.GR3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <000000000000ae2ab305a123f146@google.com>
 <CACT4Y+a_d=5TNZth0dPov0B7tB5T9bAzWXBj1HjhXdn-=0KOOg@mail.gmail.com>
 <20200318214109.GV3199@paulmck-ThinkPad-P72>
 <CACT4Y+ZhP_Qu+WZ4t2dLjd__H+rUKCTRCNoghvW9Uf3QQYRcNg@mail.gmail.com>
 <20200319150414.GD3199@paulmck-ThinkPad-P72>
 <CACT4Y+YHQQWeeW44NYAxX+fFU6RyvFbbmcig1q8NSE7yV0zgjA@mail.gmail.com>
 <20200320162650.GP3199@paulmck-ThinkPad-P72>
 <ef4ec876-8b78-3f4a-a3fb-6dbc038e92df@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef4ec876-8b78-3f4a-a3fb-6dbc038e92df@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 20, 2020 at 09:34:13AM -0700, Randy Dunlap wrote:
> On 3/20/20 9:26 AM, Paul E. McKenney wrote:
> > On Fri, Mar 20, 2020 at 04:38:54PM +0100, Dmitry Vyukov wrote:
> >> On Thu, Mar 19, 2020 at 4:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>
> >>> On Thu, Mar 19, 2020 at 08:13:35AM +0100, Dmitry Vyukov wrote:
> >>>> On Wed, Mar 18, 2020 at 10:41 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>>
> >>>>> On Wed, Mar 18, 2020 at 09:54:07PM +0100, Dmitry Vyukov wrote:
> >>>>>> On Wed, Mar 18, 2020 at 5:57 PM syzbot
> >>>>>> <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com> wrote:
> >>>>>>>
> >>>>>>> Hello,
> >>>>>>>
> >>>>>>> syzbot found the following crash on:
> >>>>>>>
> >>>>>>> HEAD commit:    47780d78 Add linux-next specific files for 20200318
> >>>>>>> git tree:       linux-next
> >>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14228745e00000
> >>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b68b7b89ad96c62a
> >>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=792dec47d693ccdc05a0
> >>>>>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >>>>>>>
> >>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
> >>>>>>>
> >>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>>>>>> Reported-by: syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com
> >>>>>>>
> >>>>>>> kernel/rcu/tasks.h:1070:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
> >>>>>>
> >>>>>> +rcu maintainers
> >>>>>
> >>>>> The kbuild test robot beat you to it, and apologies for the hassle.
> >>>>> Fixed in -rcu on current "dev" branch.
> >>>>
> >>>> If the kernel dev process would only have a way to avoid dups from all
> >>>> test systems...
> >>>
> >>> I do significant testing before pushing to -next, but triggering this
> >>> one requires a combination of Kconfig options that are incompatible
> >>> with rcutorture.  :-/
> >>>
> >>> I suppose one strategy would be to give kbuild test robot some time before
> >>> passing to -next, but they seem to sometimes get too far behind for me to
> >>> be willing to wait that long.  So my current approach is to push my "dev"
> >>> branch, run moderate rcutorture testing (three hours per scenario other
> >>> than TREE10, which gets only one hour), and if that passes, push to -next.
> >>>
> >>> I suppose that I could push to -next only commits that are at least three
> >>> days old or some such.  But I get in trouble pushing to -next too slowly
> >>> as often as I get in trouble pushing too quickly, so I suspect that my
> >>> current approach is in roughly the right place.
> >>>
> >>>> Now we need to spend time and deal with it. What has fixed it?
> >>>
> >>> It is fixed by commit c6ef38e4d595 ("rcu-tasks: Add RCU tasks to
> >>> rcutorture writer stall output") and some of its predecessors.
> >>>
> >>> Perhaps more useful to you, this commit is included in next-20200319
> >>> from the -next tree.  ;-)
> >>
> >> Let's tell syzbot about the fix:
> >>
> >> #syz fix: rcu-tasks: Add RCU tasks to rcutorture writer stall output
> >>
> >> I think what you are doing is the best possible option in the current situation.
> >> I don't think requiring all human maintainers to do more manual
> >> repetitive work, which is not well defined and even without a way to
> >> really require something from them is scalable nor reliable nor the
> >> right approach.
> > 
> > Thank you, and I do greatly appreciate the automation!
> > 
> >> We would consume something like LKGR [1] if it existed for the kernel.
> >> But it would require tighter integration of testing systems with
> >> kernel dev processes, or of course throwing more manual labor at it to
> >> track all uncoordinated testing systems and publishing LKGR tags.
> >>
> >> [1] https://chromium.googlesource.com/chromiumos/docs/+/master/glossary.md
> > 
> > At my end, it is pretty quick and easy to detect duplicate notifications
> > of the same bug, so the current situation isn't causing me undue distress.
> 
> Yeah, I saw the same build error and did-not-report it since it was
> already reported.  :)

Much appreciated!  ;-)

							Thanx, Paul
