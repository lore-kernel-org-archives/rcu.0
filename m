Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811441;
	b=EnM764XhDJXSzLPHGOn5CNHuR7rSk6RMN7KYm5WRlo4WoHxIT8nEdAkB8tgtIWUkNJFv
	 h5MILSPKF2XDtgGnI4vf+yyezTyOrOzvR6pYOtw3esF0+KkzbtyzS71YI18/PH3CD9rwQ
	 vDB8NzoSW0dkRW39CjRikay61Z7eNZOOHkDGOt/5SxAGZlvJxICansbEnR+g+/y0nI+1M
	 fiMZVdGhSNFdJEj0CjKlPJdksRmxRjgaz94Z5jIy9N+DRUufBbdenRlmGKaiBoET8RZI2
	 bZ2Cby1zao/BFBxRNrlFjsgDOLvH8Sr7BjZhWpOctBmTSwzb+RzSJnzbCGXE22obXLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T7J8ny2XgS4VVLgay75kRvU9FcVv7Jejhnbg0Ab9f3s=;
	b=xDfovxIow0OkaKnyfyYW23QZhxHydNt3PtWib8jGnuTNGiv+/INaB1WRSMziPTKaWdTZ
	 tSk6oPHCevd5676X5cR1neMe55SxDYk6pE5zxMv/YbQLeKFsrRSjEcOr9zz6elWLY2Dn4
	 d47CRllr8fcZ8c6+tePbJJ+kZPSyx3EBByNaazPvFbLEQr/WMcNPEcQFJ9k4kkdZM6Z53
	 KjGeePPMo0e0+4Gni06Q6InBhsV1t+aSUNb9+AzY0ZLtMUTgKWFpSEc8bNjqHmPORMFlj
	 lu/rwK6Wj7orc/7ao0qplhXO4ilcLmIQoZGBk/mZFkJPGx89D6+UrvBifSyiXM1UvfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2vGqyXw;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55060606D822
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55060606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2vGqyXw
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so1615338c88.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811439; x=1794416239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T7J8ny2XgS4VVLgay75kRvU9FcVv7Jejhnbg0Ab9f3s=;
        b=s2vGqyXwPr8s8Gwnu+VGfdfhZQeEInJKusCv7m1LoH8gsWmASFBvbyNMs9FBKJlW4O
         w/PVKNUu/g2ucDcu6JfiST2Wof2Fl94gdHZ4+ToBlnIzT/4AIJVZdBXNtfPGgAsBSqgL
         1/H7gD79joZjeV2l7BTgbhHhmsrcUArqUyxofoaxNIRNKZ6pXyvjQoIzVqbOhoi8nuhZ
         fkgYG+m4CXSEayHsN/tPLXn4fNqtbBO24dqtc4eImBmZZc46UFPcDPz6pSP8397LHEzs
         VPar8yqhNIXgw10k7ke3w5+ezHaZBRs6WLV+x1r+x1dxeu/U2t3tk2qW6oum4qlCYTQ4
         cs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811439; x=1794416239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T7J8ny2XgS4VVLgay75kRvU9FcVv7Jejhnbg0Ab9f3s=;
        b=UA0pa69SHuRjvKbWn/x77tl3H68TCSZP92ytvBUN135GUkbkkvKiOYtK0O1rddWPKx
         Si7wT59rETarUvg/Ehiy/3LrKdMiRl5E+4bqGbxfoFJMoSzJOm9PiXiP+O7nAdOpRoOX
         UWVvhC0Y7i5dZCji5lptwDGgnSXi2d3ILUDajuCyXoZCSJmoH9AiYW9ooqNqn6lUD0tF
         qfUPS8ikSEi6LQ98A3Xs6blDY0rTSG6xKGI2uvXMVzrM3+VUUiqeErV+9iwEG6nHaDDF
         /gZH3AlvEOi6djxZoBwjB9WmFzGX5hNHkXPMCqebu59eukSBYNBSu7c0UrvxZRIbt6zp
         /SdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMB7p121LAQffiyObA6xiIqys3GTd8Gtk+baBGTsGnXe3Q3AsixIzMi0G4aYM+zC0S2Cw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Gs9mnl9gZg4T4qOcrA4rxCnxiZbxSzIP7eKQINXdjIvOkvo6b
	vT78ghH7nmy3ihnKl6cA4pZ5dRTZDyKNnEnKod/wzbglLlXkxQnKetT7
X-Gm-Gg: AYBFou0ubelrYE8+YnW/0w/0+tAwew+dxeSsHSCDUpZkyP+r+PwwsRRBzT9jDimvVXo
	eBWMhjA7z5q7RU0+JmGrR3OeMG/MBAXiv0UUX/AdLjEUdEZ61zWkNXCFwuN+zvboLkdEvjI621Y
	TWfdZTrWE+w79cb4tV7zE+zG0gLYXNVN+KD7YGLbe6oneljIco27w9/1EuwgaTqjL8Wmsd3bi9T
	sB9ZrXC+P8oD81C/iq+PcBQldmVsTut2x2OBAWZoEabZl5fnD/ZIKadS/PYbuB9d8ea09YHeg8M
	8qAD84L6zRyK34UjDNjWhpYwMmxTPlZRjv7J+nwuU0n0EGiGgu4OuSlVGaiU5MWHzUbgo5niBnI
	tJ2HRpEHyid+0W0P2omuYUw9vW6b0151J3QjYDOuaB2NP7t/ta8fiOkK89SioS7BXMTOiH6uvwa
	oKYBL0W0qkUOiMTzFNeo91VgW2tgpfsATVYQi1Vrg1oq/mzGiQbTqSv/frtiMW60sjAFxHC1nki
	JbyACt8h8K1VMowi94Xb5uA4yV3mL3DC1jLmYQ95e9UDW85zzQOtYpfPEQt9WwwoPdAoYLggnvc
	Ga7wsCjJYQDYIhVKLxdUNtBC62ce79sSiT3xhXo=
X-Received: by 2002:a05:7022:eb42:20b0:190:3950:43e2 with SMTP id a92af1059eb24-1ac5a0b8867mr24847940c88.8.1793811439033;
        Wed, 04 Nov 2026 08:57:19 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:57:18 -0800 (PST)
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
Subject: [PATCH 13/28] hazptr: Add waiter-enqueue tracepoint
Date: Thu,  5 Nov 2026 00:54:31 +0800
Message-ID: <20261104165504.2430480-14-kunwu.chan@gmail.com>
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

Production tracepoint fired when hazptr_synchronize() enqueues a
waiter onto the scan kthread's pending list.  Downstream users
include hazptrtorture's staged hot-address scenario, which uses
it to confirm enqueue before running its controls.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/trace/events/hazptr.h | 29 +++++++++++++++++++++++++++++
 kernel/hazptr.c               |  5 +++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/trace/events/hazptr.h

diff --git a/include/trace/events/hazptr.h b/include/trace/events/hazptr.h
new file mode 100644
index 000000000000..1eed4c9fd682
--- /dev/null
+++ b/include/trace/events/hazptr.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hazptr
+
+#if !defined(_TRACE_HAZPTR_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HAZPTR_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(hazptr_waiter_enqueue,
+
+	TP_PROTO(void *addr),
+
+	TP_ARGS(addr),
+
+	TP_STRUCT__entry(
+		__field(void *, addr)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+	),
+
+	TP_printk("addr=%p", __entry->addr)
+);
+
+#endif /* _TRACE_HAZPTR_H */
+
+#include <trace/define_trace.h>
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 4784df78be4e..16f6e2acaf87 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -19,6 +19,10 @@
 #include <linux/bitops.h>
 #include <linux/bitmap.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/hazptr.h>
+EXPORT_TRACEPOINT_SYMBOL_GPL(hazptr_waiter_enqueue);
+
 #define HAZPTR_WILDCARD	((void *) 1UL)
 
 static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the list phase flip. */
@@ -411,6 +415,7 @@ static void hazptr_synchronize_queued(void *addr)
 
 	mutex_lock(&hazptr_scan.lock);
 	list_add_tail(&waiter.node, &hazptr_scan.pending);
+	trace_hazptr_waiter_enqueue(addr);
 	if (!READ_ONCE(hazptr_scan.wakeup)) {
 		WRITE_ONCE(hazptr_scan.wakeup, true);
 		swake_up_one(&hazptr_scan.wq);
-- 
2.43.0

