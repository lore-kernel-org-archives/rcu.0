Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007831;
	b=k3VMFHS2m+JO8yIwwuScJGFhM4UGL+cGkIdygvmPpYz198tvzzmLv6RQ6IblwCO6nDk0
	 9N3/UaUc7U4C3OCV4SgJ7hQYm7tecH4E+OT5Fqj/mQiYUnImp3yrRKDrZk+P3iUMHjR4y
	 qkDKLKZS93snRDaajqKZNRS5E3Uo3pT1zDwXPqidrceaCMnyN51frFVVG62KDnP+0sqJ1
	 335n/d28qKeFgBOX9J+CQuyv5SMXPWn+CKRHxmrniENSPTXqNtHVPPv/Uz+dc5W6Ajplb
	 aCM7A1w6KjvvQeQhZMg8fz1tSrnNArtYrOp0l8vFJCY1YqfY6PayAeiaDgH/MBoENGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007831;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sePCiVauuSqOAnYV288wGjdkvSBQky2K126fYSbUmfE=;
	b=iFVQGxcNzG5FPTvOO+zVvUnc0F0LQQXKSIUyTN1tJfatoKAFqHKYkQQYiJVgEgv+O3Pw
	 ZPxvawf91WCJOAgW5aZK5BqINiYK2r4RPpF9nkWdlDnqSB59oCKj3YuNZEc9dxRsuSneY
	 Irv+RhaDL1nkqCZ5k52z/d16U5vJ6REoW+ik8C/1C+BaTLZ9iATnH2QziH/TojeRil4QG
	 C1yia/fAhpiZ1eCFZxnvjTkU/2WdcxPHTb9BvCO74KoHITvxUrHA32IVGk34+AbmdWhxW
	 F2VI9o9gWsJFvdaFIEVYhmQYc0djOw87yJDEh5vr07+sYvFqsRsbeG2Z+fQvY7Gc8RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sWwfyd7x;
	arc=none smtp.remote-ip=91.218.175.209
Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F98606A325
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 13:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F98606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sWwfyd7x
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=voPRCI34GRzvXMCYJVFRcZ9FG3JeoOsk3CVz5w57PG8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795007829; v=1; x=1795612629;
 b=sWwfyd7xTgEqRvloVH+K7j1TjiK1Yb9Uy7tghUcIq8q0c6xKUceGuYClzatql7qK23ygA8nv
 DZWlGTB/LTVsoVljHsIMWHldnV7gmSVN7axetrpQf+fo/FJsk/Hht6jTujtuTmaGVP6Ui3XkG69
 bmmwVmEycKrYgGCwEZSyg+to=
X-Envelope-To: rcu@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 60ff27ef0a747041;
	Wed, 18 Nov 2026 13:17:08 +0000
X-Mizu-Trace-ID: 60ff27ef0a747041
X-Migadu-Flow: FLOW_OUT
From: xiongwei.song@linux.dev
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	dzm91@hust.edu.cn
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	paulmck@kernel.org,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@linux.dev>
Subject: [PATCH v2 1/2] docs/zh_CN: Add RCU/index.rst translation
Date: Wed, 18 Nov 2026 21:16:33 +0800
Message-ID: <20261118131636.5131-2-xiongwei.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261118131636.5131-1-xiongwei.song@linux.dev>
References: <20261118131636.5131-1-xiongwei.song@linux.dev>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xiongwei Song <xiongwei.song@linux.dev>

Translate .../RCU/index.rst into Chinese and update subsystem-apis.rst

Update the translation through commit b3eb16109ae1
("doc: Update stallwarn.rst based on RCU Tasks Trace as SRCU")

Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
---
 .../translations/zh_CN/RCU/index.rst          | 49 +++++++++++++++++++
 .../translations/zh_CN/subsystem-apis.rst     |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/RCU/index.rst

diff --git a/Documentation/translations/zh_CN/RCU/index.rst b/Documentation/translations/zh_CN/RCU/index.rst
new file mode 100644
index 000000000000..3675da1a2993
--- /dev/null
+++ b/Documentation/translations/zh_CN/RCU/index.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _zh_cn_rcu_handbook:
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/RCU/index.rst
+
+:翻译:
+
+ 宋雄微 Xiongwei Song <xiongwei.song@linux.dev>
+
+:校译:
+
+============
+RCU Handbook
+============
+
+.. toctree::
+   :maxdepth: 2
+
+TODOLIST:
+
+* checklist
+* lockdep
+* lockdep-splat
+* rcubarrier
+* rcu_dereference
+* whatisRCU
+* rcu
+* rculist_nulls
+* rcuref
+* torture
+* stallwarn
+* listRCU
+* NMI-RCU
+* UP
+
+* Design/Memory-Ordering/Tree-RCU-Memory-Ordering
+* Design/Expedited-Grace-Periods/Expedited-Grace-Periods
+* Design/Requirements/Requirements
+* Design/Data-Structures/Data-Structures
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/translations/zh_CN/subsystem-apis.rst b/Documentation/translations/zh_CN/subsystem-apis.rst
index b52e1feb0167..4488a97934ec 100644
--- a/Documentation/translations/zh_CN/subsystem-apis.rst
+++ b/Documentation/translations/zh_CN/subsystem-apis.rst
@@ -29,6 +29,7 @@
    power/index
    scheduler/index
    locking/index
+   RCU/index
 
 TODOList:
 
-- 
2.52.0

