Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20D26F476;
	Fri, 24 Apr 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053447; cv=none; b=b3O+i3a0vAsVjtnflQVRhGfthdX88gwQqeqeZzUgZ09e83WMXH8sryDABWPQ0tA8syj/ADssuSzJBU1WRRCdyC+tM8wcwn5Pnj3F7VK499209QdIH908jCxUYAiWw+/k0uL0LTixTHKIdKEwLgYcqRyNNFu+LzryEbkMxZ6smM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053447; c=relaxed/simple;
	bh=5rA2QJpQdjH30aXwBWROi5azH6CiU2oSJWc6XuEEHCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHmPGPrc6QmBUxucbQlzGbP/ueELblsuEKiYjTvnWqM3eNAdG0uBFh+6FnCKzA3VsGX4wdfGIN4+PeNg9hqBBEbXb/xGbPZPIsErJY3IYtGwqxn9G3lRJFU/MAdfKXTUbBlrJEhBmy1aNM9INuWI8Zfyr7uaX6mq4YT//D09ZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DiQX2jKS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yZIE/V/i; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DiQX2jKS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yZIE/V/i"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g2LJh3bK2z9v09;
	Fri, 24 Apr 2026 19:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777053444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jpFSfh8pkq9hgF4XdFn4gci7nJHZiQrNi+Cn4q3ldM=;
	b=DiQX2jKScEebIIsItGKvTu8w4TlEZEK5EJ1cxL3qtrx+u+a2HefIH/spvYOFb3vBGn0jFu
	b/yzMeqBhVwiTKCybbQgn3Xc8l3pEuk13jJfhasxbf8PVZzr8Igz9hONffM29xo2Ie+PkR
	DdRAxJC6yaGuDVmK7S4+R8DzzrAlGpT2Es9hCmvf4HCd9Mo9OFlAXUXmwUXgM2uuIUMZNQ
	GqrhqgRi5dqkC3V4fxxAZnevI3pZU93YyALt/u2DI5yA8yY00XAVuEHZ8vQuuMdmZlJ3JM
	pSVedQGOW3NtKUWCeErAVWrABI1acLwhtk2tsZLdRqtRGjNjnGKxb12NZCwUcQ==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777053442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jpFSfh8pkq9hgF4XdFn4gci7nJHZiQrNi+Cn4q3ldM=;
	b=yZIE/V/ioNkek2NIKv9qymxY2/zs5EY/Ens7Jn/IXiZgh3TbOvxIxXBNGpKIXLyDrYh4Nw
	8fNtIgEqZ14LnwpG7p0lznCpCw0mXseRzZQfhCtA725d1PdsoG85VUolU5JxlU2JceNoRy
	Z0mDPkaFsDne21Vn9hovQA0x2+0b9NhmnbvPa6cGHdCeEZGOCZcoFhry4ivyOyoqEXVXzT
	prwMsZYhvlDV3R8HzoEV3LrAxPpqf0DsNRU+D6nGHlL4QhMNKwaG4zFbUj6yRUXGsPntwt
	YGOi6b/yyOVxTXdmqLG6lIUCNYzSknnJG9WTGAQ+orcXjeZyghqfEKCUlNJscw==
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH v3 2/3] Documentation: RCU: adopt new coding style of type-aware kmalloc-family
Date: Fri, 24 Apr 2026 19:55:55 +0200
Message-ID: <20260424175553.258412-3-manuelebner@mailbox.org>
In-Reply-To: <20260424174743.257951-2-manuelebner@mailbox.org>
References: <20260424174743.257951-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e0518762b50c9cfe4f5
X-MBO-RS-META: fexjjn3ftc9wehobct5zrowsq8uu389o

Update Documentation/RCU/* to reflect new type-aware kmalloc-family
as suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
and family")

ptr = kmalloc(sizeof(*ptr), gfp);
 -> ptr = kmalloc_obj(*ptr);

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
Acked-by: Paul E. McKenney
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

