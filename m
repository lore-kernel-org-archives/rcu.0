Return-Path: <SRS0=/QKf=TY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744C8C072B5
	for <rcu@archiver.kernel.org>; Fri, 24 May 2019 10:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE2321773
	for <rcu@archiver.kernel.org>; Fri, 24 May 2019 10:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gEfcHnef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbfEXKgx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 May 2019 06:36:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52763 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbfEXKgu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 24 May 2019 06:36:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so8861393wmm.2
        for <rcu@vger.kernel.org>; Fri, 24 May 2019 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=P+Ps4soXhNKRq8iNC0OfOmvq/D++en0Ppi7wC4gKVx0=;
        b=gEfcHnefDLO+ppOkR7MP9RLPlcs/38SUkWXB74AxVdIaislri8gPRcwyYUCN/5B2C7
         089eb7fzZZ9gQ+AfzfePKfPQ7aSlqocafZdx57oycCGHQrZgNDU0l8r5X/A0EzKNhCzQ
         6814qW4O90X0XEI6s9r2fMX4/zVhkDiSAJqMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P+Ps4soXhNKRq8iNC0OfOmvq/D++en0Ppi7wC4gKVx0=;
        b=lMQySa24Zo0ST/Ka9zXHTOVCtI+5sfeNTyC4aaihUqUVQMn8s+X1OgKIckRCqFtsKE
         9sZQFj8FiDjj3uMjoYGZaqgpipwn3Z+3L3LmDP7QdOjbcnrXQIbje+ctOYCqG1mWo7mU
         0Glhwk9iBBrVSZq7FAWMqQjFqzo6OvA916pvVRhJDPcNNM35PFh2TEIbuxxLEnQf71ZR
         bjrejH7OlIQyfBt20E27j8X5V0yEBXmUAJEopenBvX+9VgSfy9eNas+/zvnSKan/1pfM
         k+F/ccDCBQvs3D7Ur4Ivz12OaLcs18tMPgE4s3E9XiPngoAP25e6THSh4KwYlHv9zWIM
         p0Rg==
X-Gm-Message-State: APjAAAWB/m9LC8xw4sC5ZtLe1dNhYT4jVlBcsHs5bC3P2MKUQBblLvHe
        X+pePP6bUXFYIlBhMi0ug5pH5w==
X-Google-Smtp-Source: APXvYqwA0hRTekhpxAelht4GnryGiG0SywCCf5pEww/YaqRII7ojVdJRdLYUw200qQ0ItSvG2/tIbQ==
X-Received: by 2002:a05:600c:2198:: with SMTP id e24mr2748337wme.92.1558694207340;
        Fri, 24 May 2019 03:36:47 -0700 (PDT)
Received: from localhost.localdomain (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id h12sm2438862wre.14.2019.05.24.03.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 03:36:46 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH] rcu: Prevent evaluation of rcu_assign_pointer()
Date:   Fri, 24 May 2019 12:36:37 +0200
Message-Id: <1558694197-19295-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Quoting Paul [1]:

 "Given that a quick (and perhaps error-prone) search of the uses
  of rcu_assign_pointer() in v5.1 didn't find a single use of the
  return value, let's please instead change the documentation and
  implementation to eliminate the return value."

[1] https://lkml.kernel.org/r/20190523135013.GL28207@linux.ibm.com

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>
---
Matthew, Sasha:

The patch is based on -rcu/dev; I took the liberty of applying the
same change to your #defines in:

 tools/testing/radix-tree/linux/rcupdate.h
 tools/include/linux/rcu.h

but I admit that I'm not familiar with their uses: please shout if
you have any objections with it.
---
 Documentation/RCU/whatisRCU.txt           |  8 ++++----
 include/linux/rcupdate.h                  |  5 ++---
 tools/include/linux/rcu.h                 | 11 +++++++++--
 tools/testing/radix-tree/linux/rcupdate.h |  5 ++++-
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 981651a8b65d2..f99a87b9a88fa 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -212,7 +212,7 @@ synchronize_rcu()
 
 rcu_assign_pointer()
 
-	typeof(p) rcu_assign_pointer(p, typeof(p) v);
+	rcu_assign_pointer(p, typeof(p) v);
 
 	Yes, rcu_assign_pointer() -is- implemented as a macro, though it
 	would be cool to be able to declare a function in this manner.
@@ -220,9 +220,9 @@ rcu_assign_pointer()
 
 	The updater uses this function to assign a new value to an
 	RCU-protected pointer, in order to safely communicate the change
-	in value from the updater to the reader.  This function returns
-	the new value, and also executes any memory-barrier instructions
-	required for a given CPU architecture.
+	in value from the updater to the reader.  This macro does not
+	evaluate to an rvalue, but it does execute any memory-barrier
+	instructions required for a given CPU architecture.
 
 	Perhaps just as important, it serves to document (1) which
 	pointers are protected by RCU and (2) the point at which a
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 915460ec08722..a5f61a08e65fc 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -367,7 +367,7 @@ static inline void rcu_preempt_sleep_check(void) { }
  * other macros that it invokes.
  */
 #define rcu_assign_pointer(p, v)					      \
-({									      \
+do {									      \
 	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
 	rcu_check_sparse(p, __rcu);				      \
 									      \
@@ -375,8 +375,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
 	else								      \
 		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
-	_r_a_p__v;							      \
-})
+} while (0)
 
 /**
  * rcu_swap_protected() - swap an RCU and a regular pointer
diff --git a/tools/include/linux/rcu.h b/tools/include/linux/rcu.h
index 7d02527e5bcea..01a435ee48cd6 100644
--- a/tools/include/linux/rcu.h
+++ b/tools/include/linux/rcu.h
@@ -19,7 +19,14 @@ static inline bool rcu_is_watching(void)
 	return false;
 }
 
-#define rcu_assign_pointer(p, v) ((p) = (v))
-#define RCU_INIT_POINTER(p, v) p=(v)
+#define rcu_assign_pointer(p, v)				\
+do {								\
+	(p) = (v);						\
+} while (0)
+
+#define RCU_INIT_POINTER(p, v)					\
+do {								\
+	(p) = (v);						\
+} while (0)
 
 #endif
diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/radix-tree/linux/rcupdate.h
index fd280b070fdb1..48212f3a758e6 100644
--- a/tools/testing/radix-tree/linux/rcupdate.h
+++ b/tools/testing/radix-tree/linux/rcupdate.h
@@ -7,6 +7,9 @@
 #define rcu_dereference_raw(p) rcu_dereference(p)
 #define rcu_dereference_protected(p, cond) rcu_dereference(p)
 #define rcu_dereference_check(p, cond) rcu_dereference(p)
-#define RCU_INIT_POINTER(p, v)	(p) = (v)
+#define RCU_INIT_POINTER(p, v)					\
+do {								\
+	(p) = (v);						\
+} while (0)
 
 #endif
-- 
2.7.4

