Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8CDC28CF5
	for <rcu@archiver.kernel.org>; Wed, 26 Jan 2022 15:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbiAZPEf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235639AbiAZPEe (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 26 Jan 2022 10:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643209474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PwDpPFsxTrq2rRtwOqI7ZJIt9eR/2qLQnt7AqyYtFWc=;
        b=ZQoWjxvyUigwNB2o8ZhWqqtOS2WhtM8WuFSCsWbsVZrkUPlNHG3RMV0HJDu3sMYl/cYiQm
        +Tj70oZ/I1+dsPLnSHOnzIMj/KfE6i0mLY3IWrQkA4rKyQDQyP+WKm3/pjb5gYCS6BJ83P
        vtpwpZXN/Ta78tzUTFpJe7obVlbyRE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-xtC81mBQNpa7dKO_zDclCA-1; Wed, 26 Jan 2022 10:04:30 -0500
X-MC-Unique: xtC81mBQNpa7dKO_zDclCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1CAF1934102;
        Wed, 26 Jan 2022 15:04:28 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D92A570D30;
        Wed, 26 Jan 2022 15:04:06 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     jiangshanlai@gmail.com
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH] srcutree: use export for srcu_struct defined by DEFINE_STATIC_SRCU()
Date:   Wed, 26 Jan 2022 10:03:54 -0500
Message-Id: <20220126150354.3644838-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patch fixes a sparse issue if DEFINE_STATIC_SRCU() of srcutree is
used by a module. Sparse will show:

sparse: symbol '__srcu_struct_nodes_srcu' was not declared. Should it be static?

The problem is here that the DEFINE_STATIC_SRCU() of srcutree uses
__DEFINE_SRCU() and define a non-static srcu_struct. This srcu_struct
will be exported by inserting it in a special module section
'__section("___srcu_struct_ptrs")'. During load/unloading srcutree runs
their init/cleanup functionality. It seems sparse does not understand
this connection. To avoid the sparse warning we make a prototype of the
exported srcu_struct with an export keyword. This way we tell the
that the srcu_struct might be used outside of the module.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/srcutree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index cb1f4351e8ba..f81be0749484 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -121,6 +121,7 @@ struct srcu_struct {
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
+	extern struct srcu_struct * const __srcu_struct_##name;		\
 	struct srcu_struct * const __srcu_struct_##name			\
 		__section("___srcu_struct_ptrs") = &name
 #else
-- 
2.31.1

