Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB4176FD3;
	Tue, 17 Sep 2024 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583700; cv=none; b=eltnrIapkmpUYAgkX0ljwdBrajDJMe3aWjGdtGOWAcABC8PScUbCBqXcsGsV+1CP3cgnhKh0mqxod3CVJmjVRIoqo1msV4XP54vzvUMZzMTqTL7O/k3UtHBySfPNM41Mjzp9t2Kw1BZmmrSRnSG/b1f3AGL2w7UEI3Mma253e90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583700; c=relaxed/simple;
	bh=tf1CY5ZmD1DQM6dNPOMbMR1e/p//o3ydrleK68SPShI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rt6zzYYc2Rwd19qznLVS73aTX1RcizmJxAQ0lqLBDFgukmDtIgBL1oNe9ZN1bDYfDN6PeqDFeQjn3UaUFoaWMPrUNcXJPJvFc5MnstvIJUiGyobjgvZNjFtnRAbv0X57gmZqpsuukaVR+OhWMAGjqhBbQqBcd5fCF8zuENXm9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEF1uXX9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEF1uXX9"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9ab721058so587741385a.1;
        Tue, 17 Sep 2024 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726583698; x=1727188498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IDKpmr/a+FSU5QkWBrZE0xc7m3+8vAVQA9drcgUYXjs=;
        b=FEF1uXX977lbgsZi7MBDXwb7QX0kq/Ibo+QUJ4IVlS22kpyx0U2E7td2/bxAr1s8yq
         p0Vd1FpPv7dWUIOHpI6sh23xkOwFUAzH+ss7cehliJA6q91ZPr5fdHd2PFYjB3su32UC
         UFtNWseCp2mhM0bQpNwMl9yTJ6NR8Jo77QLl2xiOh7bDKcpmvJv4SLd/ADT57UMSfulu
         6kn9kGCAUlWe2mdNwc+9kcLyxIyXFq0JAQr0PVWBnH8xmK102AikO64uyawj4zrvY1hn
         thrqomlg6TcIdEPpe2jVr2n2ipPUL0NhzR6meR43aqH017D/fJs539JnuwbE5uyKYyI2
         U3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726583698; x=1727188498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDKpmr/a+FSU5QkWBrZE0xc7m3+8vAVQA9drcgUYXjs=;
        b=wss75PUI8UYHQt++ybB1QbJfhRPXZEmtvdiO+mt8CytHkh1IOLioXjHgc6cKgCYZov
         3w4/v3LtL4Zek0t7LUAUwuyvIxukuAx91N4zBwkyOIdp2jvJAWrixNc7lDoL83MGaC2I
         5W7qokNJLvSjjFVZ93LluZI/sRKM4haHeIs45BDuHISZxQZYEZg9BEMImwj5xyXX4kzr
         6MtB6oJZqx4Rmj2XkdM9CuZ0u/iLD/hK/36S0sXcautClcclTylkVExkUpRbbVH7Q1J2
         JrylCDxMHtBbBd9HQRtmZXZjSpI6+Sjik2La17MUvtArry+wF4PUsyMXZTMP4hSPR/jk
         SqBA==
X-Forwarded-Encrypted: i=1; AJvYcCVPLRn6Wt8QXZQ9cXYvN12nqoTR33Eu8A+s90tMj/GWx2AQVUiKyQZpxMifYQ8wP1GFK7B5@vger.kernel.org, AJvYcCXGAL9JEga4RhhIPa9dNx9m/32zwPXuY7DjfkDkvCoqqCI3JPDmJ888fHYrBigPtxw+bJhq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gaIJ9dzbvjqmj24d99z9w1zK+Do1ydCWYlk6R+9GfBKr72nV
	aQPtapbK119GyhwH/KsIIipspJ9kRy20u1CUwUVch7mGOkXXpmo7
X-Google-Smtp-Source: AGHT+IG2fokLCq1TmoMpmwBtIu0E6iGiVOGurVZcFpBIdhqlPDe2hAN6K3EzM3w6osDlDfCf58pZgw==
X-Received: by 2002:a05:620a:450c:b0:7a4:d56a:a928 with SMTP id af79cd13be357-7a9bf9abe50mr4404654785a.21.1726583697681;
        Tue, 17 Sep 2024 07:34:57 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e9b39cesm363636485a.65.2024.09.17.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 07:34:57 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B5DBB1200070;
	Tue, 17 Sep 2024 10:34:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 17 Sep 2024 10:34:56 -0400
X-ME-Sender: <xms:kJPpZka25MEzYp_jD0YUbmMbyZLgPEs66SB1ZqeekowoGFIY1OBDOg>
    <xme:kJPpZvabog718eHFtBQuJOeDlj2YoFiiipzomNwdhv7rmcHM2y0a8EZX6V-et5C8S
    uNN8qw-rbY5jhfp_Q>
X-ME-Received: <xmr:kJPpZu_Dg2VfyjehSuLiWYFj1oTkhChCiXDgO7PAkPCqbA9hlPFYtVW1VygNHQ>
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
X-ME-Proxy: <xmx:kJPpZuqSWsILISGde2C_joOq5JLGWLhhGLNUAUGIWPZmM8xkxIs_Eg>
    <xmx:kJPpZvqNiri_CWVVjBl6-iPZluUou2bqsYhRC5PDxPa_AtVe2tmLcA>
    <xmx:kJPpZsSr6z081JvU4-w9W94qavkDLpv61D1_SXTPgCM7BErjt8Oxhg>
    <xmx:kJPpZvrL99xtkmg4rw8SZnMCTjCcWn7CngIrbsYFRjmobLgiSL9QIQ>
    <xmx:kJPpZk5C7ZVLgfMmtqyN1LH60RGMBLOmLTaB9eiGHwUs4u8o1g-oxEzG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 10:34:56 -0400 (EDT)
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
Subject: [RFC PATCH 2/4] refscale: Add benchmarks for hazptr
Date: Tue, 17 Sep 2024 07:34:00 -0700
Message-ID: <20240917143402.930114-3-boqun.feng@gmail.com>
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

Benchmarks for hazptr are added to evaluate the reader side performance
between hazptr and other refcounting mechanisms.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/refscale.c | 79 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f4ea5b1ec068..7e76ae5159e6 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/torture.h>
 #include <linux/types.h>
+#include <linux/hazptr.h>
 
 #include "rcu.h"
 
@@ -316,6 +317,82 @@ static struct ref_scale_ops refcnt_ops = {
 	.name		= "refcnt"
 };
 
+struct hazptr_data {
+	struct callback_head head;
+	int i;
+};
+
+static struct hazptr_data *hazptr_data;
+
+static bool hazptr_scale_init(void)
+{
+	hazptr_data = kmalloc(sizeof(*hazptr_data), GFP_KERNEL);
+
+	return !!hazptr_data;
+}
+
+static void free_hazptr_data(struct callback_head *head)
+{
+	struct hazptr_data *tofree = container_of(head, struct hazptr_data, head);
+
+	kfree(tofree);
+}
+
+static void hazptr_scale_cleanup(void)
+{
+	if (hazptr_data) {
+		struct hazptr_data *tmp = hazptr_data;
+		WRITE_ONCE(hazptr_data, NULL);
+
+		call_hazptr(&tmp->head, free_hazptr_data);
+	}
+}
+
+static void hazptr_section(const int nloops)
+{
+	int i;
+	struct hazptr_context ctx;
+	hazptr_t *hzptr;
+
+	init_hazptr_context(&ctx);
+	hzptr = hazptr_alloc(&ctx);
+
+	for (i = nloops; i >= 0; i--) {
+		BUG_ON(!hazptr_protect(hzptr, hazptr_data, head));
+		hazptr_clear(hzptr);
+	}
+
+	hazptr_free(&ctx, hzptr);
+	cleanup_hazptr_context(&ctx);
+}
+
+static void hazptr_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+	struct hazptr_context ctx;
+	hazptr_t *hzptr;
+
+	init_hazptr_context(&ctx);
+	hzptr = hazptr_alloc(&ctx);
+
+	for (i = nloops; i >= 0; i--) {
+		BUG_ON(!hazptr_protect(hzptr, hazptr_data, head));
+		un_delay(udl, ndl);
+		hazptr_clear(hzptr);
+	}
+
+	hazptr_free(&ctx, hzptr);
+	cleanup_hazptr_context(&ctx);
+}
+
+static struct ref_scale_ops hazptr_ops = {
+	.init		= hazptr_scale_init,
+	.cleanup	= hazptr_scale_cleanup,
+	.readsection	= hazptr_section,
+	.delaysection	= hazptr_delay_section,
+	.name		= "hazptr"
+};
+
 // Definitions for rwlock
 static rwlock_t test_rwlock;
 
@@ -1081,7 +1158,7 @@ ref_scale_init(void)
 	static struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
 		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops, &jiffies_ops,
-		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
+		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops, &hazptr_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.45.2

