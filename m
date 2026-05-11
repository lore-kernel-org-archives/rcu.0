Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1D47A0BA
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522099; cv=none; b=qyqmtPtKhPYwxxy5ISu+UIDGHDRN4+L2K2VIP7SAk6ZPHsR7mac054ui30H/EbJEJ3nuAZwTi6mWvcqW3AfNiwArdV7rIaP7WtUTqlUuVFu24/9WFChpT+SM5nGhhmtZPGz0XUzJWm+6SeNAbbAmBNvWlD6c/zYo7sLsaSezrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522099; c=relaxed/simple;
	bh=jofbNNrCF39vcNdNgWy6T1Gh9+EoGuK9YxZyAMEyS4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWCg1XChouq632H3I9TslqhiHOao0mTRtNnNvAPCtJLcfvba263LoVAUXcdGhBQ4dTaWY7c1fB/dBfDcvozJWJgzLDLsSWHs8jplAEACiC1xhAlSU3/NxFdxXi42YAsihhNakleDGYjBV7LBz711dUyn4M0Cc6smP8tSbxlB/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2PN4Px6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2PN4Px6"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38be5e86918so58565581fa.3
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522096; x=1779126896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK/hKMv3hTEcKQiSOTXGSh/P8Sd/0hfRCspIyE9/oj8=;
        b=C2PN4Px6MVkhCX7iptbpWVRbXHXPo6UrxXJyC39iig/h7MZl8PDVq0OO3ALB0ZnnTt
         rcU69eVZyA7hdFebOyJrGC8UgCJRiFgnk3po8gwzMjHMqFCu1HqF8E3d5i+tJoBAFrYc
         oDfoY3Ge2Ki3YSISSOJu/m3ZSdwNzHSPdiGRUqZEFequOOt0OYNeZel7EGs64WQr0Wgv
         nVXR/xBkUG1E241w2c/IoPwGAwUGLo59LRsa7rYGN2R+bN9CMKtHw2zm5aQ1JhDTkbAL
         dkjZpp8kOhW8Pd/+0zC7oSRJXg7Hl9fltDk1vwrhuFodq/ihPu5YROcR8eDbseeMo4+8
         OfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522096; x=1779126896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aK/hKMv3hTEcKQiSOTXGSh/P8Sd/0hfRCspIyE9/oj8=;
        b=WMEU/HyorTNppT6HgSVC4hc92uxmuehz5zRx98cyHqtEljaHZbELcgvga1pyy7wulk
         Ag0Yn2oyE2fCj0Z1z8SATql+e5qIzQMp07Vod52AUwbKkMnnY/xLxybj9OGs7n91A1h+
         yxYNwqcF2PNZWZFgQn4mt61XzzB7pRhF+4r/E/nEohoeGJSM0h9kGHX/UPW+M9vOOgcR
         UFbiqUPJ5at/NMHe68ASbo8u1E2d8AxQObQouiHT/HtrpTktL2GCLncFXqYhDLULWt1J
         8Uir+aU9K+C2VJ6nsp46zpPs/Mo3zHOGld2btlX54KSMHqRVoxOOUsRYDx3ga8ecBVsX
         5lXQ==
X-Gm-Message-State: AOJu0YzKT5TElSo29SBDX5bmlRcEWVk2nYwV66Zg1CX+H1GngLxe28Bx
	IyvNAI6IEeN0yeMiPFrrBxgqEdbEhQnZuWc4pCQuAb68I7XMjfrLg25O
X-Gm-Gg: Acq92OHT8nl9d7DUKW3RL4f4U005aEh/BSXdwoKt4yxHny2QyNvIqAGuuRFwpvo8dtF
	yc4pEM+WmCoMCJs4T/Wed+YDFmcHxqAS6e/2q3MVHa//0B9lMl4bVbpekllinGjwrFhS0ytxHWt
	41EHcby1cegcoKJ5tV5/8Z/w6pMdYsbxRJsvRFvYe8vjiNf07mQB/Z5EbTB5RpFyRZ0YltWMRQy
	mz2Q35i/ayoxS1pTfdVu80rWqgdzZtVHOePtw6iT5Nz8WzYoxNJxRLJlCWhbv0j8Z2lnDW5jvaE
	3W7kFUJq/zRsohP4iK2DXaiZQ+0ZFPr7nV04sVJjw7asNjgnFVZwyT4FbfB0gGDQ5LQsddi4Zg4
	S90OCmQNXthyZTlbTPBBAuwSy/tt2tZOFm0LUKnswdnOmx4wcZsGZUKdx2wLtTbm2SXVDIY4GEC
	uK+fYWZB/Aer/TZ14=
X-Received: by 2002:a2e:bc28:0:b0:394:2b8a:234a with SMTP id 38308e7fff4ca-3942b8a5e7fmr14884781fa.25.1778522096122;
        Mon, 11 May 2026 10:54:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:55 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v1 08/12] rcu: Simplify rcu_do_batch() by applying clamp()
Date: Mon, 11 May 2026 19:54:44 +0200
Message-ID: <20260511175448.153326-9-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511175448.153326-1-urezki@gmail.com>
References: <20260511175448.153326-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces a nested ?: sequence with clamp().  This does not
reduce the number of lines of code, but it does simplify the line that
it modifies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..e46a5124c3eb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2584,7 +2584,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		const long npj = NSEC_PER_SEC / HZ;
 		long rrn = READ_ONCE(rcu_resched_ns);
 
-		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
+		rrn = clamp(rrn, NSEC_PER_MSEC, NSEC_PER_SEC);
 		tlimit = local_clock() + rrn;
 		jlimit = jiffies + (rrn + npj + 1) / npj;
 		jlimit_check = true;
-- 
2.47.3

