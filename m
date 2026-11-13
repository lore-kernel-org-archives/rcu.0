Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531023;
	b=T1U4z1FAnPuAs2Zu1otijve+r+rWxXu/+2jjyeFgcfI8eaWT71dgY9ygPLtqOT3KcUw9
	 NrWtYK5aQL3IKCmhhG/1lid+BP6LwQBLcLCh9itS44Ap4uN4a6ZKt3W3ostVvCifPEHvS
	 h3syiNhgawjCNqvCsfEzyq7idKYUIIab8eIpbDnvvivFW4b/27Lxv7rkZwK6B3J445Pbj
	 rR9iuEjCYxEBsvK22Ozh4A33hDUFsXavKXf7BxBUX4vLw3K4n2S1JducgxkQsKcpz4k0H
	 5AbjqUsBOKV5pBrujDI67s0lZep+cigNbLcR7s2OGWDk0UqhSzQn8/zqCSyLIz5QooQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531023;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tjLhcVcF7G10RolnADE623QOZ6o/oGuboim5FuNB63s=;
	b=D7kFTiYiRTgukTW7baphsGIa/iVtDH1042e/i+BdRP+5eZx3EVRLpCV3aPYZdx+01Lp/
	 y3lmls1BAWav7+0P80CabGQmpOaGoIb19qqZAI/2GGUmr5JnI1ttrCVPRmJwsJkFR+Uaa
	 HblGJXy7WUSssdM1wUnWqEHYBd4xHKhrOgdEJACEow3OKXRDKE+8bWkHwuHeHkr+VPEYt
	 pVt/NmjzakTQTZ+0EapO4pg1Cq6gU0iGLvoxTjibxahp7cCNt9+mHpNJrNnV/6uga165/
	 N31shCMidoI4r1ZEj7swey00Fj1eu5qs84TS3DMF/pVoz0IZKB52ZY0+1PRHhpFOx9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmewjDM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7546E606A8A0;
	Fri, 13 Nov 2026 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmewjDM1
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 06EA91F000C4;
	Fri, 13 Nov 2026 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531023;
	bh=tjLhcVcF7G10RolnADE623QOZ6o/oGuboim5FuNB63s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HmewjDM19DPToALCxeNpjwpnfVVdc/SBra746AJTFOLuZMQgWEhvjTyyGp1+gZXqs
	 phmy6xh2bK6PHg7GfEzqnfe63GS6ho366p3cXVPcda8BD3fF3XBszZFCJ/atZysSnR
	 YNymKR9UHGB+Qm2n95vgsIqzRPRq1Xu/5mf+TQpUHPE8CMONn1C0yYITbO3HCGbBlF
	 sD5N9uMjscmp2wOfggR3y8gKGEnN1lE6U+Rq2UpTAGcor1f4i6wCbca7R9/dfOA9AV
	 nayHa7541uXer5sM64wHpibaIdhG3wrJ4vnxjVsDCS/SZbxO5k9A+ob0kKRcXqNelF
	 DbRL82+jMt1rA==
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
Subject: [PATCH for-v7.5 02/11] srcu: Record callback registration stack for KASAN
Date: Thu, 12 Nov 2026 19:50:04 -0500
Message-ID: <20261113005017.2772440-3-jfern@kernel.org>
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

Record the callback registration stack in __call_srcu()
for KASAN diagnostics involving SRCU callbacks.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/srcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2b0e2b2d2c18..46fe2f0cef85 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -20,6 +20,7 @@
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/irq_work.h>
+#include <linux/kasan.h>
 #include <linux/llist.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched.h>
@@ -1530,6 +1531,10 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 {
 	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
 		return; // Leak the callback rather than corrupt SRCU state.
+
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(rhp);
+
 	if (should_rcu_defer()) {
 		struct srcu_defer *sndp = this_cpu_ptr(&srcu_defer);
 		struct srcu_data *sdp;
-- 
2.54.0

