Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579115E5D0
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832404; cv=none; b=ImfVwgOHCe/8UFjpGxapOMk+GaoYHW92QRBOOiIBQZpACcYo0UssqM3H5mTeD71jFFzuNk2H1SZjD9c9IBDNG4EvSd96NVHngHzQOxPlpsB62OgB9Jbt/rgdEd6aiufwbdxv0exLX1ir9po6jCsY2F/MNuRGYU4E87ErlH5yNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832404; c=relaxed/simple;
	bh=acWHD554dGMwmWsp24VLqu5U9j0sx8c1KmEe7QQKjoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOx+tqJ4qN2wCjgQWcOXRw4eed8GDJxGFiDujBQE8WDSGtILdV0aaqa5Nh4fj/h1nDWps2zb+ZIwhgMyyO5WHdDmyP8xq4f3cH7Vh9sUGGr5/+lJk1HLJ70Vuo64EN+p+J2Z7nF7DdwD/uWtErAWYA4Bos01muwTpjl4AtINieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROzXZfB+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROzXZfB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZyim8qIMR9JS576g3bw695OcfGpjbXPwfILHqSDGMc=;
	b=ROzXZfB+BSsIwwFCkm/PLWPxv34Vlnk4gz9tx/5wbQI2SI6+Zo5QtmBM73E2l+zeMwkIyS
	yNor4bQ2jpdrTXAtthLDCW+NwvhERsGtNBn4beUt1qn0rUGC1OXZ9P1wJVmdlsCzgb2j70
	QQWOgUOk4dGd4sLrzW12wrMOs8/9+yw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-d5V-PEtSOBGIcmTViaDvHg-1; Wed,
 24 Jul 2024 10:46:38 -0400
X-MC-Unique: d5V-PEtSOBGIcmTViaDvHg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C5FB1955BF2;
	Wed, 24 Jul 2024 14:46:30 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 007CD194511F;
	Wed, 24 Jul 2024 14:46:15 +0000 (UTC)
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
Subject: [PATCH v3 22/25] rcu: Rename rcu_implicit_dynticks_qs() into rcu_implicit_eqs()
Date: Wed, 24 Jul 2024 16:43:22 +0200
Message-ID: <20240724144325.3307148-23-vschneid@redhat.com>
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

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, replace "dynticks_qs" into "eqs" to drop the dyntick
reference.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg  | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg      | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg | 2 +-
 kernel/rcu/tree.c                                            | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
index 13956baf748ad..ab9707f04e666 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
@@ -537,7 +537,7 @@
        font-style="normal"
        y="-8368.1475"
        x="2463.3262"
-       xml:space="preserve">rcu_implicit_dynticks_qs()</text>
+       xml:space="preserve">rcu_watching_snap_recheck()</text>
   </g>
   <g
      id="g4504"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
index 9de55fbf5be49..e17c3356041aa 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
@@ -899,7 +899,7 @@
      font-style="normal"
      y="1858.8729"
      x="4414.1836"
-     xml:space="preserve">rcu_implicit_dynticks_qs()</text>
+     xml:space="preserve">rcu_watching_snap_recheck()</text>
   <text
      xml:space="preserve"
      x="14659.87"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 286a098b9c42f..c43e1ec10774b 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3029,7 +3029,7 @@
        font-style="normal"
        y="38425.035"
        x="-337.79462"
-       xml:space="preserve">rcu_implicit_dynticks_qs()</text>
+       xml:space="preserve">rcu_watching_snap_recheck()</text>
     <text
        xml:space="preserve"
        x="9907.8887"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
index bab69a15c9c22..a92356ce40110 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
@@ -525,7 +525,7 @@
        font-style="normal"
        y="-8368.1475"
        x="2463.3262"
-       xml:space="preserve">rcu_implicit_dynticks_qs()</text>
+       xml:space="preserve">rcu_watching_snap_recheck()</text>
     <text
        sodipodi:linespacing="125%"
        style="font-size:192px;font-style:normal;font-weight:bold;line-height:125%;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e43d4e1ac4e18..3c607e45532bd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -798,7 +798,7 @@ static int rcu_watching_snap_save(struct rcu_data *rdp)
  *
  * Returns zero otherwise.
  */
-static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
+static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 {
 	unsigned long jtsq;
 	int ret = 0;
@@ -1987,7 +1987,7 @@ static void rcu_gp_fqs(bool first_time)
 		force_qs_rnp(rcu_watching_snap_save);
 	} else {
 		/* Handle dyntick-idle and offline CPUs. */
-		force_qs_rnp(rcu_implicit_dynticks_qs);
+		force_qs_rnp(rcu_watching_snap_recheck);
 	}
 	/* Clear flag to prevent immediate re-entry. */
 	if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
-- 
2.43.0

