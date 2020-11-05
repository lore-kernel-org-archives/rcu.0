Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53DCC388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CDE2071A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617241;
	bh=XlYp7OoLzkBs9gfBT6bydhG3emdrCfkQGkybFyyUB5Q=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=RZARWvaYOcataT7aGoGVcI+9EtR4gL0V4M3oBjJ5Hya4V/8X62MDgAWI+EvniR/NP
	 FixxadDFf1YZwMBRnEE5CnTkwSq+dGXZhXu6vNbpRSXiy0zml6bVL+e6WDpWSCtL7r
	 2778sonq+3Q6wn3MaqwcXJOJonTvdKFAtxIzwyis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgKEXAl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:00:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731860AbgKEXAl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:00:41 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F4920719;
        Thu,  5 Nov 2020 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617240;
        bh=XlYp7OoLzkBs9gfBT6bydhG3emdrCfkQGkybFyyUB5Q=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=XRa7JCsv02I1Vi9GjZwzsSzKgJa58ZyBecwJnARej6SoTtEevpbUDGFaVzzX9nNip
         KhF9tZTmcPALuVlew09l8vehHHEU4Z4tM4VS1BspJLkOV62NxUhN6BmOjorA5vWnCJ
         jTfHfhR2CFRWUqcKORht5pcuB8ViJQYL34sQW6C4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3DA0E3522A76; Thu,  5 Nov 2020 15:00:40 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:00:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/2] smp_call_function updates for v5.11
Message-ID: <20201105230040.GA18202@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series prevents /proc/cpuinfo from piling up quite so many redundant
IPIs, and also avoids IPIing idle CPUs.

1.	Avoid cpuinfo-induced IPI pileups.

2.	Avoid cpuinfo-induced IPIing of idle CPUs.

						Thanx, Paul

------------------------------------------------------------------------

 arch/x86/kernel/cpu/aperfmperf.c |   16 +++++++++++++++-
 include/linux/rcutiny.h          |    2 ++
 include/linux/rcutree.h          |    1 +
 kernel/rcu/tree.c                |    8 ++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)
