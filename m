Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C7DC433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF53764EC4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbhCDBAu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354859AbhCDALZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:11:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE7D164F0D;
        Thu,  4 Mar 2021 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816644;
        bh=Cv30fszy5J9ao5e9qnmhCzczyGXkQ5rEaJ7pVZCBsrY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=itLNaReN49kl55t9KSLLM0rjxHEenVbTKnMd6HLJWoZ6MBLGLAO1FStqXS8oljBz8
         mb0khTRg6RXxQHw7f2cvbTk1FB7H47iim/sZVKqCfbGyb9iEeCmXnAojM/qVLWUG6l
         IR3r82uDPOSgFT2nglRTeAJsWvN6pYe1cHhbIkrYDFvGUCNv3CVxNoexMkxRJS/Tfg
         /sIiIjwQZxxp1jTUX5rzdssMhvU8vILytvsaizA1tYrEGVSns9I2FrhDWeeqFABwhs
         mA3Er7E0LmlQXj3OaKMIAucQmQAhUDTPP957w5CL9sa2VquTTvhpPZR+VgDINkO/k1
         td6owJ+4qlhOA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A4C4D3522591; Wed,  3 Mar 2021 16:10:44 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:10:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/6] kvfree_rcu() updates for v5.12-rc1
Message-ID: <20210304001044.GA22871@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains kvfree_rcu() updates, most notably surrounding GPF
flags for memory allocation.

1.	kvfree_rcu: Directly allocate page for single-argument case,
	courtesy of "Uladzislau Rezki (Sony)".

2.	kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu().

3.	kvfree_rcu: Make krc_this_cpu_unlock() use
	raw_spin_unlock_irqrestore().

4.	kvfree_rcu: Replace __GFP_RETRY_MAYFAIL by __GFP_NORETRY,
	courtesy of "Uladzislau Rezki (Sony)".

5.	kvfree_rcu: Use same set of GFP flags as does single-argument,
	courtesy of "Uladzislau Rezki (Sony)".

6.	Add kfree_rcu() single-argument scale test, courtesy of
	"Uladzislau Rezki (Sony)".

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |   12 ++++
 kernel/rcu/rcuscale.c                           |   15 +++++
 kernel/rcu/tree.c                               |   63 ++++++++++++++++--------
 3 files changed, 68 insertions(+), 22 deletions(-)
