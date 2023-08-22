Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A2EE49AB
	for <rcu@archiver.kernel.org>; Tue, 22 Aug 2023 20:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjHVUEM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Aug 2023 16:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHVUEL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Aug 2023 16:04:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B60CE3
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OgSF644uzhy+OVHVu/h7cH50rNEswIOQkznlOPccrFQ=; b=oQ2XL21oV8Eb1VsIWI5AAvcevl
        dQMo0YeC9qMHXAMI4/zZoKnXJSZNlog+x7T7qaniUqtLhuDcscDORraE6mtbIOUsxtayUzn/oi6Rs
        Lj8LRKLq2X7IXa/4kdXkbLVWPgGiET1fmTCVrRtudBqb1L/peR+tKTPk0jsatKXHslJPJ7dbGQbfD
        iTPeWcS9tast0+tHAF7tsE5NdOI1nAz1Qe/osqLUQemaIy6iarzlVBofYClEUwjZ3xYdf7fIonnq6
        UY/zwJltvSDlfAlQiL/wIBZA7gdNym4oFjGaCHVPMdxSD5n4EtFunw8Yj+1leLH+WFP0b4TRuFjMu
        Nt+KSD8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYXbg-000fPb-RC; Tue, 22 Aug 2023 20:04:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        rcu@vger.kernel.org
Subject: [PATCH] rcu: Describe listRCU read-side guarantees
Date:   Tue, 22 Aug 2023 21:04:02 +0100
Message-Id: <20230822200402.159177-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

More explicitly state what is, and what is not guaranteed to those
who iterate a list while protected by RCU.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/RCU/listRCU.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index bdc4bcc5289f..aff1394f6d93 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -8,6 +8,18 @@ One of the most common uses of RCU is protecting read-mostly linked lists
 that all of the required memory ordering is provided by the list macros.
 This document describes several list-based RCU use cases.
 
+When iterating a list while holding the rcu_read_lock(), writers may
+modify the list.  The reader is guaranteed to see all of the elements
+which were added to the list before they acquired the rcu_read_lock()
+and are still on the list when they drop the rcu_read_unlock().
+Elements which are added to, or removed from the list may or may not
+be seen.  If the writer calls list_replace_rcu(), the reader may see
+either the old element or the new element; they will not see both,
+nor will they see neither.
+
+There is no equivalent of list_for_each_entry_reverse(); RCU lists
+may only be walked forwards.
+
 
 Example 1: Read-mostly list: Deferred Destruction
 -------------------------------------------------
-- 
2.40.1

