Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8230DEAA
	for <rcu@vger.kernel.org>; Mon,  5 Jan 2026 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767583279; cv=none; b=KnJJY+4+l8zPEHzYlQ3B0vTCgkkNF4l2bazsXwS+hdR+aaSFnqBqDuNAxtCufHerpKdk58Ini1fUqE95hSD00NmAEILKBx5fYDCqw+zKMccRP3gxuj+13IoxTjralrWPcQuFzN8jZEcLEq7su9VDinagoXgjbDpGnTHCstx3pAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767583279; c=relaxed/simple;
	bh=2yVqUrAH/rAV3CFEQtEB1zHKuYftuWks5gMh0PYY0bA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQgSGcMVW7fWSH485QgqIPUO8RnatwrVknI3PalxPOR/mLLb8dlWL/QooQn42vNyrUWaxPa1hiiP3DUTiWA2yu4WY7ma6CnbeB+OakhCthlyMFg0pPIq96F5oLMOT2rbah+hFFcoCcqu3kGnQfeySisYJKMRUa74YEN2VGJshHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drPHTw+E; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drPHTw+E"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7b80fed1505so13318917b3a.3
        for <rcu@vger.kernel.org>; Sun, 04 Jan 2026 19:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767583277; x=1768188077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nP3qC9T00rl9JbXEVxwHQu5KUyBQJJofS5UcrCiyeJU=;
        b=drPHTw+EAFM81qVVnxN7+mwQmviud3S8P/nRua6ly5Q4w7NwOkBREwzW5ByssPeVNI
         e4byB2SRYFXQ/yUkJNC0cyKx0C25Be/ToWGov0JXTeuJCyIUo7rlrViRASJWV9wPONFl
         /gD3Vbh5Ovzlfsu8P1jRyxV1G88LBE0CAr8aPtNQGTpesVX2pEzHFQyL/4QR6iyD3pW4
         eMDtcLjoPUS8Bbasl5mJQpb2raSrRCgxt8C215Hr4HLgq7hOyYXGcAV1PQTypcxOcl8t
         3DS80bgFPXgDf08fH3Uza9NLdEwAgzkb7Mwt4W4KnJbnxyEbYxB7RfJ4Vm7j7lygDVqh
         vMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767583277; x=1768188077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP3qC9T00rl9JbXEVxwHQu5KUyBQJJofS5UcrCiyeJU=;
        b=KAn6QmEYl6oCO9+fhh4WclR1ocPn/3QSHt6VliqYwKNpY6hxsllwM82NutQJJm5Puo
         CcsW1+Ym5hmpdibk/lnCjHcf922C3NWtrfoiy2ckGbrsG9o3m5c8w7O6gwzh61JggU65
         CuZm+3Aph5OF3c5wdq4Rpcfl95Jb28BWsK1KpzHN/x8MZkh4rKl5bEWTztlKFfPRGoJE
         Uv53YYD6xDuwGDmT3Ao4KGCPo0yFwqULPlRP+jZzKE666aeT33ipvGs34IWvaDpiqSrP
         cFHM2CE7S1KCMTTfhcdnZt/yjI+Z/LQCnX1ahDCm/lalOL8QYm23n15uNkyissPaQbvz
         Axmg==
X-Forwarded-Encrypted: i=1; AJvYcCUkzzzl6r5pgov7Op1UzaTCwMQhawamc6fEaaNQCbgEQGXnKQc8QJT+GhmdiZ/BYc0cU5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/fbOuOK7vTRIJGZ/OC6mJ6DKRzCRm9pyJdLVuLAP5jVqz1iP
	frDBbpD67v0J22YPBVuDe+eatAH9dTwBQj0De1XEISgU9FHDsJGh33gQ
X-Gm-Gg: AY/fxX64fx13Gl9YZVHKRteb8/oU4t8K47Q0qilQHNdlJZsnO9+3iFQWh6kkVSOTs9O
	QoKAgOQrU5foGhOl8GvJx403P6V7pEbqo+LvjNEgXVI9l1CYWLie1jBGiOqrZKaoFpB36WeoiCm
	eDZmTtalFUayqM87hUwyr3ulqpTjylM56fBNsbaZTFRNo5kQPme2hc1Kw+5nChZGGIiDRvmMBhI
	fATZ3ER6oTQdQnE0C+dBbTXcoZLv4bsrGVghq8fhTUML3/RfDtiZM2G40AvN5Wp57EV98Sd1CmN
	6G1HGV67oox6XK2xkhXVg9S6fy22/x6OhLVJTngVOBjBYPuv2MdSNfmvqD6dInlSiAXKaAnWxIZ
	TPW6vSon5bPvDITjsN7oYqBI6gHmeOzsdagWSk7sPmu0oBk5tY1i6t79LDnIg0nUvg4jpatUHbE
	J+o2DvuYiYAjxZwxFsr6ByDYK3akM=
X-Google-Smtp-Source: AGHT+IFbs+o5yKIznB+pkFkpmwW+HUV98k22TQ6APUvUWR/GyQ8u08zMV5eXgcFE9HSlhVMYAlKceQ==
X-Received: by 2002:a05:6a00:4307:b0:7e8:4398:b35c with SMTP id d2e1a72fcca58-7ff66672928mr38546276b3a.47.1767583277310;
        Sun, 04 Jan 2026 19:21:17 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b127b00sm46565337b3a.21.2026.01.04.19.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 19:21:16 -0800 (PST)
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
Subject: [PATCH v2] rcu: Align stall warning 'idle=' output with documentation
Date: Mon,  5 Jan 2026 11:21:12 +0800
Message-Id: <20260105032112.1156359-1-dolinux.peng@gmail.com>
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

This was valid until commit 171476775d32 ("context_tracking: Convert state to atomic_t"),
which merged the context-tracking state and dynticks counter into a
single atomic variable. In the new layout, the dynticks counter occupies
the higher bits starting from CT_RCU_WATCHING_START.

However, the current stall warning code prints the value from
`ct_rcu_watching_cpu()`, which returns `atomic_read(&ct->state) &
CT_RCU_WATCHING_MASK`. This masks out (clears) the lower state bits,
resulting in a value that is always even. This obscures the CPU's true
idle state and makes the output inconsistent with the documentation.

To restore consistency between the code's output and the documentation,
shift the atomic value right by CT_RCU_WATCHING_START bits before printing.
This extracts and displays only the relevant dynticks counter portion,
allowing the parity (even/odd) to correctly reflect the CPU's dyntick-idle
state.

Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
---
v2:
 - Use CT_RCU_WATCHING_START to replace ilog2(CT_RCU_WATCHING) to clean
   up the code, thanks to Zqiang.
 - Clarify the commit message.
---
 kernel/rcu/tree_stall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..fd9d7fd6e17c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       ct_rcu_watching_cpu(cpu) & 0xffff,
+	       (ct_rcu_watching_cpu(cpu) >> CT_RCU_WATCHING_START) & 0xffff,
 	       ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.34.1

