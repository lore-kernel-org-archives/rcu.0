Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369B2F7AAD;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190675; cv=none; b=dBxB9ZO1bgKfusSVabsJOMkk2MTA1JFFzPyH0RbdZBZjTRVXFbbfwXSpFIldVW0x5+h0zkwUOHSr6OPXUyGjjxkD2vbmrHaTtJawa7e3MxHlp72JXptA/1k3aqLK77+RQrFIh11PtSmAHmkc2EDmdXocRj967BJ0+ywtjNtb4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190675; c=relaxed/simple;
	bh=TClFAeQiiBqNMqlX5lL/MO+NhBy3SSx1O4T3SfYSpPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLDhGe26sdzrEfVOu3AftnGDKzakK/1EYvLasXpdDBDohsWJhPs02ipTLwLbCBY/5nsxpl+RC/xvx2FOH5TBIPrhgi5AN799vq2zyKljbWKZH6xBHIqGG7nR+Z75IAuBEELp5BFSa1sgQ2RH8lSGgrmrwQxncpj9DsaKINIhNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3rmf1DL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3rmf1DL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E6DC4CEFA;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190674;
	bh=TClFAeQiiBqNMqlX5lL/MO+NhBy3SSx1O4T3SfYSpPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3rmf1DLlZycaJ92Qtkp86ioEzEb+1T/ca/6MReH8gkXFVJUdFici1LGxWuTUUhZz
	 HKqSor9rTPDoL9JkVNZuTnWkIlwi5fOXMbZb1QMTmCFZXhTnnPq33C2EVWVHpbP8O9
	 z5XM+BHHDpAE9LyqZnBaITvxbICUI66lCtgvPNUPIJN8v+moZAMGxXQpKmWHm1+yk6
	 0V/O6VkGen2nKbhQjw0JOvmVk5iMTd6bxkQ5Dxng2MPcdhBbqQYXUPAzrGM0jSoWwq
	 WlCFvuMrDDLf4UeYQbEB0hhkblr9PCSi/s/WdWUmIBdJK5ZJTKTpt86AfeG7NO9PGF
	 Jgo2J+TmnFm3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 176CACE0EFF; Thu, 18 Sep 2025 03:17:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH v2 3/5] rculist: move list_for_each_rcu() to where it belongs
Date: Thu, 18 Sep 2025 03:17:50 -0700
Message-Id: <20250918101752.2592512-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
References: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The list_for_each_rcu() relies on the rcu_dereference() API which is not
provided by the list.h. At the same time list.h is a low-level basic header
that must not have dependencies like RCU, besides the fact of the potential
circular dependencies in some cases. With all that said, move RCU related
API to the rculist.h where it belongs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
---
 include/linux/list.h    | 10 ----------
 include/linux/rculist.h | 10 ++++++++++
 kernel/cgroup/dmem.c    |  1 +
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index e7e28afd28f8ee..e7bdad9b861827 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -686,16 +686,6 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_for_each(pos, head) \
 	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
 
-/**
- * list_for_each_rcu - Iterate over a list in an RCU-safe fashion
- * @pos:	the &struct list_head to use as a loop cursor.
- * @head:	the head for your list.
- */
-#define list_for_each_rcu(pos, head)		  \
-	for (pos = rcu_dereference((head)->next); \
-	     !list_is_head(pos, (head)); \
-	     pos = rcu_dereference(pos->next))
-
 /**
  * list_for_each_continue - continue iteration over a list
  * @pos:	the &struct list_head to use as a loop cursor.
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 1b11926ddd4710..2abba7552605c5 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -42,6 +42,16 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  */
 #define list_bidir_prev_rcu(list) (*((struct list_head __rcu **)(&(list)->prev)))
 
+/**
+ * list_for_each_rcu - Iterate over a list in an RCU-safe fashion
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ */
+#define list_for_each_rcu(pos, head)		  \
+	for (pos = rcu_dereference((head)->next); \
+	     !list_is_head(pos, (head)); \
+	     pos = rcu_dereference(pos->next))
+
 /**
  * list_tail_rcu - returns the prev pointer of the head of the list
  * @head: the head of the list
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 10b63433f05737..e12b946278b6c6 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/page_counter.h>
 #include <linux/parser.h>
+#include <linux/rculist.h>
 #include <linux/slab.h>
 
 struct dmem_cgroup_region {
-- 
2.40.1

