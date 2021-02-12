Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44917C433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5FB64E57
	for <rcu@archiver.kernel.org>; Fri, 12 Feb 2021 15:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBLPHr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Feb 2021 10:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhBLPHp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Feb 2021 10:07:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5698B64E74;
        Fri, 12 Feb 2021 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613142425;
        bh=FjAW/mBtnX1/Q68W0PWY/p9JgRXajMHsxna0jkBAf9k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=azx4/CQz+tii3wSOWTtKKjMCvXRT66O01+4tTCbPX3e5PWg1OWUaD4/XtRRm4Y8aq
         X1CVA2nFnvo9SkX10VmgGjieKS2u7CE2Zm1qzTUJmZYLM52+WLtadCryYbohw6A0G4
         hELKeiw/luoK5rcsPDCRiX/ueCcFAWUeIeR+QfHUvN/rwDeAONeu7Hjbvh9LsWfJa4
         edcmFsresoiYnG27S483/lF00jxmy0oyqQluateSauKbAOB+HIETkWAUgv5BakiM6f
         SZZn3eeplaNfSQS2YdYj/JVI6Q59Z4lB4x/bzQMfdCe3LUY1pqwRtkDBBZCk/L84C3
         EJZo4bXxZRzDw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 28B543522598; Fri, 12 Feb 2021 07:07:05 -0800 (PST)
Date:   Fri, 12 Feb 2021 07:07:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     akiyks@gmail.com, bigeasy@linutronix.de, elver@google.com,
        frederic@kernel.org, joel@joelfernandes.org, julia@ni.com,
        mchehab+huawei@kernel.org, neeraju@codeaurora.org,
        paul.gortmaker@windriver.com, peterz@infradead.org,
        qiang.zhang@windriver.com, swood@redhat.com, urezki@gmail.com,
        w@1wt.eu, wangqing@vivo.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kernel-team@fb.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.12
Message-ID: <20210212150705.GO2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210128010437.GA32221@paulmck-ThinkPad-P72>
 <20210212123109.GB2185387@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212123109.GB2185387@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 12, 2021 at 01:31:09PM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > Hello, Ingo!
> > 
> > This pull request contains changes for RCU, KCSAN, LKMM, and nolibc.
> > You can pull the entire group using branch for-mingo.  Or, if you prefer,
> > you can pull them separately, using for-mingo-rcu to pull the RCU changes,
> > for-mingo-kcsan to pull the KCSAN changes, for-mingo-lkmm to pull the
> > LKMM changes, and for-mingo-nolibc to pull the noclib changes.
> > 
> > The changes are as follows:
> > 
> > 1.	RCU updates (for-mingo-rcu):
> 
> > 4.	Fixes to nolibc that allows it to run once again on ARMv8.
> >	https://lore.kernel.org/lkml/20210121072031.23777-1-w@1wt.eu/
> 
> Pulled these two into tip:core/rcu - as nolibc's main (only?) usecase 
> within the kernel is torture-testing.
> 
> > 2.	Kernel concurrency sanitizer (KCSAN) updates from Marco Elver.
> > 	https://lore.kernel.org/lkml/20210106173323.GA23292@paulmck-ThinkPad-P72/
> 
> > 3.	Linux-kernel memory model (LKMM) updates.
> > 	https://lore.kernel.org/lkml/20210106173548.GA23664@paulmck-ThinkPad-P72/
> 
> Pulled these two into tip:locking/core.

Thank you, Ingo!  In the future, I will group nolibc with RCU.  But there
has to be something other than RCU that needs it.  I will take a look. ;-)

							Thanx, Paul
