Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811542;
	b=fvPI48hg0dlMkrUs7GEkc3g6Dx5ptehXVDrbdt5SVtzuwwpWGskt0tFMZuugGc8TPHJL
	 iGEESj/hysggt/IlDreZ9xTmIclJcKTMIeWLxbwS+GUvZZbfxLoTpLAyS6wdP+4K6vgHh
	 G7nUED1pzlTDHVvX7rq4id5QshAWQkmGHp1aS5NM1OLBbRD5Q6pqKTjQItkQfTlHUC/sx
	 wln6D4IBedsc3qy5MrU1mFg0IGJzHDyKEyQRR8/NQUeXF12UArvflrSn/42jFEcM6T/Oi
	 yhz5ZqYZ8qLUTG+QNP2obHUdoMZ1/orzqw5m5ux0Ed/T9ZU2xUjLlmbXgiZbqgxymXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Udzi7e2m5bKSaRnWhIT7TQ2xIYgHoxZdlBCHKVgs+XU=;
	b=d3RoJiwIjgRzZbWD0qtsW8NtCa8fgha5UiN3sEB8ekaGktEzekAgxxvk7gNJXTYEbNS6
	 izG9n5b2Zgzt161K0wP0SadKYwoCTSt/JbY35cmrxSSPUGszigDN5Xr2WQsUIrqVipVod
	 LnHTb0wMKkgsrPHqIuBYUAZWyWNDy+MHurHM4VbRVEIMEPgeyUEjUFijDiKbJu76rWvfh
	 IoYthislfyZEb3pOmoxqmJNgUJ8ERBiSmX4KaVXIfthK/hNkH9hxqCFluPdll72A77hqY
	 oGDkk7NH9oz1VxpdKJtijedJnSKJ9GEUeANstCxZFGYGhbr+hGI6yCqlJ0dFvLvB/Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B1Xedtr0;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E9606D82C
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3E9606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B1Xedtr0
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2057267eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811541; x=1794416341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Udzi7e2m5bKSaRnWhIT7TQ2xIYgHoxZdlBCHKVgs+XU=;
        b=B1Xedtr0oAKyhCbOYUUZwGHRYObZGkVPHWJPMPMIfuUC5/bUN3NqmzVBJprCraIK40
         JTEK8LzXWQZxf61F0u3tPe4Nm4TEoPGlix7kdAMdgZcySlTtfMApc8UeXuNWP9vxaSIy
         SJO49qL4KJ+8JvhK9XnGNGDQ4ei95PivKYWnLlZvAETNe7Dqh7haPhnmKzz3azpKFVHz
         33Gd8j/nAuVaQSPU10VhOczxcvpukSc/hTfVxRrAzw0DX/c7muQZppleshBl211WxxPt
         GSnHLV0jUNNHql1FgT4Qo5xw7BrVFbQ8LmYadTb7As2JnbPKk/c7h7Nh/1NSBCR9EiOB
         sHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811541; x=1794416341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Udzi7e2m5bKSaRnWhIT7TQ2xIYgHoxZdlBCHKVgs+XU=;
        b=mPzrsR9ZzcMQkK2pq7ePwnNzhTdQtugvhqouNU9+S9bLHKUHoNKGa7zOq9YUZ2SzHH
         Clmd2ICNIH26g1NpguX+pPMw41AoIk9dc+DVSxgReIffukAsyueKrNezyZWxPfM8LXw4
         +RRgNbYsflAO7KRcs9apDLB5mtKY+WdLSVl6ax7EBqYwgYqD7fhOZsxapBMt41kUH1dn
         1ESbx6YvO9yqpNwn9PPzCDyrbgPf24KyJMZBT2UMEs4yLMjisVPq4/thFTKjRoQxAvE9
         3tQ5aTkYN1xEAWzQYgs9uHcBFdHBByBlIq7ZovF6x53N1CH1peZ8mKcskGji+K0lmuJI
         bSgg==
X-Forwarded-Encrypted: i=1; AKwUvBwXKodbGdO7xTUsCchkvDFZPg1TYMT7FXPYU8hGoNb9493cnn5kjUAZh9wDNxPygBAwmzk=@vger.kernel.org
X-Gm-Message-State: APuU4Z87gDfqvH6+W56vgszNvM2xSrCL4nBBs6lkV6jJLBPfIBL947Fh
	bxzOy0VYY694VCrQRXal86IitftRNtqewgTtHWKeo6Q/M5bMkyMwEXhh
X-Gm-Gg: AYBFou353wdaTmhsqXFu0ZQUEV+oFjKSAZ3vitcavHYWZuYiuCGX0aXq+tlpdHq5O2y
	/46ewl+k9onU+hecbIfYDUlDA4RCyBFnNlS5N6JE/o52B0yW8emD5pIU0ytBut08Hd/N5+KHpUe
	w+OhD1KdSCy+mTWMOUI/we/MbKZFA2aL3fCL7UHrSSMBuvrjNeHg2faWWpNcGDFlWG4E2pjej11
	5KleyVkSkcwbD7kZjOM3w1uMhX4lRVN6MRNVvjA0WdVuyDPurrjgwTDN127xEC8inlOUimfXQ6L
	T6lBQzEVEz9MXGfGhO8viRxIBr3Phds9JKON6KWMAUyr4wrhephvLDIuonT8R8YPOL9kf0/FAzh
	nflk/9kXbYG8mZEycvVx6yy8O9L5NpRK8moaJJ49rVWLLVU0PUwVfWmvlFUQU7XtXhORi9TvZKg
	K0zfsDvRRNjrNMwbju58XZuVBm3HhKCvRZH2hxmvWFsgMRKCm5Qcchu/TxNS8ei4QLxVP/j125G
	yzVjeoi5+d1+tHRidESwDWN1PNlXEo32CjIlolMLDfHypukP+L0kkLKeMjRl9IJHiwEw6JJncQa
	1Y/QTnJIKblBvOouLktyIsZRXD3fU6l7CMoXir8=
X-Received: by 2002:a05:693c:8110:b0:36a:1088:fb2f with SMTP id 5a478bee46e88-36a4236d027mr26652229eec.14.1793811540869;
        Wed, 04 Nov 2026 08:59:00 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:59:00 -0800 (PST)
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
Subject: [PATCH 24/28] hazptr: Add runtime sysfs controls for stall detector
Date: Thu,  5 Nov 2026 00:54:42 +0800
Message-ID: <20261104165504.2430480-25-kunwu.chan@gmail.com>
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

Add writable sysfs attributes that let the administrator adjust
stall-detector behaviour at runtime.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/hazptr.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 7d4273a44183..66954251c332 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -423,6 +423,10 @@ static struct hazptr_scan_state hazptr_scan;
 
 /* Sysfs counters, cf. RCU's rcu_stall_count. */
 static atomic_t hazptr_stall_count = ATOMIC_INIT(0);
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+static unsigned long hazptr_stall_timeout_ms = CONFIG_HAZPTR_STALL_TIMEOUT;
+static int hazptr_stall_suppress;
+#endif
 static atomic_t hazptr_drain_count = ATOMIC_INIT(0);
 
 #ifdef CONFIG_HAZPTR_DRAIN_ASSIST
@@ -1115,8 +1119,12 @@ static void hazptr_waiter_stall_report(struct hazptr_waiter *w)
 static void hazptr_waiter_stall_check(struct hazptr_waiter *w)
 {
 	unsigned long now = jiffies;
-	unsigned long timeout = msecs_to_jiffies(CONFIG_HAZPTR_STALL_TIMEOUT);
+	unsigned long timeout_ms = READ_ONCE(hazptr_stall_timeout_ms);
+	unsigned long timeout;
 	unsigned long deadline;
+	if (READ_ONCE(hazptr_stall_suppress) || !timeout_ms)
+		return;
+	timeout = msecs_to_jiffies(timeout_ms);
 	w->cycles++;
 	deadline = w->reports ? w->last_report + 2 * timeout
 			      : w->enqueue_jiffies + timeout;
@@ -1275,6 +1283,46 @@ void __init hazptr_init(void)
 }
 #ifdef CONFIG_SYSFS
 
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+static ssize_t hazptr_stall_timeout_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *page)
+{
+	return sysfs_emit(page, "%lu\n", READ_ONCE(hazptr_stall_timeout_ms));
+}
+static ssize_t hazptr_stall_timeout_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+	if (val > 3600000)
+		return -EINVAL;
+	WRITE_ONCE(hazptr_stall_timeout_ms, val);
+	return count;
+}
+static ssize_t hazptr_stall_suppress_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *page)
+{
+	return sysfs_emit(page, "%d\n", READ_ONCE(hazptr_stall_suppress));
+}
+static ssize_t hazptr_stall_suppress_store(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    const char *buf, size_t count)
+{
+	int val, ret;
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	WRITE_ONCE(hazptr_stall_suppress, !!val);
+	return count;
+}
+#endif /* CONFIG_HAZPTR_STALL_DETECTOR */
+
 static ssize_t hazptr_stall_count_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *page)
@@ -1291,12 +1339,24 @@ static ssize_t hazptr_drain_count_show(struct kobject *kobj,
 static struct kobj_attribute hazptr_drain_count_attr =
 	__ATTR_RO(hazptr_drain_count);
 
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+static struct kobj_attribute hazptr_stall_timeout_attr =
+	__ATTR(hazptr_stall_timeout_ms, 0644,
+	       hazptr_stall_timeout_show, hazptr_stall_timeout_store);
+static struct kobj_attribute hazptr_stall_suppress_attr =
+	__ATTR(hazptr_stall_suppress, 0644,
+	       hazptr_stall_suppress_show, hazptr_stall_suppress_store);
+#endif
 static struct kobj_attribute hazptr_stall_count_attr =
 	__ATTR_RO(hazptr_stall_count);
 
 static struct attribute *hazptr_sysfs_attrs[] = {
 	&hazptr_stall_count_attr.attr,
 	&hazptr_drain_count_attr.attr,
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+	&hazptr_stall_timeout_attr.attr,
+	&hazptr_stall_suppress_attr.attr,
+#endif
 	NULL,
 };
 
-- 
2.43.0

