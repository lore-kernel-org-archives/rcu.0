Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811505;
	b=gUTZaT5Nub22uTG/iQxHxCn7/R7NcKeuQve2tWCG3dBL9CpLhEv5kE4qbi+WyjUiWarP
	 gWtxdd9TCLBTGiiL7nh0zQaN0Tx+HVaLkD12qneBypCU7fI15KnHUZtV7ndwDi2hLBZgo
	 00AX52porbfpz9JCo7d7e+XVTMEhhiCnqzS9Rw+2JvsA4ZJPeYZbfcS3wWKh17qsxm8fU
	 IccV2cV9TrhDRKUKTzm5Wx9JwOZArfZXdD9umNS24PbJ2/CJgBOIqOD90oqrxaxirM6yC
	 nTsC5Xq7IdyhxulczL99ROZXG7BdXKqm8tWb7B2r+KQmDgrZAFTQjL+PMHXcCn0IguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E3exnuIEn75Mzl8OzBk9yKBvPuDEfR29myhkVg7oSY4=;
	b=GsTXpk0UtjJ7RafNFW8gQ+nqr80bIuYD/C41ijHdw+8XYYGoxR/D9pw9r84jzcoCSAyc
	 CUpmiPOuaROjDDDM0qu2oJ43CDzdNXU32Kpyh/GoB9a0CY2QbUc7NDfLdRZoysIiQIZvb
	 Z+ucyY08v0C/ETa8YBsMqHP+oCco2hCVyY1F4Q5u7ZfP+5y6rn84Nz075loFAM3+Acl83
	 Ac11EAsMG7hiuoAftDfqNGBW8MWJV4UKJClrFlRzQMwyrE+mqyxK2ii48n3013KtHae+1
	 T/k2YJR+kNbzZYHIbYBmSc98W8VuGq/r8nExYf3fEcgazXb6ZXdlgNL0QqShFcfN18w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d4EEF2kO;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED5606D822
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59ED5606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d4EEF2kO
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2055614eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811504; x=1794416304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3exnuIEn75Mzl8OzBk9yKBvPuDEfR29myhkVg7oSY4=;
        b=d4EEF2kOlJ9ZwT7ZAqTk4BEQB6KcUy0uA9+FyL4MbNN7Zu4rDZNZ0rp/SjEM1SHJ4i
         +t/vAUuu9SCQC3AYeOMIngo6oTmzHstQm5PfvbTiZo4E0zTT9V6oh0nnxsdi583LVoP9
         a7tSdg9pv18ePLJgUJJGIePmp4/HtLBlGIL4B4XqWh6wFW0yt6vcN7QL4y2SPKtHKdOU
         bs9e6FLPI+Lm9iDleUFUew9o5bRM5WOk+/D20EOyGWfHt0Q6311/IX/Ow+PfL0FIwOAS
         sJp03RdEH8YojNlrwn4RUuHSxdKSA/A8BAe5x43K6gSXTYuYOLC0EeO1Cb5cyDhrtx52
         4QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811504; x=1794416304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3exnuIEn75Mzl8OzBk9yKBvPuDEfR29myhkVg7oSY4=;
        b=0q3jpfDSp8dNCZxDWTk5Q8ZwhNp5wxvkZNifzbHJei2GoFj6Khne/1wEagljy1dcDn
         23sc5soBHAOgWWjTXMGg6T9s9k/7kaDXrB+/cmAMPT63W2Fzv7k7uKaCetetkHhdWXBN
         poIjLU/zCezm53D8a4yEMQTlYdtYx0GiOn1JEEsPEJUt69XyaQAn9ZKgwla6DFh4OhBr
         RzghUfpKpFYsioDltoL5dmk7CMYcrNRCduNtGhl/FbRqwKzVHTBjtA+sbOJtsuDzdI0+
         b3zrwDtjWyOWDa1uH8c4ItRK706pTmSPqind13Rtwk4v1CEKuH3ss6URhJRLg8md5fQ3
         ATXw==
X-Forwarded-Encrypted: i=1; AKwUvBwG+NrNL3SDMx0LqwRAG8LKhdLW5A96Td74cPIQ10Q18jug1VivNpbIvame20hAIpcKgvw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Au3XdVNhQqTNGXXBQdCoPnRoeBwkdBpJ7NAQjUVVk6MgwDVJ1
	3vPzXH3K11FLpPfP3scDAcUGOstmRLboPZzFfuA4g9MfwR2yPvMhpFUV
X-Gm-Gg: AYBFou3xD7BpvyCarWLiU1qTo6uTzbG5J+JnmfX0iqTInK65IcKnSAc3GVUghqNoCMh
	Slc1bkXbTK/OZO040hsBGntbD0lp1ZL/zHe7pKTT0VmIVAvrKQbUanu3vH+mc3ICT9trOc8pe6x
	7ykYQ7tjL8vZJ4k5JSfkyumAxUSz67xW0WV8cCAX+CtLfwqo3ryLiP6z2cmOiIDJy6+rcn51tFk
	7XoNm1CpNiLKJFCENxh4LLd1t8WwL8oVr+55Qeg+r6WvW1lN/RiRbdzyftIrQxw2O2Chw60OAgR
	1V94jSx2tZt+yKvlkyXPaBWR/YAdsLgz6BMany1WG+UPGwZ2UOUAifqGFaT5htoUgB2I9MkekBf
	5tNbHIpwD1gNcsZ+4bvCYBfeSFr14IbH5pHnzEiHjRE57G7i5Do1zfEkIGGNOdJ5A+H0KIx4i+6
	mSC3Z6sSvkbA97sq4pfZcbSw4IiaxvhM5sImVQYXRDM7D5OkfK456fPQ/kiYTJiAVqSTrozapIk
	xyoDhmgDip2V7+vLeQ1qL8bRHWOFDexH6Vu3gIWt5rjisEYrzfFFgbMq6UVVGzjfmwLbpxJd3b9
	h/GdB0ag68mtkKupSQV0lAwDgHhl/djuzhZAdvk=
X-Received: by 2002:a05:693c:87c2:20b0:36a:6ae5:23e2 with SMTP id 5a478bee46e88-36a6ae52e67mr14054524eec.17.1793811503835;
        Wed, 04 Nov 2026 08:58:23 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:23 -0800 (PST)
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
Subject: [PATCH 20/28] locking/lockdep: Use hazptr to wait for dynamic key lookups
Date: Thu,  5 Nov 2026 00:54:38 +0800
Message-ID: <20261104165504.2430480-21-kunwu.chan@gmail.com>
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

Replace the system-wide synchronize_rcu_expedited() in
lockdep_unregister_key() with a hazptr_synchronize() scoped to
the per-key hash bucket.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/locking/lockdep.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c3dc84a7cef2..256f23a9041d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -58,6 +58,7 @@
 #include <linux/context_tracking.h>
 #include <linux/console.h>
 #include <linux/kasan.h>
+#include <linux/hazptr.h>
 
 #include <asm/sections.h>
 
@@ -1308,14 +1309,19 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 
 	hash_head = keyhashentry(key);
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
-		if (k == key) {
-			found = true;
-			break;
+	{
+		struct hazptr_ctx ctx;
+		void *bucket = hash_head;
+
+		scoped_guard(hazptr, &ctx, &bucket) {
+			hlist_for_each_entry_rcu(k, hash_head, hash_entry, 1) {
+				if (k == key) {
+					found = true;
+					break;
+				}
+			}
 		}
 	}
-	rcu_read_unlock();
 
 	return found;
 }
@@ -6717,11 +6723,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	 *
 	 * Some operations like __qdisc_destroy() will call this in a debug
 	 * kernel, and the network traffic is disabled while waiting, hence
-	 * the delay of the wait matters in debugging cases. Currently use a
-	 * synchronize_rcu_expedited() to speed up the wait at the cost of
-	 * system IPIs. TODO: Replace RCU with hazptr for this.
+	 * the delay of the wait matters in debugging cases. Replace the
+	 * expedited RCU wait with hazptr_synchronize().
 	 */
-	synchronize_rcu_expedited();
+	hazptr_synchronize(keyhashentry(key));
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
-- 
2.43.0

