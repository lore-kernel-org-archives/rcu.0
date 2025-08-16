Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E0EED8;
	Sat, 16 Aug 2025 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302511; cv=none; b=L0kL6NBrj/0WZDTjPl3wJoEMHkRjhcIUoDYGamgtOfdWDWXhyRY40Wxo9AOAFk5RCEpuF8YJGBPcBK+KTzCP3JqukcumlGNn/vnnsWjTuowg+XUGhXde9IiLBft92jiZReCt5w3Pm/YQ7Q955SvKM0cs+4g6sXO/gZ17Qy6rkdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302511; c=relaxed/simple;
	bh=FGAfKe2mUubPShjfHv2CMrtmsbPxnRWUzJcdffSD7pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyFtCkX8Q6ozpndncIHKCxT+EqQC7ly4UXUmooja90JIdpe+TelDdqKTJEL/5JgOL6SxdbJBW+XgLck1ATt9jxug0xhGwKYwhuH+u0Gl44pk3JCOBKpReqWONUIACN7jiEqagJXe3oReRSw+eqNBljoQ7Fq3fNoGNdoahkO7DtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q01lbT5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q01lbT5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2649FC4CEF7;
	Sat, 16 Aug 2025 00:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302511;
	bh=FGAfKe2mUubPShjfHv2CMrtmsbPxnRWUzJcdffSD7pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q01lbT5Sf7em/FB4qtZVWjiUNyBptsGA1+xRHaDUHJQSBHqi/A+9pxefcV9cUpLtA
	 r/Huc/7OOLG1UgSyPwBmgllW+xQfRjelusSgyOiwiKp3tYopohsMyljCIHmh/YySzX
	 n+wqJ5gKqRcyrI3a7w87kQI27af2JXmSzSMDMRBXbsjWx9uTOuTF8U6mUNfkfN9TEo
	 v6TtEQWMwVRS60nnqKPhN0oHQoU9h5bgVAwjXnnFsvKF+9mR5+lNWzM1meNbNAItXt
	 zvgqbwfEUcKv0Kphtd+EaVRoMB/vAEG+PqY0LvBKoIgYtmx1fwiZ+iPq8CBG+WFMGc
	 Q9cTfXazjCcUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 530F4CE0B31; Fri, 15 Aug 2025 17:01:50 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH 3/3] rculist: move list_for_each_rcu() to where it belongs
Date: Fri, 15 Aug 2025 17:01:49 -0700
Message-Id: <20250816000149.2622447-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a4c6f496-ca08-46f5-a159-03074a57706a@paulmck-laptop>
References: <a4c6f496-ca08-46f5-a159-03074a57706a@paulmck-laptop>
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

