Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324E3DB30B;
	Tue, 19 May 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217495; cv=none; b=ttlp/T44OBIMUqUayyas2/bLtlfKtNkJFOoxHvAT4eJH9kUkv6nJjrtyKcoy/5w7MFsTvf6frwcqaL15Pf+VdutO2sYodY9RxqBIVNLUGy5hVeQOoTiBwWImNIwuG4XsPIljSULxoreOBwLCVmXvoARNDVVk21hVxlgUNzU5gcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217495; c=relaxed/simple;
	bh=q9vHyYShoblXvtafACF0NBCrD/+1POFeC2PaIFTmsxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clWKXHWvBz+rTwZ5jKAPoDb1XX8Uw2lp9RcH/kY5lR7gYL06XsvjqHZNcr5yk5xAM3ouHqbn+jOF5d3FlmFhyT4qozmWJUitLFJAHSKwncsNKBGAivS5pUUQxYsPPi/xtpFfTqviMD1lMzF3GIC9W7ajdwGD5guNkn/oMY+nO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3O1yR03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3O1yR03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8131F00894;
	Tue, 19 May 2026 19:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217494;
	bh=0T3K58kmighpLo8FGmXiWFM+1RNwGa/FJUcw1QLWHng=;
	h=From:To:Cc:Subject:Date;
	b=F3O1yR03myHkf8jk9jD5NEOMka8AnT74OS6bYWSwdA9hY5zeWb8TWBtqZ4QUqaYYe
	 nkIGQYJSfx8/diK58KnPgiOGNfcXEN9F9F/2RYkWX/GUC65/Ttt7bNeDBFeyUejeGo
	 iXAnEN4YIwCAwQ/g2UJkCaVoDB/wkU9SADCK6JPeAXpDQXLmgf2lqwVGzJIu53MUU/
	 B1R834kobFWE3XgK5+/lcL+sQpEF6zznr3WBxt5rW5naq8UiyoyI3IqnmwxWLxL3R/
	 5C1U8J3Um8QD0rmCcpHMQXMhASi8giwac/puY83Yn4GD4Ilx17Aa4fUYFQo2nwDsgn
	 Bc6qQotn1GSig==
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
	Ingo Molnar <mingo@kernel.org>,
	Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/nocb: reduce stack usage in nocb_gp_wait()
Date: Tue, 19 May 2026 21:01:28 +0200
Message-Id: <20260519190447.1716375-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_UBSAN_ALIGNMENT is enabled, the stack usage of nocb_gp_wait()
grows above typical warning limits:

In file included from kernel/rcu/tree.c:4930:
kernel/rcu/tree_nocb.h: In function 'rcu_nocb_gp_kthread':
kernel/rcu/tree_nocb.h:866:1: error: the frame size of 1968 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Apparently, the problem is passing rcu_data from a 'void *' pointer,
which gcc assumes may be misaligned. When the function is not inlined
into rcu_nocb_gp_kthread(), that is no longer visible to gcc.

Add a 'noinline_for_stack' annotation that leads to skipping a lot of
the alignment sanitizer checks and keeps the stack usage 60% lower here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1047b30cd46b..373b877cf171 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -655,7 +655,7 @@ static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
  */
-static void nocb_gp_wait(struct rcu_data *my_rdp)
+static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 {
 	bool bypass = false;
 	int __maybe_unused cpu = my_rdp->cpu;
-- 
2.39.5

