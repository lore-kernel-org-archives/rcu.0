Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3285175A97;
	Wed, 29 Apr 2026 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447468; cv=none; b=QU8hjbcaUlbI3FYMI1SntWM7ukU7fYWkdd/06oZA0amvaM2TgeVRMqbYAJRKhBlAZBrLtCDo5T4pVHJviiEDkhCCgsXXmQFo6aFUoscdB2gsPK0wZLPEC+CG1wccgTg+i2Bsn6JJT/hVQFffKXt3zUVuQycVyIZbmYBTxgxiykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447468; c=relaxed/simple;
	bh=VB4XXVqsTELvVPxXEcNaayKjjdYCpVkpl5sTDbndMnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMOGPkNnO08fH6RuHafv5cIzB46bCn8yP39GJPFdXZKfvorGK4iDuyC1/jVr1HDzi1N97vXzZSNI2e4jN3qOnbQae4HcW2TEQBAN11iJ6EpMZAXroy46JPEMpAhjuzk31eRRbDIaD3z4LxWso6Pa8VxaXUgQoagwGaIgDuW+LTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LV1JzEdS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IIDVJIer; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LV1JzEdS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IIDVJIer"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g581y5gpBz9smP;
	Wed, 29 Apr 2026 09:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777447462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLZGA+GoMQmUnCBWDiqt4bvKANNT1G+HMTcCqRQTHDc=;
	b=LV1JzEdSj0StBn8WhdlLca46jP7oMK5XFb3p8eeT5zyDzdb4/aPbMx5Qdyv1e5+VOhm2yA
	8uJSYTg2w/XDwOX6BNGszT+0HRL9Si0OPjDev/NHESaAAnCnqsNpeVCFVX6wCeFLuvQpE6
	6WOBJFV+0t9ASpF1nzWGoZfIxIfjlS5Y1qhYFu8PTpaTVn+chlSYUbXICY7xS/Ye5yfXNX
	nSxbvgwfWpfYKZhWUj4SH0dkMdOT67jBjD50FbyRVRBkpNDaWd4m0sNCwc0Bza5KesOzN4
	yUuK+WacVrnzc6a+SdyZB4fP1+3IV0F0R1pKnikfyq18gfHYEQUEq3Dspr4lVg==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777447460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLZGA+GoMQmUnCBWDiqt4bvKANNT1G+HMTcCqRQTHDc=;
	b=IIDVJIeryqFSNmcHYDo30TAn08Ymcsoz2iobD6qJowiBs64rt5mwwarsJ5Q6HR1SrsVder
	chaq4pvCuqxsdXh/WjcHCywib1WmPcY6BcXoD7hek5PIBkBT2FTLaj5XjjNKAi2E36qx2A
	0F6IkQH/3RMqu+rWwBwHNg93JkwVkjTl/wmA/+HtlLnG4YTgbCC4Dav1yXOzd4LfalX3PS
	geq8Q4kENOfInic5/4Ga57q3Rz8cpK+p1f/Hrrhg466jUrT6A0drUlowdTLPOjfRd1gpmm
	Y77Q1g4IE0VyrmUBRu4ptQko3bk1VcztIUZn9nGmWxkdy5RlOeIAiSb6M9DKUA==
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH v4 2/3] Documentation: RCU: adopt new coding style of type-aware kmalloc-family
Date: Wed, 29 Apr 2026 09:23:21 +0200
Message-ID: <20260429072320.310817-2-manuelebner@mailbox.org>
In-Reply-To: <20260429070759.309110-3-manuelebner@mailbox.org>
References: <20260429070759.309110-3-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tg8wij6mm8gp4fotxfs97s8xd5ophxue
X-MBO-RS-ID: 3f314db930c67e0afdf

Update Documentation/RCU/* to reflect new type-aware kmalloc-family
as suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
and family")

ptr = kmalloc(sizeof(*ptr), gfp);
 -> ptr = kmalloc_obj(*ptr);

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
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

