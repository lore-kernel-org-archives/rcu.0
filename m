Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D2DC12002
	for <rcu@archiver.kernel.org>; Wed, 14 Jul 2021 20:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139CC613C5
	for <rcu@archiver.kernel.org>; Wed, 14 Jul 2021 20:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhGNUwV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhGNUwV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Jul 2021 16:52:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B204613C8;
        Wed, 14 Jul 2021 20:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626295769;
        bh=I13H3HNHji5pJUJzsVXYt/NaCUMH+vRYBnFEzoAGtzA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=oD3Rl+InNyTLcDPBaK/B3hrr0XUMLPXPHvfLoK0F7GAK4g0z5wsqzGvwpgWDpMoz7
         OvUKqnEcVDcrtZeEY9c7aPMK2arx7Qz9sau0IeRB8xrnvolAO/hJSCsnruTL2MaRm6
         84m3QnhkkplWMbuNpbg0VOhKKyO1CDasQdqjNmKqHNMSj9r3fXMmhxlWmHzI4pllza
         EwUN6eQqprDZqONZxp8bvTVFhRDuvU2VQ7ibr2A9BByKLW9OLXXj7cnSPjCV3ifp4q
         TUidp/HGQgAUcOZXEGQqpSJgtE8NPhoRiXeSJrjJc7WYf6GW+SZIyno+nU3Rk4+05S
         Z/9AadXMz/NMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 04A015C0355; Wed, 14 Jul 2021 13:49:28 -0700 (PDT)
Date:   Wed, 14 Jul 2021 13:49:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, valentin.schneider@arm.com
Subject: [PATCH rcu/urgent 0/2] Adjust for updated scheduler CPU-affinity
 semantics
Message-ID: <20210714204928.GA2033276@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series converts smp_processor_id() calls to raw_smp_processor_id()
calls in kthreads that are intended to be bound to a single CPU, but
which are subject to human rebinding.  While in the area, it warns if
set_cpus_allowed_ptr() returns failure.  The patches are as follows:

1.	Avoid false-positive warnings in scftorture_invoker().

2.	Avoid false-positive warnings in ref_scale_reader().

						Thanx, Paul

------------------------------------------------------------------------

 rcu/refscale.c |    6 +++---
 scftorture.c   |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
