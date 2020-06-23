Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800EBC433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A072075A
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872754;
	bh=PxYsx88Gz1U3tOSWgsTPU520MKLsJbobf53NrQp8E0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nSZZG2UPE6fOA8kreVO8HDotlrTXg9mtbx+c82zxAtMahcnvPmw2DuoGchfh7tqoS
	 PbgDZaRnT5Kx5ntKZq9YmFTB8r3cTN2F+QLO8oFZXnjABcXPUBqt7n5n3o5lZyha+s
	 zsjEHxyIHe4rW9UcsYsq4Oxn9cntHIhwaAW5nK5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbgFWAjJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731995AbgFWAhz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2497D20936;
        Tue, 23 Jun 2020 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872675;
        bh=PxYsx88Gz1U3tOSWgsTPU520MKLsJbobf53NrQp8E0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Bn8IkRHkpOZqVE2Equ7vDng7mjVUuFEWHkF1bmhkNpOPsFb4FFrkOo3nBB6Fz74J
         VPzFRnpX4fkkiMIm1s82oQN2TlR8BrYf7yhTu6RZyENdpULaIDXyR8zonF8US0MoJZ
         b8ZGn/jZw3KdMoL5h4UV7yoM71wBnAd7rsUypIwM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/23] rcutorture: Handle non-statistic bang-string error messages
Date:   Mon, 22 Jun 2020 17:37:35 -0700
Message-Id: <20200623003752.26872-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The current console parsing assumes that console lines containing "!!!"
are statistics lines from which it can parse the number of rcutorture
too-short grace-period failures.  This prints confusing output for
other problems, including memory exhaustion.  This commit therefore
differentiates between these cases and prints an appropriate error string.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/parse-console.sh  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 4bf62d7..1c64ca8 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -44,11 +44,23 @@ then
 		tail -1 |
 		awk '
 		{
-			for (i=NF-8;i<=NF;i++)
+			normalexit = 1;
+			for (i=NF-8;i<=NF;i++) {
+				if (i <= 0 || i !~ /^[0-9]*$/) {
+					bangstring = $0;
+					gsub(/^\[[^]]*] /, "", bangstring);
+					print bangstring;
+					normalexit = 0;
+					exit 0;
+				}
 				sum+=$i;
+			}
 		}
-		END { print sum }'`
-		print_bug $title FAILURE, $nerrs instances
+		END {
+			if (normalexit)
+				print sum " instances"
+		}'`
+		print_bug $title FAILURE, $nerrs
 		exit
 	fi
 
-- 
2.9.5

