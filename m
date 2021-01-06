Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E0C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475182312F
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhAFR2M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:28:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbhAFR1a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85A0A23131;
        Wed,  6 Jan 2021 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953971;
        bh=YRS3SgzeFsngPUCkphU23WZJuB5S0udz/s60I4DrnmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyQ9GxT1StkK60X3K6EllKQunHQJqgEKT/5Y0poif4zcxxYKzx0mJUu9NiUVD1QWO
         ee10wtUo2BGVGXLaiJ70mr3A/RWQmjbGse7eiWALu0OZhGdd5tbnVyUPgGKEFFGH4t
         hrHCPYT2oJm27P4Tw3CngIJWh/ESNSl9vp7Sqm9FUerdMBOTP9mIgjg7QjXFIhxr/k
         VRiysoucb3V1wLnvMp4wcA08WcW9giBYlFg1XMn8DB79HQhZIP9nYFqlzWngzGsw2E
         N0rfgXy2Hiq9ggamK8jP7SAtZnNy1BsMLQhpM0Rqc2g02G+/9DQ3yAO133IgcpkCNS
         YcSRKVMWlfzhA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/20] torture: Make kvm.sh include --kconfig arguments in CPU calculation
Date:   Wed,  6 Jan 2021 09:25:59 -0800
Message-Id: <20210106172607.22816-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, passing something like "--kconfig CONFIG_NR_CPUS=2" to kvm.sh
has no effect on scenario scheduling.  For scenarios that do not specify
the number of CPUs, this can result in kvm.sh wastefully scheduling only
one scenario at a time even when the --kconfig argument would allow
a number to be run concurrently.  This commit therefore makes kvm.sh
consider the --kconfig arguments when scheduling scenarios across the
available CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6f21268..472929c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -290,7 +290,13 @@ for CF1 in $configs_derep
 do
 	if test -f "$CONFIGFRAG/$CF1"
 	then
-		cpu_count=`configNR_CPUS.sh $CONFIGFRAG/$CF1`
+		if echo "$TORTURE_KCONFIG_ARG" | grep -q '\<CONFIG_NR_CPUS='
+		then
+			echo "$TORTURE_KCONFIG_ARG" | tr -s ' ' | tr ' ' '\012' > $T/KCONFIG_ARG
+			cpu_count=`configNR_CPUS.sh $T/KCONFIG_ARG`
+		else
+			cpu_count=`configNR_CPUS.sh $CONFIGFRAG/$CF1`
+		fi
 		cpu_count=`configfrag_boot_cpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
 		cpu_count=`configfrag_boot_maxcpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
 		echo $CF1 $cpu_count >> $T/cfgcpu
-- 
2.9.5

