Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF43317B513;
	Tue, 17 Sep 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583702; cv=none; b=bxmR8dmQfT5AdELLN0qv8Qk1OHryxtJeBWZBor03ctDMAUqZIeZ+266J/fFyXRuXH8xZBHIuKiJZAO2HL4iYgxGUXFfn0jMEcHWh0S0qZZ8zL3rt8nvVwpxfb7pWX2X47yn0aVGTM6vHXSIRiIcLTeY5Z6XiSn2ZV3W4QCsLfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583702; c=relaxed/simple;
	bh=Zjmy1aEbU0/OgcKVrk4j8BQEKyIgLpLw6wRloA5pGP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PasehkP5Jz4YKOZupyX05nid2di9VJB3705pV/pR7zbeHZrm50V3v20LT9xDTMspYNr49tO4J0/64WdAEO9ndZ1W/oqUgezD417nOAZ0ZGU1e9lWtOivehBNssQXjEZIL/iNQNxje9xXA3CAkYBlbCiMG+AdfP7lKhxbmvdmNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIYZoqz9; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIYZoqz9"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1a80979028so5599723276.1;
        Tue, 17 Sep 2024 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726583700; x=1727188500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GcfRMZ3iyMDLyZX4twHVpqBTdlI1aOiND6/+aYkmmFI=;
        b=RIYZoqz9KnW6AYzNf+GfgSYG0ztKNQpepJogAfk0lkLFxK24jMjreddtLJxhKM7w2h
         1VdhkcQpSa3ANXWNNM5rOMdQKID9OKir2MLosShYON+eKwkmoPwkLMagPCgkltvpCVov
         NC7Tk4Q46TUkF9SFtn0EJGVYPPMPUS6Ybhap6iNq41EIa9Z5bbuz9zPDSgSOeuh8zHFr
         8VxLQ93MIQYbgDFOksnsu4IsTpJFIpiUy9OpVUurMpiMTkZ3s7XX7QCFIALaKL1kPAOC
         gXTXsYLcPhZI4aOEuNsWL4+hrTS/DjjKf73sAprAcEH8W0aCQVb9CKbFE6y2yaHEC3q+
         LXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726583700; x=1727188500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcfRMZ3iyMDLyZX4twHVpqBTdlI1aOiND6/+aYkmmFI=;
        b=Tmo3yIK6KJEcZbotFriS9geWKHz8IOY4a+8kQmsOfmtyH0jMuuwNIhCnBsxhmzjQ88
         aHOW/1KMWJdWrFSomSi+iqP77rPTToJ8UaUDh+BKYssGkL2mZmVdFf2KjM7Y/Klhsr+3
         3OtM2Gm2YxUWmyDb/kaX8E6hnyoN4ZgJBL42RkZ214FoF8wOwDCv5Lo4D63S8QNGOD9k
         Ms0ED+qQ6453bUqQUdfaKSSScGwtKdkvE4otWOcaAxPGb0EQCUQqmeGs7cHh5G3NfTUF
         dHtQ9waj7zqVmJ2pCRWFxoezPwh4V8GedGldYFEfuxoXVXnXHd1w4Esw8/L1Ux4vUXrb
         Pb7w==
X-Forwarded-Encrypted: i=1; AJvYcCXO956lhcokio8o6kiogyoklYsHwk4H9lsQm7lwSmcJa8hxPOJrNgxh3fWIGy4RFtqarquA@vger.kernel.org, AJvYcCXT0aPSjvSy2ywcGoTjYbyozISPP4x5wEW/z8EcHyTRpVpYjmd9p1QedOze6i61TKnWs1vt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7kvJNAVcsk5OcHm1qlgkc2U1zL6kM0DLle1g9tjiKLfBIetZ
	vRgT404YrCIqIyYKrk7eFQgQDEvZFh7TSc0lCv4tYLXcwkrDQnU5
X-Google-Smtp-Source: AGHT+IGuBl7w6kHeocxSsrq7wz1PL/D3xhcWK31fEFq1kkjp/eaeFPUIN6wONAeMPCU446DmR2QvTw==
X-Received: by 2002:a05:6902:cc7:b0:e13:ceaa:59d9 with SMTP id 3f1490d57ef6-e1d9dc41795mr12290884276.41.1726583699724;
        Tue, 17 Sep 2024 07:34:59 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c7da98bsm34819796d6.145.2024.09.17.07.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 07:34:59 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7E0841200070;
	Tue, 17 Sep 2024 10:34:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 17 Sep 2024 10:34:58 -0400
X-ME-Sender: <xms:kpPpZpr52CNmslVci5Do8tSBXttYdhbPZMbTuZGTmHK1Z4zt6n_EcA>
    <xme:kpPpZrq-kCFCQDRFX0udq8YRKfZSQZqFQ33XrNBkDeH-mLd__QhIKV2CXa3e3Cp1p
    u1bxD_e6__I-ChggQ>
X-ME-Received: <xmr:kpPpZmOp1GyB8Za1UtlG8JL13R-_n02ERXUFePSegqBcXPPT8leqL9Vle2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoh
    eplhhkmhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlmhgt
    kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprh
    gtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:kpPpZk594qweYGtiOVVvF-n7zpe44oLUquQODnmKQ9SayqLNyDh8Qg>
    <xmx:kpPpZo4yL31xuVSmdcwvf0nn7uJ8aWlna1nWuLFjAoD8wtARnwO67A>
    <xmx:kpPpZsi2UvT8JR4VrByHky07ATxzTmDtYcJALwc1uH3Da5rYaLZwuA>
    <xmx:kpPpZq4UbbrqeY2iEfMJdHGY2RlRcvjdcC1QXK5nKZptAdf8LQbbXg>
    <xmx:kpPpZvLuHl7ug6ow0JUeXLgB-yLk3yKcrN3lY-SqpetBOjzHbd4Z_gbz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 10:34:57 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com
Subject: [RFC PATCH 3/4] refscale: Add benchmarks for percpu_ref
Date: Tue, 17 Sep 2024 07:34:01 -0700
Message-ID: <20240917143402.930114-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240917143402.930114-1-boqun.feng@gmail.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Benchmarks for percpu_ref are added to evaluate the reader side
performance between percpu_ref and other refcounting mechanisms.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/refscale.c | 50 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 7e76ae5159e6..97b73c980c5d 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -393,6 +393,54 @@ static struct ref_scale_ops hazptr_ops = {
 	.name		= "hazptr"
 };
 
+struct percpu_ref percpu_ref;
+
+static void percpu_ref_dummy(struct percpu_ref *ref) {}
+
+static bool percpu_ref_scale_init(void)
+{
+	int ret;
+
+	ret = percpu_ref_init(&percpu_ref, percpu_ref_dummy, PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
+	percpu_ref_switch_to_percpu(&percpu_ref);
+
+	return !ret;
+}
+
+static void percpu_ref_scale_cleanup(void)
+{
+	percpu_ref_exit(&percpu_ref);
+}
+
+static void percpu_ref_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		percpu_ref_get(&percpu_ref);
+		percpu_ref_put(&percpu_ref);
+	}
+}
+
+static void percpu_ref_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		percpu_ref_get(&percpu_ref);
+		un_delay(udl, ndl);
+		percpu_ref_put(&percpu_ref);
+	}
+}
+
+static struct ref_scale_ops percpu_ref_ops = {
+	.init		= percpu_ref_scale_init,
+	.cleanup	= percpu_ref_scale_cleanup,
+	.readsection	= percpu_ref_section,
+	.delaysection	= percpu_ref_delay_section,
+	.name		= "percpu_ref"
+};
+
 // Definitions for rwlock
 static rwlock_t test_rwlock;
 
@@ -1158,7 +1206,7 @@ ref_scale_init(void)
 	static struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
 		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops, &jiffies_ops,
-		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops, &hazptr_ops,
+		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops, &hazptr_ops, &percpu_ref_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.45.2

