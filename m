Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811377;
	b=X/ATUhfwTv724qewtxzQYhBSY1b4ERZd/EnrbSiwwsyDWwDtL/ZQA2aZjjcfc5gZMdEE
	 uGl9tXqZfqNeSIaktyGyUiYYCw486Z6FrMge9lmwaE6dhPRAuShTLTElzgI6oYj1VOdJ8
	 /hip+tVagXmbQoKnCGg+LvrxpXhWzgc/bxDy93IRMyx52Th2IcOOSCJR/zcn4euCkOFaR
	 If7CVmQY4/ZKVHoUTfm4eL0Svg3IkzJpe7EkZadARnvcGhnmqzwByQukCXsAAv1Bke/gy
	 VYJpHFDdD3Ncy0uJxhPn4K6KkWd7l2g0IBV+nwH+97pzW0K4tf3fyCZfb5Q340tWnxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nKRyKe5HAwN5rnftg1fZEx1NjIirnpES4D9l2YLy3Hc=;
	b=uO/YAnBxgp5rYrfDQDVak42VrWdA4IGl0eRv2UkMTFRgNaCK+gdqz/31iSMXDAzKe6Jy
	 2ULoxLqSoyUHAaRKu10PmyusrC9hTtMeNxXqdXwQom5Z7gE6uwMHhAa9DDOEzUS4uU+kr
	 +YpxPdW07z7P271yvtSJfmE3qV0gCLFbxgkkvDImh97oie0QVe0pnU0Uv3Bc42rKhi59c
	 jGrnIe/FipezZ6ezA5aaUFWluZx0loD695wO5hR2D/0uugyHURR/gLdkWFV8A8gJi+jx/
	 zFrfchFkYuhVCtE0HsXK3LajmhXboiAhPkXgWKxRtjwWuR/tniN3qkKr8sS9xpnrR7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJx8CYfD;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151B606D811
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C151B606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJx8CYfD
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a315ed211so918463eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811376; x=1794416176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKRyKe5HAwN5rnftg1fZEx1NjIirnpES4D9l2YLy3Hc=;
        b=HJx8CYfDIWJR5BxeLKAMWOYvIZbEog2kUXnrtJDRdSpUfdmh0HmTSZ19XuvWLXrCAe
         Ky0i5oMjyTdDQEQi/vWkK7LRip7d0uc22R2FwngdRvNmVlH/BrjpALMLN37dEdQI05BR
         qWg6LOJlanVMuZ3EEIj4K1+hiJy5rPEstLhpVNZD4crGuuwmzechnuz8MK7pYnU0mnDC
         RPut3X2Iik9HLYXsIPq+9uxxAKsWBv/wIZbfkvNzPtTlqQWfialaDUaamzNlZcOO0dqk
         yZ35EIhmitWCvoDair+nYT7gGgqD97EiaPStAb4/gM6Hy4brt9vcDlHdzBnZNwf6OUU3
         39dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811376; x=1794416176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKRyKe5HAwN5rnftg1fZEx1NjIirnpES4D9l2YLy3Hc=;
        b=B/WOxSMqs5jwUMBSD4yctwgURuyLCxEjQhLGDSUWO0y8yM0WtU7z3zxCEaKg4RQRvW
         8pfBVaKD6mjayL0cLFbgZ1fglLYbgohnApEJV7aLHPgtv/qDGRyDChFCr7lEWifqOxlr
         LYvgx83Rc8WvA+vXisfNeTZzKVn2zj75fpsn7eDJDgfUGWLKOmRdSDrcmZ1T/g33ZT9V
         bYNzmhEOoT4BS5yDZTF57/mDDx3NwGOblVf1qolGhY0UGiHLI7OwTlK36gLtc1uKMwCD
         K/IaZ5l3xlcLCGW+l4DEtNeDfkS3DRpLR0QrOMzMXKB0BS6P+Ynz0b0TULBXSiuBfxRo
         TKiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfDMGL0xFcF6fK3rnfaMWk0vF5vCwBBT6w5Wg0UFHC+o54If3W/xi00q+6I1LNXwE4cMc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YAIFk3JMNIkH+PHPArkLGLvO7FwBLc05m+PgNrqKjgruw1Jr5
	XBnwXQf60xXBmNE2dlikK55loQBNCXypdsfIdNzEu07U+Lw5b5VAxJiM
X-Gm-Gg: AYBFou2mMkQvF6eykmzsHs8jD13M5wO2U2IFuke4BKqOC9DX77DH+AvH/6HL2vxDmZ+
	GRt4NFfxW1J0N72Xz+thRSQXIVcsn5iQSL2oKPU7BJaHaYYMKF9RjyIpxYtgnXjc9c23J932HI8
	FqLnU3eu0QLbVtfzk/uZYE2g8w/QOamuNzvM/5NrfOS8epiAGclXIVoT3cx4vB1OeZN1Q4JvEU2
	BvZ6CRuqmka73qCyOW0zrLx2j/HLL4SSjqNvIXK9Lv1BbQ4D7r8FIBIfoW7UDYyP0+hJbbhFq69
	Xu98crMtGsUXQpbG5rY4GenNgS/7zg3KEGGnSOuEoicB8yVYMs+Bp8Sv9YK+BGjM/wvg0dEielK
	3CRuyhrXq52Q8VCmFTOc1RrVx5LhtM7gs0VGuKTGijU1Xn4vC0rgjVFBESURAFr6JUty6269sdl
	mvLw2MR1VLrLKZeUOAHrC75odz+rq9sTRSBjLyGw/Wy8dcsD0pZI1OIyUvf0jg2tbbArTQep+y0
	P02otqG6/XxApgqaL3lEilpIYX9nu9z4Ioru4VFsvEj+peQwV5XIq7rBusRuBDBfiABW6RTNHrZ
	V0ns0OXQw4LJilRDrZMOTKavr+FVokCo3cDo1UI=
X-Received: by 2002:a05:7301:781:b0:36c:a351:fb31 with SMTP id 5a478bee46e88-36de5f6fa87mr70409eec.7.1793811375449;
        Wed, 04 Nov 2026 08:56:15 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:14 -0800 (PST)
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
Subject: [PATCH 06/28] Documentation/litmus-tests: Add hazptr acquire-before-scan test
Date: Thu,  5 Nov 2026 00:54:24 +0800
Message-ID: <20261104165504.2430480-7-kunwu.chan@gmail.com>
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

Add a two-process litmus test for the hazard-pointer publication
protocol: the reclaimer unpublishes the pointer, executes smp_mb(),
then scans; the reader publishes the hazard pointer, executes
smp_mb(), then loads the pointer.  The smp_mb() pair forbids the
reclaimer from missing the publication while the reader still
observes the pre-unpublish pointer.

This is the publication protocol used by the lockdep
is_dynamic_key()/lockdep_unregister_key() conversion.

Verified with herd7: Never 0 3.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 Documentation/litmus-tests/README             | 13 ++++++
 .../hazptr/hazptr-acquire-before-scan.litmus  | 45 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 4d4ec9c6f2cc..c2bf20fa4092 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -97,3 +97,16 @@ SRCU-fastpath-scan-before-anchor.litmus
     period, violating the SRCU grace-period guarantee.  See
     SRCU-fastpath-anchor-before-scan.litmus for the opposite
     ordering.
+
+
+hazptr (/hazptr directory)
+--------------------------
+
+hazptr-acquire-before-scan.litmus
+    Test the resolved-publication ordering between hazard-pointer
+    publication and the scan.
+
+hazptr-wildcard-flip-escape.litmus
+    Test the in-flight wildcard window of the single-pass wildcard-flip
+    scan: a straggling acquire that published the old wildcard after
+    the final walk cannot still load the unpublished object.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus b/Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
new file mode 100644
index 000000000000..6dc13830c07c
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
@@ -0,0 +1,45 @@
+C hazptr-acquire-before-scan
+
+(*
+ * Result: Never
+ *
+ * The reclaimer unpublishes the pointer, executes smp_mb(), then
+ * scans the hazard-pointer slot.  The reader publishes the
+ * protected address, executes smp_mb(), then loads the pointer.
+ *
+ * The smp_mb() pair forbids the reclaimer from missing the
+ * publication while the reader still observes the pre-unpublish
+ * pointer.
+ *
+ * This is the publication protocol used by the lockdep
+ * is_dynamic_key()/lockdep_unregister_key() conversion.
+ *
+ * This models the resolved-publication case.  The in-flight
+ * wildcard window of the wildcard-flip scan is covered by
+ * hazptr-wildcard-flip-escape.litmus.
+ *)
+
+{
+int ptr = 1;
+int hp = 0;
+}
+
+P0(int *ptr, int *hp)
+{
+	int r0;
+
+	WRITE_ONCE(*ptr, 0);	/* Unpublish. */
+	smp_mb();
+	r0 = READ_ONCE(*hp);	/* Scan. */
+}
+
+P1(int *ptr, int *hp)
+{
+	int r0;
+
+	WRITE_ONCE(*hp, 1);	/* Publish. */
+	smp_mb();
+	r0 = READ_ONCE(*ptr);	/* Load pointer. */
+}
+
+exists (0:r0=0 /\ 1:r0=1)
-- 
2.43.0

