Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEA209671;
	Mon,  3 Feb 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595136; cv=none; b=QR8P2Chvy7qM4GEHAOjjei3XoZ+7ZDOgwWP7c2dKvWE20z9CmYGwDd/nN0MeDLgXV6oIEtJQURjP9s/w0AGCwPjMYWlBOh6rR3BFB/8PgxxWW0gVKDqhdoYY/2H7r7Ze70fac+LjcS94hZtq+Cd/eweyK4DMevnqfRxEsvUUyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595136; c=relaxed/simple;
	bh=m3uESZrSRKPioSjw60MOYzlOJg/046vKL6JeMzoirko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ0wn0OaOqENGNjn80AruP3tk/ce9i7unr9RjXREK0KK0TTHk9hbg/B4wMQ8dFJ6PxhCoQDQHo2f/DS/xngtG/7gNv+y5tHpRh3Ob/VRWScupUaIrTEaom/2nxQ78UzcU3ucNoLIZ6prYei2K5IVzGmyp5u2ck/dbGpFIRYBKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jC7I1Xiq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+O03bFMT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jC7I1Xiq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+O03bFMT"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738595132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3vC5qYMswUoSmlILzMPlQgwHaBzq1Rws+HGd2K8t+A=;
	b=jC7I1XiqPX6GgcCNL9KvmCzrW5mo8A24xJ24iIsR9rJdz049U6sTa+xuNH9oDntVfJglL5
	2JUwqDsIpwD5Jqi6wUQhZ+/ZL07y8Ygl1+qrONju5i33hEYOtApLsMOHhkftax+UcEAktY
	pxm5FSa01yqCzIrfqKbWx7L6ZhtTFqFgHfu1mfNCcIfvqYziPblO7PspcPraoW3hnWRBao
	yHGyYF+3gU/+69jtvvMcAnBbvoNF69urDYfE4do3qbCVnEvq022l4RdrPc3nN6VBd4m/aX
	mPDcHRUYjSmgJnPd0CMHSSM/ubLqoTuS0gYZMKOzXXfIpYiAzl/63D+2pHVyPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738595132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3vC5qYMswUoSmlILzMPlQgwHaBzq1Rws+HGd2K8t+A=;
	b=+O03bFMTxDKlsMaJIocTGtCulsut/refI1/IpuB794SKR+pSDPZAD9QkEK1jCCPKq3oF6Z
	0Je4tF0VCiU5qQCg==
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	MengEn Sun <mengensun@tencent.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	YueHong Wu <yuehongwu@tencent.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] rcu: Provide a static initializer for hlist_nulls_head.
Date: Mon,  3 Feb 2025 16:05:22 +0100
Message-ID: <20250203150525.456525-2-bigeasy@linutronix.de>
In-Reply-To: <20250203150525.456525-1-bigeasy@linutronix.de>
References: <20250203150525.456525-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Provide a static initializer for hlist_nulls_head so that it can be used
in statically defined data structures.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/list_nulls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index fa6e8471bd227..248db9b77ee24 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -28,6 +28,7 @@ struct hlist_nulls_node {
 #define NULLS_MARKER(value) (1UL | (((long)value) << 1))
 #define INIT_HLIST_NULLS_HEAD(ptr, nulls) \
 	((ptr)->first =3D (struct hlist_nulls_node *) NULLS_MARKER(nulls))
+#define HLIST_NULLS_HEAD_INIT(nulls) {.first =3D (struct hlist_nulls_node =
*)NULLS_MARKER(nulls)}
=20
 #define hlist_nulls_entry(ptr, type, member) container_of(ptr,type,member)
=20
--=20
2.47.2

