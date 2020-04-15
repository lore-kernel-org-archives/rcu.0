Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF93EC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D58B2076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586972075;
	bh=HikJ6mnWhOOmNpYbei/Nibhwz1bEc5VLRGABERfQOHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MAl3qUzt1AlhaG+W57lMoimoiXFYuTfFhR9BGt33eSCuzEeo6eRwrSMzyPUaaSO3d
	 oBfubkJzI52jsEUk0PCWKD43itvfX+HpkczTFjcEWUuAHwrqeImQiC0dgDHAf+848w
	 HayF8BdW9Xu54Qm/3U2Uc3pV4XLBvwxG/GmoFj/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411352AbgDOReC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411115AbgDORbC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22499208E0;
        Wed, 15 Apr 2020 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971862;
        bh=HikJ6mnWhOOmNpYbei/Nibhwz1bEc5VLRGABERfQOHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zu8b153tsFRqMvMmkruH6myie6YBQr1gKyaMBQUgw8VCRqSFZ5GjqshqYdMeWiVC4
         IXWATd+IWnf6kOrpVZHFOA7Gc+oHuIDsT6fWLO9iIKAgMyhhUQmCiJODBaOzuYvmii
         R2MLqvwk3476C905dU7DgsxFB0Ed1DH/EoxGXpfY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/18] rcutorture: Make kvm-recheck-rcu.sh handle truncated lines
Date:   Wed, 15 Apr 2020 10:30:44 -0700
Message-Id: <20200415173100.9927-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

System hangs or killed rcutorture guest OSes can result in truncated
"Reader Pipe:" lines, which can in turn result in false-positive
reader-batch near-miss warnings.  This commit therefore adjusts the
reader-batch checks to account for possible line truncation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh  | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 9d9a416..1706cd4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -41,7 +41,21 @@ else
 		title="$title ($ngpsps/s)"
 	fi
 	echo $title $stopstate $fwdprog
-	nclosecalls=`grep --binary-files=text 'torture: Reader Batch' $i/console.log | tail -1 | awk '{for (i=NF-8;i<=NF;i++) sum+=$i; } END {print sum}'`
+	nclosecalls=`grep --binary-files=text 'torture: Reader Batch' $i/console.log | tail -1 | \
+		awk -v sum=0 '
+		{
+			for (i = 0; i <= NF; i++) {
+				sum += $i;
+				if ($i ~ /Batch:/) {
+					sum = 0;
+					i = i + 2;
+				}
+			}
+		}
+
+		END {
+			print sum
+		}'`
 	if test -z "$nclosecalls"
 	then
 		exit 0
-- 
2.9.5

