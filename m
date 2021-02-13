Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419A4C433DB
	for <rcu@archiver.kernel.org>; Sat, 13 Feb 2021 12:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E0D64E46
	for <rcu@archiver.kernel.org>; Sat, 13 Feb 2021 12:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhBMMig (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 13 Feb 2021 07:38:36 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49786 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhBMMie (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 13 Feb 2021 07:38:34 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 11DCaw06003536;
        Sat, 13 Feb 2021 13:36:58 +0100
Date:   Sat, 13 Feb 2021 13:36:58 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, akiyks@gmail.com,
        bigeasy@linutronix.de, elver@google.com, frederic@kernel.org,
        joel@joelfernandes.org, julia@ni.com, mchehab+huawei@kernel.org,
        neeraju@codeaurora.org, paul.gortmaker@windriver.com,
        peterz@infradead.org, qiang.zhang@windriver.com, swood@redhat.com,
        urezki@gmail.com, wangqing@vivo.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kernel-team@fb.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.12
Message-ID: <20210213123658.GA3500@1wt.eu>
References: <20210128010437.GA32221@paulmck-ThinkPad-P72>
 <20210212123109.GB2185387@gmail.com>
 <20210212150705.GO2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212150705.GO2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Fri, Feb 12, 2021 at 07:07:05AM -0800, Paul E. McKenney wrote:
> Thank you, Ingo!  In the future, I will group nolibc with RCU.  But there
> has to be something other than RCU that needs it.  I will take a look. ;-)

All my kernels boot using a "preinit" that is built with nolibc and
integrated into the initramfs. Historically it used to just create /dev
entries and mount the rootfs, nowadays it's used to untar modules and
finish the boot so that I can have a clean separation between a kernel
image and a rootfs. It even allows to perform some minimal debugging as
it includes a minimalistic shell. Do you think something like this could
be of any use in your development sessions ? If so I can discuss this
with you in a separate thread so as not to annoy everyone. Just let me
know :-)

Cheers,
Willy
