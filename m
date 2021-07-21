Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7063C63797
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C9261246
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhGUUVN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D2906128D;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=VabKU9OkLdI/SwGQZqzip9UjdxzOD7xPLaSDLUpYFT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOZxGjaBWEavfd5wZ3luCQt3554L9FNorfiEZIk6dSW00UmIkO9KwSS0H6iqSX4y7
         Xy2ab3yrAmXxLqtThqi8gOTRDIwM+jyJHSj6WbOtsOK2d3O3O4hmSziueRbR1O+qU2
         03bczcYVkoioCsub6KU2h7M8jn99ip9Z7HnPZZj2b2fHv8HnWBKsJD4EPDizBA3+Er
         S2SCznmONuWKaLaWTFGa1p3OeEbiwoyTrO0RN5hNrKqSiZHunzExQIxPXP/gLFpOuN
         UO1k2q/BZ9h1jkESNCat0LBTcL+XJx57eMd1aY4AlLUS51xV2YYYpDnRDpmlHxFpyJ
         uJ315u85kf3RA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D726B5C0DBB; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/21] torture: Protect kvm-remote.sh directory trees from /tmp reaping
Date:   Wed, 21 Jul 2021 14:01:27 -0700
Message-Id: <20210721210140.787717-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The kvm-remote.sh script places the datestamped directory containing
all the build artifacts in the destination systems' /tmp directories,
where they accumulate runtime artifacts such as console.log.  This works,
but some systems have a habit of removing files in /tmp that have not
been recently accessed.  This commit therefore runs a simple script that
periodically accesses all files in the datestamped directory.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../rcutorture/bin/kvm-remote-noreap.sh       | 30 +++++++++++++++++++
 .../selftests/rcutorture/bin/kvm-remote.sh    |  3 +-
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-remote-noreap.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote-noreap.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote-noreap.sh
new file mode 100755
index 0000000000000..014ce68260d78
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote-noreap.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Periodically scan a directory tree to prevent files from being reaped
+# by systemd and friends on long runs.
+#
+# Usage: kvm-remote-noreap.sh pathname
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+pathname="$1"
+if test "$pathname" = ""
+then
+	echo Usage: kvm-remote-noreap.sh pathname
+	exit 1
+fi
+if ! test -d "$pathname"
+then
+	echo  Usage: kvm-remote-noreap.sh pathname
+	echo "       pathname must be a directory."
+	exit 2
+fi
+
+while test -d "$pathname"
+do
+	find "$pathname" -type f -exec touch -c {} \; > /dev/null 2>&1
+	sleep 30
+done
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 8f26dbfc2edf2..f52641fdd1fe7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -124,10 +124,11 @@ awk < "$rundir"/scenarios -v dest="$T/bin" -v rundir="$rundir" '
 	n = $1;
 	sub(/\./, "", n);
 	fn = dest "/kvm-remote-" n ".sh"
+	print "kvm-remote-noreap.sh " rundir " &" > fn;
 	scenarios = "";
 	for (i = 2; i <= NF; i++)
 		scenarios = scenarios " " $i;
-	print "kvm-test-1-run-batch.sh" scenarios > fn;
+	print "kvm-test-1-run-batch.sh" scenarios >> fn;
 	print "sync" >> fn;
 	print "rm " rundir "/remote.run" >> fn;
 }'
-- 
2.31.1.189.g2e36527f23

