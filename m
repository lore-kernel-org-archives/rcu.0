Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F27DC4167B
	for <rcu@archiver.kernel.org>; Tue,  7 Nov 2023 10:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjKGK5b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Nov 2023 05:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjKGK5I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Nov 2023 05:57:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9737F1724;
        Tue,  7 Nov 2023 02:56:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9ECC433CC;
        Tue,  7 Nov 2023 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699354589;
        bh=W35i6xhopLV9dptndmhPlBN36HCJbHWE45T4K9LNRx4=;
        h=Date:From:To:Cc:Subject:From;
        b=agsjD5eRfJS9WxEWpNLyh4cQNFSKk4GyfeQCL9G/NmPfF/N/NFjQIPzeFwiHFTLXM
         3S0exWfuhfjqdEV9M9kmCdenoCdH9zL1TMcO6WrCvCUvci4DCwEQCobFqmaMG7OG3W
         TePo+ph2OgZCB8rxApaqZ7PRWNbwD5PLtYLCANIgSyfZSD2S5qwCxP2stTBthuUWtX
         GP358/6IPH1wdQJbKy5Uq1NxFvq2xlFmk+xYrqOjN4zmyvJVr+q/4kdkuWB5SFowTz
         LnaiRj2doFH2y8kW6Tpoot9j8ydhZr1V054JFkFicI4cILctct0n01X2s7jiCcaYJf
         KlbDvvni6YDRg==
Date:   Tue, 7 Nov 2023 11:56:26 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Subject: [GIT PULL] RCU fixes for v6.7-rc1
Message-ID: <ZUoX2lAwknn9JkEm@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Linus,

Please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/rcu-fixes-v6.7

for you to fetch changes up to a80712b9cc7e57830260ec5e1feb9cdb59e1da2f:

  rcu/tasks-trace: Handle new PF_IDLE semantics (2023-11-01 22:12:03 +0100)

----------------------------------------------------------------
RCU fixes for v6.7

* Fix a lock inversion between scheduler and RCU introduced
  in v6.2-rc4. The scenario could trigger on any user of RCU_NOCB
  (mostly Android and also nohz_full).

* Fix PF_IDLE semantic changes introduced in v6.6-rc3 breaking some
  RCU-Tasks and RCU-Tasks-Trace expectations as to what exactly is
  an idle task. This resulted in potential spurious stalls and
  warnings.

----------------------------------------------------------------
Frederic Weisbecker (3):
      rcu: Introduce rcu_cpu_online()
      rcu/tasks: Handle new PF_IDLE semantics
      rcu/tasks-trace: Handle new PF_IDLE semantics

Peter Zijlstra (1):
      rcu: Break rcu_node_0 --> &rq->__lock order

 kernel/rcu/rcu.h   |  2 ++
 kernel/rcu/tasks.h | 32 +++++++++++++++++++++++++++++---
 kernel/rcu/tree.c  | 43 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 63 insertions(+), 14 deletions(-)
