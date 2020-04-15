Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD4C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA8621744
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970666;
	bh=lpFMDx1GHWoEhhhCxtAnj/ZvLR/eoqZCj41D8tbU86Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BHJlwbyWIyACmSD5f+yIiNyuNZeXCVCEEmLwRE2aJZPPnnYT3Kmi6Xc1B2Tj8OvT2
	 pkX+k2eL/OXMOcafabcwjjZBT6D/Xn3PoZA76gaprGKAwQBPs/L8uT0rVOBnH2ioSZ
	 ej3JSazyenTm7MUmAHkuMZ2KHIfYfAC4fMy+k/tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410738AbgDORLG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410722AbgDORLB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E604A21D92;
        Wed, 15 Apr 2020 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970661;
        bh=lpFMDx1GHWoEhhhCxtAnj/ZvLR/eoqZCj41D8tbU86Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xnEloBK6wDRrC35S/xGj4klu/kQpmx47AIKoOrdvUmiR3m45cSxKP7TXsd4mpjyxz
         jzGcPKa+MMC3Q7WYHqxL3ileCcIKUKrTAZ00eJ9AWaQWP8CTL9C0Ns/aw1npH1tRru
         01SYKgm59MpjRMvuihVK1d4QpMKvb92ZdYfTAPKQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Jules Irenge <jbi.octave@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/19] rcu: Replace assigned pointer ret value by corresponding boolean value
Date:   Wed, 15 Apr 2020 10:10:50 -0700
Message-Id: <20200415171054.9013-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Coccinelle reports warnings at rcu_read_lock_held_common()

WARNING: Assignment of 0/1 to bool variable

To fix this,
the assigned  pointer ret values are replaced by corresponding boolean value.
Given that ret is a pointer of bool type

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 72461dd8..17f2356 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -98,15 +98,15 @@ module_param(rcu_normal_after_boot, int, 0);
 static bool rcu_read_lock_held_common(bool *ret)
 {
 	if (!debug_lockdep_rcu_enabled()) {
-		*ret = 1;
+		*ret = true;
 		return true;
 	}
 	if (!rcu_is_watching()) {
-		*ret = 0;
+		*ret = false;
 		return true;
 	}
 	if (!rcu_lockdep_current_cpu_online()) {
-		*ret = 0;
+		*ret = false;
 		return true;
 	}
 	return false;
-- 
2.9.5

