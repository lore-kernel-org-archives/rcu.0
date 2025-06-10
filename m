Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976832417D9;
	Tue, 10 Jun 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576898; cv=none; b=N4zIAqvfXE3oJHQ6kwhmYzznyisXLCCTR1uxCTJfjiHw41fZcJ3DvFf8eaEp/JqO8HFJGSOF6lwR0s7Cqj46gDVA+FCNkTLi3ZgG8BhhttiIUEISm1BmRo22oYny3/YUcS0M7y1Lc70FcqV8RcOwtCLCs61gx3EbP+M1V6PncB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576898; c=relaxed/simple;
	bh=xN/2rqPfGxSMoZKx3wHgJjAtv2TwdbNnTpb/Vgb1fV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCfn6QjVIf0cOSNvR3oH+NdOvbSihzsQ+i/egu2V9FSFyS/zCxGZXkf6L2gjARhny5Q9AIlsJv49n7UOwc9tT5Ix3VtwkA/42USak4TrWzFcaZdcrJRtMiU/KXP5AUxFAv4LRpxgAsiWqRFsm1seBbeWWNP/lohHgTT6QgMzT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDSOAgYU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDSOAgYU"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55324062ea8so7437567e87.3;
        Tue, 10 Jun 2025 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576895; x=1750181695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+yX5lUpmefac6IS4VlNlP6XUmszyq2kkQqjyOpGbSM=;
        b=dDSOAgYU30hsESWNzObIhMHwtOzTxD1O1faQlsquEjsACtfGmEKMkbqSQ27AUms5C4
         rvYY2/f4fK+ukqJnn62hUs5/m5WAYH0SrirfetCkfOtnBhldu+V2KNyLonn95McVfS9V
         q+civD9+p2FsqHkeNIXDI4fcsIrKA2Mj3OnedqWEHkPkRC2OURbwh8pQnERQjruEbgOn
         fvdTK97bxBPowLIttzBphYsRHxCBxHQtyy5i1DRxG5bfy/I6jZXpFfeu1GIyQtBvK4VG
         UNaS+JA6C2/4WCZtsyGu1vpTH1JqDbglutCdMLoI7o6dXXgXmGlkILbbQUN1W+4AMo1w
         gVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576895; x=1750181695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+yX5lUpmefac6IS4VlNlP6XUmszyq2kkQqjyOpGbSM=;
        b=BslEygMttJCllfFgSI4y0leChZ98WWqZfAmF8/CToc7NInhzUHaATDh68KQh5DNFNo
         OJ91r0YC23ey/DFpuRHo1wFe91pU/GNgBGVEgZB0JKvPcd5NZmpSNuL2IvgppMRDvgUt
         uBjBWlu4M4C/71Fy2DeKeXSht7sj5cPrlnaoessmLZEdU+bsCQuO5/dQSmvbtdB0jv4y
         bZHuRvQnEf1QU4YzLBh74uYdvI4FU/ljJ7aiTRHq51NpDGDd9ElOMnkFYnZjsV6A1d3y
         zg4hsejhhcQrLnpHp4NkEmJp/GE6RXTtVHEHLM/nHUGH30V7VpzItNMlVSPS8n4CaVvN
         +Xog==
X-Forwarded-Encrypted: i=1; AJvYcCUOHW0PWZOY6+8KBOUGTwCWFMtFFBHtzzuRULCteZtqJXyhxzoaMi0GorUew00ObJftX3nV+9LbBUNNsA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQqlEeagcNKWjIOd1c3Ww159HFo87x08VmLqCk4mkRX4JmQKI
	xzavrnfg7uJD5QY2fqGNhmu6uiKWkKR+hrtuOz4v49SO/6+swVQ0030r
X-Gm-Gg: ASbGncutH0OdXyKsuO2A9n4tXsr0tT9VS+jflwZ3/MVyRfAKNYPK5Dcxl03p35k/6TB
	4oWqK15KqidgE0ttL3Fxu5OD6DOg/Fw/N4XNJR3jwdlgLMqaxH6FUCp2QoBO/bJnezVbKkuZvnt
	aDsF+I1MsEPs+agnFG9MAeghR2PdrLhD4/qi9XhaLRkC+x4IfClQuQrNRU4VLldIpA+YQoiOl9U
	AaYkNDWWEC6G2Kdti+12vW98ueIpGag/61hF7sEof+3JvEwh7lxERBxJKtAX0tPBOlRL6jfKcLb
	ept8eIHWMqAXxqeKZwpJQDdrWvTEjhD9Y8heAyZNGueCsMwlTpUxATskug==
X-Google-Smtp-Source: AGHT+IFyqqFVjAvoPkpv4bcqgRQaW5Hy0QwPfsuKcX19JbSicIIasRNNnKLJtTDhRphfT9J9zpt2fw==
X-Received: by 2002:a05:6512:6c4:b0:553:2868:6358 with SMTP id 2adb3069b0e04-5539c2194aemr150205e87.35.1749576894427;
        Tue, 10 Jun 2025 10:34:54 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367731754sm1624829e87.200.2025.06.10.10.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:34:53 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 3/3] Documentation/kernel-parameters: Update rcu_normal_wake_from_gp doc
Date: Tue, 10 Jun 2025 19:34:50 +0200
Message-Id: <20250610173450.107293-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610173450.107293-1-urezki@gmail.com>
References: <20250610173450.107293-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation about rcu_normal_wake_from_gp parameter.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..a2c47bdf75cf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5485,7 +5485,7 @@
 			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
 			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
 
-			Default is 0.
+			Default is 1 if num_possible_cpus() <= 16 otherwise 0.
 
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
-- 
2.39.5

