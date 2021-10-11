Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A94EC433F5
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6108860EE2
	for <rcu@archiver.kernel.org>; Mon, 11 Oct 2021 14:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhJKOxv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:32800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235128AbhJKOxr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Oct 2021 10:53:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F02960EE2;
        Mon, 11 Oct 2021 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963907;
        bh=At0WCNBvjCGiGGgF3z1lDOfAqi3ecy6QdY/pF7Wkrlw=;
        h=From:To:Cc:Subject:Date:From;
        b=q1098baukGdyMXC9gk062TUOorgT4YcpqzUMWhNag+SHyat9v4tNffwzh2/2s+4fN
         yoNybdx3U/EnLtDlrNJaWKIM2eeUquXGnu2a+xdd1H2Rd4WFDWdpUnAHqbItrg10Mq
         8HKWD/EBJWmGxLYdf+qSiL6+0nB8cwYPxTS/vBuBivBNGbUiAwcZJ3sx9ndUFlQBbx
         RmaiYbiJS4upE1mII+MXZ+54pQuwBnimwO+0jt/wUWQkF+rZ4fYRgE//RI5uicGuae
         rsy8r04ytGOK/TCOaVdBaLd6H3hsdqRopBh2TNndkcWFR3UGBmH4LmoJEh6vYWokUi
         99aIyDwCl9A1g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB + a few other fixes v2
Date:   Mon, 11 Oct 2021 16:51:29 +0200
Message-Id: <20211011145140.359412-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

No code change in this v2, only changelogs:

* Add tags from Valentin and Sebastian

* Remove last reference to SEGCBLIST_SOFTIRQ_ONLY (thanks Valentin)

* Rewrite changelog for "rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check"
  after off-list debates with Paul.

* Remove the scenario with softirq interrupting rcuc on
  "rcu/nocb: Limit number of softirq callbacks only on softirq" as it's
  probably not possible (thanks Valentin).

* Remove the scenario with task spent scheduling out accounted on tlimit
  as it's not possible (thanks Valentin)
  (see "rcu: Apply callbacks processing time limit only on softirq")

* Fixed changelog of
  "rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread"
  (thanks Sebastian).

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/rt-v2

HEAD: 2c9349986d5f70a555195139665841cd98e9aba4

Thanks,
	Frederic
---

Frederic Weisbecker (10):
      rcu/nocb: Make local rcu_nocb_lock_irqsave() safe against concurrent deoffloading
      rcu/nocb: Prepare state machine for a new step
      rcu/nocb: Invoke rcu_core() at the start of deoffloading
      rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
      rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
      rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
      rcu/nocb: Limit number of softirq callbacks only on softirq
      rcu: Fix callbacks processing time limit retaining cond_resched()
      rcu: Apply callbacks processing time limit only on softirq
      rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread

Thomas Gleixner (1):
      rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe


 include/linux/rcu_segcblist.h | 51 ++++++++++++++++++-------
 kernel/rcu/rcu_segcblist.c    | 10 ++---
 kernel/rcu/rcu_segcblist.h    | 12 +++---
 kernel/rcu/tree.c             | 87 +++++++++++++++++++++++++++++--------------
 kernel/rcu/tree.h             | 16 +++++---
 kernel/rcu/tree_nocb.h        | 29 ++++++++++++---
 6 files changed, 141 insertions(+), 64 deletions(-)
