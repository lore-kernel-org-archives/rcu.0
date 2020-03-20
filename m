Return-Path: <SRS0=HuQd=5F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ECFC4332E
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438CB20782
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u0naHVb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCTQeQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:34:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgCTQeQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Mar 2020 12:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=wn09ImmtyM/n6wRWgEQVs5UzpsZS8jQSQD4sGjfSADk=; b=u0naHVb/8v7hci/TU/GL9dHWyM
        MPMSsFGiPk757/dCPgmuplYGvS8HjskMzft6jCPCfq4NTZ33YMjqtwoR5Y7C1A65N24bPVlt/R6Z2
        oJRxlOKcYtFxeq8ZCFGaYmOg8eV/gCPYFQxu/gqfqjSNEVKY5oq8GcAIbWui/qUD9u5Zbr1PKgkNP
        sojq33wlLeyyznoOhNTIcbJT2VeTGIHskJTAfVrDFc9hhhl4XZXXusuAYOeFzFOh6Cwf0OwyHm0mG
        X5oAKchOiY9Pu9yIqH5hQIrFXfMml7omH2gq6tdb8MbX9JJHFhG4ikqi0bWnGQhYUYDtiA7d9pae4
        sjWE8W1w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFKb8-00042l-6j; Fri, 20 Mar 2020 16:34:14 +0000
Subject: Re: linux-next build error (8)
To:     paulmck@kernel.org, Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000ae2ab305a123f146@google.com>
 <CACT4Y+a_d=5TNZth0dPov0B7tB5T9bAzWXBj1HjhXdn-=0KOOg@mail.gmail.com>
 <20200318214109.GV3199@paulmck-ThinkPad-P72>
 <CACT4Y+ZhP_Qu+WZ4t2dLjd__H+rUKCTRCNoghvW9Uf3QQYRcNg@mail.gmail.com>
 <20200319150414.GD3199@paulmck-ThinkPad-P72>
 <CACT4Y+YHQQWeeW44NYAxX+fFU6RyvFbbmcig1q8NSE7yV0zgjA@mail.gmail.com>
 <20200320162650.GP3199@paulmck-ThinkPad-P72>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef4ec876-8b78-3f4a-a3fb-6dbc038e92df@infradead.org>
Date:   Fri, 20 Mar 2020 09:34:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320162650.GP3199@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 3/20/20 9:26 AM, Paul E. McKenney wrote:
> On Fri, Mar 20, 2020 at 04:38:54PM +0100, Dmitry Vyukov wrote:
>> On Thu, Mar 19, 2020 at 4:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>>>
>>> On Thu, Mar 19, 2020 at 08:13:35AM +0100, Dmitry Vyukov wrote:
>>>> On Wed, Mar 18, 2020 at 10:41 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>>>>>
>>>>> On Wed, Mar 18, 2020 at 09:54:07PM +0100, Dmitry Vyukov wrote:
>>>>>> On Wed, Mar 18, 2020 at 5:57 PM syzbot
>>>>>> <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com> wrote:
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzbot found the following crash on:
>>>>>>>
>>>>>>> HEAD commit:    47780d78 Add linux-next specific files for 20200318
>>>>>>> git tree:       linux-next
>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14228745e00000
>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b68b7b89ad96c62a
>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=792dec47d693ccdc05a0
>>>>>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>>>>>>
>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>
>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>>> Reported-by: syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com
>>>>>>>
>>>>>>> kernel/rcu/tasks.h:1070:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
>>>>>>
>>>>>> +rcu maintainers
>>>>>
>>>>> The kbuild test robot beat you to it, and apologies for the hassle.
>>>>> Fixed in -rcu on current "dev" branch.
>>>>
>>>> If the kernel dev process would only have a way to avoid dups from all
>>>> test systems...
>>>
>>> I do significant testing before pushing to -next, but triggering this
>>> one requires a combination of Kconfig options that are incompatible
>>> with rcutorture.  :-/
>>>
>>> I suppose one strategy would be to give kbuild test robot some time before
>>> passing to -next, but they seem to sometimes get too far behind for me to
>>> be willing to wait that long.  So my current approach is to push my "dev"
>>> branch, run moderate rcutorture testing (three hours per scenario other
>>> than TREE10, which gets only one hour), and if that passes, push to -next.
>>>
>>> I suppose that I could push to -next only commits that are at least three
>>> days old or some such.  But I get in trouble pushing to -next too slowly
>>> as often as I get in trouble pushing too quickly, so I suspect that my
>>> current approach is in roughly the right place.
>>>
>>>> Now we need to spend time and deal with it. What has fixed it?
>>>
>>> It is fixed by commit c6ef38e4d595 ("rcu-tasks: Add RCU tasks to
>>> rcutorture writer stall output") and some of its predecessors.
>>>
>>> Perhaps more useful to you, this commit is included in next-20200319
>>> from the -next tree.  ;-)
>>
>> Let's tell syzbot about the fix:
>>
>> #syz fix: rcu-tasks: Add RCU tasks to rcutorture writer stall output
>>
>> I think what you are doing is the best possible option in the current situation.
>> I don't think requiring all human maintainers to do more manual
>> repetitive work, which is not well defined and even without a way to
>> really require something from them is scalable nor reliable nor the
>> right approach.
> 
> Thank you, and I do greatly appreciate the automation!
> 
>> We would consume something like LKGR [1] if it existed for the kernel.
>> But it would require tighter integration of testing systems with
>> kernel dev processes, or of course throwing more manual labor at it to
>> track all uncoordinated testing systems and publishing LKGR tags.
>>
>> [1] https://chromium.googlesource.com/chromiumos/docs/+/master/glossary.md
> 
> At my end, it is pretty quick and easy to detect duplicate notifications
> of the same bug, so the current situation isn't causing me undue distress.

Yeah, I saw the same build error and did-not-report it since it was
already reported.  :)

-- 
~Randy

