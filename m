Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750738;
	b=RmjiqAnUXhRR5FKO8V3ku04qJXpR1n+6enG/6z9hCO71GJdwkkoIrMIYlFkqXyjMM7t+
	 +MU/8BP5pun2lLsav0rU5gzX1NzMxE8VdKM5yaxB+VfGu5o+8H9nWoca3HvuZwEAL0g8f
	 ZgdzveWBc6xtgrOwYCePSJl+QDHsPigO1EkuyRA6WNq4Dk6yWa/10t6nuB3t3E70Y/wGe
	 yRBySdBowNdMacJKnzThJcL1hswDXiLCkUtkM1UsAZjUA7uTFtZU1zP7GDtGhYtfAzV0/
	 XudWkgxb/rZzx2tg+h/RmmnijRLYJFOKobVf5ImL4x5pHeSxKmch3I06pRDCUtfTT4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EiRKif/CjX01ct6IZOevu5Hw8STctFNztvjIHwXGraI=;
	b=Hw9PYYutZRQcNdqMOfegM332Xnjf6L4G0UPrziqq3MBSfc6XfFgu1dOW7iFL7jVDQE4Q
	 lc5U7UtJxydVDiprKpSeFaGwOAOJd7WHGgnmjtRr+RaX6mnq3K/vtOSSL3JMsOhFPEbTw
	 cjnr7JXSUAwoClJQ/z5XJBsrrw8b7hst39iSgIREErnMGerT5fnaAKqKXIdIFkNtDT8hO
	 QEKnu4YqRKnRPa8pqVdlGRvwm2j5I1BYD/8ykOBKGtZh8pB6IDxMO7uBN4jzxvYt6DHe1
	 mefUT1UzJ1yvTDP/RTU9nCN/LssD1Hqicik4QZgg+01An/WFcxwu4NMje71HDboehVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NtXZYYB1;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA5606A31D
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32FA5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NtXZYYB1
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35ef6b49813so1027129eec.0
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750737; x=1793355537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EiRKif/CjX01ct6IZOevu5Hw8STctFNztvjIHwXGraI=;
        b=NtXZYYB1icV/lPS3+rQgreOmR84b11YSHmAYylCI56Ct5xzx2yCVwaJDet8CdjUmIT
         7RFXyA6k01QFQl/spqK9lgNFRsSkmkjtBM2LwkasA4gn+052pYC5eNc6899TdUHjAFBM
         OPbn4+rPp2EvQ2k5vcgaL6F7RGAiz/50Y/J+NY7zaiAtlIXcRGl0vIHqcBPWSqVTZbFh
         cNQw0ykeA0vwtWHwdIr5WjX+YkbEq9rX7Pkim/7nqMIMrcarQnwb+9iEju8AiLnSqFRk
         oBYPj56oX9BWrFTeY0EKtCt94aFaQMiPwVnDVjvvZyjpCoe9uAqCT3YIQiMbC8tHpTMC
         BsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750737; x=1793355537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EiRKif/CjX01ct6IZOevu5Hw8STctFNztvjIHwXGraI=;
        b=F4mAbRWWHFT7gwdcS5hJun3PwhGbPVgSSRrjfCcPvmPo69PkYbnzMoEtBcMbjglLZJ
         aT09YzvSVJhv6Pcu38cZKcqOE8nAxHjvVxWweFOzT55aVpX/5PhRn5Yn2DsxLGIo6QNb
         ycOkSTRMFFBf5T8bLUugZWd0RmNtampISD8YjhEO0WI0I44o9dWSqdjsgghQ+lvNJG/2
         VRPLnaG7vo+NGS1ifBPAfHLtqSUKSuNtkwp+cQd4avNDXYt0esxunaOU7utXVUIR/fN/
         JgaT7kMczCCGJqqh7clRgOWiHs/JjjR46pG0PoVDq/AtNXk54wz64oc1gtY11Xpv22K5
         fVYg==
X-Forwarded-Encrypted: i=1; AKwUvBwr3HSiaMTqPpz4B3l4mhQGoHzwGWPfKQweSN6nDplC2NCtWDCXixtGemvI8Uu991aSsRs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbfrvDRNEoGQENVruNEzLutT/xjMXx2aSBpaMrhB/b5UwtVr9N
	nFkA0S77p4/u9+IP2CHVeocFOLULfpn4isCM/OpzJTs28eiaYu9fxeMR
X-Gm-Gg: AYBFou1E/Q74JXiKR7tbceG5NukhURgI4wPUmExZp1UyYOVWbVTuAxWDa5Ar5922Do4
	VbTT9RsSIzMiCO9nk999ig36Mn51xFU73LA+TBM3flGXjsOhN5d/YXwSm+D+ypeHV2gLcrqH04v
	qVW9uqCI1AjL3yPkkqVCzyk96joYzdF66anAajkPMWy8nRobiSoz06KtrZCZQIPjcEcjyt3UUZM
	lijcMdpUvmXgOrJ8tC9etyGzUK2bnGOB8GOSz4aVIoMEpbKHnTZyWr0bNEc4WZyJc/1oeX7z7b+
	Qf4ZZdPOr4Mm4FeDyrDIGdKxkUyNxnDcAX95xvlTMH73tq2UXvuTklk3aol+ttmBh7+LG4Y1j4V
	PvPfBGqdUhekcWnWZbvkeMcYWMCwninwL+4KePwOrLIubayTdLz1CvKvWhLqLTViCjf8zxlIYZT
	YTu9HAgTUMI4klf2DudPRrgUARlaiPPMKttv86p9rJ+3B7X3/XPNsiF27xaZT/wLgoLSC6jGJML
	P8YCxawzS0RfczuC7Sz/OnPlcZNhOrxp6B9h9TTup6/7sIGtq08vHKomqEMsN6LEd/SX5+dCw==
X-Received: by 2002:a05:7300:e9cf:20b0:361:8d52:e148 with SMTP id 5a478bee46e88-369d90c8111mr2746649eec.4.1792750736987;
        Fri, 23 Oct 2026 03:18:56 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:18:55 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 0/9] rcu: Improve callback diagnostics and validation
Date: Fri, 23 Oct 2026 18:18:32 +0800
Message-ID: <20261023101841.2910719-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi,

This series improves callback diagnostics and validation across RCU,
SRCU, and RCU Tasks.

Patches 1-3 record callback registration stacks for KASAN in Tree
SRCU, Tiny SRCU, and Tiny RCU, matching the existing behavior in
Tree RCU.  This preserves the original registration site in KASAN
reports when callbacks are deferred through irq_work.

Patches 4-6 add rcu_head alignment and NULL callback-function
checks to SRCU, Tiny RCU, and RCU Tasks, consistent with the
existing checks in Tree RCU.

Patches 7-9 detect duplicate callback enqueue attempts at
registration time, report the callback address, function symbol,
and object information, and limit diagnostics to the first three
occurrences.  In Tree SRCU, moving the check from srcu_do_enqueue()
to __call_srcu() rejects detected duplicate registrations before
they reach the deferred-list enqueue path.

The duplicate-enqueue checks rely on the existing RCU head
debug-object mechanism and are effective only when
CONFIG_DEBUG_OBJECTS_RCU_HEAD is enabled.  They provide
diagnostics, not full protection against concurrent registration
of the same rcu_head, which violates the API contract.

Tested by rcutorture with KASAN enabled: SRCU-N, SRCU-P, SRCU-T,
SRCU-U, TINY01, TINY02, and TREE03, each for 3 minutes.  All
configurations completed with exitcode 0.

The KASAN aux stack was verified with a custom UAF module: the
"Last potentially related work creation" line in the KASAN report
identified the original __call_srcu() registration site.

A targeted Tree SRCU test module exercised duplicate enqueue
detection on both the direct and irqs-off deferred paths with
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.  Both paths rejected the
duplicate at __call_srcu() entry without list corruption or
hangs.

A targeted Tiny SRCU test module exercised NULL callback
rejection, duplicate enqueue detection, and post-callback
rcu_head reuse with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.  The
first two tests produced the expected diagnostics, and the
callback and reuse tests completed without hangs or stale
debug-object state.

RCU Tasks duplicate enqueue detection was verified by code
inspection; no targeted runtime test has been performed for
that path.
 
Kunwu Chan (9):
  srcu: Record callback registration stack for KASAN
  srcutiny: Record callback registration stack for KASAN
  rcu: Record callback registration stack for Tiny RCU
  srcu: Validate callback arguments
  rcu: Validate callback arguments in Tiny RCU
  rcu-tasks: Validate callback arguments
  srcu: Detect duplicate callback enqueue at registration
  srcutiny: Detect duplicate callback enqueue
  rcu-tasks: Detect duplicate callback enqueue

 kernel/rcu/srcutiny.c | 30 ++++++++++++++++++++++++++++++
 kernel/rcu/srcutree.c | 32 ++++++++++++++++++++++++++------
 kernel/rcu/tasks.h    | 22 ++++++++++++++++++++++
 kernel/rcu/tiny.c     | 11 +++++++++++
 4 files changed, 89 insertions(+), 6 deletions(-)


base-commit: 940793b926aa94bf65ec404043050888e3053188
-- 
2.43.0

