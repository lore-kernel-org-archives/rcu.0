Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08118C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCABE22838
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbhAFBBn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbhAFBBn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:01:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 775DB22838;
        Wed,  6 Jan 2021 01:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894862;
        bh=7dUnuK2c+aj+qWh2RUmU4X0GHD+i34O6MDU4lnS687E=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=aIsMUxF/kCc64adVEXOopyMJSMjnhCdh6b5mzQyKfQ/ZFaqHLlwG8Zb1uZmYI8zpJ
         eTL3SbNJKyIHGkGdic9SUJlcI71XUol3SXbJkR0r611RarGR8Fe/agqAoB3fXjQyIg
         YHbF3JrIk1w4MHkL3kvhnqS/rv2wlBplUIk4Vqh75z1E1RiwnQ0NiyUbQe6ERbceSi
         ykCMnDokP8EnoNAMaHh18vt07pwt8ynEXLMSMkAhmrmUhJU0lBVdmCKmE3mLs6MN+d
         KLRAT0tdmv3wXFxEvlAMI2v/nMx3BkiXOuQySVSsPaEFRZoOOpwSHBaJhTi9KI0/qb
         6HDCCv+LtX3Ww==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 41FF035228C6; Tue,  5 Jan 2021 17:01:02 -0800 (PST)
Date:   Tue, 5 Jan 2021 17:01:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/3] kfree_rcu() updates for v5.12
Message-ID: <20210106010102.GA12737@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides kfree_rcu() updates:

1.	Record kvfree_call_rcu() call stack for KASAN, courtesy of Zqiang.

2.	Introduce kfree_rcu() single-argument macro, courtesy of
	Uladzislau Rezki.

3.	Eliminate the __kvfree_rcu() macro, courtesy of Uladzislau Rezki.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcupdate.h |   40 ++++++++++++++++++----------------------
 kernel/rcu/tree.c        |    1 +
 2 files changed, 19 insertions(+), 22 deletions(-)
