Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6848CC433DF
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFFE20823
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029522;
	bh=Ud+RpLMV4dWOyKjdxATNiBtJWY31iUXVLUKQ0Pw1OEs=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=u2/uChPkSufTr38y+RZtFDlNTekhj7KYi+2OC2FixvaQ4KZGvRYPV8hXojF0ZImAQ
	 E4P7HAnsEAoS2/vO9s81/QMCEojWhljTLX9uu7h8b/ZGOUPhZrR8F8RMBfeeShxpAq
	 jjlwmQuujwNz1xs1RrjtOIvVXlYlVnb/Y3IXgf4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406271AbgFXUMC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406231AbgFXUMB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C479E2081A;
        Wed, 24 Jun 2020 20:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029520;
        bh=Ud+RpLMV4dWOyKjdxATNiBtJWY31iUXVLUKQ0Pw1OEs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Sn8K7bJI2A2bReHxyKOVrn40YgYXvT6VRe4UiqcQ8SuYRzjDU6jCotK4fb0cmghkE
         iEpCpHtGTVnfLJNGkMM97h32Kll7pdcMi5nausdVV3hF1iT7HsxoHZSAF9OKHVbG28
         bA+GJroXFubeCOb1DuR1OTdBkNFJ/FWcqh0PZetQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AF09435228BC; Wed, 24 Jun 2020 13:12:00 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:12:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/17] kfree_rcu updates for v5.9
Message-ID: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains kfree_rcu() updates.  Unless otherwise noted,
these are all courtesy of Uladzislau Rezki.

1.	Fix a kernel-doc warnings for "count", courtesy of Mauro Carvalho
	Chehab.

2.	rcu/tree: Keep kfree_rcu() awake during lock contention, courtesy
	of Joel Fernandes.

3.	rcu/tree: Skip entry into the page allocator for PREEMPT_RT,
	courtesy of Joel Fernandes.

4.	rcu/tree: Repeat the monitor if any free channel is busy.

5.	rcu/tree: Make debug_objects logic independent of rcu_head,
	courtesy of Joel Fernandes.

6.	rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro.

7.	rcu/tree: Move kfree_rcu_cpu locking/unlocking to separate
	functions.

8.	rcu/tree: Use static initializer for krc.lock, courtesy of
	Sebastian Andrzej Siewior.

9.	rcu/tree: cache specified number of objects.

10.	rcu/tree: Maintain separate array for vmalloc ptrs.

11.	rcu/tiny: support vmalloc in tiny-RCU.

12.	Rename *_kfree_callback/*_kfree_rcu_offset/kfree_call_*.

13.	mm/list_lru.c: Rename kvfree_rcu() to local variant.

14.	Introduce 2 arg kvfree_rcu() interface.

15.	Support reclaim for head-less object.

16.	Introduce single argument kvfree_rcu() interface.

17.	lib/test_vmalloc.c: Add test cases for kvfree_rcu().

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    8 
 include/linux/rcupdate.h                        |   61 ++-
 include/linux/rcutiny.h                         |   20 -
 include/linux/rcutree.h                         |    2 
 include/trace/events/rcu.h                      |    8 
 kernel/rcu/tiny.c                               |    7 
 kernel/rcu/tree.c                               |  443 ++++++++++++++++--------
 lib/test_vmalloc.c                              |  103 +++++
 mm/list_lru.c                                   |    6 
 9 files changed, 481 insertions(+), 177 deletions(-)
