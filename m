Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA58C433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C34261B1B
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhKQP7n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235325AbhKQP7l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 10:59:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06DC261A52;
        Wed, 17 Nov 2021 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637164602;
        bh=0wlnUoEor0mVOcM1L6g0mqrNoGqhsS7ylAzTRoEAP8o=;
        h=From:To:Cc:Subject:Date:From;
        b=RvY3O/ruQJ4X5zTzMtcG3KXCcE3k/E7PpgT6W6sjXEdtLZMvRBpmcfwso9hw4h8Oh
         28by5ZcGWKdocqZ94XpjHmgg/LTAcbIgGtZ+ws9h7lK0g+TXew7q6/tRxgTmcQvDUS
         z0sFTB2WCzTvlHdRinfV19lpI1PjoFXi07447Cnj061UjpKf5610+wy9u41mmQPJpt
         fdjAzH7+//R9F872NQ6YOOsuPmb87gYd6RJjxXoGv6Ms/Ven9++u27GD7pAgEu8BZu
         8HlT0in/s9gxaahcpwkZEjgxn90uWsUAVaoezxogrb/h94rb1cn8rd2yueQgr903o5
         +pbVa5QVQz1UA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 0/6] rcu/nocb: Last prep work before cpuset interface
Date:   Wed, 17 Nov 2021 16:56:31 +0100
Message-Id: <20211117155637.363706-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

Hopefully this is the last RCU-side preparation work before I manage
to add a cpuset interface to toggle nocb (de-)offloading.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 23dcef16e09a8a60cd15d001df56f72561d57a7f

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      rcu/nocb: Remove rdp from nocb list when de-offloaded
      rcu/nocb: Prepare nocb_cb_wait() to start with a non-offloaded rdp
      rcu/nocb: Optimize kthreads and rdp initialization
      rcu/nocb: Create nocb kthreads on all CPUs as long as the "rcu_nocb=" is passed
      rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
      rcu/nocb: Merge rcu_spawn_cpu_nocb_kthread() and rcu_spawn_one_nocb_kthread()


 kernel/rcu/tree.h      |   7 +++-
 kernel/rcu/tree_nocb.h | 111 +++++++++++++++++++++++++++++--------------------
 2 files changed, 70 insertions(+), 48 deletions(-)
