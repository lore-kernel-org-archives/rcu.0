Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92B1C54FD0
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51F3206F4
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488710;
	bh=w+ByQxJfkJpseVrE4ql+HULCZTp9MPApnkYaLtKa76U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ctUptJF3f/PYNzZLJAGtdoqD2Sxc/8GADE4P9GQLOz8j0NtRJscRx1PINvOdi8rdf
	 Jpy/Yl684Swa1NOg9Cn2DdcBZrpAPifMdb4RTu3726porJ/x+I3wodK39ARZo7eIys
	 Y6xRPrhfDMeWmB+GHzLqB5dxZfmMpL0BtDapKN0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgDURFC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgDUREP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 13:04:15 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9622071E;
        Tue, 21 Apr 2020 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488654;
        bh=w+ByQxJfkJpseVrE4ql+HULCZTp9MPApnkYaLtKa76U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quWaHz5ABzkiBepF1Yms4s6auCW/uyDb8Sbj398npMYyowubY1+OaRIP8t+awN8ZF
         84vz1Pj9wjaiI3LpEFfHSoSaHr+tC8BwNWDR6/C9bCP5Tu4a027Enry9aIwwV9NgHe
         qEtZb+qkZOCeuzcagqNSR+/8wpuSGe+6jIH5EXq0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwJg-00CmLr-6h; Tue, 21 Apr 2020 19:04:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 06/10] docs: RCU: convert rcuref.txt to ReST
Date:   Tue, 21 Apr 2020 19:04:07 +0200
Message-Id: <d4fa009a829bcdfca1873e467b5ba139103c9ce9.1587488137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587488137.git.mchehab+huawei@kernel.org>
References: <cover.1587488137.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to RCU/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/RCU/index.rst                  |   1 +
 Documentation/RCU/{rcuref.txt => rcuref.rst} | 193 ++++++++++---------
 2 files changed, 101 insertions(+), 93 deletions(-)
 rename Documentation/RCU/{rcuref.txt => rcuref.rst} (50%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 5d5f9a1ab8f9..9a1d51f394dc 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -18,6 +18,7 @@ RCU concepts
    whatisRCU
    rcu
    rculist_nulls
+   rcuref
    torture
    listRCU
    NMI-RCU
diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.rst
similarity index 50%
rename from Documentation/RCU/rcuref.txt
rename to Documentation/RCU/rcuref.rst
index 5e6429d66c24..b33aeb14fde3 100644
--- a/Documentation/RCU/rcuref.txt
+++ b/Documentation/RCU/rcuref.rst
@@ -1,4 +1,8 @@
-Reference-count design for elements of lists/arrays protected by RCU.
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================================================
+Reference-count design for elements of lists/arrays protected by RCU
+====================================================================
 
 
 Please note that the percpu-ref feature is likely your first
@@ -12,32 +16,33 @@ please read on.
 Reference counting on elements of lists which are protected by traditional
 reader/writer spinlocks or semaphores are straightforward:
 
-CODE LISTING A:
-1.				2.
-add()				search_and_reference()
-{				{
-    alloc_object		    read_lock(&list_lock);
-    ...				    search_for_element
-    atomic_set(&el->rc, 1);	    atomic_inc(&el->rc);
-    write_lock(&list_lock);	     ...
-    add_element			    read_unlock(&list_lock);
-    ...				    ...
-    write_unlock(&list_lock);	}
-}
+CODE LISTING A::
 
-3.					4.
-release_referenced()			delete()
-{					{
-    ...					    write_lock(&list_lock);
-    if(atomic_dec_and_test(&el->rc))	    ...
-	kfree(el);
-    ...					    remove_element
-}					    write_unlock(&list_lock);
- 					    ...
-					    if (atomic_dec_and_test(&el->rc))
-					        kfree(el);
-					    ...
-					}
+    1.					    2.
+    add()				    search_and_reference()
+    {					    {
+	alloc_object				read_lock(&list_lock);
+	...					search_for_element
+	atomic_set(&el->rc, 1);			atomic_inc(&el->rc);
+	write_lock(&list_lock);			 ...
+	add_element				read_unlock(&list_lock);
+	...					...
+	write_unlock(&list_lock);	   }
+    }
+
+    3.					    4.
+    release_referenced()		    delete()
+    {					    {
+	...					write_lock(&list_lock);
+	if(atomic_dec_and_test(&el->rc))	...
+	    kfree(el);
+	...					remove_element
+    }						write_unlock(&list_lock);
+						...
+						if (atomic_dec_and_test(&el->rc))
+						    kfree(el);
+						...
+					    }
 
 If this list/array is made lock free using RCU as in changing the
 write_lock() in add() and delete() to spin_lock() and changing read_lock()
@@ -46,34 +51,35 @@ search_and_reference() could potentially hold reference to an element which
 has already been deleted from the list/array.  Use atomic_inc_not_zero()
 in this scenario as follows:
 
-CODE LISTING B:
-1.					2.
-add()					search_and_reference()
-{					{
-    alloc_object			    rcu_read_lock();
-    ...					    search_for_element
-    atomic_set(&el->rc, 1);		    if (!atomic_inc_not_zero(&el->rc)) {
-    spin_lock(&list_lock);		        rcu_read_unlock();
-					        return FAIL;
-    add_element				    }
-    ...					    ...
-    spin_unlock(&list_lock);		    rcu_read_unlock();
-}					}
-3.					4.
-release_referenced()			delete()
-{					{
-    ...					    spin_lock(&list_lock);
-    if (atomic_dec_and_test(&el->rc))       ...
-        call_rcu(&el->head, el_free);       remove_element
-    ...                                     spin_unlock(&list_lock);
-} 					    ...
-					    if (atomic_dec_and_test(&el->rc))
-					        call_rcu(&el->head, el_free);
-					    ...
-					}
+CODE LISTING B::
+
+    1.					    2.
+    add()				    search_and_reference()
+    {					    {
+	alloc_object				rcu_read_lock();
+	...					search_for_element
+	atomic_set(&el->rc, 1);			if (!atomic_inc_not_zero(&el->rc)) {
+	spin_lock(&list_lock);			    rcu_read_unlock();
+						    return FAIL;
+	add_element				}
+	...					...
+	spin_unlock(&list_lock);		rcu_read_unlock();
+    }					    }
+    3.					    4.
+    release_referenced()		    delete()
+    {					    {
+	...					spin_lock(&list_lock);
+	if (atomic_dec_and_test(&el->rc))	...
+	    call_rcu(&el->head, el_free);	remove_element
+	...					spin_unlock(&list_lock);
+    }						...
+						if (atomic_dec_and_test(&el->rc))
+						    call_rcu(&el->head, el_free);
+						...
+					    }
 
 Sometimes, a reference to the element needs to be obtained in the
-update (write) stream.  In such cases, atomic_inc_not_zero() might be
+update (write) stream.	In such cases, atomic_inc_not_zero() might be
 overkill, since we hold the update-side spinlock.  One might instead
 use atomic_inc() in such cases.
 
@@ -82,39 +88,40 @@ search_and_reference() code path.  In such cases, the
 atomic_dec_and_test() may be moved from delete() to el_free()
 as follows:
 
-CODE LISTING C:
-1.					2.
-add()					search_and_reference()
-{					{
-    alloc_object			    rcu_read_lock();
-    ...					    search_for_element
-    atomic_set(&el->rc, 1);		    atomic_inc(&el->rc);
-    spin_lock(&list_lock);		    ...
+CODE LISTING C::
 
-    add_element				    rcu_read_unlock();
-    ...					}
-    spin_unlock(&list_lock);		4.
-}					delete()
-3.					{
-release_referenced()			    spin_lock(&list_lock);
-{					    ...
-    ...					    remove_element
-    if (atomic_dec_and_test(&el->rc))       spin_unlock(&list_lock);
-        kfree(el);			    ...
-    ...                                     call_rcu(&el->head, el_free);
-} 					    ...
-5.					}
-void el_free(struct rcu_head *rhp)
-{
-    release_referenced();
-}
+    1.					    2.
+    add()				    search_and_reference()
+    {					    {
+	alloc_object				rcu_read_lock();
+	...					search_for_element
+	atomic_set(&el->rc, 1);			atomic_inc(&el->rc);
+	spin_lock(&list_lock);			...
+
+	add_element				rcu_read_unlock();
+	...				    }
+	spin_unlock(&list_lock);	    4.
+    }					    delete()
+    3.					    {
+    release_referenced()			spin_lock(&list_lock);
+    {						...
+	...					remove_element
+	if (atomic_dec_and_test(&el->rc))	spin_unlock(&list_lock);
+	    kfree(el);				...
+	...					call_rcu(&el->head, el_free);
+    }						...
+    5.					    }
+    void el_free(struct rcu_head *rhp)
+    {
+	release_referenced();
+    }
 
 The key point is that the initial reference added by add() is not removed
 until after a grace period has elapsed following removal.  This means that
 search_and_reference() cannot find this element, which means that the value
 of el->rc cannot increase.  Thus, once it reaches zero, there are no
-readers that can or ever will be able to reference the element.  The
-element can therefore safely be freed.  This in turn guarantees that if
+readers that can or ever will be able to reference the element.	 The
+element can therefore safely be freed.	This in turn guarantees that if
 any reader finds the element, that reader may safely acquire a reference
 without checking the value of the reference counter.
 
@@ -130,21 +137,21 @@ the eventual invocation of kfree(), which is usually not a problem on
 modern computer systems, even the small ones.
 
 In cases where delete() can sleep, synchronize_rcu() can be called from
-delete(), so that el_free() can be subsumed into delete as follows:
+delete(), so that el_free() can be subsumed into delete as follows::
 
-4.
-delete()
-{
-    spin_lock(&list_lock);
-    ...
-    remove_element
-    spin_unlock(&list_lock);
-    ...
-    synchronize_rcu();
-    if (atomic_dec_and_test(&el->rc))
-    	kfree(el);
-    ...
-}
+    4.
+    delete()
+    {
+	spin_lock(&list_lock);
+	...
+	remove_element
+	spin_unlock(&list_lock);
+	...
+	synchronize_rcu();
+	if (atomic_dec_and_test(&el->rc))
+	    kfree(el);
+	...
+    }
 
 As additional examples in the kernel, the pattern in listing C is used by
 reference counting of struct pid, while the pattern in listing B is used by
-- 
2.25.2

