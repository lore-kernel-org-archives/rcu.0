Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531032;
	b=rrJg/PvOjdNXcXAPkf66xjGcd+0ragT016wS4Nemwdac1AxIV87NlDCqSQ25HHldZsVT
	 7mUPluM1+kHCRYmP9ls/zq7VhYgLvdVfRjMbaT+C29BRaVqf5qdxQL3ob7/ASOqG+Tjnq
	 gdSujjik7jWesHZwKg7FgKwXalKSOz+UoQeGHUe8g1VIHGAt0f+rEG2jByur0WilgMCRV
	 QBKTJguWFlpJ2IkpZYtflsyscrduHltf0PoNQOppuEpsIXzESgApY2VtY3B1AcCVdPetf
	 VNaNJaNJoF7JhSVMQPzyzLTg14f2ralxm8n1eRm4oJRJkYO6QuK7JHlQPOPh4Z2DC4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531032;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JdqJY5RRDpSGq340m/VPaomKfjY8Y9AVKuSj3XR3Xb0=;
	b=euy+PBE8ubhWNYbN4Gwv+tVhvSvDkPXXphN2JVFN1KppQmaZmNPPnUXKycENPCL2Ou1i
	 elhmtT84wNeZg3p4XOZ+5pf4vCX7H7MiUYPgybOPdwDjxMY6CqPpTh/hMxAJba9p4M2p9
	 3LIONXHF4m/gxb3mgAdcfA0AB7ntsEUS42TyM8O5lcU8/rOamw8WhpNEWtwKLUPIpxTLb
	 //AEJ9iQ0XQZ7mvAN4kFZezXrvkoAAfqbugQtOK5WIRQo299dRuSG4+KL3KwIuriXqrkM
	 vZC9R4OnOHOn8f6jMwbSgpnY5k5dI5espA1gdJBLIhSwMcAqqjb6eYKCYOLazMOxDyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ov7XVxBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D1C0860A3819;
	Fri, 13 Nov 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ov7XVxBC
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6270A1F000CA;
	Fri, 13 Nov 2026 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531032;
	bh=JdqJY5RRDpSGq340m/VPaomKfjY8Y9AVKuSj3XR3Xb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ov7XVxBCq8iyXIVUmJAPcR6AKTn16l2fZYVK37uEOkhrA9tYZV4qQocXTXz83RjCW
	 oo0CtZQt1O4Ipa+bq9BJ90cMdHagr1oAgrQT+OfdmPSFfJUQ1o/+GhbgDtnPsIdwgX
	 8OGEmsp3N6XaBdsiX50z6ty0UQKKHQjlOfi1gy+dSHK5pNYBdHFBHWziGLL1KSs2VZ
	 7hEpj1RMD5hxKWawSiHP8HkelngN6uieMNSV44rX0r3w1YsP51xl01HcVZE9+EKV5v
	 gdmkaM2y3eaZWKddEY7QhxG7qt4yoi7aXLpn8H5w3ZbfNboYDljQod8kBk+CXLPHP4
	 Ah+0USnjZ4o/Q==
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
Subject: [PATCH for-v7.5 07/11] rcu-tasks: Validate callback arguments
Date: Thu, 12 Nov 2026 19:50:09 -0500
Message-ID: <20261113005017.2772440-8-jfern@kernel.org>
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
functions in the generic RCU Tasks callback registration path.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/tasks.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 0eec90464d64..a1883cf5b5d1 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -349,6 +349,13 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	bool needwake;
 	struct rcu_tasks_percpu *rtpcp;
 
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	rhp->next = NULL;
 	rhp->func = func;
 	local_irq_save(flags);
-- 
2.54.0

