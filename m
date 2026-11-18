Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991945;
	b=o7YdlssA3tFxdKdxzu2TyTdxj8TxYwPbLqNyl61Ua+cZJRMGHuihEHv6joudZS6G+47B
	 TeL/0NF5+fKoqOxHABU4LITDqOr4/hr52duNfD+qNFapbuRFFSTKExsKt69vVlSKxNY4F
	 p2Kc6TneuTZZxQbasa28B5XqpX3xHj2fiRaG6rZauiSCmJCoNRfTwJTrnRHRAd4NSsBlN
	 kh6okzIIiO6z6FHaSRbmzMjNNN/N3UKFAZ0srKZT7Ptf5e+Nkl6d6Ws2xtCq6gPQ3txXK
	 r09/rPK144KgHSav8Wn+xz7fZZIZSmiGR0S2s1pXGpUjiluibQygCGXc/flCiTNsOOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eZUgNvRThSBkygn279XE/ZK5ImQQ93aCcXD2XI/JzgA=;
	b=ZCw57RI0bFSXFEFXMcBuxKsA0qlKOiEc0PjwYeqZ1sU4WD9auzcIv67QujY1kcb0tjM1
	 6n+bN2MlvzOK9QhXgvqeImZff0Vu4I7RyZI9gUCS6/iQWxEFcfM4ttUrldHDj3QjV7Okp
	 wRsadbaS/Xj/nY2C4ApZVZ6YH0FGcNvaRQjsveLGF4DOuntWXaUSm09dzj1WBlOVvLmyV
	 tQ6i46zsMW3Xj0YDVin6VmHIgZCbHC/rnTvh5KpxLYsn2R3hUhFCWwhzZaQuGBW165JpL
	 sHtHcqUpfCtLFYBXR2roSoA1KVIFPFXHnWO0u5zpsdVe++8++/cHHsqfHSf/0mt64uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=He9IaW+M;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F9606A31C
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 08:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B4F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=He9IaW+M
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4d21051042so102006666b.0
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 00:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991944; x=1795596744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZUgNvRThSBkygn279XE/ZK5ImQQ93aCcXD2XI/JzgA=;
        b=He9IaW+MibL+q/d8FrlanbAiok3rByNCBQVzaihfOKod1yX1q4GUBOpKmwNRIjJRTM
         xqw5ELx4J5BDIT8DeIxu3RHEGEGJC63ipJhyPv/BzEoPVCh0QOuRZe/r/Bzl8+bX7Eur
         ADFWO9IcXU7ozunE7frmOJ3oDWqZ+QnpNulWT1D0Z8ecl+R0TGpmeGjAf/HxzO90hMNy
         7vjvXlvQNnfF0MBEgvKhcK8TkWp64l2yAtI4/Iw2du8kGWem0txt6naabgdMrs/4ELFG
         HRqgTfO2yEPA7FmVaB+VoM658abNZfYRGLmC+AV2bJO/5u0CdRsBwEPuNtbAu7miiFeT
         LTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991944; x=1795596744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZUgNvRThSBkygn279XE/ZK5ImQQ93aCcXD2XI/JzgA=;
        b=VxYFm2/6tcjY9e4GvsYEmed91sRbD/ASI30neOElplJSoIjEYGb9RoiGnG+zgnz1j5
         6vwWXqretCwswH2xKAgBD3zSs5DiLqpmVlK0TNaci7skK5/F8WdUF00BDfRrZWk8gzQ7
         38S+xCZH2AflGVQRqC+9Rigg1US4Fv+uyis1M6+GGl1iR5QVrTVkEMltX90y5MC0rH3a
         l4I+78xd/0QYDNe2gh4OvsfZJlGp2AjfQHDX8xUJNej6e20KM+GCizcxuSZY2EVTg7R8
         AzEf7PS5wxInueS5xh21KnWmc+c7WIlLNWFN3z855T535fqd0pe4NkycrMfouggQqePc
         jHRQ==
X-Forwarded-Encrypted: i=1; AL+hErHCKcboEPxDzyZKq/yFj8xhYjX5emcRq/wvYmW2KJOppN14oheSri0yWRraW7SQc8baux8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qZqoA4+6te9NfOkPnULsfFHJ8TwKZQEf9k7SjJc8dGDnrzAOX
	sUBW8quq1sdyvrQSmDLC8BG7hG/uhHrEUFc++KtS+INUGQpBaLjBlFPM
X-Gm-Gg: AYBFou3ft9//3wCo5CpqYcl8ITqKra8ci8kX5KHeaFkOpO+B38F8Xx3YWMXa9aXRjeh
	4+YQ1GA6SMZLhe59g6enVCPHyyar8DJq6efOU1NW2FzP00RIQwUmYsF8+IGuOmIwr6fjuUCA/Pk
	sfj1kb9DWkvGEeWUZENPlrbrFgv2Wn8c2Qf8ciDgGNXZb6tiO+gUmXMLjJR6N995nQrXIucWt4M
	sKzDQDH4wJcgOxNmP1xqiGmEMRMYJCJq5WpPktq7PzvPg/bitW6LFi2ZVBiqgfC9B4MVXMGE4xa
	b2bKpb1dyXACn+jr58MbY6vaIuDUyiVfM31XjdERq3WY2qLaLZ/R4uACctXSHiMxtpo5DpkhNUD
	jn/eV2hjDpw2Z+LS1H9GGz52EDA6NsU6ts3cMqdHisa+oaB3S40I18h+eB5Bu7zSYLRJrH1FsOh
	XmeLX6k/RtvRbKrEtNJ8x7hOw1Jf+8zD8De6DeKYUuZvYr+CDiQHp2NXyTsnVC+tk9QEplB5r74
	bU4xcXKNJsY2zYyNVYD/DmZWrh6Mv+mhQ9w+xv6dij+1KQaVjPxgEGT8Mm5rzIFENElLRn6qepk
	wEFzsh+0YFUhzjG7HgmCJHoClQA7IAvj8UCl
X-Received: by 2002:a17:907:2d9f:b0:c4d:5820:325e with SMTP id a640c23a62f3a-c510e159e89mr150966266b.13.1794991943191;
        Wed, 18 Nov 2026 00:52:23 -0800 (PST)
Received: from kernel.. ([191.40.25.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f31csm71077266b.10.2026.11.18.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:52:22 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2 2/7] rcutorture: Require debug_objects flag for debug-objects test
Date: Wed, 18 Nov 2026 16:51:42 +0800
Message-ID: <20261118085147.1668598-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118085147.1668598-1-kunwu.chan@gmail.com>
References: <20261118085147.1668598-1-kunwu.chan@gmail.com>
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

rcu_test_debug_objects() checks for missing callback and barrier
operations only when ->debug_objects is set.  With the flag clear,
execution falls through to the test even if those operations are
missing.

With CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and rcutorture.object_debug=1,
the trivial flavor can therefore call a NULL function pointer.

Skip the test for flavors that do not set ->debug_objects.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/rcutorture.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 968343be4e0d1..caa550095705a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4603,8 +4603,13 @@ static void rcu_test_debug_objects(void)
 		return;
 	}
 
-	if (WARN_ON_ONCE(cur_ops->debug_objects &&
-			(!cur_ops->call || !cur_ops->cb_barrier)))
+	if (!cur_ops->debug_objects) {
+		pr_alert("%s: %s does not support debug-object testing\n",
+			 KBUILD_MODNAME, cur_ops->name);
+		return;
+	}
+
+	if (WARN_ON_ONCE(!cur_ops->call || !cur_ops->cb_barrier))
 		return;
 
 	struct rcu_head *rhp = kmalloc_obj(*rhp);
-- 
2.43.0

