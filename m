Return-Path: <SRS0=TKtl=4N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CABC35E01
	for <rcu@archiver.kernel.org>; Tue, 25 Feb 2020 14:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD042084E
	for <rcu@archiver.kernel.org>; Tue, 25 Feb 2020 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTiuFvlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgBYOyj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:54:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730905AbgBYOyi (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 25 Feb 2020 09:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582642476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QMvNXoW6psDe1PxL4MB925CUo6es0He3gLgCnJQuh1A=;
        b=RTiuFvlL9Ac/CaUS2tIiKtNcYDj0y7vvSC9u0XjVaB8pwWNlbg9dtw0k/2nxawjmkhl4Zl
        RO9be5+dSnSz2GiGMpOKCaUyNF7rnF91hhkcZ8oAc2kvswN+l8BsLiU4acFp99v9Uydyda
        bHgayZxCoyMRKLSphYFdCZ0iIyPQH+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-hv_p7hdhOdCQZbWjrxSTCQ-1; Tue, 25 Feb 2020 09:54:28 -0500
X-MC-Unique: hv_p7hdhOdCQZbWjrxSTCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45DEC102CE15;
        Tue, 25 Feb 2020 14:54:27 +0000 (UTC)
Received: from lithium.redhat.com (unknown [10.36.118.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 545361BC6D;
        Tue, 25 Feb 2020 14:54:25 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, ebiederm@xmission.com, paulmck@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v3] ipc: use a work queue to free_ipc
Date:   Tue, 25 Feb 2020 15:54:19 +0100
Message-Id: <20200225145419.527994-1-gscrivan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

the reason is to avoid a delay caused by the synchronize_rcu() call in
kern_umount() when the mqueue mount is freed.

the code:

\#define _GNU_SOURCE
\#include <sched.h>
\#include <error.h>
\#include <errno.h>
\#include <stdlib.h>
int main()
{
  int i;
  for (i  =3D 0; i < 1000; i++)
    if (unshare (CLONE_NEWIPC) < 0)
      error (EXIT_FAILURE, errno, "unshare");
}

gets from:

	Command being timed: "./ipc-namespace"
	User time (seconds): 0.00
	System time (seconds): 0.06
	Percent of CPU this job got: 0%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:08.05

to:

	Command being timed: "./ipc-namespace"
	User time (seconds): 0.00
	System time (seconds): 0.02
	Percent of CPU this job got: 96%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.03

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
v3:
- added comment for free_ipc_work
- commit message rephrased

v2: https://lkml.org/lkml/2020/2/17/839
- comment added in free_ipc_ns()

v1: https://lkml.org/lkml/2020/2/11/692

 include/linux/ipc_namespace.h |  2 ++
 ipc/namespace.c               | 24 ++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.=
h
index c309f43bde45..a06a78c67f19 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -68,6 +68,8 @@ struct ipc_namespace {
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
=20
+	struct llist_node mnt_llist;
+
 	struct ns_common ns;
 } __randomize_layout;
=20
diff --git a/ipc/namespace.c b/ipc/namespace.c
index b3ca1476ca51..c0470aef41a0 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -117,6 +117,10 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_=
ids *ids,
=20
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
+	/* mq_put_mnt() waits for a grace period as kern_unmount()
+	 * uses synchronize_rcu().
+	 */
+	mq_put_mnt(ns);
 	sem_exit_ns(ns);
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
@@ -127,6 +131,21 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	kfree(ns);
 }
=20
+static LLIST_HEAD(free_ipc_list);
+static void free_ipc(struct work_struct *unused)
+{
+	struct llist_node *node =3D llist_del_all(&free_ipc_list);
+	struct ipc_namespace *n, *t;
+
+	llist_for_each_entry_safe(n, t, node, mnt_llist)
+		free_ipc_ns(n);
+}
+
+/*
+ * The work queue is used to avoid the cost of synchronize_rcu in kern_u=
nmount.
+ */
+static DECLARE_WORK(free_ipc_work, free_ipc);
+
 /*
  * put_ipc_ns - drop a reference to an ipc namespace.
  * @ns: the namespace to put
@@ -148,8 +167,9 @@ void put_ipc_ns(struct ipc_namespace *ns)
 	if (refcount_dec_and_lock(&ns->count, &mq_lock)) {
 		mq_clear_sbinfo(ns);
 		spin_unlock(&mq_lock);
-		mq_put_mnt(ns);
-		free_ipc_ns(ns);
+
+		if (llist_add(&ns->mnt_llist, &free_ipc_list))
+			schedule_work(&free_ipc_work);
 	}
 }
=20
--=20
2.24.1

