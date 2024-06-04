Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C1214D43D;
	Tue,  4 Jun 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540595; cv=none; b=mu/ymQ370h4FR03I8bJdCCp++F49Oab93Hy//+l2wYBz2aNtgm7VVGLleER47jyCVAIHoPg07vB9nqLQJaWgVjBqCGGoG9xc/K8w9tXS2zWi87IRLP8xzI9zg6AGLwLVP5PzX+jQM1mCtWo9rykjCNeIy28xeCJ28NH41XRxh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540595; c=relaxed/simple;
	bh=r5THsMd/X1sUAYuciSxTtdm+hIb08O9PPF9XcptyhkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4fAeLGVp6dRiTDFn2mecRtJ0T7gbiPsdxt3qJz6Phh+pM5yXatfy/39k4+uY9F0684sLU09f6ZF0JP1E1HLiAKnc5fCZINKN9/YbhoBXNt2gaAo54ujvEfTT+vkZCSBUYHOYDQbMXe3QhBfi0uVarCW62/OErhYEvxbBmfhfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6p+YHBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6p+YHBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F6FC4AF09;
	Tue,  4 Jun 2024 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540595;
	bh=r5THsMd/X1sUAYuciSxTtdm+hIb08O9PPF9XcptyhkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6p+YHBNbARDbkcZOkS4CuSBt6shD/7vZMFuzxULbk0vpeNFJOLSv0fkLjuCft5zm
	 W4Gg9lJL/zU9SI3PeYTjWsoqettCdtZ59fLnXnwlFKMOL1WdoNYdktV+L26RCtFH86
	 YLY007WajTD8ywOqxtbWEMbx8DmdY7+iaUiIhKCTHP9jr44CmoagXN9cLEwgJDj/3s
	 72Rcqb5ceify9DYimB22aQWZw+gMXCRrWqU2IATUz9Fh2E/3svWmi6vLn9yd6wAmgp
	 p/hju1N+eibcfmTieFVqHhKzChjIV8KUd2E1O0M+R2wpqVDO3L4F2MIw9NPKJ6Oum3
	 9ac94q1MSlVVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5D29CE3F27; Tue,  4 Jun 2024 15:36:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/4] tools/rcu: Add rcu-updaters.sh script
Date: Tue,  4 Jun 2024 15:36:33 -0700
Message-Id: <20240604223633.2371664-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
References: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a tools/rcu/rcu-updaters.sh script that uses bpftrace
to print a histogram of the RCU update-side primitives invoked during
the specified time interval, or until manually terminated if no interval
is specified.

Sample output on an idle laptop:

@counts[poll_state_synchronize_rcu]: 6
@counts[synchronize_srcu]: 13
@counts[call_rcu_tasks_trace]: 25
@counts[synchronize_rcu]: 54
@counts[kvfree_call_rcu]: 428
@counts[call_rcu]: 2134

Note that when run on a kernel missing one or more of the symbols, this
script will issue a diagnostic for each that is not found, but continue
normally for the rest of the functions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/rcu/rcu-updaters.sh | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tools/rcu/rcu-updaters.sh

diff --git a/tools/rcu/rcu-updaters.sh b/tools/rcu/rcu-updaters.sh
new file mode 100755
index 0000000000000..4ef1397927bbf
--- /dev/null
+++ b/tools/rcu/rcu-updaters.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run bpftrace to obtain a histogram of the types of primitives used to
+# initiate RCU grace periods.  The count associated with rcu_gp_init()
+# is the number of normal (non-expedited) grace periods.
+#
+# Usage: rcu-updaters.sh [ duration-in-seconds ]
+#
+# Note that not all kernel builds have all of these functions.  In those
+# that do not, this script will issue a diagnostic for each that is not
+# found, but continue normally for the rest of the functions.
+
+duration=${1}
+if test -n "${duration}"
+then
+	exitclause='interval:s:'"${duration}"' { exit(); }'
+else
+	echo 'Hit control-C to end sample and print results.'
+fi
+bpftrace -e 'kprobe:kvfree_call_rcu,
+	     kprobe:call_rcu,
+	     kprobe:call_rcu_tasks,
+	     kprobe:call_rcu_tasks_rude,
+	     kprobe:call_rcu_tasks_trace,
+	     kprobe:call_srcu,
+	     kprobe:rcu_barrier,
+	     kprobe:rcu_barrier_tasks,
+	     kprobe:rcu_barrier_tasks_rude,
+	     kprobe:rcu_barrier_tasks_trace,
+	     kprobe:srcu_barrier,
+	     kprobe:synchronize_rcu,
+	     kprobe:synchronize_rcu_expedited,
+	     kprobe:synchronize_rcu_tasks,
+	     kprobe:synchronize_rcu_tasks_rude,
+	     kprobe:synchronize_rcu_tasks_trace,
+	     kprobe:synchronize_srcu,
+	     kprobe:synchronize_srcu_expedited,
+	     kprobe:get_state_synchronize_rcu,
+	     kprobe:get_state_synchronize_rcu_full,
+	     kprobe:start_poll_synchronize_rcu,
+	     kprobe:start_poll_synchronize_rcu_expedited,
+	     kprobe:start_poll_synchronize_rcu_full,
+	     kprobe:start_poll_synchronize_rcu_expedited_full,
+	     kprobe:poll_state_synchronize_rcu,
+	     kprobe:poll_state_synchronize_rcu_full,
+	     kprobe:cond_synchronize_rcu,
+	     kprobe:cond_synchronize_rcu_full,
+	     kprobe:start_poll_synchronize_srcu,
+	     kprobe:poll_state_synchronize_srcu,
+	     kprobe:rcu_gp_init
+	     	{ @counts[func] = count(); } '"${exitclause}"
-- 
2.40.1

