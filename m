Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A911C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2510206C3
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871025;
	bh=uM60TInvRXu0eMKTDe77HJ7sHKmRkq4gHqQx5e+Uvlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uQp+7ixYYdOp6A6D0ZCj2n3bfo7jQS64CrEcn7qKEQbtgaxR8fWlEalkCdFkGa6yh
	 B+S10vxZkGafRpjxzrV48H8mv/+W+BBUvYSQvJgmncx1XTaj1gHhTfiDG8URirI/WT
	 b/Avu3ZzxYIJtH2MI2RDQNP7a7Iw2c2b+prVPeTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgFWAKK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731509AbgFWAJw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448A4208D5;
        Tue, 23 Jun 2020 00:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870991;
        bh=uM60TInvRXu0eMKTDe77HJ7sHKmRkq4gHqQx5e+Uvlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rstvupwShAsU/O3Oi1QFL6+CllrDQW6i5xe0TtGBSXkuKxan/hzR7QrSk5YrgBlee
         5QNooCWEXQmTfxnCP7PQzVQd8iDNsFaPVx0hB8QN9tyVmvP1Yfhw50idxbcFKE3Bgd
         F7zp3aMe8SnnKbDGN8LtaxE28pVfZmn7w4jXY0Lo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/10] doc: Timer problems can cause RCU CPU stall warnings
Date:   Mon, 22 Jun 2020 17:09:46 -0700
Message-Id: <20200623000947.25222-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623000923.GA25047@paulmck-ThinkPad-P72>
References: <20200623000923.GA25047@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Over the past few years, there have been several cases where timekeeping
bugs have caused RCU CPU stall warnings, particularly during hardware
bringup.  This commit therefore adds such bugs to the list of things
that can result in RCU CPU stall warnings.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 08bc9ae..c9ab6af 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -87,6 +87,13 @@ warnings:
 	problem really has happened, and seems to be most likely to
 	result in RCU CPU stall warnings for CONFIG_NO_HZ_COMMON=n kernels.
 
+-	A hardware or software issue that prevents time-based wakeups
+	from occurring.  These issues can range from misconfigured or
+	buggy timer hardware through bugs in the interrupt or exception
+	path (whether hardware, firmware, or software) through bugs
+	in Linux's timer subsystem through bugs in the scheduler, and,
+	yes, even including bugs in RCU itself.
+
 -	A bug in the RCU implementation.
 
 -	A hardware failure.  This is quite unlikely, but has occurred
-- 
2.9.5

