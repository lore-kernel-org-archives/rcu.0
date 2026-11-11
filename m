Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409200;
	b=0z61KxCnKo+0BLctFO+cMk0a19XSvgwvQVrDoAQsBT9HznmfsqDbTwYC/wBhq/uL3w+U
	 VW02fHTxwfL06r3v/66Ouw1FkRlm9aJqKM7UZQxSklLOJqLdDirVhcs6YXeCJ6J4PU4e3
	 9tXTVjO7qVAnUH7MupaVFS2KgZCtPgGKeQZMLXKWSDOFy2FXljq9oan+mUBYDlmtDxLxc
	 eCAUqPyT4RKuX+TfaL56t2dsZSlKlcBQBkZ0J4m2KCkFc2ocgUYrKGe5LKR6kLeyfQnsG
	 78L43McKFrci9/xBppBEVF3g52dhrBhonGihKNI5wzmHYRbkyxwa64GZX2UTI1ZRZJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409200;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5VQFlTUii6Skd60qq7D0gNjbqRatGHOp3KXSUWCWCp8=;
	b=BSyrIn0k/UxYgb94aryMFtNlCQz5k/Mtxyb0SsgHnRZF649DlOatgxn6DV2lhCTWpvOw
	 a5vLxbFp6ATLw60BYsNMepIs1gCoNfUnEasv3tFxCfpHjHAOEelr4VcYYW4ckCRuwNpri
	 rMShd04s15qS2v5QryKXB2GvRetq5uAjwtMq0eVIzvqKWvLrQE+0Vu0eR9T6AVH7Lx3tp
	 Z8lPBfrrUuyTDRoVCfpGgWvYggQYu6t7iRGS2/8dSydJutiKV67r4t8sqNZIEBe93DSMc
	 KQgZpPEzAmlLQ2wvOZaO8u/fStW6bybPhwMeWEpLxDA4eP8XAaavdnXejMXlb2wzeoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=VMIPUhBp;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12B606A8B4;
	Wed, 11 Nov 2026 14:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C12B606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=VMIPUhBp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794409198;
	bh=5VQFlTUii6Skd60qq7D0gNjbqRatGHOp3KXSUWCWCp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMIPUhBpOlIWSyts/vgcaQL+/uijD00KM+T/G4FA1Hcbzp4Kv+Xqwq5+DFlmJWw6f
	 4tTXu+tgxYwlgRJNzC4e9l9kFySsnskRzLvgLqL3yKGrGNqzwIFzX4DC2waxxvbhPc
	 yHwQnriY6ArruTqoKRkn1r9IryORX3/4Rot8kPmKup98Zxqf56XtNxhcfI1NC3lpus
	 M/vGl8TcMxasKMg1Hrjhx9EIyQ7IMFrS8L6anluX/ac7lSfu22vKLdEdId2YXG1euS
	 X6NB3IIWzBYDCgyC25gXlIOWi/QjreeY1PDPwNKaLwH+W4u5ItZqXLV7kg58S2CM9/
	 K/HRam8jRQ85A==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPmsB22xFzNZJ;
	Wed, 11 Nov 2026 09:59:58 -0500 (EST)
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
	rcu@vger.kernel.org
Subject: [PATCH v2 7/7] rcutorture: Check an atomic SRCU wait within an RCU reader
Date: Wed, 11 Nov 2026 09:59:49 -0500
Message-Id: <20261111145949.70845-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
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
---
 kernel/rcu/rcutorture.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2ec461414263..d9c9ff653cb6 100644
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

