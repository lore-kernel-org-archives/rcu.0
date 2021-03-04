Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FECC433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B0064F48
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbhCDBBW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377180AbhCDAfM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:35:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D08F64EEF;
        Thu,  4 Mar 2021 00:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818071;
        bh=BgJ/cKUZ/tlELIyxY72feYiGoVFKCNo/gvisr+ITq3U=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ZO2ODiYzNWlBKvmL6CW4/WMqM4QN7l0tRKScFl/TupUXpci0TzsE78Ef9/nKAD2xH
         XhchoQZr9ud4ftJSSG/arnEYAo6EGbYTkvw8OXC1zvc6qNpqoNrQlSPDxvvpJdzA6b
         mxpMV0gJvmU/qS3R7utp5MPZOcVZ76rH+fauC0o/GtZRVO7t4zeXf3cOHxDG+JxjJA
         S713yTZr4MWRh/8TLTdQjlRIS19Gqes8wqYo36lZGK2ttbgLE3pYZLN0k+aVrC+Vmi
         8oo0YW9GLYKaqZPANM/uKB+ybvDH04Ig1YOjPr0sGxUixHPl9zym8OEQFBUQf4UYMI
         MfR/ctljJ2XQw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 200363522591; Wed,  3 Mar 2021 16:34:31 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:34:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/2] Torture-test updates for v5.13
Message-ID: <20210304003431.GA24413@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains a couple of torture-test updates:

1.	Replace torture_init_begin string with %s, courtesy of Stephen
	Zhang.

2.	Replace rcu_torture_stall string with %s, courtesy of Stephen
	Zhang.

						Thanx, Paul

------------------------------------------------------------------------

 rcu/rcutorture.c |    6 +++---
 torture.c        |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
