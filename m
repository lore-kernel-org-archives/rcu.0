Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531071;
	b=3551ZBw5Ht6qZwaOimzdIj/QFgdVjwd7o+Z8eY1uFvN9QeDqnZZih9+5/V5GdOrgX5I+
	 InrqH7GqDwU5DMtFEzSBxm9F/JQt6FiJYa6w2WwUOwny096HPFqaBhlmFEjCQYoHlbr4J
	 UOhxQ/f3FmfCh7Dwf5KKV8DOfG6sEIQarm6vXwod3tnBbHnOZpezjKhJPuuRcSHLkhC+Q
	 x5jiXAsIy9krBdCkRemiNhbbafHhAudt+avd0yI6QtiHMjal8ysPIv2SDKIoOrLqZYbUx
	 pK7yRPyS/u2p5oeIRLT7yojkf54hCNdrbctLJSOYrEIa2JpQMQ9xrqoyOQapvlYRAhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i7m41pWuuFwVUGy0tR9SE6cLKvYEyzK7NBc3aFjGQvQ=;
	b=wM49PcyNPmgqOTiKFvAKmrvp1XjqRbTISBZS0+QFdqk6y1c+8ZwiNs4Gk3ogbdMzTt8o
	 JAAPn6yzwNXZTijn65AdYzm8iF7MBMxLhG8jKCE4ayF9BPJ/mZJsmqpuB4QE9CdN+BH2b
	 N9IPA5CgvBKlNTJZeJcie3xAczgLg8RVR6J73zTAeHqe9006WvKvWygSqdvK00QP/iitO
	 nyKdisnHM2xGKH8JO60wvD8uaxuEWvtBlgzM8JiIffsmgoWnKSguca0q4FaBG5FQ9NOEx
	 VzThT5lLo460JtWhcuKMq99JyogI9DvhNOJupqb+pnlGKqCIVyqfDvzzimBiJTSlqpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgVfnw02;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F09AC60A6F7E;
	Fri, 13 Nov 2026 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgVfnw02
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 870FE1F000C4;
	Fri, 13 Nov 2026 00:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531070;
	bh=i7m41pWuuFwVUGy0tR9SE6cLKvYEyzK7NBc3aFjGQvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dgVfnw02j05x3dLnRzFKi0n8MCPulL9EFCNVAxaGL72swXfJHkh/hoaUh6Mzq8UoN
	 adQOPOTGx5qEDiusUOnHgF4b5xpITmeZeEOWmuWudzs4RJRtXGmAu/8MahJHldu5Oy
	 ZSozjPME5rLtdOwOQdhkEFPIHshuBZ73lcy8bPVYUYSXCbTVLHnzhWlccZkDvbjHWV
	 bEx186upEjsRtFPWRUcR9LLloyNkAVgQ/DU5wXWU24cmKQuT8eDibeONnyGoGNc4za
	 kAlij3vhVKSLUgCf2UskyafEyYl6nZ+xUY490+qfIQHMBNl+PuCUNlHmK2cXsO2bqd
	 irkNCrBzudodQ==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: rcu@vger.kernel.org,
	Yonghao Zhang <hyz3367@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH for-v7.5 4/5] doc: Fix stale RCU_GP_WAIT_FQS value in stallwarn.rst
Date: Thu, 12 Nov 2026 19:50:53 -0500
Message-ID: <20261113005056.2793983-5-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005056.2793983-1-jfern@kernel.org>
References: <20261113005056.2793983-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghao Zhang <hyz3367@gmail.com>

The sample "kthread starved" splat in stallwarn.rst shows
RCU_GP_WAIT_FQS(3), which was correct when the example was captured,
but has been stale since commit fea3f222d352 ("rcu: Record ->gp_state
for both phases of grace-period initialization") inserted
RCU_GP_ONOFF (3) and RCU_GP_INIT (4) ahead of it, shifting
RCU_GP_WAIT_FQS from 3 to 5.

Update the sample output to show (5), matching the current tree.h
values and the later "kthread timer wakeup" example in the same file.

Fixes: fea3f222d352 ("rcu: Record ->gp_state for both phases of grace-period initialization")
Signed-off-by: Yonghao Zhang <hyz3367@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Zqiang <qiang.zhang@linux.dev>
Link: https://lore.kernel.org/r/20261014063130.3691735-1-hyz3367@gmail.com
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index a986358a5c27..118c47506753 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -314,7 +314,7 @@ If the relevant grace-period kthread has been unable to run prior to
 the stall warning, as was the case in the "All QSes seen" line above,
 the following additional line is printed::
 
-	rcu_sched kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1 ->cpu=5
+	rcu_sched kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x1 ->cpu=5
 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
 
 Starving the grace-period kthreads of CPU time can of course result
-- 
2.54.0

