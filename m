Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353946AF25
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522100; cv=none; b=p7Or0xmlBTFQdAuBM3bF70O0XrbulgQvErKakIYdrbCoVK/2Tr2RKuN2ocoxqLYlteyYdLUrPA/42PkFnVv+aRd7NlW05qT+yRAJ9qx92YDdRL4Yix2JWAUv1ivySu3Ai9Ze+No2fke8B6MPmUGxnVFgbHdkEA7ElMdxl6bXfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522100; c=relaxed/simple;
	bh=fWM441cbSLZxfDsFxOgkHb2BPMc6Nc/hi4JixQXl/Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIlD1IoFT4yNqRp/mxyDIp7qXkHQV/yxHxamk9vIn4SEHxrgt+F5o5ZVx2fFr/RedA9ipLJXtlCMpmmJm3r3r60VlRuzCR+J8a8xfIY3LSbsglr5UmiWilf8lu+SZhOhRva6Rx0S+j+RPT620/8wNqCpAPNwEVR146xfUj4bh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1t1FMdQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1t1FMdQ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39397d63804so53826881fa.2
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522097; x=1779126897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdtDTcHWPpFzW+rLnvoZdux37/ChPi6ZVsH5L2zj1aY=;
        b=h1t1FMdQnBwCYKn1TNMBkk6RRyfAzvF2ZKdzFgfwCwF2qs3AXNa3s6nd99rvgypG6l
         /dWLrzoYerU1jDDyKjYU1Px2qrTdGOtrzxDRV/Gxjgw00Xa3ZiAVozbRF/OTOTMl/3Gh
         abqkfwKJb2GZB9KJczHt9SzGKAZ511d4Vub3/FiCT4rOZoQbnYBh6P5T+7XBgqGqyQm+
         L7GfldTJONeHyaWKBSpDq67W0+JSyNEX20sh06nRgwWm8rD2UXgvj9CFrO1KaNxtx6yG
         a/nqeNPqFSIHvs3RSegvPxO74LKMBmwcH8+jANIhh58eoFpSd/wzlWsjiO6Ha6DHlCxI
         wA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522097; x=1779126897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tdtDTcHWPpFzW+rLnvoZdux37/ChPi6ZVsH5L2zj1aY=;
        b=bvKmtrtPWbf60djU1+lJwX57Y2hcFmzeJwoGpmSK76/+UVCEV5KCVDiB2DsG0LHQN5
         QxHKUPzuFm3AjPv5e+kOTkvuYq5+Varm5r5M60MRuWnk0FdcDXNObehXwW+07K3TDOEC
         1kvv1tp4xPKwUDrR2MtnDj1+IpgVpjBQwEYmkdlrz0ZJuLBMhKQqz1QYAKp+StX8wI7Q
         M0d7L+TUEFdk5eIZUBBfMEJBGqVOitFtibpHhvlzR6DbSM0DZ5VHQPtbskZ3oHnTU+dh
         CQs9+TRviAU9mTL40evGyDECIR1bjjgp8x0EyvCwLFjXz2xgX1sbV5Dm7ElzJe7ogMDP
         JI6w==
X-Gm-Message-State: AOJu0YwHhXR+h84rDvsKUY43aU/aSF1pHQNmHKc0wQYRuwuTIZjY26ZP
	aaXTSgLtV0KoItUCCRUA+Qtw608TY8+He4gHgtJgjBMG1VDksw1WsuBc
X-Gm-Gg: Acq92OGADAo/T5xULr4io3YA0H4/u4NQHs1qrW03prW+xh4qBzA80uGnIkBl2I9df5x
	UbSovjKPUxW0prajNK1QuugfSTjNQ59TQIoFYmhNx3brvAkFCYtgxlDKZ7ang/7T7/IWa+RubQD
	+nrlHHkfFs9xP9mx86+NNh9thpaqnjZQSKb3OpMA5TlGeOcSvzbnAqXG8q0GrkhkisUJ4ByRkEZ
	Rfgx5oSkH5NXaoZL8hKNHcIY4zsQIxKNixpFczjRE9/EeYK3GXrZ/Hl2fwrNGfU2VdL0GijBM1Y
	HXqSRrTZJk7GCY5Nwwj8fSBoSfYtLDFoUOdeoreCr5wbeyA7Yc9FhFhoHq5cy+G5FGFDVLvVLvg
	YuKX/HXgq1eXBg9Hu/hPadwYOFAsKJ/uR8Zo86ArxPPZUNNdeXHIK21axCxvlJRK1/kE3GctmCp
	nq+Ik4sXZeG4AwZroI3syYyNYMiA==
X-Received: by 2002:a05:651c:503:b0:38f:f8f3:6c58 with SMTP id 38308e7fff4ca-393f4d1cb99mr48232041fa.11.1778522096884;
        Mon, 11 May 2026 10:54:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:56 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v1 09/12] rcu: Simplify param_set_next_fqs_jiffies() by applying clamp_val()
Date: Mon, 11 May 2026 19:54:45 +0200
Message-ID: <20260511175448.153326-10-urezki@gmail.com>
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

This commit replaces a nested ?: sequence with clamp_val().  This does
not reduce the number of lines of code, but it does simplify the line
that it modifies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e46a5124c3eb..09f0cef5014c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -492,7 +492,7 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	int ret = kstrtoul(val, 0, &j);
 
 	if (!ret) {
-		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
+		WRITE_ONCE(*(ulong *)kp->arg, clamp_val(j, 1, HZ));
 		adjust_jiffies_till_sched_qs();
 	}
 	return ret;
-- 
2.47.3

