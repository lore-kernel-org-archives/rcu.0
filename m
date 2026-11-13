Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531025;
	b=s/7XKVqdkeAmmLwK0fW/P0b0dtZnhZ/TOsTFy5ZdFAHXacUaXd7kmu1l1QXXEqEMJqP3
	 fKnF9hCg0QCUiHZXUATuOkVPEGDqrVrsfEtyF220nu3XtOWxfhVOBIpVbQhXivGKKYCW0
	 LV1Zqi2escUvqaqRw0fwSVqq8Yxi6G8qFN5ENfxGO8BKn3rbm/c1ZDqGXlbft7TJSHIKp
	 KmWf0cOvbO7Cgzcxnc4fIPB0iyGBRwjrf9osyor4Drb3ZAmDsUedcsRetlNAE5vNAh3m+
	 mRLhgxw9t92jG+YjlvWlEk85ixAiXwUOF3KTlOYJ/LDhs6DU319Ma/rtAgoxbij4zHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531025;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EpgHwwGxo0zu70lC+rlu57ZqhLzVLDmrr8+ivWlIrBI=;
	b=e8+wY+AFtvXzxg7Cqv9xPKF8j5VopEWz3B0JuTqExmlVlL6EsGy/Xu8OyszJvScNzvaN
	 NxUPWurMBHFFYxRjAyE67oMjL1avk3zXeMcI9aCOcgYw7vKcpboUmKkf0f9exEu+IQbGA
	 VMirVM9WKmGaTuM1G+WhlgY7qKYALmCXgCHzp09fvLlIFTbhd2s5MSXfa9k/DGAwgojvJ
	 74H7EJy98tdVt2QNYU6Fsh0yDFcvOjQvpb67sJdy6R7JmbZCiFOmjMjAaCDngtlUNlvwH
	 krzAW+AW93RJ3KLN9cDY6MJ6dC4M+S/IDy/djCZeWg0EBNOtWgXBBM/iHtlQSB1/JrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7icf2Bp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8B57860A2626;
	Fri, 13 Nov 2026 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7icf2Bp
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D6D961F000C6;
	Fri, 13 Nov 2026 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531025;
	bh=EpgHwwGxo0zu70lC+rlu57ZqhLzVLDmrr8+ivWlIrBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c7icf2BpiB8aYx5cWjMRV74ie7L/lwBq70y/C5dCYtf0iHkq11eV0xrBQmfz9wPYC
	 R594hdFFLhU5wSeKoud4Fitjj8yJTVY4PHEvKl6XAnOyjJI1kXpnXt42U1TDHele83
	 PPdaRWbjJ2KLENBTYs7DaQZK0IpNKwbm7y+nm89hGcvhxq0q8d2yGPef7YSgEh/Aa+
	 18Ej8QueSc5PHirfFycYI+5ENobr8AiWz051wxoRtfN7aL6OlfHaIZyOdFopQ97be0
	 9mFBL6E4BlhqFM40fk2zD/J9lNiYmSLTOhPnHM84jAvMiabYOv2iyVg992HJGuVbir
	 piKBmH2AU8BhQ==
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
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH for-v7.5 03/11] srcutiny: Record callback registration stack for KASAN
Date: Thu, 12 Nov 2026 19:50:05 -0500
Message-ID: <20261113005017.2772440-4-jfern@kernel.org>
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

Record the callback registration stack in call_srcu()
for KASAN diagnostics involving Tiny SRCU callbacks.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/srcutiny.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 63a3f0a8bc53..3ee28885b96f 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -10,6 +10,7 @@
 
 #include <linux/export.h>
 #include <linux/irq_work.h>
+#include <linux/kasan.h>
 #include <linux/llist.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
@@ -290,6 +291,9 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
 {
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(rhp);
+
 	if (should_rcu_defer()) {
 		/* A re-entrant call_srcu() during the drain would livelock it. */
 		if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
-- 
2.54.0

