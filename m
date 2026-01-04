Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F52135D7
	for <rcu@vger.kernel.org>; Sun,  4 Jan 2026 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767514235; cv=none; b=ptOUVIln83Kb8oBKkqBaGjzHiQCG5yIEAllGroZzN3D6zBrSBAIVeM4Gh06kxj96VF9AF+lS1v4ItA7/CqZvy6mb5z32wP/Lb9dVl1xkRaW2zflTmeA1bubMWnuDxJAxm9NjHIeroJtif2iVHTIijcEgn8vCj2pD2b2l7nI7YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767514235; c=relaxed/simple;
	bh=7fPyNwdhjUZJPea9dT33UvcMTmQd0D02kJlNBS5e7Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PIlofT/YOv/lIChVEoNue2CWAOure3AKnkuMTNd1/arPe30BBfDzwf2jhmL9MxeKYmsVn4uW3KeIYjh1H7JVDjwhR2+N5nx7kIPv4WOYqMaYY0W768O+Z30FA/l+WYRAZkHYBvc6u08Lrw/5iSD1A20l6ekqKDSA3YjLUtTPXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTZpukVr; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTZpukVr"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso14470811a91.2
        for <rcu@vger.kernel.org>; Sun, 04 Jan 2026 00:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767514233; x=1768119033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy4HRP65OXAZS3GE4LwzHNRgGglswwDVwEGpz+G+vMg=;
        b=LTZpukVrfCtirAFrdd46b8JGYqZxYx5PThkC4MUC6yDletFl8RD7myruhVFh4TAmQy
         6dV1lhcVVvSWIMbuTHe+aBjSVxcPx2DgxQiNZ9X0FBgFWMdYIdetbhJmg+J3T2L5S1eT
         rptindiZ87alBIt5e7BPEldBtkXU0KMXlQAHgbndLpwpRxgYvtTm53uR8aUqvgHIDHxU
         Z6J7WW7divP/L83WfcoZvXSxgHjhWEZoxZUOHXZVt0z5s1aN8GL49aSXdJQbojVN7opQ
         GSQmAUK2DNmfNCKIBzZmH3bYNYL98czTxxxeg4ZQErJB3PwoaZWYU9eHoDuw2CwqeVIV
         vYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767514233; x=1768119033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy4HRP65OXAZS3GE4LwzHNRgGglswwDVwEGpz+G+vMg=;
        b=clDFaP7MxoTAVGmWEpREi5y+FNdbvfxHkvyzzuK992bPTiAtjaDGbZq2Bu9x6zwxR2
         K9UnuJQVUDMRacGoLQxoHGcrIrjwsY8DIKCZaVFvxjkdKpRP4dgwcPlEGBBfCHsm7FOB
         NPwnb/4FVTFPMIYN4qaewR7PhbJb5dERNt4W+fO9U4v7wYULIr8AVw8qtw+vxR8qn+MM
         6Gaatlg04hMHRKYvF6wFuIvsYKHW7O6835peq7PAlqjVtHdlpG7mTt+zus+Uke431qq+
         5k3fzKWHcUJFUGadEcWCk1NDSoXDPDTsMwboDpYTfozngKxB8i03+ULurtw3sElhPSJ6
         1o9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQFsBTrVVHE3aKFfFZ+s21Z3oPndGMR7aTVlVgvQD5DaGWhXukBIud5x7AC2G5M8dAZHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/c7Q6yc8woh/nVaQBI60Z7dJB1HH5xFGRPdPg1giCsT098vg6
	Kn5/G7d4zL5Y3LsbTM3DcQqgFdCMMPdkUnmwXtIGYgLBeXp2od+JExe9Xbjq0FTMKDXAdg==
X-Gm-Gg: AY/fxX4JIpNsVOMMwlSgMxo0/Od26dtQLN12mWLvfb+cchdaoQV6MiFx/h6shOCf3QR
	P/bTmC+nTVvcX/27D8aHv3K1RKoZXjNYmeJ4DOozgfidc3YeR0HjNXONh4nP6Yaccw8wiwmS1Yn
	VQ3UU+apMY4JgGxYK8ww0Hgkrl1cPltLVBoiXbZ2e+TpruWo1TYqdCUrkqTZdbZSp0WGdEKWOSC
	RGX+JvIAWHDix29ZbjYQDD6K3KxOaYXgemnIl5EhQ5lP6DyRHFkpSWk4SlbSN3vNo2Gunfc6Tzn
	JB8oycgGGUeXCwOcgk9mhBmX2rwKIJuef1QCC2MSqkv/RziQ7HCig2bgEOoy9jMy+JNXA1TxK72
	asb0Ur8Ihna30dAvviCrj9aJ7VoEmrzBm2GMN+P0X7hsuZth1S952z9JJ98bGCaE+qRc5YSWgHq
	rxtpz4ncTU9beHJndjAFLhTEjiMYw=
X-Google-Smtp-Source: AGHT+IH7/mWoVRhoQ7gAa9ReyC7BPgeznqb58lEeAx3WJFOBrk5AZMwSIj7TrE6o+XeaIT9V8ZpliA==
X-Received: by 2002:a17:90a:dfc6:b0:340:d1a1:af8e with SMTP id 98e67ed59e1d1-34e921e60d9mr40794509a91.37.1767514233510;
        Sun, 04 Jan 2026 00:10:33 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476f9f8bsm3295145a91.7.2026.01.04.00.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 00:10:32 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	qiang.zhang@linux.dev,
	rostedt@goodmis.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH] rcu: Align stall warning 'idle=' output with documentation
Date: Sun,  4 Jan 2026 16:10:27 +0800
Message-Id: <20260104081027.189234-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

The RCU stall warning message includes an "idle=" field to indicate
the dyntick-idle state of a CPU. According to Documentation/RCU/stallwarn.rst,
the hexadecimal number before the first '/' represents the low-order 16
bits of the dynticks counter. An even value denotes that the CPU is in
dyntick-idle mode, while an odd value indicates otherwise.

This was accurate until commit 171476775d32 ("context_tracking: Convert state to atomic_t"),
which merged the context tracking state and the dynticks counter into a
single atomic value. Consequently, the value printed in the stall warning
no longer directly corresponds to the documented dynticks counter bits.

To restore consistency between the code's output and the documentation,
right-shift the merged atomic state value to extract and display the
correct low-order bits of the dynticks counter.

Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 kernel/rcu/tree_stall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..d25cc826d77a 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       ct_rcu_watching_cpu(cpu) & 0xffff,
+	       (ct_rcu_watching_cpu(cpu) >> ilog2(CT_RCU_WATCHING)) & 0xffff,
 	       ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.34.1

