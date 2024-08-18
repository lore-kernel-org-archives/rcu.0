Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B281758E
	for <rcu@vger.kernel.org>; Sun, 18 Aug 2024 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723969117; cv=none; b=MZLYdhbJv6lpQjJVMREFdXjftnsjdFRgp6fLGG+AOE7mAlZcY7OrfJ9zAHkB1LAuM2I20LDRnkfQjPdningd38rVz6vAQk3K1Aw8SXWs5gwRgYQNbVUSAVGDDPxCsJYGRbuth5wuw2nEonEu8jCFSXtUO7fUKCvsHM7A2f2W9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723969117; c=relaxed/simple;
	bh=IMg3TH91DvHd/UHr5nhlV9L9XMU9JmcX6l2iRKdVx04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3S4/rWEmY7OUn5t8Aw8YFCXVvkdxNrJvdT1F4qHoC50VNhjhQWMcKdNu8rUsEP/QYEARqsl3g5POWXAFS3WGECuYU1yDQfdVy8GzVRkxHGhQTbpMXVQEWMdufUterdjhPZFENS3kFs23+kqSa3VdpZfStzZ5WhsoEeXYgnqgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=xz7m1wIP; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="xz7m1wIP"
Received: from tarshish.tkos.co.il (unknown [10.0.8.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id E6B9B440242;
	Sun, 18 Aug 2024 11:16:44 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1723969005;
	bh=IMg3TH91DvHd/UHr5nhlV9L9XMU9JmcX6l2iRKdVx04=;
	h=From:To:Cc:Subject:Date:From;
	b=xz7m1wIPa2bJ474KNBSgYvyei1ygjJkylw7s8/0bKXLVKu99bQpJBoSy+uDYBzKip
	 nB12yeQ9LHU1LhIzNneBtlU5YmdRFg1fZvmUbWeeJmnJObliqcb6ipr3QSClxcaP1Y
	 eueNM/ZamRI4iYpeou87biG2kTaRRkGLgKssNMOJQO7RnTSH0bYnd96zbS1/rgZtDc
	 k1yCIk3/Fwv6wqyXM2I2ztkjsd/Tx2RItPQoO5bbQ/lv67NjwyAPw0yzOy57M8rRj3
	 NUct2NrEl/1udNk+x5HNQaSzwvPC8DB880JbEHAgfyCSkpzvOW2OBOIn/WSFP02xgv
	 cUUvdehFcdzRA==
From: Baruch Siach <baruch@tkos.co.il>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] doc: rcu: update printed dynticks counter bits
Date: Sun, 18 Aug 2024 11:18:17 +0300
Message-ID: <5dd8782f70c3b2367ae3c7d9016eb8fb32c76b49.1723969097.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stall warning prints 16 bits since commit 171476775d32
("context_tracking: Convert state to atomic_t").

Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/RCU/stallwarn.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index ca7b7cd806a1..30080ff6f406 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -249,7 +249,7 @@ ticks this GP)" indicates that this CPU has not taken any scheduling-clock
 interrupts during the current stalled grace period.
 
 The "idle=" portion of the message prints the dyntick-idle state.
-The hex number before the first "/" is the low-order 12 bits of the
+The hex number before the first "/" is the low-order 16 bits of the
 dynticks counter, which will have an even-numbered value if the CPU
 is in dyntick-idle mode and an odd-numbered value otherwise.  The hex
 number between the two "/"s is the value of the nesting, which will be
-- 
2.43.0

