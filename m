Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C21FF056;
	Tue, 12 Nov 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423155; cv=none; b=EErHVKjMUDlvcT2aN5on9xp8jgnMMbEe9/p3FnHugjyQ7uBK5jNw75FeJUSBNkbnPehB6RPrWgblfovZGk6z4oKv3AToK87om92Q1tQiaJT4C+kr8Y25uqvgihGhycBiHG3uXIZem/AoO7uoU2+qUsc8zZz9op7KT2gZFr8DQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423155; c=relaxed/simple;
	bh=+k06mgf6RuNLp0+mrhqlZ/eG8Y0LssknZjipMi01OMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCjs7e3VB66n2+GlUES0HiaDE+jZEyB2+PNDNcpll3037u71F03y9bm/OTPkuigKseEt/Y8b3NWiABpHP/+dsCoKGsDiKQXpxgi6wiDwBW0oxSdExLWFWi2GZnE7/apsBqs2PyGxftixgNdCwYYkV5OBKse1CUKdzthpQQZMV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX0vmyto; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX0vmyto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84714C4CED0;
	Tue, 12 Nov 2024 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423153;
	bh=+k06mgf6RuNLp0+mrhqlZ/eG8Y0LssknZjipMi01OMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WX0vmytoeIRvQ2poozrmqIpFfJvnrJpqZzpsRJ52HLFEQCdC+KQ0NWG2KwkQ4Luwb
	 /y3pR2b4cbjiCJ8d+Rj48f5cP1rkPVpHP02ftCPcOi2dOFOjnNJfDv0rOj1/6LgoXd
	 7ttYjEZIUo9y9BEVFt0YiOsUOivlpMrP6/x5/aKa2LfDZKcXJy4jzpVi/QzkN//zbp
	 oBB2AvyPIqbZK0VbEi7fm8x+6wtNx3mspmULayL+XTYczHodwLGXXAEnWXxSfrMZmI
	 OM6uL8wjzuPoThilq7u3bX/w4hFntyIo9dB0Gpt3dLFxPSPH1seMSJACLglh0AEu9o
	 0Iv19U8Vt+fXQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 07/16] srcu: Improve srcu_read_lock{,_nmisafe}() comments
Date: Tue, 12 Nov 2024 15:51:50 +0100
Message-ID: <20241112145159.23032-8-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112145159.23032-1-frederic@kernel.org>
References: <20241112145159.23032-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds some additional usage constraints to the kernel-doc
headers of srcu_read_lock() and srcu_read_lock_nmi_safe().

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/srcu.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 06728ef6f32a..46fd06b212ba 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -235,10 +235,13 @@ static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flav
  * a mutex that is held elsewhere while calling synchronize_srcu() or
  * synchronize_srcu_expedited().
  *
- * Note that srcu_read_lock() and the matching srcu_read_unlock() must
- * occur in the same context, for example, it is illegal to invoke
- * srcu_read_unlock() in an irq handler if the matching srcu_read_lock()
- * was invoked in process context.
+ * The return value from srcu_read_lock() must be passed unaltered
+ * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
+ * the matching srcu_read_unlock() must occur in the same context, for
+ * example, it is illegal to invoke srcu_read_unlock() in an irq handler
+ * if the matching srcu_read_lock() was invoked in process context.  Or,
+ * for that matter to invoke srcu_read_unlock() from one task and the
+ * matching srcu_read_lock() from another.
  */
 static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
@@ -256,6 +259,10 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
  *
  * Enter an SRCU read-side critical section, but in an NMI-safe manner.
  * See srcu_read_lock() for more information.
+ *
+ * If srcu_read_lock_nmisafe() is ever used on an srcu_struct structure,
+ * then none of the other flavors may be used, whether before, during,
+ * or after.
  */
 static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp)
 {
-- 
2.46.0

