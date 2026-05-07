Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4F35DA69;
	Thu,  7 May 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173040; cv=none; b=frK/F2N/ommRl0hJ+PKxuz8u8XmeS8N9l2LXUCR+0cqsqQ871GSnsssnBAVfDxqBDPP1kOFzGo5fByurYtvM+WKDHyMYQCw2v5XGKrUX55+OUjRLebPqXF44atCTe3rnoruuck8QsWXLafpM9Rlj7YHpymF270MTCuMWo2jQdZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173040; c=relaxed/simple;
	bh=pVd95Ns/uzBTB0bn/at1ZGFc7yQwnJz3425Mcywv1DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E6MRA0ME3r3PcxE3i4qARiyhOCqUGJTwRJedTT29Vx/9Dt1yOuMmXnP5vIXIv9eBZEwv1NqeFBtaXszRHotIX2OIot/BF5LJhnpI5ockjGS+K3WV9mm6T/INn2xDQGyOyAqvLXdqH/lgFP/6DtkxZoR7AzpeaKmS4EWFDFmgsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTnO79HB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTnO79HB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17107C2BCB8;
	Thu,  7 May 2026 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173040;
	bh=pVd95Ns/uzBTB0bn/at1ZGFc7yQwnJz3425Mcywv1DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTnO79HBImxocdmPnNbvR/aSCSe43pfe6tRMh57/449FkMKzCNtCzRv+xvY7hv7Wm
	 ENDKCaqFn2DkKwtTUPb64kHO3g6PJFs3k44s1cfn7hE1mMrEm8+OmStW02kWdW8Q3o
	 9ZLekt8yFlD5e0s855Dut4AnLDW9qGnUPUDKcxOFSkLFbuaGP34aVU8wtlsEjWtdzU
	 0G5PT9RmmjxReNYs/FttHD8IyfTqV/7tEpksbe88P1NRl8gY26xaBcwBettxPiPPev
	 xuzKQFUaka9Qz/k+kfB7iOk6XzMWkbDyiUCG8fH6DaFadKWimMGWoFb2kV5d/QkAg0
	 BE7UUltMy+yVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A5167CE0C96; Thu,  7 May 2026 09:57:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/6] torture: Improve kvm-series.sh header comment
Date: Thu,  7 May 2026 09:57:17 -0700
Message-Id: <20260507165718.2039781-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
References: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The constraints on the arguments to kvm-series.sh are easy to forget,
so this commit adds examples in the header comment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-series.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-series.sh b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
index c4ee5f9109310e..be9412538fb8e7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-series.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
@@ -1,12 +1,13 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Usage: kvm-series.sh config-list commit-id-list [ kvm.sh parameters ]
+# Usage: kvm-series.sh config-list commit-id-range [ kvm.sh parameters ]
 #
-# Tests the specified list of unadorned configs ("TREE01 SRCU-P" but not
-# "CFLIST" or "3*TRACE01") and an indication of a set of commits to test,
-# then runs each commit through the specified list of commits using kvm.sh.
-# The runs are grouped into a -series/config/commit directory tree.
+# Tests the specified list of unadorned configs ("TREE01 SRCU-P" but
+# not "CFLIST" or "3*TRACE01") and an indication of a range of commits
+# ("v7.0-rc1..rcu/dev", but not "cd0ce7bab0408 ff74db28df623 17c52d7b31a1f")
+# to test, then runs each commit through the specified list of commits using
+# kvm.sh.  The runs are grouped into a -series/config/commit directory tree.
 # Each run defaults to a duration of one minute.
 #
 # Run in top-level Linux source directory.  Please note that this is in
-- 
2.40.1

