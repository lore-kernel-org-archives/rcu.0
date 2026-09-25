Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4C3AFD11;
	Fri, 25 Sep 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343573; cv=none; b=cfl3enPjXjZ12vfktR6g3/6zmTX8cDowXd/aUQAax+VCmD36tIOCbKymomZtME5MMPUaix8fnp4uXCb5EovmJK016M9mfzMCwoMshlUFAZDuBMUzZ4oXgq6ROn7U6kOHZmQuau7FNMOBdSTddkAuhsSvO0Ve1MKOrUcDj8rZUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343573; c=relaxed/simple;
	bh=NeDzbfi/0L/e7kRZBImkmKMZ2661LpX+oOGKlYbsAWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcsU2HHGH8r5hNDmYZfCIsbqZSZzaui9oJ8bVYyWQV0Km9Q2uG3gQqDb1Fw8bnjdxV6A0uQdNM5V/BtKHQXxVqW5RI2DvPVuV5D5RJRFDxHNN4CXpK8s2PvTHum12caDlH7av2SmQqNiXwW6U93/TRuOHsja9GMGzNzk1weD+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ01KGHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ01KGHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B471F000FF;
	Fri, 25 Sep 2026 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790343569;
	bh=1zNEpb6b9KuMaOumLhxSNPy3dsi7OBGukBp3aBjkQNc=;
	h=From:To:Cc:Subject:Date;
	b=AQ01KGHxvzsWJ1Hwm/XBJ+M+nrmK06xcGOQxMfImbOAfQlkEU2D3dT1siNcc+l6KG
	 mnsAk2j/x/QobfGMEuEMYPPHqaWGEYP0wMHMtxnUOk72PpioJhzm5BKf5gjHAYa5RJ
	 Xrwq6rkTJHA2+bfMJpkQlRrUFVCrUkM1XjneT61ioGzFOmaZxVURwjwRz/IfRm3ltR
	 3KLU5V8v3lJ0BYToNkIZdnR4/ww+INWJAU1cIzVAlcLMOqmQ8a69K1eex9S0jevZPd
	 6xseFEvP72obToID+oMVfVB7VVblzS3vG/irb5ypBezjZwivbtUc+NZqBWM75O7Dth
	 VhF7A02s4TzYw==
From: Arnd Bergmann <arnd@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Gustavo Luiz Duarte <gustavold@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: include rtmutex_common.h in tree_stall.h
Date: Fri, 25 Sep 2026 15:39:04 +0200
Message-ID: <20260925133922.1356404-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The added call to rt_mutex_owner() makes this fail to build in
some configurations:

In file included from kernel/rcu/tree.c:5121:
kernel/rcu/tree_stall.h:333:8: error: call to undeclared function 'rt_mutex_owner'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
      |                             ^
kernel/rcu/tree_stall.h:333:48: error: comparison between pointer and integer ('int' and 'struct task_struct *') [-Werror,-Wpointer-integer-compare]
  333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
      |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~
In file included from kernel/rcu/tree.c:5124:
In file included from kernel/rcu/tree_plugin.h:14:
kernel/rcu/../locking/rtmutex_common.h:231:35: error: conflicting types for 'rt_mutex_owner'
  231 | static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
      |                                   ^
kernel/rcu/tree_stall.h:333:8: note: previous implicit declaration is here
  333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
      |                             ^

There are already a couple of inclusions of "../locking/rtmutex_common.h",
so assume this is safe to do here.

Fixes: 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I wonder if it would be better to either move the rt_mutex_owner()
definition into a global header like include/linux/rtmutex.h, or to
move the code out of tree_stall.h into a .c file, as this feels like a
layering violation.
---
 kernel/rcu/tree_stall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5dded1e89197..803a56af3259 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -12,6 +12,7 @@
 #include <linux/rcu_notifier.h>
 #include <linux/smp.h>
 #include <linux/rtmutex.h>
+#include "../locking/rtmutex_common.h"
 
 //////////////////////////////////////////////////////////////////////////////
 //
-- 
2.53.0

