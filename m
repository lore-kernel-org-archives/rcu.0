Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03158C6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC92B60698
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhGUTqk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhGUTqk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:46:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74A8C61221;
        Wed, 21 Jul 2021 20:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899236;
        bh=TQmEZg+Sj+04B+Vhe9Tt8lQmPjDUAau6RE/aWEtgw0Y=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=trgxzN4SH23g+lxC+6TR77r37TEz8CwneEgh8WejwWSPY9tDyldQStDaugmKjlSEr
         6Rl2eoipfskIwmafnjPlrkMcGpOHXz9K6R8+7/zXCdAE1z4QNdhAadskZo2xahnbnQ
         4KTg20BE1/ByKxEclWVFLOcXNN8PFld0R5ArmbOK2a413ibdJtYBPA+I7ahVMf5Sfx
         VKQyxFE+9C9wAcNMo90ms3dsEMBLlqcpWiOx34LD+0KsN9YHZcLhpHseJbh7PMvjiq
         Hkm1Cme6X6s/D7vcmdbXaAISNNnVMmXoFO7vz1jSpMkaVvaMYxyR3FOvzJr1LnjDEd
         7OWE8mmGAa5Vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 358D05C09A4; Wed, 21 Jul 2021 13:27:16 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:27:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/2] NOCB-CPU updates for v5.15
Message-ID: <20210721202716.GA2679705@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

The following series provides NOCB updates:

1.	Start moving nocb code to its own plugin file, courtesy of
	Frederic Weisbecker.

2.	Remove NOCB deferred wakeup from rcutree_dead_cpu(), courtesy
	of Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree.c        |    1 
 b/kernel/rcu/tree_nocb.h   | 1496 +++++++++++++++++++++++++++++++++++++++++++++
 b/kernel/rcu/tree_plugin.h | 1487 --------------------------------------------
 kernel/rcu/tree.c          |    3 
 4 files changed, 1497 insertions(+), 1490 deletions(-)
