Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E8C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D362F20842
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872715;
	bh=A4vha9pyInfPaCLA6akZMwVrr7X6XKSlu00Tn4YD7JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GQORsULfrcRJjsqcuJtNeqoaCMJK9s1+FxTv+Wi17bUGPGBsW4+ciIJUoTDx3V7CX
	 nb6VDKXO7THA6Kor1d2yFbHEjhV5Y60DL09GFEUIREuMPyCC7yAF1zumOMrQwM1Qze
	 kLEIv6TPt47U2TXTgO6r6wUa+/shFqObD9vPD1FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbgFWAh6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732149AbgFWAh5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B43820E65;
        Tue, 23 Jun 2020 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872676;
        bh=A4vha9pyInfPaCLA6akZMwVrr7X6XKSlu00Tn4YD7JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RN8+wrZk+rhP3TiLfjxaVsjUuU0Cml1bXb24T4i0Lb/cHgWcB3cxKunP0GFrZ+sLl
         7Eqh7/8RueWQ+QtWLb8rTkrMRn//LcnPmoZ+51LVtTMG4jJsSSkj7ikBCF2npRRBpC
         h+ehF3sA1EkbtQwn2WDMGD9RqulFiLkNwg5b6Q2M=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/23] torture: Abstract out console-log error detection
Date:   Mon, 22 Jun 2020 17:37:42 -0700
Message-Id: <20200623003752.26872-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit pulls the simple pattern-based error detection from the
console log into a new console-badness.sh file.  This will enable future
commits to end a run on the first error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/console-badness.sh  | 16 ++++++++++++++++
 tools/testing/selftests/rcutorture/bin/parse-console.sh  |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/console-badness.sh

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
new file mode 100755
index 0000000..0e4c0b2
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Scan standard input for error messages, dumping any found to standard
+# output.
+#
+# Usage: console-badness.sh
+#
+# Copyright (C) 2020 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
+grep -v 'ODEBUG: ' |
+grep -v 'This means that this is a DEBUG kernel and it is' |
+grep -v 'Warning: unable to open an initial console'
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 1c64ca8..98478e1 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -116,10 +116,7 @@ then
 	fi
 fi | tee -a $file.diags
 
-egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for' < $file |
-grep -v 'ODEBUG: ' |
-grep -v 'This means that this is a DEBUG kernel and it is' |
-grep -v 'Warning: unable to open an initial console' > $T.diags
+console-badness.sh < $file > $T.diags
 if test -s $T.diags
 then
 	print_warning "Assertion failure in $file $title"
-- 
2.9.5

