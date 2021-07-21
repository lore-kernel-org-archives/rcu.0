Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D60C6377D
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206946124C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhGUUVM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DC916128E;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=9guxo/HavLdv7hja4DcSh7RJUR0VSPxZDqh9LOoDbRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DC+IPN0PKBqyZazEsydPoNa6NFq7mEqYW09rvh7KUxZXgZX6im9VIBrOE9Qq/rm3Q
         1gtz/05GM0rbDhBcExaBtdqYwy3zTrZSFArUEG7UJ6mibT/uzL8cc3vUNCVSQqL6/R
         HzCtk3zcX48WZLL4Exh3+9AJ5ghfk/qTcpaakpUzIFYVbk1E/XMubH8kIXMzKVxdlQ
         5jykovKuEXfN1LMvOXD/CQJvGS5rqQyjcrNKBp8mHhosHofQU3j97vOh69YhXhmPbA
         LNMi8HD1P3VKwWHdJRB3hekXVA4GBMgZG/3k1iX4jTYKFy8M3+w+Vjyth08Cx1Lazf
         qrUlqN/3bmp/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DCB455C0F64; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/21] torture: Put kvm.sh batch-creation awk script into a temp file
Date:   Wed, 21 Jul 2021 14:01:30 -0700
Message-Id: <20210721210140.787717-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit is a first step towards pinning guest-OS vCPUs so as
to force latency differences, especially on multi-socket systems.
The kvm.sh script puts its batch-creation awk script into a temporary
file so that later commits can add the awk code needed to dole out CPUs
so as to maximize latency differences.  This awk code will be used by
multiple scripts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 27 ++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index b4ac4ee332226..0f26a81599f5c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -430,17 +430,8 @@ then
 	git diff HEAD >> $resdir/$ds/testid.txt
 fi
 ___EOF___
-awk < $T/cfgcpu.pack \
-	-v TORTURE_BUILDONLY="$TORTURE_BUILDONLY" \
-	-v CONFIGDIR="$CONFIGFRAG/" \
-	-v KVM="$KVM" \
-	-v ncpus=$cpus \
-	-v jitter="$jitter" \
-	-v rd=$resdir/$ds/ \
-	-v dur=$dur \
-	-v TORTURE_QEMU_ARG="$TORTURE_QEMU_ARG" \
-	-v TORTURE_BOOTARGS="$TORTURE_BOOTARGS" \
-'BEGIN {
+cat << '___EOF___' > $T/dumpbatches.awk
+BEGIN {
 	i = 0;
 }
 
@@ -560,7 +551,19 @@ END {
 	# Dump the last batch.
 	if (ncpus != 0)
 		dump(first, i, batchnum);
-}' >> $T/script
+}
+___EOF___
+awk < $T/cfgcpu.pack \
+	-v TORTURE_BUILDONLY="$TORTURE_BUILDONLY" \
+	-v CONFIGDIR="$CONFIGFRAG/" \
+	-v KVM="$KVM" \
+	-v ncpus=$cpus \
+	-v jitter="$jitter" \
+	-v rd=$resdir/$ds/ \
+	-v dur=$dur \
+	-v TORTURE_QEMU_ARG="$TORTURE_QEMU_ARG" \
+	-v TORTURE_BOOTARGS="$TORTURE_BOOTARGS" \
+	-f $T/dumpbatches.awk >> $T/script
 echo kvm-end-run-stats.sh "$resdir/$ds" "$starttime" >> $T/script
 
 # Extract the tests and their batches from the script.
-- 
2.31.1.189.g2e36527f23

