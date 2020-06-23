Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99503C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7443F2075A
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872750;
	bh=iHknxDkTnFHJnDmbU03q98hZ82TjCD5sEz39o8rCohg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yrObb7gak0P41OdBgbJIBfxhRBgmXOmrRV6806/6AKIWyqZJX/4WMX7kqFQHUf3+d
	 GCIyP+Y/ilEVwEEa/w2epR4ZUBAQ+ieGZHQc0PQastliFo1yBdFYN+OYpkoNxDSNJn
	 oFDn4tAMbHnE6j5Jf5apA7MAtls3XmOK44iIhibM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgFWAhz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbgFWAhz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F05720842;
        Tue, 23 Jun 2020 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872674;
        bh=iHknxDkTnFHJnDmbU03q98hZ82TjCD5sEz39o8rCohg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZsSzzXaA0kQkCTTq5WBCMrMXLc5GDawMn/jMWXMDEt9lx4US1WUoSSUPOIt5EZXL
         ax9gGN1D6R+96MD2WvAHUqy5ZAIst1mLJrG7VxRbyoXofaFQylwspQJ3DiGZsNbnuI
         fdQEVdaAFyh8PccAK97eH3i8F03onC+WGg7lpuEc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/23] torture: Add script to smoke-test commits in a branch
Date:   Mon, 22 Jun 2020 17:37:31 -0700
Message-Id: <20200623003752.26872-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a kvm-check-branches.sh script that takes a list
of commits and commit ranges and runs a short rcutorture test on all
scenarios on each specified commit.  A summary is printed at the end, and
the script returns success if all rcutorture runs completed without error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-check-branches.sh | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
new file mode 100755
index 0000000..6e65c13
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run a group of kvm.sh tests on the specified commits.  This currently
+# unconditionally does three-minute runs on each scenario in CFLIST,
+# taking advantage of all available CPUs and trusting the "make" utility.
+# In the short term, adjustments can be made by editing this script and
+# CFLIST.  If some adjustments appear to have ongoing value, this script
+# might grow some command-line arguments.
+#
+# Usage: kvm-check-branches.sh commit1 commit2..commit3 commit4 ...
+#
+# This script considers its arguments one at a time.  If more elaborate
+# specification of commits is needed, please use "git rev-list" to
+# produce something that this simple script can understand.  The reason
+# for retaining the simplicity is that it allows the user to more easily
+# see which commit came from which branch.
+#
+# This script creates a yyyy.mm.dd-hh.mm.ss-group entry in the "res"
+# directory.  The calls to kvm.sh create the usual entries, but this script
+# moves them under the yyyy.mm.dd-hh.mm.ss-group entry, each in its own
+# directory numbered in run order, that is, "0001", "0002", and so on.
+# For successful runs, the large build artifacts are removed.  Doing this
+# reduces the disk space required by about two orders of magnitude for
+# successful runs.
+#
+# Copyright (C) Facebook, 2020
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+if ! git status > /dev/null 2>&1
+then
+	echo '!!!' This script needs to run in a git archive. 1>&2
+	echo '!!!' Giving up. 1>&2
+	exit 1
+fi
+
+# Remember where we started so that we can get back and the end.
+curcommit="`git status | head -1 | awk '{ print $NF }'`"
+
+nfail=0
+ntry=0
+resdir="tools/testing/selftests/rcutorture/res"
+ds="`date +%Y.%m.%d-%H.%M.%S`-group"
+if ! test -e $resdir
+then
+	mkdir $resdir || :
+fi
+mkdir $resdir/$ds
+echo Results directory: $resdir/$ds
+
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+cpus="`identify_qemu_vcpus`"
+echo Using up to $cpus CPUs.
+
+# Each pass through this loop does one command-line argument.
+for gitbr in $@
+do
+	echo ' --- git branch ' $gitbr
+
+	# Each pass through this loop tests one commit.
+	for i in `git rev-list "$gitbr"`
+	do
+		ntry=`expr $ntry + 1`
+		idir=`awk -v ntry="$ntry" 'END { printf "%04d", ntry; }' < /dev/null`
+		echo ' --- commit ' $i from branch $gitbr
+		date
+		mkdir $resdir/$ds/$idir
+		echo $gitbr > $resdir/$ds/$idir/gitbr
+		echo $i >> $resdir/$ds/$idir/gitbr
+
+		# Test the specified commit.
+		git checkout $i > $resdir/$ds/$idir/git-checkout.out 2>&1
+		echo git checkout return code: $? "(Commit $ntry: $i)"
+		kvm.sh --cpus $cpus --duration 3 --trust-make > $resdir/$ds/$idir/kvm.sh.out 2>&1
+		ret=$?
+		echo kvm.sh return code $ret for commit $i from branch $gitbr
+
+		# Move the build products to their resting place.
+		runresdir="`grep -m 1 '^Results directory:' < $resdir/$ds/$idir/kvm.sh.out | sed -e 's/^Results directory://'`"
+		mv $runresdir $resdir/$ds/$idir
+		rrd="`echo $runresdir | sed -e 's,^.*/,,'`"
+		echo Run results: $resdir/$ds/$idir/$rrd
+		if test "$ret" -ne 0
+		then
+			# Failure, so leave all evidence intact.
+			nfail=`expr $nfail + 1`
+		else
+			# Success, so remove large files to save about 1GB.
+			( cd $resdir/$ds/$idir/$rrd; rm -f */vmlinux */bzImage */System.map */Module.symvers )
+		fi
+	done
+done
+date
+
+# Go back to the original commit.
+git checkout "$curcommit"
+
+if test $nfail -ne 0
+then
+	echo '!!! ' $nfail failures in $ntry 'runs!!!'
+	exit 1
+else
+	echo No failures in $ntry runs.
+	exit 0
+fi
-- 
2.9.5

