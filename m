Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C34A0131
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048011; cv=none; b=iCtfDuHlonMcOYiBLqnWVz59L+gsyZJDmBOppCV4tjmKwhDIy8E5h5xh+lJK34M0syFAkjNScj9CLn7+ZqQcLM6OoG0QOiYUvMRw2mHHwatoOSant/a5rlyaC5ZbVxABwqIZZSifUYde8vNGzbUbLvkf0h1dcIi+ExVjfUYF8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048011; c=relaxed/simple;
	bh=UXHuXOhFDKFisF/9OmmcTV6G79e9pR0bjsa1Y/uydpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzUWfLKoMiVzd+C6ADIqMYwZ8hfmY5yFwr4+ttGbLBRytaVJDOurP7KHzTuD5dyTFFpY24Eoe5MVPC+1iVvXOJ2F+ys26iQMo4aBgtBN0t6H4Q6KRHvWLCZ9Z4hUlxOQjtNyQmxEnY2vc1ZO55dDNvSLJ1AnGnURSK7SwNrTp40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSDi2czV; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSDi2czV"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-478cbd5b48aso1297183fac.2
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789048008; x=1789652808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ugE+BUq8sDK0fNpwmpU6SEIFPEB70ZUCPnwQzu3hcY=;
        b=iSDi2czVrhGIJfpOLi0nmBaNgKP9pAmmMnWokn004OUVwM+Q7YpR/czFVjGO1ufWPV
         8ZekuZaZXBfAWhgBIOu3kJ4NojyD+H/XAdq4pRgtZlqLoEsFDuRkMZQzPhO/NwvjhlPN
         VVp0161wKj4VqvlJvEsbPKpW7cNpr/Gd7PW60bOzcl0Q/z5YDV+Hecqs8H5hG5GBVwes
         fI1ai45ja7HqOe8+pXL3RBvntZx49oLm9BS4JfCNUE6FA/Fum5mBLJNBXu1lRzxDH0H4
         BF+2WNB8ToN/ELp7TDZZttE0rxMjnKgRegy5VzfFIK2cW8OgXv9gzLgiP5cMASq3CjrA
         3JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048008; x=1789652808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ugE+BUq8sDK0fNpwmpU6SEIFPEB70ZUCPnwQzu3hcY=;
        b=mmbGsQmJ23oRBNxUh+LbYk1z8L0zuaS91CdA5E46bvi/Dcpj2TMa8aSWIEZO8mRJL9
         JW+GYmxkMJRSkF8R3fdguNQHG/HxkaxpWJBfrhRvjQpl5AVjJbQadz97V+92gv0Mvr7A
         f10kQl35EaKikGGcQgdqNcv8fluNkYAQn4FH+wiAEGrNuBsXOYkta8q1eczb+DILb3/C
         miWKlMFELPFRKLil7X1+gby1tjhHPyZy9SDtElltyL4ev6UDb33Vf8oouGLHfdqYMQqI
         TQQc1R2Jnru9HbwR2fcApsCOfXVT5Rq8YzyGz8zmfHlZwEI2Kg4qgGM9DWLtrSyqSDHS
         TvtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZBZgBWD1MGYjrYUP9jzo2hmrS0Wy4h2F/6tLzrDOCyY/H44TFSHkUDotW6yEblysJPfU=@vger.kernel.org
X-Gm-Message-State: AFuF++klyk2gP41sYE+t71rVrCNJYXkOErI4tYcgAiNOSaok8AVdG+Bg
	Mnez0en1hcoDnFLgB+4+HM5KSZMqkdAwLP4syR6bCatLd0GT/wLW24Uu
X-Gm-Gg: AYBFou3gaSGf4HOSOWWkekcz0vbjzjGmeZoB7kltKCfjaQ2Sc80Y4Hu4y2EmqWtO+mB
	LVchPNzoCFtdXkFg7f2v2ghnwzG6B3yFy2UdJBuf7m3iY6nnQAYxeE230kj4CuAuYwrWZzCB4ko
	TRgiNu7nEDEhKTCVKFG30zfm4W2wWxrUS9FT1abblC4+d5yOSLVVdKdGNv8sCWea9MZUYMK3Pq5
	ZF521kMIF0xUrsCXryfNNcGGmE/s8Zz7zPUt82P5PbVrKNUZn+/9u+XHHmMutjD0Cw71zAYWA+t
	AE9XFrrb9DlkIa+V3I2B+M/fhQLyLaf8PTtkbbBN5N+YcSJe2qiEfZguBW9jlsMNjVxzyZc7dC0
	k+FCftnYstRw2MYRPzxE2BHpgIEvaCUMq+xcLLaZFgByyXi/sXTxUq+1pM7nuK3f5BRHE5FVvvk
	xEB0/fH3Z8Uo/f+cLeBctJ7Kx+Jh56Q7iDhHYh/lArlcDM15s2LTXbvELq/m1uVN1FP4qk7DtxN
	KZMY5zGwIfNu/6IAiE/kZ+5tWm6IaXxG9pI9s6z2ms3VzHS14GmnmzfUefDKxiDRyhHO9UWOl1r
	8mI5nsaFt5S6yL2CAeOoTRAKz3RG/sgmrCx3D0zg9uaoT5OMR7xwP7/UqYvfbRA=
X-Received: by 2002:a05:6870:d408:b0:475:a153:2dce with SMTP id 586e51a60fabf-47c5239a143mr4735595fac.36.1789048007972;
        Thu, 10 Sep 2026 06:46:47 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4760cec8679sm15256534fac.5.2026.09.10.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:46:47 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Harry Yoo <harry@kernel.org>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	surenb@google.com,
	vbabka@kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] rcu: drain kfree_rcu sheaves from the userspace barrier hook
Date: Thu, 10 Sep 2026 21:46:40 +0800
Message-ID: <20260910134640.2044424-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aqKZXmlRGsmJPl3r@thinkstation>
References: <20260910101112.1648978-1-matthias.goergens@gmail.com> <20260910101112.1648978-2-matthias.goergens@gmail.com> <aqKZXmlRGsmJPl3r@thinkstation>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks. I ran into this while testing bcachefs performance changes. The bcachefs ktest end checks write `do_rcu_barrier` before reading `/proc/allocinfo`, with the expectation that allocations still reported afterwards are leaks. Small objects released with `kfree_rcu()` remained visible after repeated writes to the hook and 20 seconds of waiting, so otherwise clean tests failed their leak check.

Strictly, that ktest is assuming a stronger contract than the hook currently documents: `do_rcu_barrier` promises an ordinary `rcu_barrier()`, not a complete drain of objects still held in `kfree_rcu()` batching. I nevertheless think the stronger behaviour is useful for this test-only quiescence hook, because it lets allocation-leak checks reliably separate deferred frees from genuine leaks.

I followed those allocations across repeated filesystem lifecycles. Their number eventually fell when an RCU sheaf filled, so I have no evidence that this path grows without bound or causes OOM. The problem I observed is limited to test isolation: the hook can leave deferred frees behind and make them look like leaks. With the proposed change, the same unmodified bcachefs workload passed the leak check.

After tracing that behaviour, I wrote the private-cache module in the cover letter to reproduce it without bcachefs. I can publish the original bcachefs workload and results if anyone is interested.

I also found that this exact follow-on was discussed when `kvfree_rcu_barrier()` was added in 2024: Paul proposed calling it from `rcu_barrier_throttled()` for clean userspace benchmark baselines, and Uladzislau agreed that adding it and documenting both operations was safest: https://lore.kernel.org/all/20240820155935.1167988-1-urezki@gmail.com/

You are right about the `Fixes:` tag. `kvfree_rcu()` batching predates `do_rcu_barrier`, and the existing interface does what it documents, so the later sheaf commit is not the right introduction point. I will omit the `Fixes:` tag in v2 and present this as a strengthening of the test interface.

-- 
Matthias
