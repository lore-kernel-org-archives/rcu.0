Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441932;
	b=HOKrdpY+aNqExp/vhtDIqT5VtHLX9CK/F+6T/Ci0HEdHat/AwD01u2UZO65TjoK29oDi
	 J4YS74WvKPoZonSYeHsl+eyPWpDkNZbDlhIvQoPM4IIamb0icteiIihhsh1NTHo79IrIm
	 bBU8b+mblFddNRUT2Qhza5g1HnJ/G+PGrWPTkHx7BbmxYhMpb4FL3UqXX8rUuXO/8l6dA
	 Q97gRSpzvr2/Tv8iyMcnulR//Nc2aCAuvIix1gJhH/QEdpoy00gaKQjthImpNtLMXHgqL
	 qXn7pAX/9Kg5SHQdw+Lbb1uzZGkETVfI1I+Mw4dMLJHUuK2hY2HY7QnutOrUjOSj1bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t3XbpV7aE8lPEF3WjasnioB+LmUiUo8YbJQhUQP3FUk=;
	b=bOsZgRrUZWqk+8MrOhQ2XL/TWm8FiMMYpJj8mmHUalBhHV5liEUauUurYdiig3ucwcDy
	 4Gw9kCkF7NCERPbHyzHeu65ZwrO/V3eudfX4IL3V14FPce3mZ/KE6a6xYuetZvho4ji1Q
	 CndGMbnmJ4VwUKhBOSMi8lbdtdHd0i/OTxRnHjonCJns3IKvNpu/TANvIMKsKvWuFHiIo
	 2yyzBta3HJfpje+ziy3lXkC0W23fBSUOCqkWjQM3oUwZWdAJ4bX13RcZKOYRpts2u27QT
	 rJzbvs/mKFGj4auckFW/ejLf3WzPtZfbNP7zvPh0HX4CdtjGUEn7KTzg6cmCr3s8EjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b="RbfSu/x0";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002E606A338
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B002E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=RbfSu/x0
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so4220665e9.3
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1795441930; x=1796046730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3XbpV7aE8lPEF3WjasnioB+LmUiUo8YbJQhUQP3FUk=;
        b=RbfSu/x0bDwJHK4flElPnk1iqilrNXrIFmDpp8JSLeS0nOuRHwXBkrEGvEsHiyIjRT
         N5hTJC5fNWPiCGSQpzNXqDsJa2II6qUe8scq0sApwJm71mSZaaTmYe5IDh9JexBg5ITm
         /Ub5Ixyc1yGS9Q2VA0OZX4nVRTpExuGwOoAaQt6G+WGKh37/8XCxfKpzuevzTiNZKXCw
         clWXXxtiTYnGfgPafZ4vX1bkHqewPW/LhO05hMUGQkiyWv6X0e7G4WHIzMORyNfLZ3x7
         RuOz3Y4Vv0/02LPT9GRCshSaCMAQFQ3RFEHEGGkdx5zQ0yuhB/UpdekyELB5Z3TNsdb3
         qldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441930; x=1796046730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t3XbpV7aE8lPEF3WjasnioB+LmUiUo8YbJQhUQP3FUk=;
        b=C7sGILHC/1VEFqUatSsTCcpQeh9u2Bx5W9DezgjmSid1qJaCR/cwjS41rqDji/MKJu
         fxpqavE2l0DqdI+THGbdYd1hQ9Nor5wuR3oX4dL7ShKjNYg+gbriiAPnpA2pWp+ND/v/
         BuZleOXZPHbSZ7DU/pjmFlSabIFft8MOAqRmfBmexaEI8usZ1RlCp7nMNbOFSr1XjGKn
         pW8xkEQCRCpEkbGbd1X7uHHEcjfG//K8hNU6PXABL2NopC+Dp2AGCUUXWdIBamVpO0yr
         TRdCBysWPkaZxEzAd+QE3kqOnuj2TC3m6v7hH5Nr31OgVkk6CqHyz7Vlg4QTOqb7wvRR
         wK8g==
X-Forwarded-Encrypted: i=1; AL+hErFHGuCYfeFuq5C0U7H/2moadWDoAppVJC+mABOcWIPUKn4sGg5hV8GmlKdy8yWuBf8aFGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z98zkwNu8g4nnaeKy71fSO5a3FaT0FcJWq7l5RstwouWxqG39D8
	jYSlO0H6gZ2XrSLTBbrfBUJYyYyUO5dU6g3m1FBPwRZe4oTIatdovtT1cyDVr1eW3HE=
X-Gm-Gg: AZFdTZcQylYYdvgRlMe5Xdn4HmJ6MZmkMJWs2gJBWA3S3dTy6cVPmN+U7ad5+Je6Fwy
	C/bPekp5sEG5xt64oiJ+xG/QzDizAAn67GlbwDWpk0dho8KKpqnjZPLQ1aPBKCjnhguof4XmUYm
	gc0bQWX4T1u9tH5sCvlMQQCiF9aX4Vs8bvvXT6lSHdIAOlv9pxq07uEO/qcIbvqOl/47/xoX7nG
	ZXERDwT/oWrU77uMAUTazIZgvHoSFnuCqzYuje0OzWn69KCCMEYWmDDEsIU064+NgIB4aDfhwIF
	jp9R6XN9PZAo0Ua+q/LCc8b78Ry8Ezw1/iZBFyuCQqqza/3Nq1qit7vH5tcKI5r+kv2tn9AQkfa
	ta2VnZLJZ3AheeNruRxnrUi+gMSb8r46MEvjNOZlp+DJO+mRR31uUBtTufnMFlQ/fignJJAqXpd
	N9sh2DUdH8MI28kQAbmePPmlwXgJYRvAMNNROZ4Odv95tQj/Xgaads8WxJAJo5+51Q72KJJl6xe
	4coBJX6EvLuqxBWFGuxpMeOV2zoRuaR/VDnZq9UKw/LS70m5LZqzzPJ1zodzIoa50MvFAdtcw69
	vzY+a6tuFOzCpCavTqGEcgai6jJxWOTq4a0RXw2f/ATTFwMegnLZvR3a4RnVraClepYsdminsc7
	Rid7u7lNLcNTFiHZWtfDbEqQvcgFsX5a8QJiKm8E22oxVPc9Aipw=
X-Received: by 2002:a05:600c:64c7:b0:4bb:68c4:2044 with SMTP id 5b1f17b1804b1-4bb887fe725mr225665445e9.11.1795441929971;
        Mon, 23 Nov 2026 05:52:09 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f1b7800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1b:7800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm169279215e9.5.2026.11.23.05.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:09 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 5/5] mm/mglru: reschedule between memcg reclaim attempts
Date: Mon, 23 Nov 2026 14:52:00 +0100
Message-ID: <20261123135200.4086519-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123135200.4086519-1-max.kellermann@ionos.com>
References: <20261123135200.4086519-1-max.kellermann@ionos.com>
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

shrink_one() can return immediately for empty or protected memcgs, and
try_to_shrink_lruvec() can break out before reaching its
cond_resched().  A scan through many memcgs can repeatedly rotate
entries without giving other runnable tasks a scheduling opportunity.

Call cond_resched_tasks_rcu_qs() (as the existing shrink_lruvec() loop
does) after shrink_one(), while the memcg reference still pins the
cursor and before reacquiring the RCU read lock.  Also call it between
bins and nulls-marker retries, covering scans that skip every entry.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b9715acf2f22..f8259de7f592 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5403,6 +5403,9 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
 	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
 restart:
+	/* Yield between bins/retries that contain only skipped entries. */
+	cond_resched_tasks_rcu_qs();
+
 	op = 0;
 	memcg = NULL;
 
@@ -5433,6 +5436,14 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 
 		op = shrink_one(lruvec, sc);
 
+		/*
+		 * Empty or protected memcgs can bypass the
+		 * rescheduling points in page reclaim.  The memcg
+		 * reference pins our cursor while we yield outside
+		 * the RCU read-side critical section.
+		 */
+		cond_resched_tasks_rcu_qs();
+
 		rcu_read_lock();
 
 		if (should_abort_scan(lruvec, sc))
-- 
2.53.0

