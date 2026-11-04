Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811478;
	b=wxvL0ECJvXHTXtaGgp+iexpNJFTK/2Lj7wxhWVDVycW7PD4tu69VdMC9odFzYpf+jtYx
	 Sat9sgyUgZsc/3GzZLZNrsXUlMwTe1hCUW2aEXZjOmiSNOVnqgwDT7aKK2dbD1QM8jC+b
	 0IlCysf2GCueZ9usPJL7RPD3YP+e9fXWLIeAeMQmDDo4UWs0mkxERrbRLWqv2pf1a1jpo
	 8+fnrvvF34lrMdBO0YKSa5hmS6584C1kqwhYTxC4zTe9DGnh03JGy9VIh9v0mlyXmKknm
	 FpNGmJVBJj8W+9TA18Z5HWF/oThoJgzXSdmHhvvHUN+ttoHlmz5almoP+gI7l6w+CzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vZX2J2F6ScsUN9tYZ3R0cEhAjGjvMCPd+3MYzWgyxI0=;
	b=SYBae3QGRUV49/OMusQtmMwrzm4LEV19WgjYpqRJusqi2w63OqQezBbf7X00wHxoDD3r
	 Torf9jP2x3p/M0v5eInGszzKe/GY9mru5TslI3AXfFzqQGRsmoNtG1QppBsmjnqIB8ZDX
	 2txQehbdSMCCJWZgK87QLbdTmVVv4wSqsygtIT0HJv9Id/ZDObpsLw+Z2C38Dy4CV4NrR
	 PPzzBEwcybauaaq9vrC9SKYdyjZeFyOKKRUpTtHJyEn9pcKC0CfpdvRgyr1tqKzMSX3DM
	 uxLisxjnl4AigHQ89cKIzTphaVCjdakRGD/SEu8AALmOsuyrCgudIHJ+DCj+Mx0/vDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lpDOW6AD;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39A606A33D
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE39A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lpDOW6AD
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3550c917fd3so1343751eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811477; x=1794416277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZX2J2F6ScsUN9tYZ3R0cEhAjGjvMCPd+3MYzWgyxI0=;
        b=lpDOW6ADYu851lyuivuLo7QwlZhzKTNs3PLF10Rp8myOxE5BpOBWhjm7Q4MqLXHeCx
         J52PFqv0AaxfoECHtzUpZMoovnjGHZgtZkxUez8M9SYQzp1jWB3MSam8LxY2TDtwtYM4
         i3YsZK1YrUlfkTefb9OYyeuUQ2dajq19tol+OtKNoLQ+MTKFu1lkw68gpHISoAjLNrX5
         GeRbxOyi04N5JeHjXQ+yP+UlpAEd/NKnQVYCH+cBYLKUSrSb3q/aJt4+3rxkSRyjQBnC
         YQ/20uVwMzwVNPsexHWcF+BUwyqNK40THR9TTrc2B1//qZ3wuMYu1M/+MQKh2WT/05Xl
         Q+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811477; x=1794416277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vZX2J2F6ScsUN9tYZ3R0cEhAjGjvMCPd+3MYzWgyxI0=;
        b=2mBUKPmw+u0BqGyu1+LAYSMKn9BA79qruV50JQkB8PSJE0uvLpai+7V5JZk2mSaKOe
         U4tBu0yk75GawfuX7omNU1cJao3WOLijU1WO+aapn9UCaE73WGVpiPF2cvaj3GhXZkgk
         6AwNjFMb8pB/dF54vP6vBuYPP9WX8oMR0DP1QmrIcxq1ag1oR8c0QSfSucT6KzVd6sda
         O8JmGcBf5CjE3aDI8pCRAZScAsTwTXJVxRI/cPgsno3G7uZF4Lnkbi6CdAYAzGbExZd/
         J2puJSzlXJWTq/pbu6/vpBPGZEtPTSviS+x0pA5dOizu9qj7rkL1LewfqjkRlkExkUPN
         jtbA==
X-Forwarded-Encrypted: i=1; AKwUvBzEYGriPtG4qPAStxq4MWeicYr1Npa9wh7smB8pYLzB/QzmlME0p3tuh4WIwlCng4jFISQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8z2InsYRHbM7v4Pbm1XjPx0mkYL5WBPi8+xHLffUe7Bb43BidN
	t88RQLPV+8D64ZWt1SrzcmlFZrjDlQoX5Bttt9HlvKgMpFSSPS/MIFzs
X-Gm-Gg: AYBFou1/J5GjLEPIuLpMtV6mJt3N9r38hvHk1xBeC5JfbvER9PUSwt3e5Naig6LH8cM
	Eoh1eCzbfvzebGe494WQDy4dZM/1kV1AyqezivRr+7mwNRoY/Ic6DUuhq0hUE7leE7vV89OipDt
	BwcFocghWo0cS003HoG9TaDzpNs+1NikS8V6IJHyCiGzJFUY82EDL9pwxU0+m3q7sg2anruqvnA
	josC/ypYasSj0fzmF59XSwWvVrDs0XKlYc3Sn1piY1zXvCdk3ono/lNBjZaUwmFDXYo/yqVQt2a
	/xSUvSp6v8/MQtCwoGSoCyDF/vyFv9yu06vJeshL6RxfiqJDWygdKsFXsjOL1ZPJwIsuFiqcQX9
	bB3rqsn1cPwiOIclouJ8oxu0EYLARlDGkZVRoSVVZo4APQCW+syZ2auYkPrMylOIW4N4UddAjTQ
	Dtj8EZNUYOeyT5ZuerFpKK1dUZtYbh6lmhbkJZPwCFDYap6QXh/y1aGgHqVUU8epdaEG/ydCcgp
	eGNW6SmCDoQl7Txernyo0/Gx3/tfGOH9Am2nPr5upZqBXFyEjmQ50RePPOrJXPoxkPlVZbo4GUv
	aA85UI1fd+RTVCcu4oVo845wrfY0lzMsht0uaYJa1C3Y2kDZCommoPHMBcaZ
X-Received: by 2002:a05:693c:42d3:b0:36a:1452:8dad with SMTP id 5a478bee46e88-36a4244dbfcmr24088619eec.20.1793811476479;
        Wed, 04 Nov 2026 08:57:56 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:57:55 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 17/28] Documentation/litmus-tests: Add hazptr drain resnapshot-slot-race test
Date: Thu,  5 Nov 2026 00:54:35 +0800
Message-ID: <20261104165504.2430480-18-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
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

Model the marker consumption race between the resnapshot
recovery path and a reader release: only one path may consume
the drain_gen marker (the cmpxchg in the implementation).  The
Sometimes result confirms the race window exists
(herd7: Sometimes).

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             |  4 +++
 .../hazptr-drain-resnapshot-slot-race.litmus  | 36 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-resnapshot-slot-race.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index daab126e45a2..02c26d6bea50 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -115,3 +115,7 @@ hazptr-drain-engage-wildcard.litmus
     Test the drain engage's wildcard defer: an engage that reads a
     slot holding a wildcard (an in-flight slow-path acquire) must
     not complete for the target address.
+
+hazptr-drain-resnapshot-slot-race.litmus
+    Test the marker consumption race between the resnapshot recovery
+    path and a reader release: only one path may consume the marker.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-drain-resnapshot-slot-race.litmus b/Documentation/litmus-tests/hazptr/hazptr-drain-resnapshot-slot-race.litmus
new file mode 100644
index 000000000000..699cbf0e3d7a
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-drain-resnapshot-slot-race.litmus
@@ -0,0 +1,36 @@
+C hazptr-drain-resnapshot-slot-race
+
+(*
+ * Result: Sometimes
+ *
+ * Models the marker consumption race between the resnapshot
+ * recovery path (P0) and a reader release (P1).  The shared
+ * slot_gen represents drain_gen; only one path may consume
+ * the marker (cmpxchg in the implementation).
+ *
+ * The Sometimes result confirms the race window exists; the
+ * cmpxchg ensures only one of the release hook, resnapshot,
+ * or unchain path decrements backup_outstanding.
+ *)
+
+{
+	slot_addr = 3;
+	slot_gen = 1;
+}
+
+P0(int *slot_addr, int *slot_gen)
+{
+	int r0;
+
+	r0 = READ_ONCE(*slot_addr);
+	if (r0 != 3)
+		WRITE_ONCE(*slot_gen, 0);
+}
+
+P1(int *slot_addr, int *slot_gen)
+{
+	WRITE_ONCE(*slot_addr, 0);
+	smp_store_release(slot_gen, 0);
+}
+
+exists (0:r0=3 /\ slot_gen=0)
-- 
2.43.0

