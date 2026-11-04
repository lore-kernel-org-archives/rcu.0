Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811579;
	b=Ak8Vmcy1ECvEyAsTx7Gx4K9YfiaXx7wCowPjUvwa+3noj2f6zo0gY3kcYNuUIvfvc6uO
	 RgFQZkK351Jzw9fGmxY9R6IQJIHvdMJfHQ8n/SXl0KE/AwFKaCo05uCUqkRj01zLZmGDd
	 9e6sBQZ2bXNZ6Wz7LerIaTblXXCNdzqxeLE97uJ57t2+OlejotPIeCNvXhmf6znc+v4Lz
	 qGljkQaXFKo47BhLmE8gQR+Yk8zCEG/hvbB3y0OaR+tS2W3qsbFvsE699XRf8FOh9hYbk
	 kzYU+maot1FlN11kw0EH3fnHoYUFA0xKg7YKCYhXwgHvz/8ie46hYD+y3m35p0hZ3AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cteKSNOPJ5AcN+4sRo9jQDZ7xAOL9wTKiT1G4A5c+WA=;
	b=ymK7l0z5nRi+COCAT5tAtrPSykA+z6Psmrk5Lv99/FH+RGD5kiHQI50pbrgskz5l3GdX
	 Wjiqq+Z8z1AS1+cN+94HHP7GgxzMvJ3hYPPpfqAIv5HLiUu4NN9umFqc7bNniTV/dxMjJ
	 E11SRoF3+wnNPbdn68/R9NIN1PZiyNEzUxsUFt+HIIEIy0BqnT+ukfSoy9UdBHZeiLeHU
	 iYX5+r76aMUeSkjuuYn9NPauyCK0daJTJaNAbadOw61Tibv7TeXu39Ymg3bbz3uJ0rd/m
	 jptjdRLfYAWX8giWh1H70/kNZpDy42EpOmfIP9Uowf0QPq5e/pim44cowvgHEx21ebw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrse6usq;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167C606D832
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1167C606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrse6usq
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535a54bed9so1233378eec.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811578; x=1794416378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cteKSNOPJ5AcN+4sRo9jQDZ7xAOL9wTKiT1G4A5c+WA=;
        b=jrse6usqBnrS+soUkCyFUg2F1RMgHEti6okHxkqcz8eXjyjL6hgO59HYse6SKdGg4S
         gmhsRH2BukszB3rE1G+ljKLc9MeAFdzPhVvn5ghI+cUZOEDZs49P6E2pUJcqypTcVo/e
         1p7oN0C8hNpdiiAZd58xsCRac5ExecZ8JbUWVaS9of6d8ewtNoh5E3iDr7qbTZgNyWoy
         MeYxDmBgMk8kqfKyiKGEAfj7Qe+JJRsN1N8Kn1C9hjexqAgVvQOobQZU0tiyHNyixf53
         j4xZoXo9nnFkK/q07aUOVg953ppzvaadCtW0T/zZajLGlqoa98FxyjdY3WwZXW4+j8BO
         3tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811578; x=1794416378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cteKSNOPJ5AcN+4sRo9jQDZ7xAOL9wTKiT1G4A5c+WA=;
        b=FPMEc+uP2TlTFoALvmC0sz4q4FR6C8nPquu1GhTw4l8P4lRqM2lvMreAlgcVgxDo5y
         DQct7SAPBXdChOtU3qVugd2PK9CphCkZSRAu0mSryQ5Ek5cuSSx07q9QetEhAXOKPBeg
         KgSBmcEjO4LI6a3jEQe4zDkcBfEq5JuahuTB7ziUp6q+QGws+T74ERIknb0Ano7lle/t
         1lY8eZwUCX/BHJI7w+1MNYXCtKXLcTT7dB0AZ7eCRemkF47bk7KyuWCCqabalzOTyu8+
         Zan531SCKFjkF2FGAcNOZJ1o0i4Kra5HmpcEbbgX+b13onMiz1gMgli7VLt3ZpD18g5r
         XK9g==
X-Forwarded-Encrypted: i=1; AKwUvBzT5cl+P5+W2328itgcKhlgucKiManFJm5vqvPDZYCMkcVqxAiLY9/8VurkO7il5qIXBM0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0Pk8tnsuGy1qvVqf3XV99nfzLKEerIJazW30WOeaTrSb5pLPx
	7dA+VLzunGNBgBLIp02b4TBaKP7Hxiwl727iyseOXpL27lBoug86uGW/
X-Gm-Gg: AYBFou1g15os/gjzTAL7eEENvYuSm5MkK1/zthmFk1pspDnWAa+Sl8XrayR3YJwn+Mp
	I3FvfePFYZn4m4gZANsD2rGOul8MzN84fHpaK2b+yEnSvMUZZhi5zcwWcgoMRAqNZLDZqBobj/V
	f3Pzequ7s6EDHMBvnNEB+KGY2jDDzITPnFfPMxFzppOQN0YwWZsUDL0j5/TozEYMWmcK8PEj11+
	hJY1PwHkVuqSQb7OlekIHyVBz+OlfYFM8ThYWji5ot8ziSO1z+rLrqzYz5yE8skNhVtbEix/Ro2
	hJX1yxbuz1Gw0Sz330pT8POSJ4SEpFVoj2HACIK3Cz6vpJGKNjd+LSLNe5vwRyNy3hP4Hz402QW
	c4FJ5QSonTpf9i9mEmBVi20KvDgF45y7LnnCVTNMhwSvKPPX/tNAYS++XdgWviSu8sIAyPCAI4i
	oAX/8TmMrJzRUgXYxVYFwW1h4PNevdoXRYos19H3GKajzlbAVtWRYT8Ni/wQe7Xd8wMPrj/bSqm
	gfu/vOj3lnD+cwxfTLie+awzCbwnXYeww6ebfuzNXHzK1kZtReGmw3WjpSBjMi7WrNBkZzatKhI
	t//Ppup8aOvQ7ypNtuE3XNS5EzhUWFZxvavCpE00+LfN4dU0peTtJoCtHv0N
X-Received: by 2002:a05:7301:fae:b0:351:1e2e:da4d with SMTP id 5a478bee46e88-36a424596c7mr24456857eec.23.1793811577443;
        Wed, 04 Nov 2026 08:59:37 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:59:36 -0800 (PST)
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
Subject: [PATCH 28/28] Documentation/litmus-tests: Add hazptr bloom wildcard-hole test
Date: Thu,  5 Nov 2026 00:54:46 +0800
Message-ID: <20261104165504.2430480-29-kunwu.chan@gmail.com>
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

Test the wildcard-deferral of the shared-scan Bloom walk: a
slow-path acquire that published a wildcard to an overflow-list
slot cannot be missed by the kthread's post-wildcard slot read.
Verified with herd7: Never 0 6.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             |  7 +++
 .../hazptr/hazptr-bloom-wildcard-hole.litmus  | 49 +++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-bloom-wildcard-hole.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 79b0634ddb13..561319404126 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -111,6 +111,7 @@ hazptr-wildcard-flip-escape.litmus
     scan: a straggling acquire that published the old wildcard after
     the final walk cannot still load the unpublished object.
 
+
 hazptr-drain-engage-wildcard.litmus
     Test the drain engage's wildcard defer: an engage that reads a
     slot holding a wildcard (an in-flight slow-path acquire) must
@@ -127,3 +128,9 @@ hazptr-drain-safety.litmus
 hazptr-drain-generation-visibility.litmus
     Test the drain generation ordering: a release hook that observes
     the new drain address also observes the new generation.
+
+hazptr-bloom-wildcard-hole.litmus
+    Test the wildcard-deferral of the shared-scan Bloom walk: a
+    slow-path acquire that published a wildcard to an overflow-list
+    slot cannot be missed by the kthread's post-wildcard slot read
+    (completion is deferred until the wildcard resolves).
diff --git a/Documentation/litmus-tests/hazptr/hazptr-bloom-wildcard-hole.litmus b/Documentation/litmus-tests/hazptr/hazptr-bloom-wildcard-hole.litmus
new file mode 100644
index 000000000000..28a2bc1206c7
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-bloom-wildcard-hole.litmus
@@ -0,0 +1,49 @@
+C hazptr-bloom-wildcard-hole
+
+(*
+ * Result: Never
+ *
+ * Wildcard handling in the shared-scan Bloom walk: a slow-path
+ * acquire publishes HAZPTR_WILDCARD (Store B) to an overflow-list
+ * slot before loading the target pointer (Load A) and publishing the
+ * real address (Store C).  The scan kthread observes the wildcard
+ * (r2=2, its walk loop keeps waiting) and defers completion
+ * decisions; the model captures the final post-wildcard slot read
+ * (r0) that gates completion.
+ *
+ * P0 models the kthread's post-wildcard read: it must not complete
+ * the waiter based on a slot value observed before the reader's
+ * Load A.  P1 is the slow-path reader.
+ *
+ * Question: can the kthread's post-wildcard slot read (r0) miss the
+ * reader's Store C while the reader's Load A still saw the old
+ * pointer (1:r1=1)?  The smp_mb() between Store B and Load A, paired
+ * with the kthread waiting out the wildcard before its final
+ * load-acquire, forbids it: Never.
+ *)
+
+{
+	slot = 2;
+	head = 1;
+}
+
+P0(int *slot, int *head)			/* scan kthread */
+{
+	int r0;
+	int r2;
+
+	r2 = smp_load_acquire(slot);		/* walk sees wildcard... */
+	r0 = smp_load_acquire(slot);		/* ...waits, reads again */
+}
+
+P1(int *slot, int *head)			/* slow-path reader */
+{
+	int r1;
+
+	WRITE_ONCE(*slot, 2);			/* Store B: wildcard */
+	smp_mb();
+	r1 = READ_ONCE(*head);			/* Load A */
+	WRITE_ONCE(*slot, 1);			/* Store C: real address */
+}
+
+exists (0:r0=0 /\ 0:r2=2 /\ 1:r1=1)
-- 
2.43.0

