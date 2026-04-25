Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE6242D72;
	Sat, 25 Apr 2026 05:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777096019; cv=none; b=bYb2BSBEbdUDshDn0Q8/KpiPPvb4V2wB2z74Fu9+igOFcU4kO2nmmK4cUFWRYa7bgcd5skdOyfWj6ENOT48iCYqISrXHJIexN18cNLY/c2Ku9Fm0HizuLEMCQSILeY5c18TELWgC1i0RzAUNAkuIfFKseScpzpqJOL078q1I0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777096019; c=relaxed/simple;
	bh=rSGR3AR0m8Ij/PV5Oqw2GgCPF1gXz4burjiZJh16MP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZjN4ssMg1CqXbsX9WopdtM7++sK1u7c2QJRtIq56bcMlmbwwu7I5VIxXSfHlE/a3SP0sRsbRXr1BOcVe7uDlZOvdhMemxcG3LLYN/gS1v1WmLyZBd+ehBOSW+aR+OiZEr2vcMoTDmAYVxS9blBiTPMJhSPkIxZ/t/9tu0KLRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GJ0XVQmP; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uwnlv62W; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GJ0XVQmP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uwnlv62W"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g2f3G1B5xz9tjB;
	Sat, 25 Apr 2026 07:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777096010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1U+Lzz1qrYnndGzgY0hK0tfu2XW3iifx6J3/jCY6ZA=;
	b=GJ0XVQmPVZ3C29V9VBzl1FqGS399NvjW9ZZ3Czra6gwGX4whf9zFV5hgdEw1oKpLtx2Vrv
	nOXr0u1WiFNxSOlWBJZkxz39rjVqiQyYtumwli3ddvkY4e0tWQCdzP5pzDJWY6DYwSJVhO
	fDs2HQ5eOXNs6kFxoluFlnI2S1htr6BcfNCCkhXPh6AbZ4uWMKZP2z8m9BmEQHUS3rbONy
	JKjGz2+vXemyfx8PL/YVHLryudAG4KWcs1jxi/BGdMG/88M9FlI/ataiI5t3HyGvJA906W
	P6ETUPC3HtEqGg0bc8v/W05+GnJWhyxaIWbLa/FiXFNjm2bcDj5KppO+lFSyzg==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777096009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1U+Lzz1qrYnndGzgY0hK0tfu2XW3iifx6J3/jCY6ZA=;
	b=uwnlv62WEPzcPWrQ5ZoaPqt6xlfYJLtO8XDZ46qQf0Tp3LSBPrknlCmYXpVhTgI3EyUV5A
	lElEPJo0PzvigUjm/TwgKEgzqD4q7XAHeC3bvyy0YIZ30oeYz2i4yovhysO26IQ3JLUhhD
	kgTXPpAXchi2m+OmBWEvOk6ocrVn9lW9g42g4XmLzERtZXzCYpwCuTLu5b1E89WhOlo1LB
	9U1vE3A1PQ5VKeQd5194wA1rmfSojZpyB9TWxoezmi4J+Ex42PiXen/asjwsU3sbqSIAgE
	d5ycbOektijgf7+dIkUSkcFspf3q/6bUKhFzYos3cDwNIYKE3EJCc/AQdsQSyA==
To: manuelebner@mailbox.org,
	corbet@lwn.net
Cc: kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	paulmck@kernel.org,
	rcu@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v3 2/3] Documentation: RCU: adopt new coding style of type-aware kmalloc-family
Date: Sat, 25 Apr 2026 07:46:31 +0200
Message-ID: <20260425054630.272707-2-manuelebner@mailbox.org>
In-Reply-To: <20260424175553.258412-3-manuelebner@mailbox.org>
References: <20260424175553.258412-3-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j4corux7dnuf8pgzx97gu3oi9rymqth4
X-MBO-RS-ID: 47ae089f101825f15ed

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

