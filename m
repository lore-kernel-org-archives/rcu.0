Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C216DC388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785E32151B
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617486;
	bh=LBCefsbGCV4llPjyXhLN8g8/VrwsLqfCoTm/RG87HMQ=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=Tis0O03RuYG9f8wOSMDAx4wUsijgUXv00ubJmb/mFM2OY0oD6HN0+VvJOlPS3zxNm
	 DCLX5n0McF/pDx9OK1/VEtA+xvqfkVGJUv/sxtTe2bn/vFVKjvl34OGSU/svsWfy/E
	 hhC8i/kh7LGQlssN+2Fq6WQICFcaqxvbJKyvkbAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgKEXEp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731860AbgKEXEp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:04:45 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C5020786;
        Thu,  5 Nov 2020 23:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617485;
        bh=LBCefsbGCV4llPjyXhLN8g8/VrwsLqfCoTm/RG87HMQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=gp7R2xcEj+VsA1o9KHPN8MUgskEckDD6GkAkglpIhOWATZeYYxxxE6Dfgnm7EvdeU
         S7f/nPE/Sk5/u7XmmQ9Xp3WU5QAUlQHCJ8nUFHyZxaEtgZ7+uDh5VU0RJ4EzAcKPaO
         Zs5pe/Gu/awBmU4pZR8O/UZ7hNVTWUEkrkp10D54=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DEFC23522A76; Thu,  5 Nov 2020 15:04:44 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:04:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] Documentations updates for v5.11
Message-ID: <20201105230444.GA18574@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains documentation updates:

1.	Present the role of READ_ONCE().

2.	Update RCU's hotplug requirements with a bit about design.

3.	Fix a Requirements.rst list block.

4.	Update the call_rcu() API.

						Thanx, Paul

------------------------------------------------------------------------

 Design/Requirements/Requirements.rst |   50 ++++++++++++++++++++++++++++-------
 checklist.rst                        |    7 ++++
 rcu_dereference.rst                  |    6 ++++
 whatisRCU.rst                        |    3 --
 4 files changed, 54 insertions(+), 12 deletions(-)
