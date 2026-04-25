Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112275CDF1;
	Sat, 25 Apr 2026 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777095685; cv=none; b=uMtyJV9g9oG4MK2pRUaXMs+ixpSZqk602q261sRtZ7D7sjuOfRXDe0rR9vFweB++vcBi9WpOk721XnQpM5Hd+Cg1+Jfx9N/aAC1VkjeQK8UHadR67XvedDRaWoJsW7HqtB/rt2Brkv6LOTZPFpNumgwFDqehreGbJTB++EDneRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777095685; c=relaxed/simple;
	bh=rSGR3AR0m8Ij/PV5Oqw2GgCPF1gXz4burjiZJh16MP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTvavsD3ls2x4nnQoFgJBEtcwCykxuvIbNfQQnvxFETxL5NS71DGI8tGr393I8KVfDkyIz9/MgUZxl7THR86aJjMNctusDTjLKNPX2lqmNlMgeatAUxkYZNc317OyWLPfsANw9tr/MhVSig67dYq3uOb1Oq9kCpjE0Rzl6CbfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NOO5DGf5; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Tdp0XVzw; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NOO5DGf5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Tdp0XVzw"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g2dwq1fWXz9tm7;
	Sat, 25 Apr 2026 07:41:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777095675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1U+Lzz1qrYnndGzgY0hK0tfu2XW3iifx6J3/jCY6ZA=;
	b=NOO5DGf5VHaE2zSaG8d4Eyy9VXNnwIrp1C7MqDKmImHFjez7ISyF2QtwJ5e6HyKjZ1C00V
	kxW18MfngRdxrNhpmB2qUMNENQgr21fhmOpMUIzXLe691L4Gq8p0t4AO1Ucre6AfJCEdym
	d/7YdwYEw7vL888GQRkPXD4Wvy2gKgX43TMEJv1THMSOEo/VRBvU2kSxpF2AR0gk/sbd2T
	Vc245H3CAxWaRch/uSG03J3AF/0LQcheTAMLSOtIrAC50CyRaVVKJOeYfJK7cKj+MGtclL
	J2zoRj9z+sCxpqn39rKXEjucf/Eqlulu+N/QzFcxKE/EXW8J6OYp6S0rFFR/cw==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777095673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1U+Lzz1qrYnndGzgY0hK0tfu2XW3iifx6J3/jCY6ZA=;
	b=Tdp0XVzwyZ66Pp0J9qNYYK+uc4Iwyjt711kR+T2fvjpkKQIbEZkSrqfrMmqL25ozLORdAo
	KE4PY4S/ggutcL/U6Df5AFS5Fz01a4zDzoAdcAEHeOLlY6YpbfqCW8FSWdK1+zgOGL1umF
	/BNzK4kQA3OO0DR1x4GuqvpHxR18SUG94vSoteVxFStJgR55QCVd9Hl3AiX/rnkxNSV2Kp
	oepNqQNAw8jp1dya6W2npFoypVQLrj8jps8ua71KVzZhP5xliB75jz2qLJEPI7riM2fWcw
	6a1eTdRJLeAwVqQZXPpuTGPSo04YXVbBN3d8pETX1ATJDPxxsuATabtTLNUjDw==
To: paulmck@kernel.org
Cc: corbet@lwn.net,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	manuelebner@mailbox.org,
	rcu@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v3 2/3] Documentation: RCU: adopt new coding style of type-aware kmalloc-family
Date: Sat, 25 Apr 2026 07:39:22 +0200
Message-ID: <20260425053920.272388-3-manuelebner@mailbox.org>
In-Reply-To: <7a49fee0-09c8-4a48-9506-d9172ef024b0@paulmck-laptop>
References: <7a49fee0-09c8-4a48-9506-d9172ef024b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p5n7fqecu8qcsz3shzj3ypu6u3i79smt
X-MBO-RS-ID: fb2fc64301aaf637227

Update Documentation/RCU/* to reflect new type-aware kmalloc-family
as suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
and family")

ptr = kmalloc(sizeof(*ptr), gfp);
 -> ptr = kmalloc_obj(*ptr);

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
in the prior mail i forgot the e-mail address of Paul
Acked-by see 
https://lore.kernel.org/linux-doc/7a49fee0-09c8-4a48-9506-d9172ef024b0@paulmck-laptop/

 Documentation/RCU/Design/Requirements/Requirements.rst | 6 +++---
 Documentation/RCU/listRCU.rst                          | 2 +-
 Documentation/RCU/whatisRCU.rst                        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index b5cdbba3ec2e..faca5a9c8c12 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -206,7 +206,7 @@ non-\ ``NULL``, locklessly accessing the ``->a`` and ``->b`` fields.
 
        1 bool add_gp_buggy(int a, int b)
        2 {
-       3   p = kmalloc(sizeof(*p), GFP_KERNEL);
+       3   p = kmalloc_obj(*p);
        4   if (!p)
        5     return -ENOMEM;
        6   spin_lock(&gp_lock);
@@ -228,7 +228,7 @@ their rights to reorder this code as follows:
 
        1 bool add_gp_buggy_optimized(int a, int b)
        2 {
-       3   p = kmalloc(sizeof(*p), GFP_KERNEL);
+       3   p = kmalloc_obj(*p);
        4   if (!p)
        5     return -ENOMEM;
        6   spin_lock(&gp_lock);
@@ -264,7 +264,7 @@ shows an example of insertion:
 
        1 bool add_gp(int a, int b)
        2 {
-       3   p = kmalloc(sizeof(*p), GFP_KERNEL);
+       3   p = kmalloc_obj(*p);
        4   if (!p)
        5     return -ENOMEM;
        6   spin_lock(&gp_lock);
diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index d8bb98623c12..48c7272a4ccc 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -276,7 +276,7 @@ The RCU version of audit_upd_rule() is as follows::
 
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
-				ne = kmalloc(sizeof(*entry), GFP_ATOMIC);
+				ne = kmalloc_obj(*entry, GFP_ATOMIC);
 				if (ne == NULL)
 					return -ENOMEM;
 				audit_copy_rule(&ne->rule, &e->rule);
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index a1582bd653d1..770aab8ea36a 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -468,7 +468,7 @@ uses of RCU may be found in listRCU.rst and NMI-RCU.rst.
 		struct foo *new_fp;
 		struct foo *old_fp;
 
-		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
+		new_fp = kmalloc_obj(*new_fp);
 		spin_lock(&foo_mutex);
 		old_fp = rcu_dereference_protected(gbl_foo, lockdep_is_held(&foo_mutex));
 		*new_fp = *old_fp;
@@ -570,7 +570,7 @@ The foo_update_a() function might then be written as follows::
 		struct foo *new_fp;
 		struct foo *old_fp;
 
-		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
+		new_fp = kmalloc_obj(*new_fp);
 		spin_lock(&foo_mutex);
 		old_fp = rcu_dereference_protected(gbl_foo, lockdep_is_held(&foo_mutex));
 		*new_fp = *old_fp;
-- 
2.53.0

