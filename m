Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490658;
	b=NWCTR0p92pes83J4PTgGaqd4X+eR7223gz5e34xcu731JvLdztmZalj+74wU+ZS0UTYq
	 1RyVIqXOZae1yd7IvsKBYs/LyU9kElCEEVkjvCjFsh3qV9Uh4zvVWK+Oiaa9+0yke4TCY
	 93Np32FGhbYmx0uXybWUo7ITfyXhF5PPi4kPZw/MPDJNwANm1J1TccljEdXv4JeURS1hG
	 OQSjCjaLvteOST0WyXr1m/Fac2sU5X9zHPQr4YDeZoOu9lZshb5DWWbFl4BeY8hizmdkU
	 06i7uMU4T1W1liWHBBgYsA6U3WrtF1dTBlHLgONXda9colXEMyvrL4ibyIauymIiSrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490658;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YEQaNevzxyEinFLAke3JIGptgL7sAUKgKJdAphZQ2tY=;
	b=BVxFPWu0kUYA0o2wjKbjB6HYZQPDl5hZLnrudHSa/X2fPPcxgNf9q04L9Y8FBYqCKxlL
	 BGGIQ7wg1X9KjSkmLNNUdDQQbGTgpn1Dpc4sorqq5tDlTFPg9dLi4oyuXMjXc/oUUI8EK
	 7PVtBi02aMTJ//ODAAqG1zhdLLHZyO+B+svNVAXdspkgChnZEsozY6FeVsI08fxo9OJtD
	 kQps1LgNN/BzMVUTK1LGPKc+0NT45AeeSSWMVWYczKjrPxwA0eMnWCLR/XoTgJYOQao1o
	 LeIEUV1Sx0imM2Erd4IelkG/0qV02Ou9YUa96otTqkq80coQ12jzgoWjHiRm/c3SsNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=rH1syplY;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953B606A8A1;
	Thu, 12 Nov 2026 13:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A953B606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=rH1syplY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794490656;
	bh=YEQaNevzxyEinFLAke3JIGptgL7sAUKgKJdAphZQ2tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rH1syplY22LKZ8IKgf0Ge97NOoG7UQ4SkLTu9xOQHbUhc8fujd10TWo7Ai95xp1Ul
	 0ni/ZF2MY/ae3L4YTYVN5V4eIsTxD42CN01Ycej5WLvdojmaIPs/GhfoKx/isbHogj
	 jZhAWIfZAyoWJgurO/iHlKYhclv/DSrhEAmEB+fiUDn+8yGAI/r8GHzYRscwQF/Bya
	 95GGag+rt9Vv+KpP31GvAcztq1RjmKMd+dOKELuurZVHZOFAvXfLixudDB661WkX7z
	 HrYBEM0zTAnOSzVIOojXH7gBepJdAcMX98zNukruUDEyMZTDV2Zv9wy6//pm3rOkf6
	 iJsemYt6eNT1g==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQLzh1C2SzNlx;
	Thu, 12 Nov 2026 08:37:36 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	rcu@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 7/7] rcutorture: Check an atomic SRCU wait within an RCU reader
Date: Thu, 12 Nov 2026 08:37:31 -0500
Message-Id: <20261112133731.127221-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261112133731.127221-1-mathieu.desnoyers@efficios.com>
References: <20261112133731.127221-1-mathieu.desnoyers@efficios.com>
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

synchronize_srcu_atomic() may be called within rcu_read_lock().  It must
then not end an RCU grace period, because its caller still holds it up.
Tiny SRCU did end one, by calling synchronize_rcu().

Check this once, when a torture type starts with atomic SRCU readers.
Take a cookie from get_state_synchronize_rcu() within rcu_read_lock(),
call synchronize_srcu_atomic(), and warn if
poll_state_synchronize_rcu() then reports the cookie as completed.  The
cookie is taken within the reader, so no RCU grace period can complete
it before rcu_read_unlock().

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
---
 kernel/rcu/rcutorture.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e177a94da14e..7d7a61ae1ed8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -799,6 +799,24 @@ static void srcu_torture_read_unlock_atomic(int idx)
 	srcu_read_unlock_atomic_irqrestore(srcu_ctlp, idx, flags);
 }
 
+/*
+ * Wait for an atomic SRCU grace period within an RCU reader.  The wait must
+ * not end an RCU grace period: this reader still holds it up.  The cookie is
+ * taken within the reader, so no RCU grace period can complete it there.
+ */
+static void srcu_torture_check_atomic_in_rcu_reader(void)
+{
+	unsigned long cookie;
+
+	rcu_read_lock();
+	cookie = get_state_synchronize_rcu();
+	synchronize_srcu_atomic(srcu_ctlp);
+	WARN_ONCE(poll_state_synchronize_rcu(cookie),
+		  "%s: synchronize_srcu_atomic() ended an RCU grace period within an RCU reader\n",
+		  __func__);
+	rcu_read_unlock();
+}
+
 static void srcu_torture_init(void)
 {
 	rcu_sync_torture_init();
@@ -819,6 +837,7 @@ static void srcu_torture_init(void)
 		VERBOSE_TOROUT_STRING("srcu_torture_init atomic SRCU");
 		srcu_torture_init_forbidden_apis();
 		srcu_torture_init_irqsave();
+		srcu_torture_check_atomic_in_rcu_reader();
 	}
 }
 
@@ -1093,6 +1112,8 @@ static void srcud_torture_init(void)
 		WARN_ON(init_srcu_struct(&srcu_ctld));
 	}
 	srcu_ctlp = &srcu_ctld;
+	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC)
+		srcu_torture_check_atomic_in_rcu_reader();
 }
 
 static void srcu_torture_cleanup(void)
-- 
2.47.3

