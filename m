Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3848230D15;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057762; cv=none; b=diXw2ADjKUWLEH6V7m9wPCKA+055zsMlbbi/IamHdEC7KkJ0FCDw+zj0KZj/J5YL1yxwkdgIczaEKUWIdwjUAHB+WrYZnU2uzY3rcUjQOqiXf/JQFD0kgV3tPG3TTVfOrYGxaxwMiseKMuXPTbeMoXqSyjh5QX1K+MX/3qjLhpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057762; c=relaxed/simple;
	bh=rVsXW6OIYTVEN0bfuaeNNyP5q/z2Ibgs5P1cnobIV5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoR4Y91QuKLBzdfTmBjna1i3OulhMA+emTazVIqsQF4b62fJdeDgHHxiCyjRIEzewd79jgmCojOczzsLmso/3MeCIaHgosYplI1iiZeW7v1ihUzzsWIvtgJx1w4/tXWHc3tOPyqO9pxGxTCahUOsWQfOYSWQbFL+cGajI98iGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG3DwXri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG3DwXri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93481C4CEE4;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057761;
	bh=rVsXW6OIYTVEN0bfuaeNNyP5q/z2Ibgs5P1cnobIV5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tG3DwXriUypkz5Rb226tMVXp1RyoyfZZyS/+4AwGQl8vbddBDfYM/fJEqO2NQTGdm
	 J7WnY1p8gmTxHmBJYZ4vG36+TJbuJ3LqYWyZtaqACTY5GYzfy6aduEoDkLXbJiAvR/
	 +coa3OhEQs+1eyJ/GVYyPkSDBwkijjB0w7fE5kB/5p2/gvLUjUutiHKaiTFnVvhlai
	 FQuElAgF/f5KGtzmaLsOiOPpRZesDO7xRY12BlCQ0whvJH373PzVFdypf+1agRXNqU
	 1swYBdLNY+qYkAVurL3gGBA4JFG2dfQ14NyFTajMZv9gVoTZGBbJ7l9T3SRpgehJVo
	 IB4uTl4cjpiPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 329A1CE37C1; Thu, 16 Jan 2025 12:02:41 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/7] rcu: Add CONFIG_RCU_LAZY delays to call_rcu() kernel-doc header
Date: Thu, 16 Jan 2025 12:02:37 -0800
Message-Id: <20250116200239.3782374-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a description of the energy-efficiency delays that
call_rcu() can impose, along with a pointer to call_rcu_hurry() for
latency-sensitive kernel code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index befe35058c49a..229f427b8c821 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3193,6 +3193,13 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  *
  * Implementation of these memory-ordering guarantees is described here:
  * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
+ *
+ * Specific to call_rcu() (as opposed to the other call_rcu*() functions),
+ * in kernels built with CONFIG_RCU_LAZY=y, call_rcu() might delay for many
+ * seconds before starting the grace period needed by the corresponding
+ * callback.  This delay can significantly improve energy-efficiency
+ * on low-utilization battery-powered devices.  To avoid this delay,
+ * in latency-sensitive kernel code, use call_rcu_hurry().
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-- 
2.40.1

