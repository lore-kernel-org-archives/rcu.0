Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441930;
	b=SkXABbXlBsGsUCdB+HtT1VfcImtr6jkgM0ZCA2IjEWkFPWcL/xnx9ep1IdXDaf8dPrBj
	 7WaKmWoqn3xjzFKi77WiMb/NRTFsK7vg3R+xT+R9/0SpRy1Xe2Mlzl5u3gPB+5/9MwQPC
	 KsLQ34JnG/c91Ag20MawiQ6CO8yfKYc/iYEK/o5VIlb4X8aaZ1xoXLhyWGZCsnnHV/vxh
	 abyavvbtd+Om/Pgzk4g6kzsrE7/UfZ9tYebG2nyVx40hwh5NfPGwZ+j4ZWLeEDrY3qufW
	 zIatcjhtHHq5SCgprf5VeUQgzq1a5o6/WK6WHbu75xStMkmk4+PENI97h0ErdeFdd+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EG/Oikx8PiqldF2Yo+sswkzJPWoRKLQTCOHC1uaRhQA=;
	b=zS+Nb44cb3FjNp77aQvCz9s5tNd+DQHdl+weMBeGAEC9H9ria0SLKyZtTOBSezdRLnoC
	 eK8G6limE2T/EOvxuR/lJ1p/QjqEhIpPqKfrM1LalHa0X1bPGZK/kKJK4ILXdWwhruqtm
	 wvISkpWUFo/GA2XwboBQHqS0rRdYQRYv9xVZ29niv/XOwCm4qrQpI5XDgugwsn+t51ZIY
	 Jw2/gwCGpql3B9xgC+XcckJipmPet+8IW47ts00g4tTmhMhGpw2uCMFx3GRHeVhgzdw/I
	 8b3rUf16zeElAzttIhDDKxRu/dpAcSBnLNelzY08GVeff/ew1P86Tp1HQiYXhVh3XRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=jLpeNRkT;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB7C606A690
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB7C606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=jLpeNRkT
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so34171155e9.0
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1795441929; x=1796046729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EG/Oikx8PiqldF2Yo+sswkzJPWoRKLQTCOHC1uaRhQA=;
        b=jLpeNRkT1LwniF5bH3yOxk7DtL8lOQmvku8nN0q7N0mifyQykHKamb6z105uRDnt5F
         Wef3GIuag9BKlJ7P6l8SL/f/UiY/iObB5XgelgfUlLjC7fvLI455U7snG4h5u6EF7cYe
         ONjx9rx2l0XXvV0IOZKrJViKXc9VVekxIq6UwEV/iedEtMjV7+Cl3ARnQq7pDvliku1f
         v2z22ilJR0SgO4FU/XLc2Fn324Rdd0di++9+hJBJNAtehv5qv2ww4zztMy3DYSxHGfKj
         aHhVidgVKwX3JslII7w27ZJ66sEnGJwYX60jEgupafJWIF/7h0epAKYRte+nAnzWB8Gx
         aByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441929; x=1796046729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EG/Oikx8PiqldF2Yo+sswkzJPWoRKLQTCOHC1uaRhQA=;
        b=X49VENP5i9RiTdLqKHyBvatB0U2Fz0v/yX8CdSU9rKY7gEs7lH7oa0U341wptGmPIP
         nB/M6dNc7elp5JGrFeoy7T5y7Oj5aDjSJK3s0r4xuMFzAz6Rm3hmBKCHvCAwN0U/5cOE
         Yz6bCUMECCjUkyr4CyrhuLjN3/pytGn3h0o0h58+LH1VQ6EfjV949azkvIAZQy8Eu1l0
         E1YMGgngqQLqTCgWFB1kwMoA2UrpN4IaWCnIVhgedJOvZ8t2YoVGGM930cB8KaEbVoe6
         ZaeG+7aX8EFxy2x9KICn52q2USdxzojQMB+HQJ45J4oqb3eyuVF9/3n5YsNgwHJwQvMg
         vxGg==
X-Forwarded-Encrypted: i=1; AL+hErFGrZ8RwMs3YF/xTFY/rO69zbQuEPPedPL9Hw6jw9et2ZW7kbvah21+qBZgv/9YiK7FzyA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/psjpPAXwNT1KpEZCaF/vtTuH39SwB8I8zpEpB0QtK5UDoYmV7
	LjJSKK9VIcBPu9JZFqPqvHamIjT5HLCx2LZt2zI8ORGM3in3ad4e64uyjVnqMR0zpdU=
X-Gm-Gg: AZFdTZdnNPp4GodXibGw4UnugpfW645ZCKMZDB4Q2qSCih9a9R/7uo26UcEV67/Jgej
	F3s0anHpHklCxX+gf1cAfsN74ytoSM1Tej1eE+F5qy51x239Lv8CLbbMp8I/1igqApghDBESTRR
	1sq5DlhVgH4jKKvxkjUh+c0cGl74QHzGQCOui7hn97hY63tKvgN4hC5w4uZxFuQw7YbvGsUD1DI
	L/38dNLp3dnAI/7rmfyucR988QPPvVg+vVamIBaCm5KGisiO336ifZ5rFPGZVHKQjG+oIPaDlrd
	hOM/sLQfnq7xVxW2V3axCe8TbWsNZWh5QV4u3KCqRcIavuxWG5F0+VPy65aJ9bemsYmstReBWWC
	dIYKCqzLGKMLXSHX3wiINC93Rn16/zByIjrH9TEDRzyptOnu58wO0ML3pFnvCH0I3Z/rjcwtBxZ
	HxiRD2KitvBx1FMhAS7SH4HzQqXWc9dWJqrKHQn367HZFCzahLOZayayXNq5E+2imN+nReWS0ql
	iX6XNpkcurrCPeIiRPOrOzXRu0mA5PRlxRZZuUkL7UDTEKn26q89IsxYWZhrQ4PxcuIB2Dcs02O
	SBDjvchi8UlMJ7jURHdZeDe5nF9QCVm3rlrzI7SNTYBOQBTeNnMnpwX2WCAd8jrWSCHARYk2CzU
	xKPp7TwPjjapA3O6nUBl160twsAyNgpA=
X-Received: by 2002:a05:600c:4e87:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4bb88922c81mr242428605e9.32.1795441928731;
        Mon, 23 Nov 2026 05:52:08 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f1b7800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1b:7800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm169279215e9.5.2026.11.23.05.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:08 -0800 (PST)
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
Subject: [PATCH v4 4/5] mm/mglru: avoid redundant rotations of young memcgs
Date: Mon, 23 Nov 2026 14:51:59 +0100
Message-ID: <20261123135200.4086519-5-max.kellermann@ionos.com>
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

Concurrent reclaimers can request promotion after another reclaimer
has already moved a memcg into the young generation.  Requeueing it
into a random bin again adds list mutations without advancing the
old-generation scan.

Therefore, skip `MEMCG_LRU_YOUNG` when the memcg is already in the
default segment of the current young generation.

In my micro benchmark, this increases the request rate by 36% and
reduces the average duration of each write request by 27%.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 mm/vmscan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 91f31b65f9f6..b9715acf2f22 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4492,6 +4492,14 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	else
 		VM_WARN_ON_ONCE(true);
 
+	if (op == MEMCG_LRU_YOUNG && old == new && lruvec->lrugen.seg == seg)
+		/*
+		 * This memcg is already in the young generation and
+		 * reshuffling it again cannot help the scan of the
+		 * old generation.
+		 */
+		goto unlock;
+
 	WRITE_ONCE(lruvec->lrugen.seg, seg);
 	WRITE_ONCE(lruvec->lrugen.gen, new);
 
@@ -4504,6 +4512,7 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
 		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
+unlock:
 	spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
 }
 
-- 
2.53.0

