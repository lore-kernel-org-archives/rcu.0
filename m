Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30153F8ED8
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762989; cv=none; b=ZquThbVRRuV5uoj+iulQuPJSl0iMCJaiLjRoPhWvq0akEzFae9tVfCBoI2RKzkpTAoSNEAGJadqV8HBbAK/mqRhcPCBn3zUOZJRQNMVATOdPE/f5TMFP4YW89XE0a2N0VA2Gy6HMC6GZD5juFkQwKjhlhLCYNVrxE7IyK5f+0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762989; c=relaxed/simple;
	bh=pD03QRjgr7BU5SpMfl5vWA3SVD55yZSCZWQBX1G2H+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxPslleg8qpErJWQuFzqVq0tpudvW0G7lO0/+Ax9I8s3KPM1rRhtESiKDBVFZZgsmQghyErjzveBFDPEQAod9XDs+2CZ7D51rPEiBHgevNjqfJnyZoLwn678xQeq/N9kw7FTFy6dDIjEoFL0bEEcoopaNVJLEYv7WVcQbKweS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6sXoDgB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6sXoDgB"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so2359991a12.1
        for <rcu@vger.kernel.org>; Sun, 06 Sep 2026 23:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788762988; x=1789367788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qWnfnrlWdLKnAvIv1s560hFLdETMMfBpllW7CQBsWdY=;
        b=c6sXoDgB+F4SInfky4oEQzvlmLo3rsuHKRYVYUwkHaWLGhi1G5GIe1Ovo58kpUNMun
         Ox3RtJ/zQ0yVKc/H2ILVIgN+rPcNdnyZPRGgwLlndVZziZEiHKOqPco4ncobJJQ5VmfW
         7bkPlYC7IhGniMg9aFuGZVZ5V93++KZatLIMBbM/KxWsGT9LSmJwXkEwkF4lh638+Luk
         gI7w4d9Pl+523qDDhAAHiGdCZEN7ogvCiRr7fkOBj4OQr6F2NC46bvdR+eBs/mnKvsyF
         hf+3zMC8jdORX6SqaBTKGEFp70EFsf2WVyE0zU4XAoxxPt7jNRztb9gujbaHqDfiQyGD
         kY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762988; x=1789367788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWnfnrlWdLKnAvIv1s560hFLdETMMfBpllW7CQBsWdY=;
        b=SUIU4w46PkMx9Yz4rhwXzcVVkwRE5pvc/M9fMPnZArWnNxBUxfnRKEVfTfRRVq3qLD
         zopm2kFQdrbnfIyiHGIQavk42Y5mDRhzQCSJRR7iejcnN7HnxMWXoZYWjVIIZy+stzKF
         qzStvpmgYqtGOy1eLdDxzma7qhISaXX9KLJY++KxbRKLNly0sEst2bW5gMRRnE9LUPFC
         rsQdqhRmc1kE4rg59tAVvpsIPuD1feY185u8Qin5S3Gpbh6wzFGbcDyPVy4OzD0kn2lU
         WuLiYbG6kE1dtCnluo1UUejK/tjr0lfXuk4Ldt3gJIIKEBE3YoTjkou2HfdQLWlyCdje
         CNxg==
X-Gm-Message-State: AFuF++lvikW0ooYhaqeaExzGVx0ZNANBxIM8bDUwEuAVFodtT7rwlwvu
	LdzyLpWBdKlAaa2cA7kOnCpPCdEkMwyifhRFp68f0fZ2IvOT9LNtDGkN
X-Gm-Gg: AYBFou3x8jrBbrvOx5iJ0JcefyPLSiKGTI2ynfyJznIHKPxsHXy/JdOy9/BxHa8FOKH
	XeHgrrwwxo9C4hgjIHF/kCmmmPe/bbC115wVFrMDS6ixZwg/G5Rxbi15grh2Y1dO7ky79cWxBnA
	37BzXNDXG9FAOPyaE6rMcTO6zSf8aUq1Fms1zRR2KnEquuV6yjWABtqjrBzIEI8tQFxZGCO+7wY
	gaBrCoUeJG+rcByN8410cbSGFVZ6dH2t58AZ4mLl4hivqRx0hwd+p6o1pph74K2MnxyphvUEpT+
	4InBgnxmMjJDO8rmDpum6a7CLotHJ1qyI4j7L9hJm8PfHywslSxVh0HkJAhMzy6UQNRMRTWpj7X
	YsdA5/lAbGli8olPtebbx4rROYWNu7zdh0Rp4Z8NEqFu+dhG4XoQmnZrjObs4bYE/bwDugiSbnX
	h26+dsXOPPnlDL874oymgt+NXhUQTuaxwA38PpZiHDNhGmKk3DH1q+VNm/UMg+MQi0HYfyOKm3i
	JMkxinkehUAVw==
X-Received: by 2002:a05:6300:6708:b0:3cc:eea9:f757 with SMTP id adf61e73a8af0-3da3a00565emr30434532637.16.1788762987982;
        Sun, 06 Sep 2026 23:36:27 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm24675937eec.12.2026.09.06.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:36:27 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: fix typo "upto" in comment
Date: Mon,  7 Sep 2026 12:06:22 +0530
Message-ID: <20260907063622.24824-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ed204b3f4b84..01f19bb17dd6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -624,7 +624,7 @@ module_param(srcu_retry_check_delay, ulong, 0444);
 #define SRCU_UL_CLAMP_LO(val, low)	((val) > (low) ? (val) : (low))
 #define SRCU_UL_CLAMP_HI(val, high)	((val) < (high) ? (val) : (high))
 #define SRCU_UL_CLAMP(val, low, high)	SRCU_UL_CLAMP_HI(SRCU_UL_CLAMP_LO((val), (low)), (high))
-// per-GP-phase no-delay instances adjusted to allow non-sleeping poll upto
+// per-GP-phase no-delay instances adjusted to allow non-sleeping poll up to
 // one jiffies time duration. Mult by 2 is done to factor in the srcu_get_delay()
 // called from process_srcu().
 #define SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED	\
-- 
2.48.1

