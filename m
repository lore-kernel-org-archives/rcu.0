Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEAF372EEF;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581839; cv=none; b=qcGikQV5zmNdkdTBR+qLUso3SXhF0ft0rc56+htQ1A6Vh7AcCl7KavNgY4e1Hf2MmCuroEavsYlIqen/SjgVWjTelnTf3EnBKC/zKDNyZCDunuOJrfXhQhiDNZbY2c6t2P5VtMzVOX9AK9xOKGYbsjVUQfvfs5ka9cZWlk2KeOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581839; c=relaxed/simple;
	bh=U5A5O6LHSQqP2dmty8DQIFoZzPOWU0iJi95jYP0ws+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnROF4T9NzAL6+juA5Ock+ZNKaFeSSM8DD062qgq7Vuree/MUN5vehjR4YgVgzTSTDJXP5nsB2/ndST/YarIvxi8dDdtZ4F1hnQcOnpSLelJNaKnAew3sF6DWAHkpQL+SHyQTe70e97qQXKc1ETHZ7yJcW9F/VNG4kfGsGNCrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmT9z2EA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmT9z2EA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CF6C2BC9E;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581839;
	bh=U5A5O6LHSQqP2dmty8DQIFoZzPOWU0iJi95jYP0ws+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmT9z2EAZ+/ViHwJW0GmrEG2y3C0Huhoxbw3kUMsP1JJLEu8t2naY8txPhjt0U/9H
	 uvLs7aKDuEkG2AgWqZzTS1d3Ynq7zQG1gghagEhguHaM7/5BKU5tYWFz4iv6Qp6bc1
	 3DTIt0jMkZ/qN69LdF832cu9PVULZuRJ7BaGTJbs3vXbR/xQ79kR+KG4kGGdXdYzGP
	 kHFnWiDs7zSUpeahzKzhtyME5j6mJAh9JA794IqHOVF1sjlUpFcLvvmShrYERxvNPK
	 aZHaGyiCkCJgejGFnICc2rNhWm2BWqYiyIeHD7c7c2U+l5FdRBYw0txyW011XLwvBu
	 QejPLhItjmYLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E44BACE0DFD; Tue,  3 Mar 2026 15:50:38 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 02/11] kvm-check-branches.sh: Remove in favor of kvm-series.sh
Date: Tue,  3 Mar 2026 15:50:28 -0800
Message-Id: <20260303235037.1967017-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
References: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kvm-series.sh script is an order-of-magnitude optimization of
kvm-check-branches.sh, so remove the old script.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../rcutorture/bin/kvm-check-branches.sh      | 102 ------------------
 1 file changed, 102 deletions(-)
 delete mode 100755 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
deleted file mode 100755
index ed0ec7f0927e7..0000000000000
--- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Run a group of kvm.sh tests on the specified commits.  This currently
-# unconditionally does three-minute runs on each scenario in CFLIST,
-# taking advantage of all available CPUs and trusting the "make" utility.
-# In the short term, adjustments can be made by editing this script and
-# CFLIST.  If some adjustments appear to have ongoing value, this script
-# might grow some command-line arguments.
-#
-# Usage: kvm-check-branches.sh commit1 commit2..commit3 commit4 ...
-#
-# This script considers its arguments one at a time.  If more elaborate
-# specification of commits is needed, please use "git rev-list" to
-# produce something that this simple script can understand.  The reason
-# for retaining the simplicity is that it allows the user to more easily
-# see which commit came from which branch.
-#
-# This script creates a yyyy.mm.dd-hh.mm.ss-group entry in the "res"
-# directory.  The calls to kvm.sh create the usual entries, but this script
-# moves them under the yyyy.mm.dd-hh.mm.ss-group entry, each in its own
-# directory numbered in run order, that is, "0001", "0002", and so on.
-# For successful runs, the large build artifacts are removed.  Doing this
-# reduces the disk space required by about two orders of magnitude for
-# successful runs.
-#
-# Copyright (C) Facebook, 2020
-#
-# Authors: Paul E. McKenney <paulmck@kernel.org>
-
-if ! git status > /dev/null 2>&1
-then
-	echo '!!!' This script needs to run in a git archive. 1>&2
-	echo '!!!' Giving up. 1>&2
-	exit 1
-fi
-
-# Remember where we started so that we can get back at the end.
-curcommit="`git status | head -1 | awk '{ print $NF }'`"
-
-nfail=0
-ntry=0
-resdir="tools/testing/selftests/rcutorture/res"
-ds="`date +%Y.%m.%d-%H.%M.%S`-group"
-if ! test -e $resdir
-then
-	mkdir $resdir || :
-fi
-mkdir $resdir/$ds
-echo Results directory: $resdir/$ds
-
-RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
-PATH=${RCUTORTURE}/bin:$PATH; export PATH
-. functions.sh
-echo Using all `identify_qemu_vcpus` CPUs.
-
-# Each pass through this loop does one command-line argument.
-for gitbr in $@
-do
-	echo ' --- git branch ' $gitbr
-
-	# Each pass through this loop tests one commit.
-	for i in `git rev-list "$gitbr"`
-	do
-		ntry=`expr $ntry + 1`
-		idir=`awk -v ntry="$ntry" 'END { printf "%04d", ntry; }' < /dev/null`
-		echo ' --- commit ' $i from branch $gitbr
-		date
-		mkdir $resdir/$ds/$idir
-		echo $gitbr > $resdir/$ds/$idir/gitbr
-		echo $i >> $resdir/$ds/$idir/gitbr
-
-		# Test the specified commit.
-		git checkout $i > $resdir/$ds/$idir/git-checkout.out 2>&1
-		echo git checkout return code: $? "(Commit $ntry: $i)"
-		kvm.sh --allcpus --duration 3 --trust-make --datestamp "$ds/$idir" > $resdir/$ds/$idir/kvm.sh.out 2>&1
-		ret=$?
-		echo kvm.sh return code $ret for commit $i from branch $gitbr
-		echo Run results: $resdir/$ds/$idir
-		if test "$ret" -ne 0
-		then
-			# Failure, so leave all evidence intact.
-			nfail=`expr $nfail + 1`
-		else
-			# Success, so remove large files to save about 1GB.
-			( cd $resdir/$ds/$idir/$rrd; rm -f */vmlinux */bzImage */System.map */Module.symvers )
-		fi
-	done
-done
-date
-
-# Go back to the original commit.
-git checkout "$curcommit"
-
-if test $nfail -ne 0
-then
-	echo '!!! ' $nfail failures in $ntry 'runs!!!'
-	exit 1
-else
-	echo No failures in $ntry runs.
-	exit 0
-fi
-- 
2.40.1

