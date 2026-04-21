Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4529ACF7;
	Tue, 21 Apr 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794857; cv=none; b=Vifw0syXoNymdtvZZzNuBFfUSCVXxOK4ZSq60PQrZ/JjfSbw344GSkK8CbAHTqQAW7Drr5I1ief+4669lTAgFDu9n1RHGhKV4OCky3SDrgmiPZtvp5E3X41izUu3XAp6RDF2hHtwe3VxYPwl1B7ziE1nnWh64SQ8Zb7HHOINtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794857; c=relaxed/simple;
	bh=yxVHxdSp7Dt5zLz1Ul9AB4dMOW5SkdCzihyUkteyqQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djZNyrgECaOY4zw3YiPvMSZo/wrpnHmgIrG1nAiTn0Fffl8uBWVuOZTSy8m863Exi/D03nxOSgBGTzHSdYhTacwwgxVndD/6y5ijB9wrEzvWx09aJI6/f9UJC8tMGirUIyvqLvNHQrSF9m0gI6zzSx0Wpq2Zg8sEfr94LDvlJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=plu6z+2E; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yEuShqYH; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="plu6z+2E";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yEuShqYH"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g0Vgh29p9z9thr;
	Tue, 21 Apr 2026 20:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776794848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2hgMsvze8nGQImJuCGOID1wYWGUzBxU3qKr2x1+dmI=;
	b=plu6z+2EZINUedUhHHd/4083sh1v7WXZ9HqREpWu9pP/8npzDnG+XjmZqK41Rcwq/lzTqz
	+/nuxBU40bmfSEcPmWREmmtAPmLdsiF13T0zqRpIwxzulwoHSZeNRlWEh/6zjEE1U+bqLc
	KiUOnjY80pKPBwRhUWsF8qx5xHOOSIwIuN25dZSjRO2rbU9MIb1pnV/M1ZOUlQLy0v/zwc
	K1BTi4ke84LIDhRjyINqeYxvQSJdIdMbW5Y5S4RvWmyAqm7bGmcAp4bC2dn54DuNzvcHI1
	s1YwEEIDv5278I1YpU9bN6p1TmamdKdoUn9eHNIbGtpYhYIgZlVYFpBYQ14PMg==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776794846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2hgMsvze8nGQImJuCGOID1wYWGUzBxU3qKr2x1+dmI=;
	b=yEuShqYH6vNQFif44NR1NbDTW9xu5m8w9QLCv8UGn8yErjOcg2/hCvCJNSG935s4kOKsoL
	gVIBheNX+ILXag5tXoA3FmbsMnVfkQVoE2PaLu4TDAxoAWwQJ3IMqnezwoVu61HWNIprOM
	V6oRIkhaj4tQ24Q7+yGFWEROZpjmpNoYagsV4Jd96Zg9EKy3F7IdRKqtIp8Mx+tp5mWjn4
	W5xvdpuXAxwQvwhITv6+ivNcsf6x4/C5I2mZvFL+jIrFN+0V9Q74t5gjGt2ET3ETZkXSZF
	47TsGBaVrUEdRpWLWPUOqsQU3/oZZYz+cSJGFYF/cGiI8epzjWdTEF9+UoPPPw==
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH v2 2/3] Documentation: RCU: adopt new coding style of type-aware kmalloc-family
Date: Tue, 21 Apr 2026 20:06:53 +0200
Message-ID: <20260421180652.225394-2-manuelebner@mailbox.org>
In-Reply-To: <20260421175516.224960-2-manuelebner@mailbox.org>
References: <20260421175516.224960-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2ac130f2e09ab5f0d9d
X-MBO-RS-META: yntwsr4fks77mbdj3mpjqxc9z8aejzo3

Update Documentation/RCU/* to reflect new type-aware kmalloc-family as
suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")

ptr = kmalloc(sizeof(*ptr), gfp);
 -> ptr = kmalloc_obj(*ptr);

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
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

