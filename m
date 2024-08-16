Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1654F87;
	Fri, 16 Aug 2024 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781182; cv=none; b=Ef7Ro2irpPkdgjweMxLO4oMPr7uM5ceHVtx7YkaWvBH5DdX3DyBG1A7W4jESzN5xJYaDDyyoA8L67gkwMtwzi6ppWf7n+0jWI+Xlmo74ouLEaokgzkrgjwXhHl+1Bgr5JvZQcDTGocGg+A4tBVfDkEfKujUcfJZHhJX3U99eKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781182; c=relaxed/simple;
	bh=3WRner0RMhGFgnkPtCcFs9g6yG8s5bs0mSd98/aW7I0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AwZL4cJlZfDKK46wNK+Ytb5kGkHTN+A/sSyxY4YycxU1R6VHH+Sp+O1NaQUQuYKnEr1gFJ1gnFZ2l2zaQn7SNtLPEvj/nB+0W2kEOCgvuiY/o7+HrRdYdhiat83+9zxWbRtfGDLEih0upObYlMHm5J4xCswRh1/ghCCgxBqMjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElUiE6sD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElUiE6sD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAC6C4AF0B;
	Fri, 16 Aug 2024 04:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781181;
	bh=3WRner0RMhGFgnkPtCcFs9g6yG8s5bs0mSd98/aW7I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElUiE6sDSBSDn3OiqGnUJOZsCkEvNjTEjW8SgwSF7qWlUVI4XFjJ0wtUuEmOyUVzf
	 tvdX4UjZY9c6zEOIMzLry76HV4qinYwYhqz0PcwEH0MG5u1U19gzT2cHv9RzteHDk3
	 RiL1aUeDYa10VcWgmB3XvjvpsF7q+RaTPMp0vYJsJ/b8yKMMuHQBR6x9c9aqcC2cmZ
	 9DN/BUfTAzNyQT08Wz0QrqVqAHVfD4dAPUqeNEh7s2B7lRkfco8sidi8o1nIUJqLHT
	 kncS+CZjCm+nrjKQctLscR/h7Vs/IMRbLFO8aVoDWhGR9rg/E+robBF2fU6Hp3zEXl
	 yNViFP6kgTISQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 22/26] rcu: Rename rcu_implicit_dynticks_qs() into rcu_watching_snap_recheck()
Date: Fri, 16 Aug 2024 09:32:37 +0530
Message-Id: <20240816040241.17776-22-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, drop the dyntick reference and update the name of this helper
to express that it rechecks rdp->watching_snap after an earlier
rcu_watching_snap_save().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg  | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg      | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg | 2 +-
 kernel/rcu/tree.c                                            | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
index 13956baf748a..ab9707f04e66 100644
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
index 9de55fbf5be4..e17c3356041a 100644
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
index 286a098b9c42..c43e1ec10774 100644
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
index bab69a15c9c2..a92356ce4011 100644
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
index 93039414733a..b53b354417ae 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -812,7 +812,7 @@ static int rcu_watching_snap_save(struct rcu_data *rdp)
  *
  * Returns zero otherwise.
  */
-static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
+static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 {
 	unsigned long jtsq;
 	int ret = 0;
@@ -1998,7 +1998,7 @@ static void rcu_gp_fqs(bool first_time)
 		force_qs_rnp(rcu_watching_snap_save);
 	} else {
 		/* Handle dyntick-idle and offline CPUs. */
-		force_qs_rnp(rcu_implicit_dynticks_qs);
+		force_qs_rnp(rcu_watching_snap_recheck);
 	}
 	/* Clear flag to prevent immediate re-entry. */
 	if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
-- 
2.40.1

