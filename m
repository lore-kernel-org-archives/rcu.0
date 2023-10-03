Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA11CE8FDC0
	for <rcu@archiver.kernel.org>; Tue,  3 Oct 2023 23:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjJCX3O (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbjJCX3N (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Oct 2023 19:29:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B5BB;
        Tue,  3 Oct 2023 16:29:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80845C433C8;
        Tue,  3 Oct 2023 23:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375750;
        bh=7/LYX88Wk78uddD8OaNEI8pUWtPtDqIWAY8ypJFmHC0=;
        h=From:To:Cc:Subject:Date:From;
        b=Na8OIKWcA3s1tnsiGzBkH6XQzt1OvSR34rjmF5LpWfY1CykzCctd0mILCqPJ21rvb
         bbsn0izR+SCRC6HG5y+94AfYFokm5USYZsyH31nUOr8yHuj2dWbNHL7OdMO/WL9Ck1
         xZe2QMyJlSGxKscidjiBJxcfVM/eu+n4m1w1gn9zKEu0EcKv0o+03ecojiok1VUbmo
         EueifNbmz77inUBt/CPmRDXw0hHMLRkDYreXljo7p2pLrJwT0kkrwxv0N2fVjVvETX
         kHKqOxuMJoA3baqtY+NCaTz60K4Yz4+a9ceUH6Ovg6OKPTeFykQjbr5dL7Ed2j6rUY
         QhXf8N8qhxY+A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: [PATCH 0/5] srcu fixes
Date:   Wed,  4 Oct 2023 01:28:58 +0200
Message-ID: <20231003232903.7109-1-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

This contains a fix for "SRCU: kworker hung in synchronize_srcu":

	http://lore.kernel.org/CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com

And a few cleanups.

Passed 50 hours of SRCU-P and SRCU-N.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	srcu/fixes

HEAD: 7ea5adc5673b42ef06e811dca75e43d558cc87e0

Thanks,
	Frederic
---

Frederic Weisbecker (5):
      srcu: Fix callbacks acceleration mishandling
      srcu: Only accelerate on enqueue time
      srcu: Remove superfluous callbacks advancing from srcu_start_gp()
      srcu: No need to advance/accelerate if no callback enqueued
      srcu: Explain why callbacks invocations can't run concurrently


 kernel/rcu/srcutree.c | 55 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 16 deletions(-)
