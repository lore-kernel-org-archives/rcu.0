Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531031;
	b=rffirzfmYjXutPJy6t0JjLgsTt8q2trvAmJ0HHRXf8Nbzbhnt0Oan3ozsS1b4Ksw1Drs
	 Ab1yCZ91dmJddwvClXjP0sJL/hNhUzcnfzxFz+aeNeJ4ZvsatsJXY80NC2M3wR6Kt12Bf
	 j6H0s1hwLxu4bfUVRDS9bsZEQ5nuZZ3SUnoFET6W9upvZ0TbgBssLRDnXeKbHYeRP1NaD
	 Td299ZIjJKbHF1+Lu2ikEXMQObxumwE3LTOlq1Lja4nAywre/xfLhCFBfnBtgej5DIZW0
	 gV+l4TLKYnd6qM/uEiH5KA9az5u/TRcS90UXSyDI9+2IjmABoKJ58SEs5qyRld1+ZTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531031;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1a4g1x9vsYzzv++fXoooojmy+PmtFfgrh5pDZvJXW2M=;
	b=TkZrbFBbtN9+RXCEH0Ac6P67W3X8UwPcOBAwr3TMyTvHZR3WecSsoStXMjpBCjaOaehu
	 kp06LFxe2ys0a1T4lORRWsmAQ3W6sh7UL0LTYoaC3x/em50ZB/mDDO9xA2bpGpEWFkMq0
	 Fa7Bu6cqmV5/OpON4T47RsZIwEGRGbKo5H/NgCk9FuE0F//mn+xotYk2kWYPsRiHDhfkX
	 2NSZ1Vn5pTHE/52fHa3xudiRMs/EsFWOSCqXGdyOdp5NO3dz3xU79FbHGEWdXWrjZ7eVi
	 W7nbZwWOAxy2RtodbmxgsIzr7wOB/B0MExJt8HPZ7gROJJ0/gtgZ29ofN+YPY3dG+7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ce9S9ctW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3EBE0606A8B5;
	Fri, 13 Nov 2026 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ce9S9ctW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8396C1F000C4;
	Fri, 13 Nov 2026 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531030;
	bh=1a4g1x9vsYzzv++fXoooojmy+PmtFfgrh5pDZvJXW2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ce9S9ctWaxvAvG33UhIjXrnbWPxeVap98BcDhLtOhHs/pcmupcO2vVe94v75K0KLH
	 zuEdUz6LIbh2Tu1N/+w9D/s9TZXT+zwyP2B9cDedem3fymV7GFChpmkUQs7swMgmX3
	 nzVpLYAQUvwoJqz3kbttRsCHRJohmhjQd4ZVnAPVy5yvaiV7foXWpWP6/jtpcH+ZNl
	 gprkn0mjXyE3WtNL/JWoF7eRPa0eB8dgfMRCh7yh0Nryn/UlwsfEKDQ6VfgyIkOXRf
	 WW9j4AnxFW/9ROpuwkT3yxeIkVT98cAfFG8P+8dpMyeeY0GW/nHCWhA8vmCeUZJ1rn
	 hS7VKUqEWPzWA==
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
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH for-v7.5 06/11] rcu: Validate callback arguments in Tiny RCU
Date: Thu, 12 Nov 2026 19:50:08 -0500
Message-ID: <20261113005017.2772440-7-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005017.2772440-1-jfern@kernel.org>
References: <20261113005017.2772440-1-jfern@kernel.org>
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

From: Kunwu Chan <kunwu.chan@gmail.com>

Check callback-head alignment and reject NULL callback
functions in Tiny RCU's call_rcu() path.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/tiny.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index bd22fa43108d..ef0b0474f207 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -252,6 +252,13 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(head);
 
-- 
2.54.0

