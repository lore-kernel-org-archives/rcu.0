Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1ECC433DB
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3D164E2E
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 12:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhBVMHZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Feb 2021 07:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhBVMG6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Feb 2021 07:06:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2745460C3E;
        Mon, 22 Feb 2021 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613995577;
        bh=5Gsn/zc702+nIWsLqonuQfLsJTK2q5SP5gmnXwDweWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mIAajKHp5asVP7wiXsMndVJuWXwPSaz78FMPKlx+yXjfKuY/UB3DiTnhuvZ+kabui
         Xn8GyMTuuYV4iRxiCI7zrZWuMkkdZ79WPhz/CG+z/CDfzWzTkvpH7o2FCmgoFQrh/N
         e+0aYRDNyMA3YRweRlPi2wTO9ADCq2cjKZkKXsQk0FbaPHhIYrzpjwpx1oqRwqwqS8
         on6ItQKt0Mb+MPHYp6JKBAk0Di/VoSs4ZhRCFBZfiJAOxtkv0oayoY/tbjDw2dwHtc
         z6/vUQIZXwOzNSAw5ecwAejo9F0fTMamdAgfqgm/+2A1b75OfWUTx0X95pyYvqObPx
         1Yk431yNSuHzw==
Date:   Mon, 22 Feb 2021 21:06:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-Id: <20210222210610.66488ea25ce5d999162f9f6b@kernel.org>
In-Reply-To: <20210219200442.GB2743@paulmck-ThinkPad-P72>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
        <20210219143607.3cdf9ed8@gandalf.local.home>
        <20210219194744.GA2743@paulmck-ThinkPad-P72>
        <20210219145830.0baca550@gandalf.local.home>
        <20210219200442.GB2743@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 19 Feb 2021 12:04:42 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Fri, Feb 19, 2021 at 02:58:30PM -0500, Steven Rostedt wrote:
> > On Fri, 19 Feb 2021 11:47:44 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > Could you please add the following Reported-by tags?
> > > 
> > > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Reported-by: Uladzislau Rezki <urezki@gmail.com>
> > > 
> > > Sebastian first noticed the problem, and Uladzislau figured out
> > > how softirqs were involved.
> > 
> > These were already added. They must have appeared in the thread somewhere,
> > as my internal patchwork picked them up already.
> 
> Even better, thank you!

Thank you for fixing and pulling it Steve and Paul!
I couldn't find the original thread, so it is helpful :)

Thanks!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
