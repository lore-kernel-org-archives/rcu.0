Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BDDC4332D
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4AE23125
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbhAFRcn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbhAFRcm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 811CF23158;
        Wed,  6 Jan 2021 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954282;
        bh=pcE5RZNr7iI0Mg2o0dARbyoj958xj5NC9xj8ycv1oYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgvcH9x7XChwfZklHL+wxnQbItdTEjVCddACvhH+1slwkxKFj8m0jHup/6/IoWo4O
         n34MXFmtph5gtFqMSQrcxSrtVEpJAw7f6F+5EIF2+ZhijnnSseBK7IWfDwLgEBTuiH
         wax3G6LisH6RvWpQFXR+90stEqD39sDhFyDCSOjXPRGyfNtc7177hFTAqOypDoq/vF
         LtSFVO9xAzKJ5plT3lNXDMXkXN7hmBPuuvSQFXFqo57gbBrvKnlHPJa9yvhTWws/tR
         uEp0V+FLy8QpFP2OCTNZFWOQsVnxQyFqpK7SpxhtlVDkcJMT1cy23YElbqcAFViLHu
         JlTDhsBNwE+Uw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/18] torture: Make torture.sh refscale runs use verbose_batched module parameter
Date:   Wed,  6 Jan 2021 09:31:10 -0800
Message-Id: <20210106173119.23159-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

On large systems, the refscale printk() rate can overrun the file system's
ability to accept console log messages.  This commit therefore uses the
new verbose_batched module parameter to rate-limit some of the higher-rate
printk() calls.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a89b521..a3c3c25 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -24,6 +24,11 @@ if test "$HALF_ALLOTED_CPUS" -lt 1
 then
 	HALF_ALLOTED_CPUS=1
 fi
+VERBOSE_BATCH_CPUS=$((TORTURE_ALLOTED_CPUS/16))
+if test "$VERBOSE_BATCH_CPUS" -lt 2
+then
+	VERBOSE_BATCH_CPUS=0
+fi
 
 # Default duration and apportionment.
 duration_base=10
@@ -309,7 +314,7 @@ fi
 for prim in $primlist
 do
 	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS" --trust-make
 done
 
 if test "$do_rcuscale" = yes
-- 
2.9.5

