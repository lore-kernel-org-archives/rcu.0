Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705852;
	b=VmNKfLL9vg6WmGin/m4QzmzS6dR7FVwFDsDMo+bR8e+pvhTyuiXfsVhHVfmJbbDkLFoc
	 d2SE91Pq6phwIQ3uMXVw5w9xNYxau+xuyWQMkkyhYYEkBd3KyXUFy6mEsgZ/YygJYFxr2
	 FNLgpE/+2bYwc9VC73TfmlYvz6xo5XlL4LbPNAw2XK7F5RbQU7sJgmV4inI2mXBeEmNRf
	 glwUC/e+xcE0pGa0xIj7SYZ0nif7t8Ofxfjef/uiaKzFyoULQ6+KRuCkT/8Nz2k2eUXoe
	 Vkt8O11xnX1wLoE2cX98fbz6OGul53oBk7/uNVoylQZa8j8jeXRY/fU24s0ri4ZB/VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IsKP26C+4uK+emKCr1xcjNZltVUV41qm/vZF8BC5G1Y=;
	b=yzT8sXC1jqjKRjbvmulvVwgu+cbCub8zPbKlwWVrZiZctQmZAeYxV/yEcZ61a+m57YBA
	 w7F54Bh1OSBVB7VfqauGOGyrWtPMQsiicWbixFBBiOgSgAwWCiekd5aRoKSPx27UjnRLF
	 KFxT9hb/a8jDN0Q+GuPfN4oO1ocgAK0C8FsKabCu8fktLxNE2XCy1VmepzXVXLHgleibU
	 FtkWP1QTlU2ALrHGpXlOVYFtpwXHrVdHx0TEdVu84uQxWfa/CJrvMYzC//5GsvKCR9k1L
	 8NrfrCwjd2/APO98bYyii1l9x3tStp+d6yiME7HffyNm+ubLwpUAhMdCCDijsLgi0Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=OqnZvdGr;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3460A2619
	for <rcu@vger.kernel.org>; Tue,  3 Nov 2026 11:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A3460A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=OqnZvdGr
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso2484002f8f.2
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 03:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793705850; x=1794310650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IsKP26C+4uK+emKCr1xcjNZltVUV41qm/vZF8BC5G1Y=;
        b=OqnZvdGr7oKaBQXj79USnk3s8lZBQrS/KMUdL6ZQzFzA1UyHvDX8eY4wNAXYnlpsEh
         0S+U0Mqg+ENxsPh8s4nJZW80ztlQwl1zH79w49YP79ha1Gxe9QW8mLl0E1ZiUoKUuhgq
         NwptN/Ui3HcG3VTOjxYP7fdkw9NHTSJRpWtGPWNPTrRfDvEST/zI7+PYPYRubt/Y83lh
         /o7o4bp8VYv8jcEI5NUgO6DTMiLRcVUHS7bTX9pVIB33MHrXMEIEK76IeYERYstR86z/
         jRrmSqyhimPa5cPENpWuv/TtqB5upXBVtmtNZYb2CqVa/g+5dhgomvt6jK6MbroCPTL7
         Y/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705850; x=1794310650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IsKP26C+4uK+emKCr1xcjNZltVUV41qm/vZF8BC5G1Y=;
        b=pQFsroTZvrsERv4nypPbsUX6+C+ALa+p7Oz3VGVPaAG+yr+M89t4puBb0cap8WmGU+
         nzwO6Nv5d7Bj8QtBYcv3FVa2eBrJEZEuBevV4ekAMpM8RUzzSZQW75TSUIFm6xosWXZL
         61gCIAn3xYNvO8gZpbtKce0v5kPVCdY+EEKwKfqbTXctviT8busptNF/Trk1l/ZQU69J
         DzcldlmzyxJmlSsfpB5kxITYLZe3ZgivdjBfdYKnzlaXLg57rOWrljaw7CHJYSiV03kT
         abgnJEffVlmLTl2y9K2DdiFMnLF0efFiEyPzjZaPWOhn98yJc1xXjzfF1f53iCdgXfTa
         JTbQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5ROTVUAuWrQ4+/nH1Ifmd0NuU6DS9VPumWk0ds/N5leVl3jLRdRtmH+VBhC4mlUfGCqM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2ZZSGV0kVnPAg4356EQBoC14g0ErrbRTqMDXrz5xe31pkoNlw
	dAmrU7IA0CgdVw3qPbN91QlmYw6okwZlac3S70WKq6CGbHXhIfwBtTQWzvapXa6AAL0=
X-Gm-Gg: AYBFou2jL0pf1NQQyBMiofhUlOfvYpunVgNhre5c9i8sY2ubqMWBT9nfx6nuAbhYf78
	0xkq5bAz51LN6LBUCetdG3ny29PLXhD/UuItzYiaGCBQNqU6sYn3LjBRpML7iG5ZheDzwnDPhfr
	4qQMFsRxBTuPpsdqt26HXOtqabZ82LYaIQNlh33OtZHFY7WzT1onnSwdm3TXh9g0AdqW0lkm09c
	IVmxpbqeU1lx7ythtG7oX9R6DnNftMgmf2lEB8MtwbKfpiVw1djvp/5MJrTZy+8GXDXrp27nC2S
	M2m6Q4s75yu5SOrV6M+dabOS0TqKlcyt77uwluf+4AONWaKRan5FiXJws69PzWFLwOa5232HgOi
	2JvyG0JmJZ0BIxxsjEx0um/2C2TseI+Y1ow2qPNui2EBms3tP/COT0JrqmM/PJtbEFVkzT0LjGR
	ZaGt4hoGiuHbk34U5QBWfKDcftNWGWILO1Mha9JJEcNMLpkzuSXg4zsGKOHx51J0PS3sJxIw08i
	dx7Ghr/dhkaBln6xEM0XtROsXSy0fjRHvtxPkG8qnd2Zcl0hKNyoETNky7ElML3u/te/Y5vEzB9
	yZkGTpkRoGGjaBU7NsIr5qc6t1WCD2xvh4/Giz7iWBCqHQkFmieqiDhAOij/K9WC2f/50PLbE/1
	RKdaSKDORiL/6Lyr/w7JmGkI61W8yYQ==
X-Received: by 2002:a05:6000:240e:b0:48e:76ab:78f7 with SMTP id ffacd0b85a97d-48e76ab7f2bmr21607663f8f.20.1793705849795;
        Tue, 03 Nov 2026 03:37:29 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78f95sm23000997f8f.28.2026.11.03.03.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:37:28 -0800 (PST)
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
Subject: [PATCH v2 5/5] mm/mglru: reschedule between memcg reclaim attempts
Date: Tue,  3 Nov 2026 12:37:10 +0100
Message-ID: <20261103113711.1832834-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103113711.1832834-1-max.kellermann@ionos.com>
References: <20261103113711.1832834-1-max.kellermann@ionos.com>
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
---
 mm/vmscan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 899f756bd15b..5dc5e698e243 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5395,6 +5395,9 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
 	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
 restart:
+	/* Yield between bins/retries that contain only skipped entries. */
+	cond_resched_tasks_rcu_qs();
+
 	op = 0;
 	memcg = NULL;
 
@@ -5425,6 +5428,14 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 
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

