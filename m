Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0643D51E
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767969; cv=none; b=CyhzeUDIowlMmNkzk94NNfoeR28kgqe7A/+rTIISLgP26kaXmt+DX7/Xcj4L4pIrSOWTIBkavZQUTRRaShZGwFnQBu8YjwP6YcEs3A1UkrmAlLfMoB3xEp2/uxB2/HBDuPtWvuAhMOdnUcUnx75RhwzJdMEKqR1R54/uL6PcziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767969; c=relaxed/simple;
	bh=CY0SGZKkWGBgKFAKz+DqhuTW6aotEarWwAXGLJcyfqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+uOCIbyLKCY73quV58Uh/DzbUiA3XHLhD94tuWpUwEEHkMpbbq4FhWUNEuorF4WgfxvhnLNxhGqVzzb5qZMYMHsZzoCa1DND3V313bquSDT1QIWdDB+pyRxyFo6D/wElMIkS0Y5tjxCsTnjZfCZt8K9qkRDj+k4JpKG3U/B+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlczcLJ/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlczcLJ/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso28498775ad.3
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767967; x=1789372767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rknn3+6TS+aLNZFIltiGpSi2IYKIP8ZCdc2t7DJkt98=;
        b=ZlczcLJ/b25uKxe47Zb1+5Rr69MFn6lsDS07k1AsDeHmvonMSHsT4ZGPO1SIRaeY+d
         75Usme2oHOuM9FwevXhlmemtMQ/Okrgz2JsdnRq1IJZXOMx4Pg3d4KjO7g9QC/tUDgQK
         /DAMmXuKV2dxO4YGaIX7Cl4DETxCN0d5Q54x3vqR8r6C9B0Wx0JbknmG9LDgdYaVX0Ht
         93GS6TO1mEoIBlRDY0csiZvOFtbQWZmEdF1pfRkXtwb+dBbLfygTql9JUm661TbdgrRc
         3qMZ1y0ktCEKRLoXNd6//wVADz/GHgUOJdZp5B8vn/AYjw7zLzs9+4gJKlToGwUY7XHa
         0xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767967; x=1789372767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rknn3+6TS+aLNZFIltiGpSi2IYKIP8ZCdc2t7DJkt98=;
        b=V/oB3hqJjFLQw1sLkhKUWQS6z3iTA6OcInNSYz2v1Osj4J4u8NP4Cv9ckqVEwE0qvy
         zztIFVXgB6PuU0w2d3r5sXOIuZiuLVB13l+Qu/2crtt79LNs1BdrNUHiiGpbKWHfbafI
         mCtKdMRxc1bAdaN2hDrT5LEw+V5b8bpaRIPYJ6Tfd74CtIObwoB1M0HqYKQVm7Zbf+Eh
         syY1f42wzigwEsdPaFZ66OJxsHdNhoG/RKzOdGylBeJ8KoTeZydFtFedGlDaLfKQ/Dgr
         iu/fE2HCCmr/ihGi80BrPutmTN4NtTcIUEobLKQKaWHJLNEhm1BgER83CSGHAHPJamCZ
         osIg==
X-Forwarded-Encrypted: i=1; AKwUvByg8R9KknOFzET6i4Gl5/ARuxu2JpHpZL0YURTx0zmIeNX8igZwGR4RFuIqqX8OWqO+K5E=@vger.kernel.org
X-Gm-Message-State: AFuF++kc02ImkKARVC3qZ7cJkT1D5z+r5ljjcryYb1Brf0bVw1So+ATa
	F92PqDo3XXnj67PBf2JKlGiWaOGl6/22ePrjT/3rcQUnudpJQWLsTK8s
X-Gm-Gg: AYBFou0UlTQSPBgrvk+74E43XU1URNBRzFyfie63Ky475oFXm4a2zt6YRRuMu1pg/2n
	uYjOg8QOcRg46J+pma/6YCisf1eeBKBfS+uQEmK4gLvZuoPW5ytjZkdGWwR7IIljdmAvy/l2Pcg
	YyeU53VfV30TBPaKeTU4kHnvfgC297koHlfweR512/jnHqzz4GyPryHVHhcTAooK926pxG/fYHP
	eeiZelxedq9LsEAral0aSIzvgOQD9Kav39Oe24QD7rmdfEn75WkJcnevk0jQDjsGJdRS9qufqJP
	/IONLuomtOuaJmRYVV4y/NKksTVTvN52rGjDzmtG9WjkVgd7y092dsGhXJLxKYzB5898vJMoSqh
	Vt13BiK9Gb3Z+7xTjHtO/ti65pkrSXleCdppt7HoHqlXupPleaDgDdKlMaY2dG3IqyldUOsQdWq
	puJkR2qoID0ao7r7jLuLyEhCWWRXxP1BzKkP9kL2MgH3U09PZ6t05Fz5VQRv/ppqkzRWloc/rgl
	CPq6Hw=
X-Received: by 2002:a17:903:1af0:b0:2db:331b:e187 with SMTP id d9443c01a7336-2db331be292mr163344515ad.8.1788767966572;
        Mon, 07 Sep 2026 00:59:26 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:59:26 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 12/13] srcutree: Remove debug pr_alert()s
Date: Mon,  7 Sep 2026 15:58:28 +0800
Message-ID: <20260907075829.2073224-13-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907075829.2073224-1-kunwu.chan@linux.dev>
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Remove the debug pr_alert()s from srcu_gp_start() and
synchronize_srcu_atomic().

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/srcutree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index a93bf803e2f7..a016c93d65cb 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -916,7 +916,6 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 {
 	int state;
 
-	/*&&&&*/pr_alert("%s() start: ->srcu_gp_seq: %lx ->srcu_gp_seq_needed: %lx\n", __func__, ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed);
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed));
 	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
@@ -2152,7 +2151,6 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	// OK, we really have to do it ourselves.  Start the grace period.
 	non_block_start();  // We must not voluntarily block!
 	smp_store_release(&sup->srcu_gp_seq_needed, srcu_state); // See srcu_funnel_gp_start().
-	/*&&&&*/pr_alert("%s() start: ->srcu_gp_seq: %lx ->srcu_gp_seq_needed: %lx\n", __func__, ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed);
 	ASSERT_EXCLUSIVE_WRITER(ssp->srcu_sup->srcu_gp_seq);
 	srcu_gp_start(ssp);
 	raw_spin_unlock_irq_rcu_node(sup);
@@ -2208,7 +2206,6 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 		cpu_relax();
 		srcu_advance_state(ssp, true);
 	}
-	/*&&&&*/pr_alert("%s() end: ->srcu_gp_seq: %lx ->srcu_gp_seq_needed: %lx\n", __func__, ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed);
 	ASSERT_EXCLUSIVE_WRITER(sup->srcu_atomic_gp_flag);
 	atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
 	preempt_enable();
-- 
2.43.0

