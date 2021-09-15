Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BEEC433F5
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B44360F25
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhIOXmh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhIOXmh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:42:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB8D960F8F;
        Wed, 15 Sep 2021 23:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749277;
        bh=/nO/zst4HXobeaTIjQ4tntFgOhmHOvUeyhfXrtrNa5g=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=C3BPt5fw5wmdu1hR6UUFSBFgwvB4TX84eXKMLPs9erMOmmrmVYkJDpGw/cpPbo4yM
         uwvLY26jFQEropD1kxxOxSGhX6CBqBeqEr7nNwNJPNAFRckPljnB5BxEfchQJUCEYR
         jeZhCTiorHvkbn+I6FgMVL1leRmmPa6ZWhklMZZm7g4MUj3fxTUS/eNUnIGP6rPyku
         4VmclcjeOPVrkiGjMQEx3lAa/VZj9NKjqN8EC74zG7CE6G/Hg8U+OlvbJXzv25QJpT
         2xnXb1MhyNXP7+y/uup+feDR1sMVvi+h4Zc/hLmEQKzOnjN4h5RIiZLe8OtAqXFdX3
         MMnmlhtAk6G7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 995FA5C054E; Wed, 15 Sep 2021 16:41:17 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:41:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/5] smp_call_function() torture-test updates for v5.16
Message-ID: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains in-kernel torture-test updates for smp_call_function()
and friends, AKA scftorture.

1.	Allow zero weight to exclude an smp_call_function*() category.

2.	Shut down if nonsensical arguments given.

3.	Account for weight_resched when checking for all zeroes.

4.	Count reschedule IPIs.

5.	Warn on individual scf_torture_init() error conditions.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/scftorture.c |   24 ++++++++++++------------
 kernel/scftorture.c   |   19 ++++++++++++-------
 2 files changed, 24 insertions(+), 19 deletions(-)
