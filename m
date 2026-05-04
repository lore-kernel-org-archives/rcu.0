Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762DF19D07E
	for <rcu@vger.kernel.org>; Mon,  4 May 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911360; cv=none; b=q+lqDknB1jFixUGrwfKfvrcBE9bJvbfX/2xA4ccM29W0yGtnqHQ4EcARMiGLhDHlCkKRrOMA9Bu88laUpbLYJjvINHkEjZLeDkfsxOERQuhQrKaZP+5RkNPUzy8xxXxlMkd2riv+eYrnp4GvpzxvwWs8HxBaXsdqgjyyfmRELlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911360; c=relaxed/simple;
	bh=i2uTmw86oe4Zld1zoLl+oRVsiZdNKvagpwGiZa9Pcz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIO8b/i3j7bPScTAxi9gutxP4WtVBB0ZCTWtFsz2AqaxDUqDRjD4Z12Y6bVzoMbYoasVSYL81/+aReUsgh5ih4JfGL3IkiFKp43ysUIUK6V3aQskaT0y5R9qYIqsGpPheERuCWAkokJde7m97kg7njh51BI61ux7yeSFBlU8Ycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOSkzmlP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOSkzmlP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c802803ac17so529088a12.1
        for <rcu@vger.kernel.org>; Mon, 04 May 2026 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911359; x=1778516159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQLIOStAwhgu/CxvIZZEBshgUUBWgh6WL45RaSlH8Fs=;
        b=UOSkzmlPBOvSpBcfndMh/N5vrc26XM/V7ULLBzPAJAGH+g15cBoBC8EGTxPdj7BNzS
         Y8KiA/AMJ8lopQzwyA5y3fkeUQcGqJaGhzv64xx0ZmiYT61ydQ+9DXGUKmt8ZOQx+cQZ
         4CIT+AgQgqi7Xm6I5NLL+o24JpQYOPcUz1uQikrbCcmVG+7vAiSXYIdQDPWFbYkP3nfD
         mYon4n4rLTu6LUcDz0V2tx6iZgzL95RmodWT80XBRhMFuV6s8vzXiDcFMp9nKTByXIR3
         jL0C6hhbi5dKSbbZQ9M04wcgpEIVg0cWZUIGgpwljzzcgdmUbo8gVEexBzBTUHZNeqn6
         lP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911359; x=1778516159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQLIOStAwhgu/CxvIZZEBshgUUBWgh6WL45RaSlH8Fs=;
        b=ifD1nCW4iGZi/uAYXKbH19aaWxntXPQK59A5F/wtecK/eIVHvdBxJb24p0x3gqD3AL
         w/CP+7/60iEYMEwn+9DHTMW+o8+aHbJG+AYpXi+jxIsM5V/cH0+BnqubVbmbIvLXf3gR
         l8g7uegBtdiQEaJ+GnBQy77e+2iU8BccxrGnu9iL07wXuBoLl6KWo6/xlSsl3TrPNrkd
         7fve6DVvGguYSpHHuN7MD2LaxjQhBPeBSKogNeJE4ZdpLFzFhCFCDMsjkCHqrZxONzdx
         OVlstTCZ6g1OpPvhVFKkEFG1ijMIzrmIjJH3o8kZQ4zMrgGFLoJ3be8c5aAOiSVPW7Yz
         HNOg==
X-Forwarded-Encrypted: i=1; AFNElJ8ri+KsWKMuxFsjm4ZNM+KSLhLJs8HH3ZtS8GzXcPi+cTFT73FKkr6+1hRGi9bULzzPeJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwU+gj+Ys3c/6LnPtd6Vz2uPOCTQA3J+nsEyZF7wl/VtsWXOD
	h/kZB5HNJ+uR9ZzpLuhqUfc/zcgoMgrOEwm4EU+9V9QO05PYpEwINjUX
X-Gm-Gg: AeBDievZxqxjVRbXbWJMtFbgaDJtoq8rPB8I6YGJMGroWArTrL6x8pUl8ShgvUqZW21
	dpnEa1cxE9C7d8rtpq3waI2euoqr6FIaMvEPS1u54cA+UlOLvq9/xZmyInm5KgVV1gqpyPtp1Mc
	IchVPBQlUhYetcJM5CtlL5NtUKqyIxyLev5eag2BIis/JhDCko1MS476tcD+y92FXb04LAGqC0B
	hmseErDPWE+ozoCAEL4ULQiCuh3tJFZ+H+lv3APeTxVAgw+yPIKeYOedgScnWCNrKZ/aPkrBkIt
	7mYU/e6CZaTAIKaeRTE3Cz7SQjxjYHLE3PPuhKSItfQbuGo3IgUlLmUEBOz0a+uT48oe3DGvBLW
	vNSUuZoQYkBFM7e5fx9Js8uYxHGy44lCUb0m9BqgJ8emlGjp2/Xtp2lwmFAeGuCgANjqiXgZrL1
	JvwJ4IVSZFC9T9D4MRjMQr8KQnpGLv8XeWTKihGKe099DHNUGnwY0g4G1oNWxoKA==
X-Received: by 2002:a05:6a20:7d9b:b0:3a2:c685:f9b5 with SMTP id adf61e73a8af0-3a7f1c9b8d2mr9695990637.54.1777911358648;
        Mon, 04 May 2026 09:15:58 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d123:1fb:b1d3:aa01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba4ccf6a1esm2385745ad.81.2026.05.04.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:15:58 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Tue,  5 May 2026 00:08:18 +0800
Message-ID: <20260504161543.674488-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up of Tejun's suggestion [1]:

Patch 1: Normalize "on cpu N" -> "on CPU N" in the exit dump header to
match UEI output style.

Patch 2: Fix exit_cpu accuracy for the hard lockup and RCU stall paths
which were recording the detector CPU instead of the actual hung/stalled
CPU. Touches kernel/rcu/tree_stall.h and kernel/rcu/tree_exp.h to thread
the stalled CPU through panic_on_rcu_stall().

Based on sched_ext/for-next (88588854c283).

Changes in v2:
- Use raw_smp_processor_id() in synchronize_rcu_expedited_wait() to
  avoid CONFIG_DEBUG_PREEMPT splat (preemption is enabled there after
  nbcon_cpu_emergency_exit()).
- Link to v1: 
  https://lore.kernel.org/r/20260501131521.161852-1-yphbchou0911@gmail.com/

[1]: https://lore.kernel.org/r/e7cbfc99b52b4b7059267bb81498179f@kernel.org/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Normalize exit dump header to "on CPU N"
  sched_ext: Fix exit_cpu accuracy for lockup paths

 include/linux/sched/ext.h   |  4 ++--
 kernel/rcu/tree_exp.h       |  2 +-
 kernel/rcu/tree_stall.h     | 11 +++++++----
 kernel/sched/ext.c          | 16 +++++++++-------
 kernel/sched/ext_internal.h |  2 --
 5 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.48.1

