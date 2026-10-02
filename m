Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4150277A
	for <rcu@vger.kernel.org>; Fri,  2 Oct 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961061; cv=none; b=fcXAlD3d/no+Crpi4AsETIHkBV+dnDANauUUaBKiu3mHp1+tEUG0VAaassRD5Dmx3A/son8Phz/zpXkBAKjaiIooQY6UQubeLkLLr7cD6uNegG/sXjXa8VAs2ihxEBqskB8e5FFVtfbqs9R31jBNFwAA5ms12qxoIQV6AC7olgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961061; c=relaxed/simple;
	bh=bKK6Ka9Gp+vtwgFDDZYR/jwqeinj7CuEjE6r7sAsMFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrDGWF91cOsluVOHpKNm+8hZe5zw8Wum5moYpmkfjFVFHzlvHgH2U8X82uLKA3vc+pz6zmJcD03livEZNjEm7s66OBjr0l8zb/jJaDpXxUfUskLS38d9HRaxuaDZ6FjqzTA3KHjMjcZEmqLpItpQBd48dr/jofg0zznPl/KKb+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT5MgHF4; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT5MgHF4"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso153430a91.0
        for <rcu@vger.kernel.org>; Fri, 02 Oct 2026 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961050; x=1791565850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJpC50bJQ46wh7HHA0CogRCPQLVQ5kdzi3EXJci6E9Q=;
        b=PT5MgHF4yyEUUQ+6sF7B7UQBFmhWMgpeWvlxpmjhS5yqEywN50roF1rRY+bflK48kp
         7uoFyOQWZk3RRJpObvmHVnDzjkkwFCeAKSyawrdXj4dSbIESpMBR/PkMEw4m7YiQe2Cm
         7bnm01mMLCCRkjMe/2qkkmRJ2XofwwtFbI2Zo2DtOAL1OVPfanUPZ9KWKJ7Y+bP/Fmlg
         qJxCc/bqWmjrPs3Q/v5KIWa1oW0mvS7fpdJUb3SKpw5eFuf1LsXxBNnXulikuWI68E7r
         mv674X7M255u41gG2lp710eyVDqLkb21cuqu3LfBXDZaSFQM05CGMkgu1bCDb4EIkHLU
         p2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961050; x=1791565850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJpC50bJQ46wh7HHA0CogRCPQLVQ5kdzi3EXJci6E9Q=;
        b=jIhQhKu28gOYQSybUJCYTk2/2fvvtInpSuI+7iGNIEcisiF3jQiNRzqa4SoWBhqUXg
         NrerjFKq8BR+7gYr6xi9X02bWDpby03a3X1lTi0qtix/do7wgIqITgPJThQJfNsM85xn
         waAEYyuKdMHSi1gs4f2sIVIUyj9By/ewoEp8PFfMpodY+KNUMn/UHCqBuySyai9Bsi65
         h0kDH6jlCvj0ZIDjKWK2E6xtnZ5T5Y0zIvJ8suIJROiH1YHf2HLU6N7D/olbDqI2YNcy
         KmtRZozv2oLQaYClD82+/Z0aBwzA9Ztf7oCjKHOork3MPzkbOpDPNFVJ/llRmpke1LDT
         YxmA==
X-Forwarded-Encrypted: i=1; AKwUvBzY5l7Bx4DVXX4KqrvgWHYn5w3oOc5nH6+GsfzNRMMuOa6F7AooZnCaGL39iSmfWx3JLGg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ32erlGNQNRiujT0XkrtPfTpGtlxY2RY41WNKU9K8Y8FuEUy1J
	CwFt9Un7FPpkH54zYiEHu7nMz9C2NvoUMdnX1xya2SEtJHdif9Mw3DGk
X-Gm-Gg: AYBFou2t8qOI7x9/DKaSIAtvHt3pg3ngJDjbq7Z0c6UaGoGJZOFxlunGRdMgyzenBkU
	KX73fxdht4EfildiWtoWWX4kZgDNIPVCU+hkg964qVr1sZq4NnyI9Jy6aVocc+yXZWCkVjuw7CD
	DU+q+8dZkxb30pb5zp6fq8azjwx0g5rI+UcJOeV/R5NxueVOB9XPjmRsror8PoiDb7b98C7ZnBp
	KCbmMcUfIYg1KcjuRPFKkoJ7KglOKRZKUTYjBCmbHlCSBh6gRPN329p59L+kWyOf+i8Q9HdSazu
	LYeG0qtKbztjhKrsAMGeeno0CEMWcKvEnWMjJHNmNeFP8Tipc+TxQ/kVsPGMXfmwMCReSCeeDc6
	ytVhoujhyloLjC1n21JVgeGNtCstQTFPDgo/6ZxBk0nvBhVdY5AZJ3WLtd1jPYR0XrErqS78yg4
	B3MdHBmqi+QkFeoqdIHGIkA5YPElDIFLew6wc4w+gfojTImHD68K4wDjcjFm7XX2y6GRF/dhOVB
	iqBfm1OU0MtDRmp1U77mmHFSuGT
X-Received: by 2002:a17:90b:28c4:b0:3a4:97ea:f0d6 with SMTP id 98e67ed59e1d1-3a6cecb5167mr2765857a91.42.1790961050063;
        Fri, 02 Oct 2026 10:10:50 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:10:49 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net,
	lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
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
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC v2 10/15] hazptr: fix kernel-doc of hazptr_release()
Date: Sat,  3 Oct 2026 01:08:42 +0800
Message-ID: <20261002170847.3653663-11-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002170847.3653663-1-kunwu.chan@gmail.com>
References: <20261002170847.3653663-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second parameter of hazptr_release() is named @addr, not
@addr_p.  It is the address passed to the matching
hazptr_acquire().

Fix the kernel-doc header to match the API.

Fixes: 17969a0e7f7e ("hazptr: Upgrade kernel-doc headers")
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/hazptr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 4ee02d23abc9..07f5d9ef5a6d 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -293,7 +293,7 @@ static inline void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr) { }
  * hazptr_release - Release the specified hazard pointer
  *
  * @ctx: The hazard-pointer context that was passed to hazptr_acquire().
- * @addr_p: The pointer that is to be hazard-pointer unprotected.
+ * @addr: The address passed to the matching hazptr_acquire().
  *
  * Release the protected hazard pointer recorded in @ctx.
  *
-- 
2.43.0

