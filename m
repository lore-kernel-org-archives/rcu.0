Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811487;
	b=sbt0NXEkg5Bbdp8vjOtbWGxQwZnLJXfRoCUYunzCx1lLumofXYbN0Ten8YGl1rO+rx/K
	 T6y9Vt7RbfwbT27Xk3nPvaTVe9FWehuoECiCh3hZRxJGNgOxGtnkDHBzBOKFB4pk4QhZY
	 zggP/n9+r+cbDaufdIPI2iEvS+8c110IkPaBRQ7OohKjIUAjQ4IXFQ7qH4kJupLnWHxQL
	 eTF+HFS8TnSqGpz8QmIfcjs94cISt2iSIulFXHkDXr+iZe2iUuI6YSXoc4Ge7ad+l8UlW
	 8dbZGjPZZ92VWncm6V3GGUXmzfgyLmz5vrKzOmDuaoOuuRwPkUlefVSfj3vYy3bmSYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MX5bYyRBv2xWDRuJgCQ6Y/+Akj3zDi4J3TbhhKtB2VQ=;
	b=O/wpX9WypmRnkH4EPzE+SZenA6rxSCQFGUbLpIPMfgDieQ5w8DoI1AOGqXCQ7PF44lp6
	 UI9SIAUedfu70qaF45KaYZseDyWoytZEUEutxTimO8jlWvgOHG7bqs1+JM1OozkQxg6J3
	 9h7nkTDHiAPi6m4vJguoJveMvaTUKccCHTbgAURN+Yb+JDeP+4SHjQf81U0u1AjDF3hBS
	 ic79rFbpFlEGDQYSq9fz2neP3tiAZT854g8Ht5IgA+yc6ML0w6SWb6xA6D3GsXoHc44fX
	 dSKe2Y+4uW8c/+ufgJiP2xnSJL/LHx7JXVZ8ar7dgl3BfY/hYhY5ERwArPIFtOHkiQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lotFQVZd;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A407606A330
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A407606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lotFQVZd
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36cedf1bd63so973680eec.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811486; x=1794416286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MX5bYyRBv2xWDRuJgCQ6Y/+Akj3zDi4J3TbhhKtB2VQ=;
        b=lotFQVZdNFhgVBDY7gna/kQwMt63LK8lZz7tMqJUIb8zH+l9m73GQU6xHgD8P4ZvZr
         1OS5T920Lqtt5GrJdQI/O7A/6fmemqaErhCNIlByN/wbXf/1XFlPVuCPkBuVcHrspK7l
         h3axa2N4YUH/YCY5LW1xycCedkvGXaq+AfvA7G+sdphoY7zT9z147BkTQr5zcfQaGlLK
         txraV1kFET4Rk4EEZPaTRDD/LKciGdu0jFc1pqCztMxzKSExFygfUyHNWNADpSIHVKQA
         jg1Ytx+JWO03LhIPjRtRyt+v8z5i1u4FBwFF4KovX6GB812JLN5y62qTJhVW97+uhY6Y
         YAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811486; x=1794416286;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MX5bYyRBv2xWDRuJgCQ6Y/+Akj3zDi4J3TbhhKtB2VQ=;
        b=xo3fHwx1dQisBSxWRZ4Ph4QRbXtoH5FH5hdK/t3YuvhK1CzuUrrqKhJaWZfulRzP/L
         2MYunXYu+q/fsnnFeT1dtCNGZyHNidOrgc1LV5uLSUniTrukwzJpb273bwayPJ9iQJZW
         IwiTlw7q04uCXXe2yfELKoC5SmvmkcpMtlaawk8dbbAaTni9eiWEWKwodJvPwVP6idxu
         GkTi5ouKwc99q9iNpsnkukBzMcSCu8n9x2B8h4D9I6Vjiy3rNzw/B3J2edPmst1j7KWu
         rripQ1RlanQmFWr/5QUpfr9rsWwxinABrru//PQ4/LLCa5d2GInI/7roAPZE6mSI2vWL
         hr3Q==
X-Forwarded-Encrypted: i=1; AKwUvByHWlFSy++9e/S1kJdZvIoYMpf3S8NzsXSudbwA8lFD28dh9GRRimr8n66589VXkIgmv/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ISZawANV3Vqgqyr3BtQWxQvOVEnlv7zmzBWkb3SDIgvLBV1hq
	s1AiMPgHJzQsvYNE25ZwSO2t2QqHHwEnSh5vosZq6daNwk7ahx5bpzPv
X-Gm-Gg: AYBFou3EsALfMt3oISmO/0n0okebaXetlZuWUyIB7WFwAo2yyRXVOuR8pU8ttefky9A
	xC4yUxTuneAG01/BXse/9nhBdM+tXrdCPQa8Mq0AYnn4GAQ+u+YSlz7FrAyhbKdBuO+ZmbIquRZ
	mD3NfY0iie6UTM8BLcnbj0TTad7WMHme3iD+/YxPleZLMvXhmEHaO7dI6C5zb0Lh3hXkm05wq40
	ycab9k42TGMBA3wTzqCKoxkjTeQ1Gr6H0eLjZmStuBGSN2PTsTEGI1gFgerl0WeYpmkwublAaYB
	WMQ3vaRoKp60b9h27ssJOA00v2e5FJpH+VEeaAf5edIawYSdafjH3Mg9eLef7Wtmhp3O2POK+3O
	nXQiF5uTGdb7+gysyM38u5rYxiG8yk/UOuCCPRsrTwfalw+jTApwstp1gcCONq4oO+wrGHmVdJO
	mrXajs9HuGzGux1NGcKhC2abfrPHq6fQToy5FGF8rwCrblul3jTv2sIg/AK7M9bGWiFR0FM268i
	JE/1Gmi4+cTpXf/TrBo2Y17WP3wM5kD8oAa0A7ts+Bjw1Bc421zzb5j6ptsdfeNY+PYRXCN419m
	SHHnl9wYKM+kmWrdkEJQGuNUrPNcWv0B6aDd1dDgD4HLgxZDbllLkDISEZ8m
X-Received: by 2002:a05:7300:f78c:b0:35e:af84:bf1e with SMTP id 5a478bee46e88-36de479614fmr127613eec.7.1793811485795;
        Wed, 04 Nov 2026 08:58:05 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:05 -0800 (PST)
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
Subject: [PATCH 18/28] Documentation/litmus-tests: Add hazptr drain safety test
Date: Thu,  5 Nov 2026 00:54:36 +0800
Message-ID: <20261104165504.2430480-19-kunwu.chan@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Model the drain engage snapshot race: the engage may read a
slot as empty or wildcard while an in-flight slow-path acquire
still sees the pre-unpublish head.  The Sometimes result
confirms the window exists; the engage's wildcard check (see
the engage-wildcard test) closes the gap by deferring
(herd7: Sometimes).

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             |  4 ++
 .../hazptr/hazptr-drain-safety.litmus         | 43 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-safety.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 02c26d6bea50..604c2c0025d9 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -119,3 +119,7 @@ hazptr-drain-engage-wildcard.litmus
 hazptr-drain-resnapshot-slot-race.litmus
     Test the marker consumption race between the resnapshot recovery
     path and a reader release: only one path may consume the marker.
+
+hazptr-drain-safety.litmus
+    Test the engage snapshot race: the engage can miss an in-flight
+    slow-path acquire, so completion must defer on wildcards.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-drain-safety.litmus b/Documentation/litmus-tests/hazptr/hazptr-drain-safety.litmus
new file mode 100644
index 000000000000..a0ec1a063642
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-drain-safety.litmus
@@ -0,0 +1,43 @@
+C hazptr-drain-safety
+
+(*
+ * Result: Sometimes
+ *
+ * Models the drain engage snapshot race: the engage (P0)
+ * unpublishes the object (head=0) and reads the slot, while
+ * a slow-path reader (P1) publishes a wildcard (1), then
+ * replaces it with the target address (2).
+ *
+ * The engage may read 0 (empty), 1 (wildcard), or 2 (target).
+ * Reading 0 or 1 while the reader sees head=1 means the
+ * snapshot missed an in-flight acquire — the Sometimes result
+ * confirms this window exists.  The engage's wildcard check
+ * (hazptr-drain-engage-wildcard) closes the gap by deferring
+ * when it reads the wildcard value.
+ *)
+
+{
+	head = 1;
+	slot = 0;
+}
+
+P0(int *head, int *slot)
+{
+	int r0;
+
+	WRITE_ONCE(*head, 0);
+	smp_mb();
+	r0 = READ_ONCE(*slot);
+}
+
+P1(int *slot, int *head)
+{
+	int r1;
+
+	WRITE_ONCE(*slot, 1);
+	smp_mb();
+	WRITE_ONCE(*slot, 2);
+	r1 = READ_ONCE(*head);
+}
+
+exists ((0:r0=0 \/ 0:r0=1) /\ 1:r1=1)
-- 
2.43.0

