Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DB6C43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D5023120
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbhAFR1J (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbhAFR1J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55CE22313B;
        Wed,  6 Jan 2021 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953970;
        bh=OEfY3xiIt0gW1Vu5topX4y2S9ZQ4hVjPlvIpFKlKX/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbcMT+Bnj0mELdy2cr3sCqurDMLU7J/NKqHNHJ4teZG8cf2zjHWuT90xZ2lSbi4a/
         i9qBzGJmoAuU1xQhwxSf0mrQfIQw7TIM0OWclLUP3D0mvzAFj8XESKtX2tySpKao6Y
         3E5nC8y2T/qOc3nHeo42sYWu79bWD6hm4B1yMSyJsl4UDaNSBRd7gJCPn2e6Q3x5qx
         IaDPtWs7cAI843y2rp0FUWGfPfxaZMnnD1RWmsSxi87FKjacZh7ViOSXwcGKrczaJZ
         6C8pYWRXmybJW3FWYfnOQIAXhzT35ddOQ9Jbs4hF/ldPHyQZ57hSzrE7QzbUiEb8uU
         gQwO76EwHebvw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/20] torture: Add config2csv.sh script to compare torture scenarios
Date:   Wed,  6 Jan 2021 09:25:53 -0800
Message-Id: <20210106172607.22816-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a config2csv.sh script that converts the specified
torture-test scenarios' Kconfig options and kernel-boot parameters to
.csv format.  This allows easier comparison of scenarios when one fails
and another does not.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/config2csv.sh | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/config2csv.sh

diff --git a/tools/testing/selftests/rcutorture/bin/config2csv.sh b/tools/testing/selftests/rcutorture/bin/config2csv.sh
new file mode 100755
index 0000000..d5a1663
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/config2csv.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Create a spreadsheet from torture-test Kconfig options and kernel boot
+# parameters.  Run this in the directory containing the scenario files.
+#
+# Usage: config2csv path.csv [ "scenario1 scenario2 ..." ]
+#
+# By default, this script will take the list of scenarios from the CFLIST
+# file in that directory, otherwise it will consider only the scenarios
+# specified on the command line.  It will examine each scenario's file
+# and also its .boot file, if present, and create a column in the .csv
+# output file.  Note that "CFLIST" is a synonym for all the scenarios in the
+# CFLIST file, which allows easy comparison of those scenarios with selected
+# scenarios such as BUSTED that are normally omitted from CFLIST files.
+
+csvout=${1}
+if test -z "$csvout"
+then
+	echo "Need .csv output file as first argument."
+	exit 1
+fi
+shift
+defaultconfigs="`tr '\012' ' ' < CFLIST`"
+if test "$#" -eq 0
+then
+	scenariosarg=$defaultconfigs
+else
+	scenariosarg=$*
+fi
+scenarios="`echo $scenariosarg | sed -e "s/\<CFLIST\>/$defaultconfigs/g"`"
+
+T=/tmp/config2latex.sh.$$
+trap 'rm -rf $T' 0
+mkdir $T
+
+cat << '---EOF---' >> $T/p.awk
+END	{
+---EOF---
+for i in $scenarios
+do
+	echo '	s["'$i'"] = 1;' >> $T/p.awk
+	grep -v '^#' < $i | grep -v '^ *$' > $T/p
+	if test -r $i.boot
+	then
+		tr -s ' ' '\012' < $i.boot | grep -v '^#' >> $T/p
+	fi
+	sed -e 's/^[^=]*$/&=?/' < $T/p |
+	sed -e 's/^\([^=]*\)=\(.*\)$/\tp["\1:'"$i"'"] = "\2";\n\tc["\1"] = 1;/' >> $T/p.awk
+done
+cat << '---EOF---' >> $T/p.awk
+	ns = asorti(s, ss);
+	nc = asorti(c, cs);
+	for (j = 1; j <= ns; j++)
+		printf ",\"%s\"", ss[j];
+	printf "\n";
+	for (i = 1; i <= nc; i++) {
+		printf "\"%s\"", cs[i];
+		for (j = 1; j <= ns; j++) {
+			printf ",\"%s\"", p[cs[i] ":" ss[j]];
+		}
+		printf "\n";
+	}
+}
+---EOF---
+awk -f $T/p.awk < /dev/null > $T/p.csv
+cp $T/p.csv $csvout
-- 
2.9.5

