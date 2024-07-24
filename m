Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C616F839
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832420; cv=none; b=mbhN0s2rawTwC19jCKLXkPjNe5dZouShGUFQzD7WFRhNecP3DbPGqH4efrm2T9GHoZhk+2iUaTmyVcqPo7yZFlPo20vXbY/uCMnkSi4Y4MwMRgt6t+V3OzyDXzY39Ic6ragJyXlVY8II5lajJ04ZSOrkHhFDK6haeNsDoU3LjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832420; c=relaxed/simple;
	bh=fBtq/bzE7bOfYsATeLb2PgDITbvvaV6tktnx3UpoO9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STGMEySWOm8fS94yTPU3sEjaqWpHO9FHE7rqHyppZo9pzh8phiMca58wbf3VHhOD3x6/KKfj2DCPnT/O5FKNGM3qayNa2Wradi8+AC0uGoIhMUG+7kuDKHVpA9EKA7uDzUh+fo7YzL2pf4dCogqYoVZvJx1yaYgO6Ho7ltg7ghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1mHbPNn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1mHbPNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1L7SUbA74bwDlKd8f6GAtSPyfAOBnxPU1a1lLpr2cQ=;
	b=Y1mHbPNn70ARYgyFiGGPn5KhQfdb1b6zwOGxpIiV3+sLCYzK8K7MuiN7l/nFqu1Isi5Tul
	06Dz3MPHtjAP6OVXdTly4GqhgYEJ0pGqDTHH7pqKDkmusnWmQvVrKurr9ll4Ej10y3njeY
	EpGG07b/IrxFsDl+e1l9ep+tcRVznAA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-UxCgXkiZN5me8Ypg1DnwLw-1; Wed,
 24 Jul 2024 10:46:52 -0400
X-MC-Unique: UxCgXkiZN5me8Ypg1DnwLw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 254111956088;
	Wed, 24 Jul 2024 14:46:50 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE0C01955F40;
	Wed, 24 Jul 2024 14:46:45 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v3 24/25] rcu: Update stray documentation references to rcu_dynticks_eqs_{enter, exit}()
Date: Wed, 24 Jul 2024 16:43:24 +0200
Message-ID: <20240724144325.3307148-25-vschneid@redhat.com>
In-Reply-To: <20240724144325.3307148-1-vschneid@redhat.com>
References: <20240724144325.3307148-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

rcu_dynticks_eqs_{enter, exit}() have been replaced by their
context-tracking counterparts since commit:

  171476775d32 ("context_tracking: Convert state to atomic_t")

Update the stray documentation references.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 4 ++--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg  | 4 ++--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg   | 4 ++--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg       | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 7163d0def34e6..1a5ff1a9f02e3 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -147,8 +147,8 @@ RCU read-side critical sections preceding and following the current
 idle sojourn.
 This case is handled by calls to the strongly ordered
 ``atomic_add_return()`` read-modify-write atomic operation that
-is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
-time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
+is invoked within ``ct_kernel_exit_state()`` at idle-entry
+time and within ``ct_kernel_enter_state()`` at idle-exit time.
 The grace-period kthread invokes first ``ct_rcu_watching_cpu_acquire()``
 (preceded by a full memory barrier) and ``rcu_watching_snap_stopped_since()``
 (both of which rely on acquire semantics) to detect idle CPUs.
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
index ab9707f04e666..3fbc19c48a584 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
@@ -607,7 +607,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
@@ -638,7 +638,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6-1"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
index e17c3356041aa..25c7acc8a4c25 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
@@ -977,7 +977,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
@@ -1008,7 +1008,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6-1"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index c43e1ec10774b..d05bc7b27edb7 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3107,7 +3107,7 @@
          font-weight="bold"
          font-size="192"
          id="text202-7-5-3-27-6"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
       <text
          xml:space="preserve"
          x="3745.7725"
@@ -3138,7 +3138,7 @@
          font-weight="bold"
          font-size="192"
          id="text202-7-5-3-27-6-1"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
       <text
          xml:space="preserve"
          x="3745.7725"
-- 
2.43.0

