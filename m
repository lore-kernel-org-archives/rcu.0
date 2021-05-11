Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B459C433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B37A61624
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhEKXKb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhEKXKb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:10:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B68361626;
        Tue, 11 May 2021 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774564;
        bh=f7yVnIcNg9JX9ov8g3wDGlv/bRhnW+rugvwUG0H3tNk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=htYy12xdloOhp2RyYTN+E1gh069+k2O0NDwsLEbuRe4ug/Odm4sUmlTPBM9sAI35h
         bP20BiXo+DBqDznVDgSIonB49l0ScNelpDWdNkcw50FvSM2Ff1cSRZ+fytu1FXodDS
         bNexLbtF0haEwqpSUf3MrGp7g5qBHOaf7+5M+Vhn0jVdoczjv9HLUbugEM/R05iLdC
         PNPGyTfLtraSX1N/TdIUzRkf2IBgZFqtj2GCQMwJHtRsdRXLCxc6octnEk7ErimSE8
         PPNyt/88JVnBCnwprmH2PPQrf8aAkQOw1+zSjV3d8ywfw5RGG5xHGJ6F/S8M4q82kj
         OcmhVDIQBkg8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2B38F5C0138; Tue, 11 May 2021 16:09:24 -0700 (PDT)
Date:   Tue, 11 May 2021 16:09:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/4] Tasks-RCU updates for v5.14
Message-ID: <20210511230924.GA2894768@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides Tasks-RCU updates.

1.	rcu-tasks: Add block comment laying out RCU Tasks design.

2.	rcu-tasks: Add block comment laying out RCU Rude design.

3.	rcu-tasks: Make ksoftirqd provide RCU Tasks quiescent states.

4.	tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcu.h   |    4 ++++
 b/kernel/rcu/tasks.h |   40 ++++++++++++++++++++++++++++++++++++++++
 b/kernel/rcu/tree.c  |    1 +
 kernel/rcu/tasks.h   |   10 +++++++---
 4 files changed, 52 insertions(+), 3 deletions(-)
