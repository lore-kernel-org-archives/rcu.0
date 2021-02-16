Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710AC433E0
	for <rcu@archiver.kernel.org>; Tue, 16 Feb 2021 18:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0EE64E28
	for <rcu@archiver.kernel.org>; Tue, 16 Feb 2021 18:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBPSg4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:36:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhBPSg4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Feb 2021 13:36:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E113A64D73;
        Tue, 16 Feb 2021 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613500569;
        bh=NFq5YCA7OAYMbJBNV5q6bpOyFcjr4mwojFFSOqQaw2c=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Ofqtbw1dMiC6TuUWUG3Gykd4b/ITx7GV+RxQL91XLTM157BWsOonjRpPqUYR23NGl
         S8LTCjQlvaJgN3rmekKxiPMacKy+H0/8TGIzBvwCndHWm4Fptdrgu1eOUUy9zog6VJ
         xB5s1w/HwAqJHYCN4TjcaNOI5lZj2MO2/q2dr7X4dwg0mFZN7ou69BZjJflIRWaiBb
         SrtHvQ9XghND93hjYg/75uCCAcng3Xps9x5aEFl8sZzxmP1GsNg870SWzmW5g0sgnf
         8LUKaJRzfanU/5s3zDXHPfXMOb2Zn/Ex6rsLo0PqH9umaZloSG1r0zmwFsOiYMm8B6
         FY3AZqogfV+LQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ACF473523946; Tue, 16 Feb 2021 10:36:09 -0800 (PST)
Date:   Tue, 16 Feb 2021 10:36:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Should RCU_BOOST kernels use hrtimers in GP kthread?
Message-ID: <20210216183609.GA7027@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Sebastian,

I punted on this for the moment by making RCU priority boosting testing
depend on CONFIG_PREEMPT_RT, but longer term I am wondering if RCU's
various timed delays and timeouts should use hrtimers rather than normal
timers in kernels built with CONFIG_RCU_BOOST.  As it is, RCU priority
boosting can be defeated if any of the RCU grace-period kthread's timeouts
are serviced by the non-realtime ksoftirqd.

This might require things like swait_event_idle_hrtimeout_exclusive(),
either as primitives or just open coded.

Thoughts?

							Thanx, Paul
